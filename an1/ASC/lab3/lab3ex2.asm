bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db -3
    b dw -5
    c dd +14
    d dq +2
;c-(d+a)+(b+c), s
; our code starts here
segment code use32 class=code
    start:
        ;(b+c)
        mov ax, [b]; ax=FFFBh
        cwde; eax=FFFF FFFBh
        add eax, [c]; eax=0000 0009h
        ;(d+a)
        push eax
        mov ebx, [d+4]; ebx= 0000 0000h
        mov ecx, [d]; ecx= 0000 0002h
        mov al, [a]; al=FDh
        cbw; ax=FFFDh
        cwde; eax= FFFF FFFDh
        cdq; edx:eax
        add ecx, eax; ecx= FFFF FFFFh
        adc ebx, edx; ebx= FFFF FFFFh
        ;c-(d+a)
        mov eax, [c]; eax=0000 000Eh
        cdq; edx:eax
        sub eax, ecx; eax= 0000 000Fh
        sbb edx, ebx; edx= 0000 0000h
        ;c-(d+a)+(b+c)
        mov ecx, eax
        mov ebx, edx
        pop eax; eax=0000 0009h
        cdq
        add eax, ecx; eax=0000 0018h
        adc edx, ebx; edx= 0000 0000h
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
