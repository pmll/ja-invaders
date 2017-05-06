; display missile + detect collisions

xyadd: equ 0x00ED

inv_x: equ 0x01ED
inv_y: equ 0x02ED
inv_state: equ 0x05ED
missile_x: equ 0x0FED
missile_y: equ 0x10ED

erase_gr: equ 32
barricade_gr: equ erase_gr + 128    ; reverse video space
explode_gr: equ 42
missile_gr: equ 24

; load hl with screen address of missile
ld a, (missile_x)
srl a
srl a
srl a
ld b, a
ld a, (missile_y)
ld c, a
call xyadd

; at end of flight?
ld a, (missile_y)
and a
jr z, blankold

; check for collision with barricade
ld a,(hl)
cp barricade_gr
jr nz, nobarricade

; we've hit a barricade, that's the end of this missile's journey
ld (hl), erase_gr
ld a, 0
ld (missile_y), a
jr blankold

nobarricade:

; check for invader collision
ld a, (inv_x)
ld b, a
ld a, (missile_x)
srl a
srl a
srl a
sub b
bit 7, b ; inv_x is allowed to be negative, in which case, ignore carry flag
jr nz, ignorecarry
jr c, noinvader
ignorecarry:
bit 0, a
jr nz, noinvader  ; invaders will be at an even offset
cp 15
jr nc, noinvader
; ok, missile x is in range for an invader, what about y?
ld b, a
ld a, (inv_y)
ld c, a
ld a, (missile_y)
sub c
jr c, noinvader
bit 0, a
jr nz, noinvader
cp 7
jr nc, noinvader
; missile y is in range for an invader, is there actually a live one there?
push hl
ld hl, inv_state
sla a
sla a
srl b
add b
ld c, a
ld b, 0
add hl, bc
ld a, (hl)
cp 2
jr z, hitinvader
pop hl
jr noinvader

hitinvader:
; ok, we have hit, that's the end of this missile's journey
ld a, 1
ld (hl), a  ; invader flagged as dying
pop hl
ld (hl), explode_gr  ; visible death on screen
ld a, 0
ld (missile_y), a    ; end of this missile's journey
ld a, 1
jr blankold

noinvader:

; display missile
ld a, (missile_x)
and 7
add a, missile_gr
ld (hl), a

; blank old missile below current position, if there is one
blankold:
ld bc, 32
add hl, bc
; test if the character in that position is a missile
ld a, (hl)
sub missile_gr
jr c, done
sub 8
jr nc, done
; we have a missile, blank it out
ld (hl), erase_gr

done:
jp (iy)
