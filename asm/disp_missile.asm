; display missile + detect collisions

include 'data.inc'

; load hl with screen address of missile
ld a, (missile_x)
srl a
srl a
srl a
ld d, a
ld b, a
ld a, (missile_y)
ld c, a
call xyadd

; at end of flight?
and a
jr z, blankold

ld a, (hl)     ; a = character under the next missile position

; check for mother ship collision
cp mother_gr
jr nz, nomother
push hl
; hit mothership, make it explode
ld a, (mother_x)
ld c, explode_gr
call disp_mother_ch
inc a
call disp_mother_ch
inc a
call disp_mother_ch
; update the score
ld a, 10
call upd_score
pop hl
; flag mothership as dying
ld a, mother_dying
ld (mother_state), a
; missile is at end of journey
jr end_of_journey

nomother:
; check for collision with barricade
cp barricade_gr
jr nz, nobarricade

; we've hit a barricade, that's the end of this missile's journey
ld (hl), erase_gr
jr end_of_journey

nobarricade:
; check for invader collision
cp invader_gr
jr c, noinvader
cp invader_gr + (((inv_rows - 1) >> 1) * 2) + 2
jr nc, noinvader
; hit an invader, update the score
push hl
sub invader_gr
srl a
inc a
call upd_score
; flag invader as dying
ld hl, inv_state
ld a, (inv_x)
ld c, a
ld a, d
sub c
srl a       ; x offset into inv_state
ld c, a
ld b, 0
add hl, bc

ld a, (inv_y)
ld c, a
ld a, (missile_y)
sub c
srl a       ; y offset into inv_state
jr z, y_offset_done
ld bc, inv_cols

y_offset_loop:
add hl, bc
dec a
jr nz, y_offset_loop

y_offset_done:
ld a, 1
ld (hl), a 
pop hl
; show an explosion
ld (hl), explode_gr

; end of missile journey
jr end_of_journey

noinvader:
; display missile
ld a, (missile_x)
and 7
add a, missile_gr
ld (hl), a
jr blankold

end_of_journey:
; end of this missile's journey
xor a
ld (missile_y), a

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
