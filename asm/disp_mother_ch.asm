; display mothership helper subroutine

; enter with a = x coord and c = char to emit
; uses de, hl
include 'data.inc'

mother_display_start: equ display_start + (32 * mother_y)

bit 7, a
ret nz

cp 32
ret nc

ld e, a
ld d, 0
ld hl, mother_display_start
add hl, de
ld (hl), c
ret
