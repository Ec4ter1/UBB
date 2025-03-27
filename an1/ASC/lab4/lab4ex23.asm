bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
;23. Se da octetul A si cuvantul B. Sa se formeze dublucuvantul C:
;bitii 24-31 ai lui C sunt bitii lui A
;bitii 16-23 ai lui C sunt inversul bitilor din octetul cel mai putin semnificativ al lui B
;bitii 10-15 ai lui C sunt 1
;bitii 2-9 ai lui C sunt bitii din octetul cel mai semnificativ al lui B
;bitii 0-1 se completeaza cu valoarea bitului de semn al lui A
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 11111111b
    b dw 1100110011001100b
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        mov eax, 0
        mov ah, [a]
        mov bx, [b]
        xor bl, 11111111b
        mov al, bl; ax = 1111 1111 0011 0011 = FFDD
        rol eax, 16
        mov ax, 0FFFFh
        mov al, bh
        shl ax, 2
        mov cl, [a]
        and cl, 10000000b
        rol cl, 1; cl =01h
        or al, cl
        rol cl, 1
        or al, cl
        
        
        
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
