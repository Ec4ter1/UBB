bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate caracterele speciale (!@#$%^&*) din sirul S.
;Exemplu:
;S: '+', '4', '2', 'a', '@', '3', '$', '*'
;D: '@','$','*'

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db '+', '4', '2', 'a', '@', '3', '$', '*'
    l equ $-s
    d times l db 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, l
        mov esi, 0
        mov edi, 0
        jecxz Sfarsit
        Repeta:
            mov al, [s+esi]
            cmp al, 30h
            ja semn; nu e semn sare
                mov [d+edi], al
            semn:
            cmp al, 3Ah
            jb sf; sarim perste cifre
            cmp al,40h
            ja sf; sare la sfarsit daca e mai mare decat 40h adica e litera
                mov [d+edi], al
            
            sf:
            inc esi
            inc edi
        loop Repeta
        Sfarsit:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
