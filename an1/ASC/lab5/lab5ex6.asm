bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se da un sir de octeti S. Sa se construiasca sirul D astfel: sa se puna mai intai elementele de pe pozitiile pare din S iar apoi elementele de pe ;pozitiile impare din S.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1, 2, 3, 4, 5, 6, 7, 8
    l equ $-s
    d times l db 0
; our code starts here
segment code use32 class=code
    start:
        mov ecx, l; lungimea
        mov esi, 0; pt sirul s
        mov edi, 0; pt numerele pare
        mov edx, l-1; pt numerele impare
        jecxz Sfarsit
        Repeta:
            mov al, [s+esi]
            test al, 01h; zf= 1 par sau 0 impar
            jz par
            ;e impar
            push edi
            mov edi, edx
            mov [d+edi], al
            dec edx
            jnz sf_bucla
            par:
            pop edi
            mov [d+edi], al
            inc edi
            sf_bucla:
            inc esi
        loop Repeta
        Sfarsit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
