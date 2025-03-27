bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf             ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import fopen msvcrt.dll  
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
                         ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;Se da un fisier text. Sa se citeasca continutul fisierului, sa se determine cifra cu cea mai mare frecventa si sa se afiseze acea cifra impreuna cu frecventa acesteia. Numele fisierului text este definit în segmentul de date.

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "fisier.txt", 0  ; numele fisierului care va fi creat
    mod_acces db "r", 0         ; modul de deschidere a fisierului - w - pt scriere. daca fiserul nu exista, se va crea                                   
    descriptor_fis dd -1
    len equ 100                                    
    text times len db 0 
    format db "Textul este: %s.", 0
    cifre db '0123456789'
    fr times 10 db 0
    msg db " Frecventa maxima e %d", 0
    msg2 db " a numarului %d", 0
    maxi dd 0
    nr dd 0

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
        
        ; citim textul in fisierul deschis folosind functia fread
        ; eax = fread(text, 1, len, descriptor_fis)
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4                 ; dupa apelul functiei fread EAX contine numarul de caractere citite din fisier
        
        ; afisam numarul de caractere citite si textul citit
        ; printf(format, eax, text)
        push dword text
        push dword format
        call [printf]
        add esp, 4*3
        
        mov ecx, 10; lungimea sirului cifre
        jecxz final
        cld
        mov esi, cifre
        et:
            lodsb; al <- <ds:esi> cifra
            mov dl, al
            push esi
            push ecx
            mov ecx, len
            mov ebx, 0
            mov esi, text; index pt sirul din fisier
            cif:
                lodsb; al<-cifra tx
                cmp dl, al
                jne incolo
                inc ebx
                incolo:
            loop cif
            ;gasim maixmul
            cmp [maxi], ebx
            jnl acolo
            mov dword [maxi], ebx
            mov byte [nr], dl
            acolo:
            pop ecx
            pop esi
        loop et
        ;afisam maximul
        push dword [maxi]
        push dword msg
        call [printf]
        add esp, 4*2
        ;afisam numarul
        mov al, [nr]
        sub al, '0'
        cbw
        cwde
        push eax
        push dword msg2
        call [printf]
        ; apelam functia fclose pentru a inchide fisierul
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        final:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
