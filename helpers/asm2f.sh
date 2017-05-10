#!/bin/sh

# uses z80asm cross assembler http://www.nongnu.org/z80asm/
z80asm -I asm $1 && cat a.bin | genforth
