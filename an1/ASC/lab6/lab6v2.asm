bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dw -22, +145, -48, +127
    len equ ($-s)/2
    d times len db 0

; our code starts here
segment code use32 class=code
    start:
        mov ecx, len; lungimea sirului
        mov esi, 0; index pt s=> i=0
        mov edi, 0; index pt d=> j=0
        jecxz final
        repeta:
            push ecx
            ; citim wordul curent
            mov ax, word[s+esi]
            ;afla, daca negativ sau pozitiv
            rol ax, 1
            mov ecx, 8; vom repeta ciclul numara de 16 ori
            mov bl, 0; suma
            jc negativ
            ;e pozitiv
            ror ax, 1
            ;numaram 1 din nr pozitive
            numara1:
                shr ax, 1; bitul care iese e retinut in CF
                adc bl, 0; BL = BL + CF
                loop numara1
            jnc sf_bucla
            negativ:
            ror ax, 1
            mov ecx, 16
            ;numaram 0 din nr negative
            numara0:
                ;aflam mai intai cati biti de 1 sunt
                shr ax, 1; bitul care iese e retinut in CF
                adc bl, 0; BL = BL + CF
                loop numara0
            ;scadem din nr total de biti bitii de 1
            mov dl, 16;
            sub dl, bl
            mov bl, dl
            sf_bucla:
            mov [d+edi], bl
            inc edi; j++
            inc esi; i++
            inc esi; i++ pt ca avem word
            clc; clear carry
            pop ecx
        loop repeta
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
