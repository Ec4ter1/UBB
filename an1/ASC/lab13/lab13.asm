bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
        max equ 50
        s1 times max+1 db 0
        s2 times max+1 db 0
        s3 times max+1 db 0
        d times 2*max+1 db 0

; our code starts here
segment code use32 class=code
    start:
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
