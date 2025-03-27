bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, scanf, printf, fprintf, fread             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll  
import scanf msvcrt.dll 
import printf msvcrt.dll 
import fprintf msvcrt.dll 
import fopen msvcrt.dll
import fread msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    max equ 50
    len equ 100
    text times len db 0
    text2 times len db 0
    nume_fisier times max db 0
    d times max db 0
    m times max db 0
    format_s db "%s", 0
    mod_access_w db "w", 0
    mod_access_r db "r", 0
    descriptor dd -1
    format_d db "%d", 0
    p dd 0
    s dd 0
    fis2 db "output.txt", 0

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
        
        push dword p
        push dword format_d
        call [scanf]
        add esp, 4*2
        
        push dword mod_access_r
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor],eax
        
        cmp eax, 0
        je final
        
        push dword [descriptor]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4
        
        mov edx, eax
        push edx
        push dword edx
        push dword format_d
        call [printf]
        add esp, 4*2
        
        mov ebx, 0
        mov eax, 0
        mov esi, 0
        mov ecx, 11
        repeta:
        mov al, [nume_fisier+esi]
        cmp al, 20h
        jb mai_inc
        cmp al, 2Dh
        ja mai_inc
        mov bl, al
        mai_inc:
        inc esi
        loop repeta
        
        
        push dword ebx
        push format_d
        call [printf]
        add esp, 4*2
        
        pop edx
        push dword [p]
        push dword format_d
        call [printf]
        add esp, 4*2
        
        mov ecx, [p]
        mov esi, 0
        mov edi, 0
        repeta2:
            mov [text+edi], bl
            inc edi
        loop repeta2
        
        push dword mod_access_w
        push dword fis2
        call [fopen]
        add esp, 4*2
        
        mov [descriptor], eax
        cmp eax, 0
        je final 
        
        push dword text
        push dword [descriptor]
        call [fprintf]
        add esp, 4*2
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
