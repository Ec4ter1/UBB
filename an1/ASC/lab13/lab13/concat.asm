bits 32

extern _citireSirC
extern _str1
extern _str2
extern _str3
global _asmConcat

segment data public data use32
    lenRez                dd        0
    adresaSirRezultat     dd        0
    adresaSirParam        dd        0
    adresaSirCitit        dd        0
    mesaj                 db        "Sirul 2 citit din modulul asm: ", 0

segment code public use32
; int asmConcat(char[], char[])
; Conventia de apel: _cdecl
_asmConcat:

    ; Codul de intrare
    ; -----------------------------------------------------------
    ; - creare cadru de stiva pentru programul apelat
    push ebp
    mov ebp, esp
    
    ; - rezervam spatiu pe stiva pentru variabilele locale
    sub esp, 4*3                    ; rezervam pe stiva 4*3 de octeti pentru sirul citit de la tastatura
    ; -----------------------------------------------------------
    
    ; argumentele transmise pe stiva functiei asmConcat
    ; la locatia [ebp] se afla valoarea EBP pentru apelant
    ; la locatia [ebp+4] se afla adresa de revenire (valoarea din EIP la momentul apelului)
    mov eax, [ebp + 8]                          ; primul parametru se afla la EBP + 8
    mov [adresaSirParam], eax
    
    mov eax, [ebp + 12]                         ; al doilea parametru se afla la EBP + 12
    mov [adresaSirRezultat], eax
    
    ; salvam adresa sirului care va fi citit
    mov [adresaSirCitit], ebp
    sub dword [adresaSirCitit], 4*3
    
    ; Codul de apel
    ; -----------------------------------------------------------
    ; afisam un mesaj pentru utilizator
    push dword mesaj
    call _printf
    add esp, 4*1
    
    ; Codul de apel
    ; -----------------------------------------------------------
    ; apelam functia citireSirC din C pentru a citi cel de-al doilea sir
    push dword [adresaSirCitit]
    call _citireSirC
    add esp, 4*1
    ; -----------------------------------------------------------
    
    ; concatenam sirurile
    ; copiem sirul transmis ca parametru procedurii (sir1) in sirul rezultat
    cld
    mov edi, [adresaSirRezultat]
    mov esi, [adresaSirParam]
    mov ecx, 10
    rep movsb
    
    ; copiem sirul citit de la tastatura (sirCitit) in sirul rezultat
    add dword [lenRez], 10
    mov esi, [adresaSirCitit]
    mov ecx, 10
    rep movsb
    
    ; copiem sirul definit global in programul C (sir3) in sirul rezultat
    add dword [lenRez], 10
    mov esi, _str3
    mov ecx, 10
    rep movsb
    add dword [lenRez], 10
    
    ; Codul de iesire
    ; -----------------------------------------------------------
    ; - restaurarea resurselor nevolatile care au fost alterate
    ; !! nu am salvat valorile registrilor in codul de apel
    ; daca se doreste acest lucru se poate face cu instructiunile PUSHAD si restaurarea lor cu POPAD
    
    ; - stergem spatiul rezervat pe stiva
    add esp, 4*3
    
    ; - refacem cadrul de stiva al programului apelant
    ; cele doua instructiuni ce refac cadrul de stiva pot fi inlocuite cu instructiunea leave
    mov esp, ebp
    pop ebp
    
    
    