bits 32

global start

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    a dd 0
    b dd 0
    c dd 0
    format_d db "%d" ,0
    format_h db "%h" ,0
    
segment code use32 class=code
start:
    push dword a
    push dword format_d
    call [scanf]
    add esp, 4*2
    
    mov eax, [a]

    ; push dword [a]
    ; push dword format_d
    ; call [printf]
    ; add esp, 4*2
    
    push dword b
    push dword format_d
    call [scanf]
    add esp, 4*2
    
    add eax, [b]
    
    ; push dword [b]
    ; push dword format_d
    ; call [printf]
    ; add esp, 4*2
    
    push eax
    call [printf]
    add esp, 4*2
    
    push dword 0
    call [exit]