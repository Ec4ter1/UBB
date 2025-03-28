bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Se da un sir de octeti S de lungime l. Sa se construiasca sirul D de lungime l-1 astfel incat elementele din D sa reprezinte produsul dintre fiecare 2 elemente consecutive S(i) si S(i+1) din S.
;Exemplu:
;S: 1, 2, 3, 4
;D: 2, 6, 12

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1, 2, 3, 4
    l equ $-s 
    d times l dw 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, l-1
        mov esi, 0
        mov edi, 0
        jecxz Sfarsit
        Repeta:
            mov al, [s+esi]
            mov bl, [s+esi+1]
            imul bl
            mov [d+edi], ax
            inc esi
            inc edi
        loop Repeta
        Sfarsit:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
