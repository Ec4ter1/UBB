bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;18.Sa se citeasca de la tastatura un numar in baza 10 si un numar in baza 16. Sa se afiseze in baza 10 numarul de biti 1 ai sumei celor doua numere citite. Exemplu:
;a = 32 = 0010 0000b
;b = 1Ah = 0001 1010b
;32 + 1Ah = 0011 1010b
;Se va afisa pe ecran valoarea 4.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 0
    b db 0
    format1 db "%d", 0
    format2 db "%X", 0
    msg db "Suma este %d", 0

; our code starts here
segment code use32 class=code
    start:
        push dword a
        push  dword format1
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2  
        
        push dword b
        push  dword format2
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2 
        
        mov al, [a]
        mov bl, [b]
        add al, bl
        mov ecx, 8
        mov ebx, 0
        repeta:
            shr al, 1
            adc bl, 0
        loop repeta
        
        push ebx
        push  dword msg
        call  [printf]
        add  esp,4*2
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
