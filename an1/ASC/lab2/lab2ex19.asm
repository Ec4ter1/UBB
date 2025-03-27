bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;19. (e + g) * 2 / (a * c) + (h – f) + b * 3
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 1
    b db 2
    c db 3
    e dw 4
    f dw 5
    g dw 2
    h dw 7
    
; our code starts here
segment code use32 class=code
    start:
        mov ax, [e]; ax = 0004h
        add ax, [g]; ax = 0006h
        mov bx, 2
        mul bx; ax:dx = 000Ch
        push ax
        push dx
        mov al, [a]; al=01h
        mul byte [c]; ax = 03h
        mov bx, ax
        pop dx
        pop ax
        div bx; dx:ax = 04h
        mov bx, [h]; bx = 0007h
        sub bx, [f]; bx = 0002h
        mov cx, 0
        add ax, bx
        adc dx, cx
        push ax
        push dx
        mov bl, [b]
        mov al, 3
        mul bl; ax = 0006h
        mov bx, ax
        mov cx, 0
        pop dx
        pop ax
        add ax, bx
        adc dx, cx
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
