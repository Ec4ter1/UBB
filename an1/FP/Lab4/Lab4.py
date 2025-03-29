import datetime
from Functii import read_valid_str, copy_apartments, register_for_undo, read_valid_number, pop_undo_list, read_ap, add_cheltuiala, mod_cheltuiala, acelasi_numar,mica_suma, sortare, stergere_cheltuieli, cautari_cheltuieli, cautari_cheltuieli2, rapoarte, mare_suma, acelasi_tip, fsterge, inainte_de_ziua
from datetime import date
from Interfata_noua import introdu_date

"""Creați o aplicație pentru gestiunea cheltuielilor lunare de la apartamentele unui
bloc de locuințe. Aplicația stochează cheltuielile pentru fiecare apartament:
suma și tipul cheltuielii (tip poate fi una dintre: apa, canal, încălzire, gaz, altele).
Aplicația permite:"""
def print_menu():
    print("""
    1. Citeste date
    2. Adauga cheltuiala pentru un apartament
    3. Modifică cheltuială
    4. Șterge toate cheltuielile de la un apartament
    5. Șterge cheltuielile de la apartamente consecutive
    6. Tipărește toate apartamentele care au cheltuieli mai mari decât o sumă dată
    7. Tipărește cheltuielile de un anumit tip de la toate apartamentele
    8. Tipărește toate cheltuielile efectuate înainte de o zi și mai mari decât o sumă (se dă suma și ziua)
    9. Tipărește suma totală pentru un tip de cheltuială
    10. Tipărește toate apartamentele sortate după un tip de cheltuială
    11. Tipărește totalul de cheltuieli pentru un apartament dat
    12. Elimină toate cheltuielile de un anumit tip
    13. Elimină toate cheltuielile mai mici decât o sumă dată
    14. Undo
    15. Iesire
    """)

def main():
    finish = False
    apart = [{'nr': 1, 'suma': 12, 'tip': "apa", 'data' : "21.11.2022"}, {'nr': 4, 'suma': 2, 'tip': "gaz", 'data' : "09.12.2023"}, {'nr': 2, 'suma': 42, 'tip': "canal", 'data' : "06.09.2019"}, {'nr': 3, 'suma': 82, 'tip': "gaz", 'data' : "16.09.2022"}]
    undo = []
    register_for_undo(undo, apart)
    while not finish:
        print_menu()
        option = read_valid_number("Choose: ")
        if option != int:
            introdu_date()
        if option == 1:
            register_for_undo(undo, apart)
            ap = read_ap()
            print(ap)
            print("Read successfuly")
        elif option == 2:
            register_for_undo(undo, apart)
            ap= read_ap()
            add_cheltuiala(apart, ap)
            print(apart)
        elif option == 3:
            register_for_undo(undo, apart)
            ap = read_ap()
            if ap in apart:
                suma = read_valid_number("Enter new sum:")
                tip = read_valid_str("Enter new type:")
                year = read_valid_number('Enter a year: ')
                month = read_valid_number('Enter a month: ')
                day = read_valid_number('Enter a day: ')
                d = datetime.datetime(year, month, day)
                indice = apart.index(ap)
                apart[indice]=mod_cheltuiala(ap, suma, tip, d)
            else:
                print("Invalid apartment option")
            print(apart)
        elif option == 4:
            """
            Șterge toate cheltuielile de la un apartament
            """
            register_for_undo(undo, apart)
            nr = read_valid_number("Choose apartment: ")
            stergere_cheltuieli(apart, acelasi_numar, nr)
            print(apart)
        elif option == 5:
            """
            Șterge cheltuielile de la apartamente consecutive
            """
            register_for_undo(undo, apart)
            ap = read_ap()
            indice = apart.index(ap)
            for i in range(indice-1, indice+2):
                fsterge(apart, i)
            print(apart)
        elif option == 6:
            """
            Tipărește toate apartamentele care au cheltuieli mai mari decât o sumă dată
            """
            register_for_undo(undo, apart)
            suma = read_valid_number("Choose sum:")
            cautari_cheltuieli(apart, mare_suma, suma)
        elif option == 7:
            """
            Tipărește cheltuielile de un anumit tip de la toate apartamentele
            """
            register_for_undo(undo, apart)
            tip = read_valid_str("Choose type:")
            cautari_cheltuieli(apart, acelasi_tip, tip)
        elif option==8:
            """
            Tipărește toate cheltuielile efectuate înainte de o zi și mai mari decât o sumă (se dă suma și ziua)
            """
            register_for_undo(undo, apart)
            year = read_valid_number('Enter a year: ')
            month = read_valid_number('Enter a month: ')
            day = read_valid_number('Enter a day: ')
            d = datetime.datetime(year, month, day)
            print("Data aleasa e: ", d)
            suma =read_valid_number('Enter sum: ')
            cautari_cheltuieli2(apart, inainte_de_ziua, mare_suma, d, suma)
        elif option == 9:
            """
            Tipărește suma totală pentru un tip de cheltuială
            """
            register_for_undo(undo, apart)
            tip = read_valid_str("Choose type:")
            print("suma este: ")
            rapoarte(apart, acelasi_tip, tip)
        elif option == 10:
            """
            Tipărește toate apartamentele sortate după un tip de cheltuială
            """
            register_for_undo(undo, apart)
            sortare(apart)
        elif option == 11:
            """
            Tipărește totalul de cheltuieli pentru un apartament dat
            """
            register_for_undo(undo, apart)
            nr= read_valid_number("Enter number : ")
            cautari_cheltuieli(apart,acelasi_numar,nr)
        elif option == 12:
            """
            Elimină toate cheltuielile de un anumit tip
            """
            register_for_undo(undo, apart)
            tip= read_valid_str("Enter type: ")
            stergere_cheltuieli(apart, acelasi_tip, tip)
            print(apart)
        elif option == 13:
            """
            Elimină toate cheltuielile mai mici decât o sumă dată
            """
            register_for_undo(undo, apart)
            suma = read_valid_number("Choose sum:")
            stergere_cheltuieli(apart, mica_suma, suma)
            print(apart)
        elif option == 14:
            pop_undo_list(undo)
            print(undo)
        elif option == 15:
            print("BYEE")
            return
        else:
            print('Invalid option')
main()