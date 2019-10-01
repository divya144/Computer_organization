
; Objectives: To enocde a given string in nasm language
; Inputs: String
; Outputs: Encoded string

%include "io.mac"

.DATA
prompt_msg1 db "Please input the string: ",0
prompt_msg2 db "Output string: ",0
prompt_msg3 db "want to continue: ",0
Add EAX,2

.UDATA
s resb 21
flag resb 1

.CODE
.STARTUP
l1:
  PutStr prompt_msg1
  GetStr s,21
  mov EBX,s
  PutStr prompt_msg2

process_char:
    mov AL,[EBX]
    cmp AL,0
    je l3
    cmp AL,'0'
    je final

    cmp AL,'9'
    jg final

    cmp AL,'9'
    jg encode9

    cmp AL,'3'
    jge loop2

    cmp AL,'0'
    jge loop1

    cmp AL,'9'
    jl loop2

    cmp AL,'2'
    jle loop1

loop1:
    add AL,'X'-'0'
    PutCh AL
    jmp print
loop2:
    add AL,'A'-'3'
    PutCh AL
    jmp print
encode9:
  mov AL,'0'
  PutCh AL
  jmp print

print:
  inc EBX
  jmp process_char

final:
  PutCh AL
  jmp print

l3:
  ;PutStr s
  nwln
  PutStr prompt_msg3
  GetStr flag,1
  cmp byte[flag],'y'
  je l1
  cmp byte[flag],'Y'
  je l1
done:
  .EXIT
