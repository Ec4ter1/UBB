bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf  ; adaugam printf si scanf ca functii externe           
import exit msvcrt.dll     
import printf msvcrt.dll     ; indicam asamblorului ca functia printf se gaseste in libraria msvcrt.dll
import scanf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
extern concatenare
;6. Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    max equ 50
    s1 times max+1 db 0
    s2 times max+1 db 0
    s3 times max+1 db 0
    d times 2*max+1 db 0
    len1 dd 0
    len2 dd 0
    len3 dd 0
    
    format_d db "%d", 0
    format_r db "%s", 0
    format_p db "Sir final: %s", 13, 10, 0
    format db "Concat: %s,%s,%s", 13, 10, 0
    text_1 db "Dati primul sir: ", 0
    text_2 db "Dati al doilea sir: ", 0
    text_3 db "Dati al treilea sir: ", 0
    text_4 db "Dati lungimea: ", 0

; our code starts here
segment code use32 class=code

    concat:
            mov esi, [esp+16]; s1
            mov edi, [esp+4]; d
            mov ebx, [esp+28]; len1
            mov ecx, [ebx]; valoarea lui len1
            repeta:
                lodsb; incarca in al ce e in esi
                stosb; incarca in edi octetul din al
            loop repeta
            
            mov esi, [esp+12]; s2
            mov ebx, [esp+24]
            mov ecx, [ebx]
            repeta2:
                lodsb; incarca in al ce e in esi
                stosb; incarca in edi octetul din al
            loop repeta2
           
            mov esi, [esp+8]; s3
            mov ebx, [esp+24]; len3
            mov ecx, [ebx]
            repeta3:
                lodsb; incarca in al ce e in esi
                stosb; incarca in edi octetul din al
            loop repeta3
            
            ret 4*4
            
    start:
        ;Dati lungimea
        push dword text_4
        call [printf]
        add esp, 4
        push dword len1
        push dword format_d
        call [scanf]
        add esp, 4*2
        
        ;Dati primul sir
        push dword text_1
        call [printf]
        add esp, 4
        
        push  dword s1       ; ! adresa lui n, nu valoarea
        push  dword format_r
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2 
        
        push  dword s1
        push  dword format_p
        call  [printf]
        add  esp,4*2 
        
        ;Dati lungimea
        push dword text_4
        call [printf]
        add esp, 4
        push dword len2
        push dword format_d
        call [scanf]
        add esp, 4*2
        
        ;Dati al doilea sir
        push dword text_2
        call [printf]
        add esp, 4
        
        push  dword s2       ; ! adresa lui n, nu valoarea
        push  dword format_r
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2 
        
        push  s2
        push  dword format_p
        call  [printf]
        add  esp,4*2
        
        ;Dati lungimea
        push dword text_4
        call [printf]
        add esp, 4
        
        push dword len1
        push dword format_d
        call [scanf]
        add esp, 4*2
        
        ;Dati al treilea sir
        push dword text_3
        call [printf]
        add esp, 4
        
        push  dword s3       ; ! adresa lui n, nu valoarea
        push  dword format_r
        call  [scanf]       ; apelam functia scanf pentru citire
        add  esp, 4 * 2 
        
        push  dword s3
        push  dword format_p 
        call  [printf]
        add  esp,4*2
        
        push dword len1
        push dword len2
        push dword len3
        push dword s1
        push dword s2
        push dword s3
        push dword d
        call concatenare
        
        
        push dword d
        push format_p
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

     