; load screen address into hl for given xy position stored in bc (xy)

display_start: equ 9216

ld h, 0
ld l, c
ld c, b
; x coord is allowed to be negative as invader block can start off screen
ld b, 0
bit 7, c
jr z, notneg
ld b, 255
notneg:
sla l
sla l
sla l       ; y val wil be max 24, so we can get away with 3 shifts of lsb
add hl, hl
add hl, hl  ; hl = y * 32
add hl, bc  ; + x
ld bc, display_start
add hl, bc
ret
