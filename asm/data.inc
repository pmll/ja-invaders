; common variable addresses and constants

; substitute these with forth vars
xyadd:              equ 0x00ED
inv_x:              equ 0x01ED
inv_y:              equ 0x02ED
old_inv_x:          equ 0x03ED
old_inv_y:          equ 0x04ED
inv_state:          equ 0x05ED
inv_anim_state:     equ 0x06ED
leftmost_inv:       equ 0x07ED
rightmost_inv:      equ 0x08ED
bottommost_inv:     equ 0x09ED
invaders_left:      equ 0x0AED
update_inv_stats:   equ 0x0BED
ship_x:             equ 0x0DED
old_ship_x:         equ 0x0EED
missile_x:          equ 0x0FED
missile_y:          equ 0x10ED
bombs:              equ 0x11ED
last_dropper:       equ 0x12ED
bomb_rel_idx:       equ 0x13ED
mother_x:           equ 0x15ED
mother_state:       equ 0x16ED
mother_dir:         equ 0x17ED
disp_mother_ch:     equ 0x18ED

; constants
inv_rows:         equ 5
inv_cols:         equ 10
ship_y:           equ 22
mother_y:         equ 2
mother_in_flight: equ 2
mother_dying:     equ 1
mother_waiting:   equ 0
max_bombs:        equ 5
display_start:    equ 9216
invader_gr:       equ 18
erase_gr:         equ 32
barricade_gr:     equ erase_gr + 128    ; reverse video space
explode_gr:       equ 42
missile_gr:       equ 24
bomb_gr:          equ 27
ship_gr:          equ 2
mother_gr:        equ 239     ; reverse video 'o'

