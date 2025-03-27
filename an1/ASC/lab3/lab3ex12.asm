bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
;12. (a*b+2)/(a+7-c)+d+x; a,c-byte; b-word; d-doubleword; x-qword
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1
    b dw 2
    c db 4
    d dd 2
    x dq 3

; our code starts here
segment code use32 class=code
    start:
        mov ah, 0
        mov al, [a]; ax = 0001h
        mul word [b]; dx:ax = 0000 0002h
        mov cx, 2
        mov bx, 0
        add ax, cx
        adc dx, bx; dx:ax = 0000 0004h
        mov bl, [a]
        add bl, 7
        sub bl, [c]; bl = 04h
        mov cx, 0
        mov cl, al
        div cx; dx:ax = 0000 0001h
        mov bx, [d+2]
        mov cx, [d]
        add ax, cx
        adc dx, bx
        mov ebx, [x+4]
        mov ecx, [x]
        add cx, ax
        add bx, dx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
