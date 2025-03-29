"""
10. Pentru un număr natural n dat găsiți numărul natural minim m format cu
 aceleași cifre. Ex. n=3658, m=3568.
"""
n= int(input())
a = [0,0,0,0,0,0,0,0,0,0,0,0,0]
m=0
while n > 0 :
    a[int(n%10)]+=1
    n=int(n/10)
for i in range(1, 10) :
    while a[0]>0 and m>0 :
        m=m*10
        a[0]-=1
    while a[i]>0 :
        m=m*10+i
        a[i]-=1
print(m)
