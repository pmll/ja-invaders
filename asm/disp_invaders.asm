; dsplay invaders

include 'data.inc'

; toggle the invader animation state
ld a, (inv_anim_state)
xor 1
ld (inv_anim_state), a

; get screen address for current invader x,y
ld a, (inv_x)
ld b, a
ld a, (inv_y)
ld c, a
call xyadd
push hl

; get screen memory address for old invader x,y
ld a, (old_inv_x)
ld b, a
ld a, (old_inv_y)
ld c, a
call xyadd

; run through the stored invaders and display as appropriate
; invader states 2: alive, 1: dying, 0: dead
ld bc, inv_state

ld d, inv_rows
rowloop:

ld e, inv_cols
colloop:

ld a, (bc)

and a
jr z, dead

; blank out the old invader
ld (hl), erase_gr

dec a
jr nz, notdying

; make dying invader dead
ld (bc), a
jr dead

notdying:

ex (sp), hl     ; new x,y
ld a, invader_gr - 2 
add a, d
add a, d
push de
ld de, (inv_anim_state)
add a, e
pop de
ld (hl), a
ex (sp), hl     ; old x,y

dead:

inc bc ; advance to next invader state
; advance to next screen column
inc hl
inc hl
ex (sp), hl     ; hl = new x,y
inc hl
inc hl
ex (sp), hl     ; hl = old x,y

dec e
jr nz, colloop

; advance to next screen row
ld a, 64 - (inv_cols * 2)
add l
ld l, a
jr nc, nocarry1
inc h
nocarry1:
ex (sp), hl     ; hl = new x,y
ld a, 64 - (inv_cols * 2)
add l
ld l, a
jr nc, nocarry2
inc h
nocarry2:
ex (sp), hl     ; hl = old x,y

dec d
jr nz, rowloop

pop hl

jp (iy)     ; return control to caller

