# Computer_organization
This repository contains assembly code of some programs using nasm assembler and cache-simulator<br/>
Command to run the code:<br/>
```console
nasm -f elf32 -g  -F stabs program.asm  -l program.ls
ld  -m  elf_i386 -o program program.o  io.o
./program
```
 
 
