# Computer_organization
This repository contains assembly code of some programs using nasm assembler.

# Command to run the code:
nasm -f elf32 -g  -F stabs program.asm  -l program.lst
ld  -m  elf_i386 -o program program.o  io.o
./program
