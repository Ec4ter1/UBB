bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;19. Sa se citeasca de la tastatura un octet si un cuvant. Sa se afiseze pe ecran daca bitii octetului citit se regasesc consecutiv printre bitii cuvantului. Exemplu:
;a = 10 = 0000 1010b
;b = 256 = 0000 0001 0000 0000b
;Pe ecran se va afisa NU.
;a = 0Ah = 0000 1010b
;b = 6151h = 0110 0001 0101 0001b
;Pe ecran se va afisa DA (bitii se regasesc pe pozitiile 5-12).
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    o db 0
    c dw 0
    format db "%d", 0
    msg1 db "Da", 0
    msg2 db "Nu", 0

; our code starts here
segment code use32 class=code
    start:
        push dword o
        push  dword format
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2  
        mov al, [o]
        
        push dword c
        push  dword format
        call  [scanf]       
        add  esp, 4 * 2 
        mov bx, [c]
        
        mov ecx, 16
        repeta:
        
        loop repeta
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
