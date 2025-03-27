bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global concatenare        

; declare external functions needed by our program
extern exit, printf              ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

; our code starts here
segment code use32 class=code
concatenare:
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
