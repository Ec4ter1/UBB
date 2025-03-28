bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern printf, scanf
import printf msvcrt.dll
import scanf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 0
    b dd 0
    c dd 0
    format_d db "%d" ,0
    format_h db "%h" ,0

; our code starts here
segment code use32 class=code
    start:
        push dword a
        push dword format_d
        call [scanf]
        add esp, 4*2
        
        
        push dword b
        push dword format_d
        call [scanf]
        add esp, 4*2
        
       
        push dword c
        push dword format_d
        call [scanf]
        add esp, 4*2
        
        mov ax, [a]
        add ax, [b]
        add ax, [c]
        mov bl, 3
        idiv bl
        
        push eax
        push dword format_d
        call [printf]
        add esp, 4*2

    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
