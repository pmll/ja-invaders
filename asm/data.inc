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

; constants
inv_rows:       equ 4
inv_cols:       equ 10
display_start:  equ 9216
invader_gr:     equ 16
erase_gr:       equ 32
barricade_gr:   equ erase_gr + 128    ; reverse video space
explode_gr:     equ 42
missile_gr:     equ 24
