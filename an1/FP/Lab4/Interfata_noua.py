from Functii import add_cheltuiala, read_ap, mod_cheltuiala, read_valid_number, read_valid_str, stergere_cheltuieli, acelasi_numar
from Functii import creare_apart
import datetime
from datetime import date, datetime
def introdu_date():
    apart=[{'nr': 1, 'suma': 12, 'tip': "apa", 'data' : "21.11.2022"}, {'nr': 2, 'suma': 9, 'tip': "canal", 'data' : "09.12.2023"}, {'nr': 4, 'suma': 2, 'tip': "gaz", 'data' : "09.12.2023"}]
    while True:
        cerere = input("Introdu cerere: ")
        l = cerere.split()
        if l[0]=="creeaza":
            nou=creare_apart(int(l[1]), int(l[2]), l[3], l[4])
            print(nou)
        if l[0]=="citeste":
            i=int(l[1])
            while int(i)!=0 :
                ap=creare_apart(int(l[2]), int(l[3]), l[4], l[5] )
                add_cheltuiala(apart, ap)
                i-=1
            print(apart)
        if l[0]=="modifica":
            care=creare_apart(int(l[1]), int(l[2]), l[3], l[4])
            print(care)
            print(l[8])
            if care in apart:
                indice = apart.index(care)
                apart[indice] = mod_cheltuiala(care, l[5], l[6], l[7], datetime.strptime(l[8], '%d.%m.%Y'))
            else:
                print("Invalid apartment option")
            print(apart)
        if l[0]=="sterge":
            nr = int(l[1])
            stergere_cheltuieli(apart, acelasi_numar, nr)
            print(apart)

introdu_date()