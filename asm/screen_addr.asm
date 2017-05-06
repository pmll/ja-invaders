; load screen address into hl for given xy position stored in bc (xy)
; uses a 

display_start: equ 9216

ld hl, display_start
ld a, b

; set bc to y * 32
ld b, 0
sla c
sla c
sla c
sla c
rl b    ; c will have max value 24, so only now do we start to fill b
sla c
rl b

add hl, bc

; the x co-ord is allowed to be negative (the start column for the invader block
; can be off screen) so we must deal with that
ld b, 0
ld c, a
bit 7, c
jr z, notneg

ld b, 255

notneg:
add hl, bc
ret

