bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, scanf, printf, fprintf              
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll
import fopen msvcrt.dll    
import fprintf msvcrt.dll; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "fisier.txt", 0
    mod_access db "w", 0
    descriptor dd -1
    format_d db "%d", 0
    format_h db "%x", 0
    n dd 0
    m dd 0
    text db "nr %d", 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor], eax
        cmp eax, 0
        je final
        
        push dword n
        push dword format_d
        call [scanf]
        add esp, 4*2
        
        mov ecx,[n]

        repeta:
            push ecx
            
            push dword m
            push format_h
            call [scanf]
            add esp, 4*2
            
            mov bx, [m]
            cmp bh, bl; ah-al =?0
            ja bhm
            ;il punm pe bl
            mov al, bl
            cbw
            cwde
            push eax
            push dword [descriptor]
            call [fprintf]
            add esp, 4*2
            
            jmp mai_incolo
            bhm:
            ;il punem pe bh
            mov al, bh
            cbw
            cwde
            push eax
            push dword [descriptor]
            call [fprintf]
            add esp, 4*2
            
            mai_incolo:
            
            pop ecx
        loop repeta
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
