proyecto_1: proyecto_1.o
    gcc -o proyecto_1 proyecto_1.o -no-pie

proyecto_1.o: proyecto_1.asm
    nasm -f elf64 -g proyecto_1.asm -o proyecto_1.o -l proyecto_1.lst
