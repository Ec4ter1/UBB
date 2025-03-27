bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global _citire  
global _lung
global _s1      

; declare external functions needed by our program
extern _printf
extern _scanf
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

;6. Se citesc trei siruri de caractere. Sa se determine si sa se afiseze rezultatul concatenarii lor.
; our data is declared here (the variables needed by our program)
segment data public data use32
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
    text_1 db "Dati sir: ", 0
    text_4 db "Dati lungimea: ", 0

; our code starts here
segment code public code use32
    _lung:
        push ebp
        mov ebp, esp
        
        ;Dati lungimea
        push dword text_4
        call _printf
        add esp, 4
        push dword len1
        push dword format_d
        call _scanf
        add esp, 4*2
        
        mov eax, [len1]
        mov esp, ebp
        pop ebp
        
        ret
        
    _citire:
    
        push ebp
        mov ebp, esp
        
        
        ;Dati primul sir
        push dword text_1
        call _printf
        add esp, 4
        
        push  dword s1       ; ! adresa lui n, nu valoarea
        push  dword format_r
        call  _scanf       ; apelam functia scanf pentru citire
        add  esp, 4 * 2 
        
        
        mov eax, s1
        mov esp, ebp
        pop ebp
        
        ret

     