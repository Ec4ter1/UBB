bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 7
    b dw 5
    c dd 9
    d dq 4
;(a+b)-(a+d)+(c-a), uns
; our code starts here
segment code use32 class=code
    start:
        ;(a+b)
        mov al, [a]; al=07h
        mov ah, 0; ax=0007h
        add ax, [b]; ax=000Ch
        ;(c-a)
        mov ebx, [c]; ebx= 0000 0009h
        mov edx, 0
        mov dl, [a]; edx= 0000 0007h
        sub ebx, edx; ebx= 0000 0002h
        ;(a+b)+(c-a)
        mov ecx, 0
        mov cx, ax; ecx= 0000 000Ch
        add ecx, ebx; ecx= 0000 000Eh
        ;(a+d)
        push ecx
        mov ebx, 0
        mov edx, [d+4]; edx= 0000 0000h
        mov eax, [d]; eax= 0000 0004h
        add bl, [a]; bl= 07h, ebx = 0000 0007h
        mov ecx, 0
        add eax, ebx; eax= 0000 000Bh
        adc edx, ecx
        ;(a+b)-(a+d)+(c-a)
        pop ebx
        mov ecx, 0
        sub ebx, eax; ebx=0000 0003h
        sbb ecx, edx
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
