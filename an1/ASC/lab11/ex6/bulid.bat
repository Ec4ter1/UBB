nasm -fobj lab11ex6.asm
nasm -fobj concatenare.asm
alink lab11ex6.obj concatenare.obj -oPE -subsys console -entry start