from datetime import date, datetime
from Domain import creare_apart, get_number, get_suma_cheltuieli, get_tip_cheltuieli, get_date, set_tip_cheltuieli, set_suma_cheltuieli, set_number, set_data


def read_ap():
    ap = {"nr": None, "suma": None, "tip": None}
    nr = read_valid_number("Enter apartment number: ")
    suma = read_valid_number("Enter sum: ")
    tip = read_valid_str("Enter type: ")
    year = read_valid_number('Enter a year: ')
    month = read_valid_number('Enter a month: ')
    day = read_valid_number('Enter a day: ')
    d = date(year, month, day)
    set_number(ap,nr)
    set_suma_cheltuieli(ap, suma)
    set_tip_cheltuieli(ap, str(tip))
    set_data(ap, d)
    return ap


def read_valid_str(msg: str):
    """
        Returns a non-empty stripped string read from the console
        :param msg: input prompt
        :return:
    """
    val = input(msg)
    if (val.strip() == "") or ((val != "gaz") and (val !="apa") and (val !="incalzire") and (val !="canal")):
        print("Invalid input")
        return read_valid_str(msg)
    return val.strip()

def read_valid_number(prompt):
    """
    Citeste o valoare int
    :param prompt: ce se citeste
    :return:
    """
    while True:
        try:
            return int(input(prompt))
        except ValueError:
            print("Invalid input")
def add_cheltuiala(apartments, ap):
    """
    Adauga cheltuiala in lista
    :param apartments: lista de apartamente
    :param ap: apartamentul adaugat
    :return:
    """
    apartments.append(ap)

def test_add_cheltuiala():
    apartments = []
    ap={"nr": 1,"suma": 56,"tip": "canal"}
    ap1={"nr": 2,"suma": 6,"tip": "apa"}
    add_cheltuiala(apartments,ap)
    add_cheltuiala(apartments, ap1)
    assert apartments[0]==ap
    assert apartments[1]==ap1
    assert len(apartments)==2
    assert get_suma_cheltuieli(apartments[0])==56

def mod_cheltuiala(ap, nsuma, ntip, d):
    set_suma_cheltuieli(ap,nsuma)
    set_tip_cheltuieli(ap,str(ntip))
    set_data(ap, d)
    return ap

def test_mod_cheltuiala():
    apartments = []
    ap = {"nr": 1, "suma": 56, "tip": "canal", "data": '03.12.2003'}
    ap1 = {"nr": 2, "suma": 6, "tip": "apa", "data": '09.09.20009'}
    apartments.append(ap)
    apartments.append(ap1)
    mod_cheltuiala(ap,345, "apa", "21.11.2021")
    assert get_number(apartments[0])==1
    assert get_suma_cheltuieli(apartments[0])==345


def stergere_cheltuieli(apartments, conditie, p):
    """
    Stege un apartament din lista, in functie de conditie
    :param apartments: lista de aprtamente
    :param conditie: o functie
    :param p: parametrul introdus de utilizator
    :return:
    """
    n=len(apartments)-2
    while n>-2:
        if conditie(p, apartments[n]):
            del apartments[n]
        else:
            n-=1

def test_stergere_cheltuieli():
    apartments = []
    ap = {"nr": 1, "suma": 56, "tip": "canal", "data": '03.12.2003'}
    ap1 = {"nr": 2, "suma": 6, "tip": "apa", "data": '09.09.20009'}
    apartments.append(ap)
    apartments.append(ap1)
    stergere_cheltuieli(apartments, acelasi_numar, 1)
    assert get_number(apartments[0]) == 2
def mare_suma(parametru1, a1):
    """
    Compara cei doi parametri pentru a gasi in lista apartamentul cu suma mai mare ca parametru5
    :param parametru1: suma data
    :param a1: apartamentul
    :return:
    """
    return parametru1<get_suma_cheltuieli(a1)
def mica_suma(parametru6, a6):
    """
    Compara cei doi parametri pentru a gasi in lista apartamentul cu suma mai mica ca parametru6
    :param parametru6: suma data
    :param a6: apartamentul
    :return:
    """
    return parametru6>get_suma_cheltuieli(a6)
def fmici(parametru2, a2):
    return parametru2>a2
def acelasi_numar(parametru5, a5):
    """
    Compara cei doi parametri pentru a gasi in lista apartamentul cu acelasi numar ca si parametru5
    :param parametru5: numarul dat
    :param a5: apartamentul din lista
    :return:
    """
    return parametru5==get_number(a5)
def acelasi_tip(parametru3, a3):
    """
    Compara cei doi parametri pentru a gasi in lista apartamentul cu acelasi tip ca si parametru3
    :param parametru3: stringul dat
    :param a3: apartamentul din lista
    :return:
    """
    return parametru3==get_tip_cheltuieli(a3)
def fsterge(a, n):
        del a[n]

def inainte_de_ziua(parametru4, a4):
    return parametru4<datetime.strptime(get_date(a4),'%d.%m.%Y')
def cautari_cheltuieli(apartments, conditie, p):
    n = len(apartments) - 1
    while n>-1:
        if conditie(p,apartments[n]):
            print(apartments[n])
        n -= 1
def cautari_cheltuieli2(apartments, cond1, con2, p1, p2):
    n = len(apartments) - 1
    while n > -1:
        if cond1(p1, apartments[n]) and con2(p2,apartments[n]):
            print(apartments[n])
        n -= 1
def rapoarte(apartments, conditie, p):
    n = len(apartments) - 1
    s = 0
    while n>-1:
        if conditie(p, apartments[n]):
            s+=get_suma_cheltuieli(apartments[n])
        n -= 1
    print(s)

def sortare(apartments):
    rez=apartments
    for i in range(0, len(rez)-1):
        print(rez[i])
        for j in range(i+1, len(rez)):
            if get_tip_cheltuieli(rez[i])==get_tip_cheltuieli(rez[j]):
                print(rez[j])
                del rez[j]

def copy_apartments(apartments):
    result = []
    for ap in apartments:
        result.append(creare_apart(get_number(ap), get_suma_cheltuieli(ap), get_tip_cheltuieli(ap), get_date(ap)))
    return result


def register_for_undo(undo_list, current_entities):
    """
    Registers a new entry in the undo list
    :param undo_list:
    :param current_entities:
    :return:
    """
    undo_list.append(copy_apartments(current_entities))


def pop_undo_list(undo_list):
    if not undo_list:
        raise ValueError("Nothing to undo")
    return undo_list.pop()

if __name__ == '__main__':
    test_add_cheltuiala()
    test_mod_cheltuiala()
    test_stergere_cheltuieli()