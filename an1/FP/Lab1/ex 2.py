n= int(input())
ok = 1
if n < 2:
    print("Nu")
for i in range(2, int(n / 2)):
    if n % i == 0:
        print("Nu")
        ok = 0
if ok == 1:
    print("Da")
