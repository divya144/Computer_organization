;Objective: To multiply two matrx
;Input: 2 matrix
;Output: Multiplication of two matrix

%include "io.mac"
.DATA
prompt_msg0 db "matrix1 ",0
prompt_msg1 db "Enter the number of rows : ",0
prompt_msg2 db "Enter the number of columns : ",0
prompt_msg3 db "Enter the values of matrix1 ",0
prompt_msg8 db "Matrix 2 ",0
prompt_msg4 db "Enter the values of matrix2 ",0  
prompt_msg5 db "Matrix 1 is : ",0
prompt_msg6 db "Matrix 2 is : ",0
prompt_msg7 db "Multiplication of matrix1 and matrix2 : ",0
space db " ",0
abort_msg db "Matrix can't be multiplied :) ",0
count1 dw 0
count2 dw 0
count3 dw 0
sum dw 0
offset1 dd 0
offset2 dd 0
.UDATA
A resw 500
B resw 500
C resw 500
row1 resw 1
column1 resw 1
row2 resw 1
column2 resw 1
total1 resw 1
total2 resw 1
.CODE
    .STARTUP
;--------------------READING MATRIX1--------------------------------    
        PutStr prompt_msg0
        nwln
        PutStr prompt_msg1
        GetInt [row1]
        mov AX,[row1]
        cmp AX,0
        je abort

        PutStr prompt_msg2
        GetInt [column1]
        mov BX,[column1]
        cmp BX,0
        je abort

        imul AX,BX
        mov [total1],AX
        PutInt [total1]
        nwln

;-------------------------READING MATRIX2-------------------------------------
        PutStr prompt_msg8
        nwln
        PutStr prompt_msg1
        GetInt [row2]
        mov AX,[row2]
        cmp AX,0
        je abort

        PutStr prompt_msg2
        GetInt [column2]
        mov BX,[column2]
        cmp BX,0
        je abort

        mov AX,[column1]
        cmp AX,[row2]
        jne abort

        imul AX,BX
        mov [total2],AX
        PutInt [total2]
        nwln

        PutStr prompt_msg3
        nwln
        push word [total1]
        push  A
        call mat_read

        PutStr prompt_msg4
        nwln
        push word [total2]
        push B
        call mat_read
;----------------------------PRINTING BOTH MATRIX-----------------------------------
        PutStr prompt_msg5
        nwln
        push word [row1]
        push word [column1]
        push A
        call mat_print

        PutStr prompt_msg6
        nwln
        push word [row2]
        push word [column2]
        push B
        call mat_print 
;-----------------------------------Multiplying both matrix-----------------------------------------------
        
        push word[row1]
        push word[column1]
        push word[column2]
        push A
        push B
        push C
        call mat_mult

        PutStr prompt_msg7
        nwln
        push word [row1]
        push word [column2]
        push C
        call mat_print
          
done:
    .EXIT
 abort:
        PutStr abort_msg
        nwln
        jmp done
;-------------------------Function to read matrix--------------------------------
mat_read:
        enter 0,0
        mov ECX,[EBP+8]  
        mov AX,0
        read:
            GetInt BX
            mov [ECX],BX
            add ECX,2
            add AX,1
            cmp AX,[EBP+12]
            jne read
            read_end:
                    leave
                    ret 6
;-------------------------Function to print matrix------------------------------------                    
mat_print:
        enter 0,0
        mov EAX,[EBP+8]
        mov BX,0;for row
        mov CX,0;for column
        print:
            PutInt word [EAX]
            PutStr space
            add EAX,2
            inc CX
            cmp  CX,[EBP+12]
            jne print
            nwln
            mov CX,0
            inc BX;
            cmp BX,[EBP+14]
            jne print
            leave
            ret 8
;-----------------------------------------------------------------
mat_mult:
        enter 0,0
        ;C-->[EBP+8] 
        ; B-->[EBP+12] A-->[EBP+16]  
        ;column2-->[EBP+20]
        ; column1==row2---->[EBP+22] row1-->[EBP+24]
       ; PutInt [EBP+20]
       ; PutInt [EBP+22]
        mov EAX,[EBP+16]
        mov EBX,[EBP+12]
        mov ECX,[EBP+8]
        mov EDX,0
        mulLoop:
            mov word[count2],0
            loop1:
                mov [sum], word 0
                mov [count3], word 0
                loop2:
                    mov DX,word [count1]
                    imul DX,[EBP+22]
                    add DX, word [count3]
                    mov [offset1],DX
                    
                    mov DX,word [count3]
                    imul DX,[EBP+20]
                    add DX,word [count2]
                    mov[offset2],DX
                    add EAX,[offset1]
                    add EAX,[offset1]
                    add EBX,[offset2]
                    add EBX,[offset2]                    
                    mov DX,[EAX]
                    imul DX,[EBX]
                    add [sum],DX                    
                ;     sub EAX,[offset1]
                ;     sub EBX,[offset2]
                ;     sub EAX,[offset1]
                ;     sub EBX,[offset2]
                        mov EAX,[EBP+16]
                        mov EBX,[EBP+12]

                    add [count3],word 1
                    mov DX,word [count3]
                    cmp DX,[EBP+22]
                jne loop2

                mov DX,word [sum]
                mov word [ECX],DX
                add ECX,2
                add [count2],word 1
                mov DX,[count2]
                cmp DX,[EBP+20]
            jne loop1
            add [count1],word 1
            mov DX,[count1]
            cmp DX,[EBP+24]
        jne mulLoop
        mulLoop_end:
                leave
                ret 18

                    




            




             





            
            

