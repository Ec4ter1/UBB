bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se da un sir de caractere S. Sa se construiasca sirul D care sa contina toate literele mari din sirul S.
;Exemplu:
;S: 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'
;D: 'A', 'B', 'M'
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 'a', 'A', 'b', 'B', '2', '%', 'x', 'M'
    l equ $-s
    d times l db 0
; our code starts here
segment code use32 class=code
    start:
        mov ecx, l; lungimea sirului
        mov esi, 0; i=0
        mov edi, 0; j=0
        jecxz Sfarsit      
        Repeta:
            mov al, [s+esi]
            mov bl, 61h; codul ascii pt 'a'
            cmp bl, al; 61-caracter 
            jbe mica 
            mov bl, 41h; codul ascii pt 'A'
            cmp al, bl
            jb mica
            mov [d+edi], al
            inc edi; j++
            mica:
            inc esi; i++
        loop Repeta
        Sfarsit:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
