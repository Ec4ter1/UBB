bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, scanf, printf, fprintf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll  
import scanf msvcrt.dll 
import printf msvcrt.dll 
import fprintf msvcrt.dll 
import fopen msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    max equ 50
    nume_fisier times max db 0
    d times max db 0
    m times max db 0
    format_s db "%s", 0
    mod_access db "w", 0
    descriptor dd -1

; our code starts here
segment code use32 class=code
    start:
        push dword nume_fisier
        push dword format_s
        call [scanf]
        add esp, 4*2
        
        push dword nume_fisier
        push dword format_s
        call [printf]
        add esp, 4*2
        
        push dword mod_access
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor],eax
        
        cmp eax, 0
        je final
        
        mov ecx,11
        mov esi, 10
        mov edi, 0
        mov ebx, 0
        
        repeta:
        mov al, [nume_fisier+esi]
        cmp al, "a"
        jb maj
        ;al>"a"
        mov [d+edi], al
        inc edi
        jmp mai_inc
        
        cmp 
        maj:
        mov [m+ebx], al
        inc ebx
        mai_inc:
        dec esi
        loop repeta
        
        push dword d
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        push dword mai_inc
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
