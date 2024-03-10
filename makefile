proyecto_1: proyecto_1.o
	ld -o proyecto_1-exe proyecto_1.o

proyecto_1.o: proyecto_1.asm
	nasm -f elf64 -o proyecto_1.o proyecto_1.asm