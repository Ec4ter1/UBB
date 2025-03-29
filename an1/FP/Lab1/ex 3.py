n= int(input())
m= int(input())
while m:
    r = n % m
    n = m
    m = r
print(n)
