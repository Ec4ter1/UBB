; Ne propunem ca programul de mai jos sa citeasca de la tastatura un numar si sa afiseze pe ecran valoarea numarului citit impreuna cu un mesaj.
bits 32
global start        

; declararea functiilor externe folosite de program
extern exit, printf, scanf  ; adaugam printf si scanf ca functii externe           
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll      ; similar pentru scanf
                          
segment  data use32 class=data
	n dd 0       ; in aceasta variabila se va stoca valoarea citita de la tastatura
	message1  db "Nr n vazut ca nr unsigned este %u ", 0
    msg2 db 10, 13, "Nr in hexa e %X",0
	format  db "%d", 0  
    
segment  code use32 class=code
    start:
                                               
        ; punem parametrii pe stiva de la dreapta la stanga
        push  dword n       ; ! adresa lui n, nu valoarea
        push  dword format
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2     ; eliberam parametrii de pe stiva; 4 = dimensiunea unui dword; 2 = nr de parametri
        
        ;convertim n la dword pentru a pune valoarea pe stiva 
        mov  eax, [n]
        
        ;afisam mesajul si valoarea lui n
        push  eax
        push  dword message1
        call  [printf]
        add  esp,4*2 
        
        mov eax, [n]
        push eax
        push dword msg2
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push  dword 0     ; punem pe stiva parametrul pentru exit
        call  [exit]       ; apelam exit pentru a incheia programul