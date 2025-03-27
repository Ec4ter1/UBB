bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;24. (a + b + c) - d + (b - c)
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 2
    b dw 3
    c dd 1
    d dq 4

; our code starts here
segment code use32 class=code
    start:
        mov al , [a]
        cbw; ax = 0002h
        add ax, [b] ; ax = 0005h
        cwde; eax = 0000 0005h
        mov ebx, [c]
        add ebx, eax; ebx = 0000 0006h
        mov ax, [b]
        cwde; eax = 0000 0003h
        sub eax, [c]; eax = 0000 0002h
        add eax, ebx; eax = 0000 0008h
        cdq; edx:eax = 0000 0000 0000 0008h
        mov ebx, [d+4]; ebx = 0000 0000h
        mov ecx, [d]
        sub eax, ecx; eax =..2h
        sbb edx, ebx
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
