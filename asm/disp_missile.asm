; display missile + detect collisions

include 'data.inc'

missile_ch_x: equ temp_store

; load hl with screen address of missile
ld a, (missile_x)
srl a
srl a
srl a
ld (missile_ch_x), a
ld b, a
ld a, (missile_y)
ld c, a
call xyadd

; at end of flight?
and a
jr z, blankoldstep      ; out of range for direct relative jump

; check for mother ship collision
cp mother_y
jr nz, nomother
ld a, (mother_state)
cp mother_in_flight
jr nz, nomother
ld a, (missile_ch_x)
ld b, a
ld a, (mother_x)
dec a
cp b
jr nc, nomother
add a, 3
cp b
jr c, nomother
; hit mothership, make it explode
push hl
ld c, explode_gr
call disp_mother_ch
dec a
call disp_mother_ch
dec a
call disp_mother_ch
; update the score
ld a, 10
call upd_score
pop hl
; flag mothership as dying
ld a, mother_dying
ld (mother_state), a
; missile is at end of journey
xor a
ld (missile_y), a
jr blankold

nomother:

; check for collision with barricade
ld a,(hl)
cp barricade_gr
jr nz, nobarricade

; we've hit a barricade, that's the end of this missile's journey
ld (hl), erase_gr
xor a
ld (missile_y), a
blankoldstep:
jr blankold

nobarricade:

; check for invader collision
ld a, (inv_x)
ld c, a
ld a, (missile_ch_x)
sub c
bit 7, c ; inv_x is allowed to be negative, in which case, ignore carry flag
jr nz, ignorecarry
jr c, noinvader
ignorecarry:
bit 0, a
jr nz, noinvader  ; invaders will be at an even offset
cp inv_cols * 2 - 1
jr nc, noinvader
; ok, missile x is in range for an invader, what about y?
ld c, a
ld a, (inv_y)
ld b, a
ld a, (missile_y)
sub b
jr c, noinvader
bit 0, a
jr nz, noinvader
cp inv_rows * 2 - 1
jr nc, noinvader
; missile y is in range for an invader, is there actually a live one there?
push hl
ld hl, inv_state

ld b, a
srl b
srl c
ld a, c

rowloop:
add a, inv_cols
djnz rowloop

ld b, 0
ld c, a
add hl, bc
ld a, (hl)
cp 2
jr z, hitinvader
pop hl
jr noinvader

hitinvader:
; ok, we have hit an invader
ld a, 1
ld (hl), a  ; invader flagged as dying
; update the score
ld a, (inv_y)
ld b, a
ld a, (missile_y)
sub b
if inv_rows & 1
; if we have an odd number of rows, the top row alone will have the top score
add a, 2
endif
srl a
srl a
neg
add a, 0 + (inv_rows + 1) / 2
call upd_score
pop hl
ld (hl), explode_gr  ; visible death on screen
xor a
ld (missile_y), a    ; end of this missile's journey
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
