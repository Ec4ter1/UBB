bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
;13. Dandu-se 4 octeti, sa se obtina in AX suma numerelor intregi reprezentate de bitii 4-6 ai celor 4 octeti.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    o1 db 11111111b
    o2 db 10101010b
    o3 db 11001100b
    o4 db 00000000b

; our code starts here
segment code use32 class=code
    start:
        mov al, [o1]
        and al, 01110000b
        mov cl, 4
        shr al, cl; al = 07h
        
        mov bl, [o2]
        and bl, 01110000b
        mov cl, 4
        shr bl, cl; bl = 02h
        add al, bl; al =09h
        
        mov bl, [o3]
        and bl, 01110000b
        mov cl, 4
        shr bl, cl; bl = 02h
        add al, bl; al = 0Dh
        
        mov bl, [o4]
        and bl, 01110000b
        mov cl, 4
        shr bl, cl; al = 02h
        add al, bl
        cbw
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
