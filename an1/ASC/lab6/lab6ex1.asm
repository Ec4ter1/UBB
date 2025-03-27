bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Se da un sir de dublucuvinte continand date impachetate (4 octeti scrisi ca un singur dublucuvant). Sa se obtina un nou sir de dublucuvinte, in care fiecare dublucuvant se va obtine dupa regula: suma octetilor de ordin impar va forma cuvantul de ordin impar, iar suma octetilor de ordin par va forma cuvantul de ordin par. Octetii se considera numere cu semn, astfel ca extensiile pe cuvant se vor realiza corespunzator aritmeticii cu semn.
;Exemplu:
;pentru sirul initial:
;127F5678h, 0ABCDABCDh, ... 
;Se va obtine:
;006800F7h,  0FF56FF9Ah 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dd 127F5678h, 0ABCDABCDh
    l equ $-s
    d times l dd 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, l
        jecxz final
        cld
        mov esi, s
        mov edi, d
        Repeta:
            lodsd; eax <= <ds:esi>
            mov bl, al
            ror eax, 8
            add bl, ah; ebx = 0000 00F7
            rol ebx, 16
            mov bl, al
            ror eax, 8
            add bl, ah; ebx = 00F7 0068
            ror ebx, 16
            mov eax, ebx
            stosd; <es:edi> <= eax
        loop Repeta
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
