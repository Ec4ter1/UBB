bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
        a dd 125
        b db 2
        c dw 15
        d db 200
        e dq 80

; our code starts here
segment code use32 class=code
    start:
        mov al, [b]; al=02h
        mov ah, 0; ax= 00 02h
        mov dx, 0; dx:ax=0000 0002h
        div word [c]; cat in ax
        mov bx, ax
        mov al, 2
        mul byte [d]; d*2 in ax
        sub bx, ax
        mov cx, 0; cx:dx
        mov ax, word [a]; [a+0]
        mov dx, word [a+2]
        add ax, bx
        adc dx, cx
        push dx
        push ax
        pop eax
        mov edx, 0
        sub eax, dword[e]
        sbb edx, dword[e+4]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
