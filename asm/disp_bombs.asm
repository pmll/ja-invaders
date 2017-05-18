; display bombs

include "data.inc"

ld hl, bombs

ld d, max_bombs

bombloop:
ld a, (hl)
ld b, a
inc hl
ld a, (hl)
cp ship_y + 2
jr z, bombinactive
ld c, a
ld e, a
push hl
call xyadd

ld a, e
cp ship_y + 1
jr z, nobomb

ld a, (hl)
cp barricade_gr
jr nz, nobarricade

; bomb has hit a barricade, that's the end of it's journey
ld a, erase_gr
ld (hl), erase_gr
ex (sp), hl
ld a, ship_y + 2
ld (hl), a
ex (sp), hl
jr nobomb

nobarricade:
; invaders sometimes descend after releasing a bomb
; if this happens, don't overwrite the invader
cp erase_gr
jr nz, nobomb

ld (hl), bomb_gr

nobomb:
ld bc, 32
and a   ; just to clear carry
sbc hl, bc
ld a, (hl)
cp bomb_gr
jr nz, noblank
ld (hl), erase_gr

noblank:

pop hl

bombinactive:

inc hl
dec d
jr nz, bombloop

jp (iy)
