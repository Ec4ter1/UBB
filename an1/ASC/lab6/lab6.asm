bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

                          
;Se da un sir de cuvinte s. Sa se construiasca sirul de octeti d, astfel incat d sa contina pentru fiecare pozitie din s:
;- numarul de biti de 0, daca numarul este negativ
;- numarul de biti de 1, daca numarul este pozitiv
;Exemplu:
;s: -22, 145, -48, 127
;in binary:
;1111111111101010, 0000 0000 1001 0001, 1111111111010000, 1111111
;d: 3, 3, 5, 7
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s dw -22, 145, -48, 127
    len equ ($-s)/2
    d times len db 0
    
; our code starts here
segment code use32 class=code
    start:
        mov ecx, len; lungimea sirului
        jecxz final
        cld
        mov esi, s
        mov edi, d
        repeta:
            push ecx
            ; citim wordul curent
            lodsw; Ax <- <DS:ESI> si inc ESI
            ;afla, daca negativ sau pozitiv
            rol ax, 1
            mov ecx, 16; vom repeta ciclul numara de 16 ori
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
            mov al, bl
            stosb ;<ES:EDI> <- AL si inc EDI
            pop ecx
        loop repeta
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
