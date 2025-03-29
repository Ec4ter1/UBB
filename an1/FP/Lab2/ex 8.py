"""
8. Pentru un număr natural n dat găsiți numărul natural maxim m format cu
 aceleași cifre. Ex. n=3658, m=8653.
"""
n= int(input())
a = [0,0,0,0,0,0,0,0,0,0,0,0,0]
m=0
while n > 0 :
    a[int(n%10)]+=1
    n=int(n/10)
for i in range(9, -1,-1) :
    while a[i]>0 :
        m=m*10+i
        a[i]-=1
print(m)
