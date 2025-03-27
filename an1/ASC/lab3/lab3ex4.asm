bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 8
    b db 4
    c dw 2
    d db 6
    e dd 5
    x dq 7

;x+a/b+c*d-b/c+e, uns
; our code starts here
segment code use32 class=code
    start:
        ;a/b
        mov al, [a]; Al=08h
        mov ah, 0; ah=00h , ax=0008h
        div byte [b]; ah=00, al=02h
        mov cx, ax; cx=0002
        ;c*d
        mov al, [d]
        mov ah, 0
        mul word [c]; dx=0000h ax=000Ch
        ;a/b+c*d
        mov bx, 0
        add cx, ax; cx=000Eh
        adc bx, dx; bx=0000h
        ;b/c
        mov eax, 0
        mov al, [b]; eax=0000 0004h
        div word [c];dx=0000h ax=0002h
        ;a/b+c*d-b/c
        sub cx, ax; cx=000Ch
        sbb bx, dx; bx=0000h
        push bx
        push cx
        pop eax; eax=0000 000Ch
        ;a/b+c*d-b/c+e
        add eax, [e]; eax=0000 0011h
        ;x+a/b+c*d-b/c+e
        mov edx, 0
        mov ecx, [x+4]; ecx=0000 0000h
        mov ebx, [x]; ebx= 0000 0007h
        add eax, ebx; eax=0000 0018h
        adc edx, ecx; edx=0000 0000h
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
