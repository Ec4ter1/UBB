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
    
;x+a/b+c*d-b/c+e, s
; our code starts here
segment code use32 class=code
    start:
        ;a/b
        mov al, [a]; al=08h
        cbw; ax=0008h
        idiv byte [b]; ax=0002h
        cwde; eax= 00000002h
        ;c*d
        mov ebx, eax; ebx=00000002h
        mov al, [d]; al=06h
        cbw; ax=0006h
        imul word [c];dx=0000h ax=000Ch
        push dx
        push ax
        pop eax; eax= 0000 000Ch
        ;a/b+c*d
        add ebx, eax; ebx=0000000Eh
        ;b/c
        mov al, [b]; al=04h
        cbw; ax=0004h
        cwd; eax= 0000 0004h
        idiv word [c];dx= 0000h ax=0002h
        push dx
        push ax
        pop eax
        ;a/b+c*d-b/c
        sub ebx, eax; ebx= 0000000Ch
        ;a/b+c*d-b/c+e
        mov eax, [e]; eax= 00000005h
        add eax, ebx; eax= 00000011h
        cdq; edx:eax
        ;x+a/b+c*d-b/c+e
        mov ecx, [x+4]; ecx= 0000 0000h
        mov ebx, [x]; ebx= 00000007h
        add eax, ebx; eax= 0000 0018h
        adc edx, ecx; edx= 0000 0000h
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
