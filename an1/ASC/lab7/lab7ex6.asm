bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll   
import printf msvcrt.dll
import scanf msvcrt.dll   
                            ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
;Se dau doua numere naturale a si b (a: dword, b: word, definite in segmentul de date). Sa se calculeze a/b si sa se afiseze catul impartirii in urmatorul format: "<a>/<b> = <cat>"
;Exemplu: pentru a = 200 si b = 5 se va afisa: "200/5 = 40"
;Valorile vor fi afisate in format decimal (baza 10) cu semn.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd 6
    b dw 4
	message1  db "nr %d / %d =", 0
    message2 db " %d ", 0
	format  db "%d", 0  

; our code starts here
segment code use32 class=code
    start:
        ;citim a
        ;push  dword a    ; punem pe stiva adresa lui a
        ;push  dword format
        ;call  [scanf]       ; apelam functia scanf pentru citire
        ;add  esp, 4 * 2
        
        
        ;citim b
        ;push  dword b       
        ;push  dword format
        ;call  [scanf]       ; apelam functia scanf pentru citire
        ;add  esp, 4 * 2
        ;mov bx, [b]
        ;afisam "a/b="
        mov ax, [b]
        cwde
        ;afisam a si b
        push eax
        push dword [a]
        push dword message1
        call [printf]
        add esp, 4*3
       
        ;a/b
        mov bx, [b]
        mov ax, [a]
        mov dx, [a+2]
        div bx; ax:dx impartit la bx
        cwde; extindem catul din ax in eax
        ;mov ax, [b]
        ;cwde
        push eax
        ;afisam a/b
        push dword message2
        call [printf]
        add esp, 4*3
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
