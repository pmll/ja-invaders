; dsplay invaders
; substitute these with forth constants/variables
xyadd: equ 0x00ED
inv_x: equ 0x01ED
inv_y: equ 0x02ED
old_inv_x: equ 0x03ED
old_inv_y: equ 0x04ED
inv_state: equ 0x05ED
inv_anim_state: equ 0x06ED
leftmost_inv: equ 0x07ED
rightmost_inv: equ 0x08ED
bottommost_inv: equ 0x09ED
invaders_left: equ 0x0AED
update_inv_stats: equ 0x0BED
invaders_left_h: equ 0x0CED ; we use high byte of this forth var for temp storage

invader_gr: equ 16
erase_gr: equ 32
display_start: equ 9216

; prime rightmost, leftmost, bottommost invader and invaders left
ld a, 0
ld (invaders_left), a
ld (leftmost_inv), a
ld a, 9
ld (rightmost_inv), a
ld (bottommost_inv), a

; toggle the invader animation state
ld a, (inv_anim_state)
xor 1
ld (inv_anim_state), a

ld a, 2
ld (invaders_left_h), a   ; we use high byte of this forth var just for convenience
mainloop:

; get the memory location of invader x,y
ld a, (invaders_left_h)
cp 2
jr z, old1

ld a, (inv_x)
ld b, a
ld a, (inv_y)
ld c, a
jr notold1

old1:
ld a, (old_inv_x)
ld b, a
ld a, (old_inv_y)
ld c, a

notold1:
call xyadd  ; hl now contains screen address

; run through the stored invaders and display as appropriate
; invader states 2: alive, 1: dying, 0: dead
ld bc, inv_state

ld d, 4
rowloop:

ld e, 8
colloop:

ld a, (bc)
dec a
jr nz, notdying

; we have a dying invader, blank it and make it dead
; we should only encounter these on the first pass of the main loop
ld (bc), a
ld (hl), erase_gr

notdying:

dec a
jr nz, notalive

; if old, display blank, else live invader
ld a, (invaders_left_h)
cp 2
jr z, old3

ld a, invader_gr - 2 
add a, d
add a, d
push de
ld de, (inv_anim_state)
add a, e
pop de
ld (hl), a

call update_inv_stats

jr notold3

old3:

ld (hl), erase_gr

notold3:

notalive:

inc bc ; advance to next invader state
inc hl
inc hl  ; advance to next screen column

dec e
jr nz, colloop

push bc
ld bc, 48
add hl, bc  ; advance to next screen row
pop bc

dec d
jr nz, rowloop

ld a, (invaders_left_h)
dec a
ld (invaders_left_h), a
jr nz, mainloop 

; fix up "back to front" leftmost, rightmost, bottommost
ld hl, (leftmost_inv)
ld a, 8
sub l
ld (leftmost_inv), a

ld hl, (rightmost_inv)
ld a, 8
sub l
ld (rightmost_inv), a

ld hl, (bottommost_inv)
ld a, 4
sub l
ld (bottommost_inv), a

jp (iy)     ; return control to caller

