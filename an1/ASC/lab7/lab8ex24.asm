bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf, fprintf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll  
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import fprintf msvcrt.dll   ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;24. Se dau un nume de fisier si un text (definite in segmentul de date). Textul contine litere mici, litere mari, cifre si caractere speciale. Sa se inlocuiasca toate CIFRELE din textul dat cu caracterul 'C'. Sa se creeze un fisier cu numele dat si sa se scrie textul obtinut prin inlocuire in fisier.

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "lab8_t.txt", 0  ; numele fisierului care va fi creat
    nume_fisier2 db "lab8_w.txt", 0
    mod_acces db "r", 0
    mod_acces2 db "w", 0
    descriptor_fis dd -1
    len equ 100                                    
    text times len db 0 
    d times len db 0
    format db "Textul este: %s.", 0

; our code starts here
segment code use32 class=code
    start:
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]
        add esp, 4*2                ; eliberam parametrii de pe stiva

        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        cmp eax, 0     ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        je final
        
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4
        
        push dword text
        push dword format
        call [printf]
        add esp, 4*3
        
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4

        
        mov ecx, len
        cld
        mov esi, text
        mov edi, d
        jecxz final
        repeta:
            lodsb; al<-primul elem text
            cmp al, 30h
            jb nu
            cmp al, 39h
            ja nu
            mov al, "C"
            nu:
            stosb
        loop repeta
        
        push dword d
        push dword format
        call [printf]
        add esp, 4*3
        
        push dword mod_acces2     
        push dword nume_fisier2
        call [fopen]
        add esp, 4*2 
        
        mov [descriptor_fis], eax
        
        cmp eax, 0
        je final
        
        push dword text
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*2



        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
