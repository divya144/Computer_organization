# Computer_organization
This repository contains assembly code of some programs using nasm assembler. 
 
Command to run the code:<br/>
nasm -f elf32 -g  -F stabs program.asm  -l program.ls <br/>
ld  -m  elf_i386 -o program program.o  io.o 
./program
