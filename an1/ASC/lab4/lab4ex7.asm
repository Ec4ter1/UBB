bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se dau doua cuvinte A si B. Sa se obtina dublucuvantul C:
;bitii 0-4 ai lui C au valoarea 1
;bitii 5-11 ai lui C coincid cu bitii 0-6 ai lui A
;bitii 16-31 ai lui C au valoarea 0000000001100101b
;bitii 12-15 ai lui C coincid cu bitii 8-11 ai lui B

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 22BBh
    b dw 11BBh
    c dd 0

; our code starts here
segment code use32 class=code
    start:
        mov ax, [a]; 
        mov ebx, 0;
        ;c(5-11)=a(0-6)
        and ax, 0000000001111111b; ax=003Bh
        or bx, ax; bx=003Bh
        mov cl, 5
        rol ebx, cl; ebx=00000760h
        ;c(0-4)=1
        or bx, 0000000000011111b; ebx=0000077F
        ;c(12-15)=b(8-11)
        mov ax, [b]; ax=11BBh
        and ax, 0000111100000000b; ax=0100h
        mov cl, 8
        ror ax, cl; ax=0001h
        mov cl, 12
        ror ebx, cl; ebx=77F00000h
        or bl, al; ebx= 77F00001h
        rol ebx, cl; ebx= 0000177Fh
        ;c(16-31)=0000000001100101b
        mov cl, 16;
        ror ebx, cl;
        or bx, 0000000001100101b; ebx=177F0065h
        rol ebx, cl; ebx=0065177Fh
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
