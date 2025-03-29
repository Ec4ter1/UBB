"""
6. Găsește cel mai mic număr m din șirul lui Fibonacci definit de
 f[0]=f[1]=1, f[n]=f[n-1]+f[n-2], pentru n>2,
 mai mare decât numărul natural n dat, deci exista k astfel ca f[k]=m si m>n.
"""
n = int(input())
a=1
b=1
c=0
while a+b<=n :
    c=a+b
    a=b
    b=c
m= a+b
print(m)
