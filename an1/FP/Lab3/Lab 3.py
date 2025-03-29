def print_menu():
    print("""
    1. Citirea unei liste de numere intregi
    2. Oricare doua elemente consecutive difera printr-un numar prim
    3. Are oricare doua elemente consecutive sunt de semne contrare
    4. Oricare doua elemente consecutive sunt relativ prime intre ele
    5. Iesire din aplicatie
    """)

def read_list():
    raw_list = input("Enter list: ")
    string_list = raw_list.split(' ')
    result = []
    for number in string_list:
        result.append(int(number))
    return result

def test_prim():
    assert prim(-1) == False
    assert prim(2)


def prim(n):
    if n < 2:
        return 0
    for i in range(2, int(n / 2)+1):
        if n % i == 0:
            return 0
    return 1

def cmmdc(m,n):
    if m<0 or n<0:
        return 0
    if(m*n==0):
        return m+n
    while m:
        r = n % m
        n = m
        m = r
    return n

def conditie(a,b,op):
    if op == 2:
        if prim(abs(a - b)) == 1:
            return 1
    elif op == 3:
        if a*b<=0:
            return 1
    elif op == 4:
        if cmmdc(a,b)==1:
            return 1
    return 0


def cea_mai_lunga_secventa(l,op):
    c=0
    maxi = -1
    p=-1
    for i in range(0, len(l)-1):
        if conditie(l[i],l[i+1],op) == 1:
            c+=1
            if p==-1:
                p=i
        else:
            c=0
            p=-1
        if c>=maxi:
            maxi =c
            start=p
    print(l[start:start+maxi+1])


def test_conditie():
    assert conditie(-2,5,2)
    assert conditie(9,1,2) == False
    assert conditie(-1,2,3)
    assert conditie(2,4,3) == False
    assert conditie(1,3,4)
    assert conditie(8,14,4) == False

def test_cmmdc():
    assert cmmdc(14,21)==7
    assert cmmdc(0,2)==2

def main():
    finish = False
    numbers = [18, 7, 2, 8, 2, 15, 8, 3]
    while not finish:
        print_menu()
        option = int(input("Choose: "))
        if option == 1:
            numbers = read_list()
            print(numbers)
            print("Read succesfully")
        if option == 2:
            cea_mai_lunga_secventa(numbers, option)
        elif option == 3:
            cea_mai_lunga_secventa(numbers, option)
        elif option == 4:
            cea_mai_lunga_secventa(numbers, option)
        elif option == 5:
            print("Bye")
            return

test_prim()
test_cmmdc()
test_conditie()
main()
