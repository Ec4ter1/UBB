bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program

extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll
import printf msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd -1, 123456, 0abcdeffh, 0abcdeffh, 0
    format_s db "Sirul e %s", 0
    format db "%d", 0
    spatiu db " ", 0
    l equ ($-a)/4
    b times l dd 00000000h
    

; our code starts here
segment code use32 class=code
    suma:
        mov ecx, [esp+12] ;l 
        jecxz final
        cld
        mov esi, [esp+8];a
        mov edi, [esp+4];b
        
        repo3:
            push ecx
            ;mov eax, [a+esi]
            lodsd
     
            ;suma unui elem
            mov ecx, 8
            mov edx, 0
            repi2:
                push ecx
                mov ecx, 4
                mov ebx, 0
                repeta:
                    ror eax, 1
                    rcl bl, 1
                loop repeta
                add edx, ebx
                pop ecx
            loop repi2
            pushad
            push edx
            push dword format
            call [printf]
            add esp, 4*2
            
            push dword spatiu
            call [printf]
            add esp, 4
            popad
            mov eax, edx
            stosd
            ; mov [b+edi], edx
            ; inc edi
            ; inc edi
            ; inc edi
            ; inc edi
            
            ; inc esi
            ; inc esi
            ; inc esi
            ; inc esi
            
            pop ecx
        loop repo3
        final:
        ret 4*3
        
    start:
        push l
        push a
        push b
        call suma
        
        push dword b
        push dword format_s
        call [printf]
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
