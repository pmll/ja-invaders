; release a free bomb

include 'data.inc'

inv_state_final_row: equ 0x14ED     ; inv_state + inv_cols * (inv_rows - 1)

; locate a free bomb to release

ld hl, bombs
ld b, max_bombs
inc hl

bombloop:
ld a, (hl)
cp ship_y + 2
jr z, bombfound
inc hl
inc hl
djnz bombloop
; they're all in flight
jr done

bombfound:
; we have a free bomb, let's find an invader to release it, maybe
push hl

ld b, inv_cols
ld a, (last_dropper)

invcolloop:
; increment column number but keep it modulo inv_cols
inc a   
cp inv_cols
jr c, colok
sub a, inv_cols

colok:
ld hl, inv_state_final_row
ld d, 0
ld e, a
add hl, de

ld c, inv_rows

invrowloop:
ld d, (hl)
dec d
dec d
jr nz, noinv  ; 2 indicates a live invader

; we found an invader, but he's not sure if he wants to release a bomb
; so he tosses a slightly dodgy coin...
push hl
ld d, a
ld a, (bomb_rel_idx)
inc a
ld (bomb_rel_idx), a
ld h, 0
ld l, a
bit 0, (hl)
pop hl
jr z, foundinv
ld a, d
; the bottom invader of this column has turned down the chance to drop a bomb
; move on to the next column
jr nextcol

noinv:
ld d, 0
ld e, inv_cols
and a       ; clear carry
sbc hl, de
dec c
jr nz, invrowloop

nextcol:
; no invader found in this column
djnz invcolloop

; no invader found willing to take up the challenge
pop hl
jr done

foundinv:
; for our found invader, d contains the column offset, c contains the row
; offset + 1, the address of our bomb store+1 is on the stack
ld a, d
ld (last_dropper), a
pop hl
dec c
sla c
inc c
ld a, (inv_y)
add a, c
ld (hl), a
dec hl
sla d
ld a, (inv_x)
add a, d
ld (hl), a

done:
jp (iy)

