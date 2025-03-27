bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se da quadwordul A. Sa se obtina numarul intreg N reprezentat de bitii 17-19 ai lui A. Sa se obtina apoi in B dublucuvantul rezultat prin rotirea spre ;stanga a dublucuvantului superior al lui A cu N pozitii. Sa se obtina octetul C astfel:
;bitii 0-2 ai lui C sunt bitii 9-11 ai lui B
;bitii 3-7 ai lui C sunt bitii 20-24 ai lui B

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dq 77EECCDD22AABB11h
    n db 0
    b dd 0
    c db 0

; our code starts here
segment code use32 class=code
    start:
        ;n=a(17-19)
        mov edx, [a+4]; edx= 77EECCDDh
        mov eax, [a]; eax= 22AABB11h
        and eax, 00000000000011100000000000000000b; eax=000A0000h
        mov cl, 17
        ror eax, cl; eax=0000 0005h
        mov cl, al; cl=05h= n
        ;b= a rotit spre stanga de n ori
        rol edx, cl; edx=b=FDD99BAE
        ;gasim b(9-11) si b(20-24)
        and edx, 00000001111100000000111000000000b; edx=01D00A00h
        ;c(0-2)=b(9-11)
        mov cl, 9
        ror edx, cl; edx=0000E805h
        mov bl, al; bl=05h
        mov cl, 8
        ror edx, cl; edx=050000E8h
        or bl, dl; bl= EDh= c
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
