bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;[2*(a+b)-5*c]*(d-3)
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    mov al, [a]
        add al, [b]
        mov bl, 2
        mul bl
        mov cx, ax
        mov al, 5
        mul byte [c]
        sub cx, ax
        mov ax, [d]
        sub ax, 3
        mul cx

; our code starts here
segment code use32 class=code
    start:
        ; ...
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
