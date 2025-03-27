bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;bitii 8-15 ai lui C sunt 0
;bitii 16-23 ai lui C coincid cu bitii lui 2-9 ai lui B
;bitii 24-31 ai lui C coincid cu bitii lui 7-14 ai lui A
;bitii 0-7 ai lui C sunt 1

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0111011101110111b
    n db 0
    b dw 0
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        ;n=a(0-2)
        mov cx, [a]; cx= 7777h
        and cl, 00000111b; cl=07h, n=0111b
        ;b= a rotit spre dreapta de n ori
        mov ax, [a]; ax=0111 0111 0111 0111b
        ror ax, cl; ax=EEEEh
        mov bx, ax; bx=b
        ;c(8-15)=0
        mov eax, [c]; eax = 00000000h
        ;c(0-7)=1
        or eax, 00000000000000000000000011111111b; eax=000000FFh
        ;c(16-23)=b(2-9)
        and bx, 0000001111111100b; bx= 02ECh, bx= 0000 0010 1110 1100b
        mov cl, 2
        ror bx, cl;bx=00BBh
        mov cl, 16
        ror eax, cl; eax=00FF0000h
        or ax, bx; ax=00BBh eax=00FF00BBh
        rol eax, cl; eax= 00BB00FFh
        ;c(24-31)=a(7-14)
        mov bx, [a]; bx=7777h
        and bx, 0111111110000000b; bx=7700h
        mov cl, 7
        ror bx, cl; bx= 0000 0000 1110 1110b, bx=00EEh
        mov cl, 24
        ror eax, cl; eax=BB00FF00h
        or al, bl; al=EEh eax=BB00FFEEh
        rol eax, cl; eax=EEBB00FFh
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
