; pause for a given number of fiftieths of second (up to 255)

frames: equ 0x3C2B

rst 24  ; pop forth stack -> DE

loop:
; this doesn't work so well as xAce does not correctly emulate halt
halt
dec e
jr nz, loop

jp (iy)
