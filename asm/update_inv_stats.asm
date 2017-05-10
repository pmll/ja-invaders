; update invaders values: bottommost, leftmost, rightmost and invaders left

include 'data.inc'

; prime rightmost, leftmost, bottommost invader and invaders left
ld a, 0
ld (invaders_left), a
ld h, a         ; h = leftmost
ld l, inv_cols  ; l = rightmost
ld a, inv_rows
ld (bottommost_inv), a

ld bc, inv_state

ld d, inv_rows
rowloop:

ld e, inv_cols
colloop:

ld a, (bc)
cp 2
jr nz, notalive

ld a, d
ld (bottommost_inv), a      ; we are always at the lowest row visited

ld a, h
cp e
jr nc, not_more_left
ld h, e

not_more_left:

ld a, l
cp e
jr c, not_more_right
ld l, e

not_more_right:

ld (invaders_left), a

notalive:
inc bc ; advance to next invader state
dec e
jr nz, colloop

dec d
jr nz, rowloop

; fix up "back to front" leftmost, rightmost, bottommost
ld a, inv_cols
sub h
ld (leftmost_inv), a

ld a, inv_cols
sub l
ld (rightmost_inv), a

ld hl, (bottommost_inv)
ld a, inv_rows
sub l
ld (bottommost_inv), a

jp (iy)     ; return control to caller
