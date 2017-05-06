; update invaders values: bottommost, leftmost, rightmost and invaders left

; d will be row but numbered from top to bottom 4, 3, 2, 1
; e will be column but numbered from left to right 8, 7, 6, 5, 4, 3, 2, 1

leftmost_inv: equ 0x07ED
rightmost_inv: equ 0x08ED
bottommost_inv: equ 0x09ED
invaders_left: equ 0x0AED

ld a, d
ld (bottommost_inv), a      ; we are always at the lowest row visited

ld a, (leftmost_inv)
cp e
jr nc, not_more_left

ld a, e
ld (leftmost_inv), a

not_more_left:

ld a, (rightmost_inv)
cp e
jr c, not_more_right

ld a, e
ld (rightmost_inv), a

not_more_right:

ld a, (invaders_left)
inc a
ld (invaders_left), a

ret
