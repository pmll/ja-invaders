; add to score on screen

; add the value of a to our on screen score, uses hl

; only adds scores from 1 to 10

include 'data.inc'

right_digit: equ display_start + 11
ascii_zero: equ 48
ascii_nine: equ 57

ld hl, right_digit

carry_loop:
add a, (hl)
cp ascii_nine + 1
jr c, nocarry   ; looks confusing... if a <= '9' , we don't need to carry to next digit
sub 10
ld (hl), a
ld a, 1
dec hl
jr carry_loop

nocarry:
ld (hl), a

ret

