; display mothership

include 'data.inc'

ld a, (mother_state)
cp mother_waiting
jr z, done

cp mother_dying
jr nz, in_flight

; mothership is dying, blank it out and set it to waiting
ld a, (mother_x)
ld c, erase_gr
ld b, 3

erase_loop:
call disp_mother_ch
inc a
djnz erase_loop

ld a, mother_waiting
ld (mother_state), a
    
jr done
    
in_flight:
ld a, (mother_dir)
bit 7, a
jr z, going_right

; going left
ld a, (mother_x)
ld c, mother_gr
call disp_mother_ch
add a, 3
ld c, erase_gr
call disp_mother_ch
jr done

going_right:
ld a, (mother_x)
dec a
ld c, erase_gr
call disp_mother_ch
add a, 3
ld c, mother_gr
call disp_mother_ch

done:
jp (iy)
