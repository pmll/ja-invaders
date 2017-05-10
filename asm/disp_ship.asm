; display player ship

include 'data.inc'

ship_display_start: equ display_start + (22 * 32)

ld b, 0
ld hl, ship_display_start
ld a, (ship_x)
ld c, a

srl c
srl c
srl c

and 7
ld d, a
sla d

ld hl, ship_display_start
add hl, bc

ld a, (old_ship_x)
srl a
srl a
srl a

cp c
jr z, ship
jr c, blank_left

; blank right of ship
inc hl
inc hl
ld (hl), erase_gr
dec hl
dec hl
jr ship

blank_left:
dec hl
ld (hl), erase_gr
inc hl

ship:
ld (hl), d
inc hl
inc d
ld (hl), d

jp (iy)     ; return control to caller
