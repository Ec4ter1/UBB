nasm concat.asm -fwin32 -o concat.obj
cl main.c /link concat.obj