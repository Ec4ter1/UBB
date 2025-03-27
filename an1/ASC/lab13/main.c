/*++
Se cere un program C/C++ care apeleaza functia asmConcat scrisa in limbaj de asamblare. Aceasta functie primeste
ca si parametru un sir de caractere citit in programul C/C++, citeste un sir de caractere apelānd pentru aceasta
functia C/C++ citesteSir si mai acceseaza un sir de caractere care este o variabila globala a programului C/C++ (numita sirC).
Functia asmConcat construieste si intoarce ca rezultat sirul obtinut prin concatenarea primelor 10 caractere ale celor 3 siruri.
Acest sir va fi afisat pe ecran. Obs.: Sirurile citite de la tastatura nu contin spatii.
--*/


#include <stdio.h>
#include <string.h>

// functia declarata in fisierul modulConcatenare.asm
int citire();

// functia folosita pentru a citi un sir de la tastatura
void citireSirC(char sir[]);
int lung();

// sir global accesat din asmConcat
char str3[] = "0011223344";

int main()
{
    char str[100], * a, * b, * c;
    char dest[123] = "";
    char* d = dest + 0;
    int len1 = 0;
    int len2 = 0;


    len1 = lung();
    a = citire();
    printf("Sirul 1 e %s\n", a);
    strcpy(d, a);

    d = dest + len1;

    len2 = lung();
    b = citire();
    printf("Sirul 2 e %s\n", b);
    strcpy(d, b);

    d = dest + len1 + len2;
    c = citire();
    printf("Sirul 3 e %s\n", c);
    strcpy(d, c);

    printf("Sirul concatenat %s", dest);

    return 0;
}

void citireSirC(char sir[])
{
    scanf("%s", sir);
}