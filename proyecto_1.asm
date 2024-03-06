%include "linux64.inc"
;/home/fabianch/ARQUI/Proyecto_1/proyecto_1.asm
section .data
    filename db "info.txt",0
    file_descriptor dq 0 ; Descriptor de archivo
    buffer_len equ $ - buffer
section .bss
    text resb 36

section .text
    global _start

_start:
    ; Open the file
    mov rax, SYS_OPEN ; 
    mov rdi, filename ; puntero al nombre del archivo
    mov rsi, O_RDONLY ; read only flag
    mov rdx, 0 ; file permission
    syscall
    ;read from the file
    push rax
    mov rdi, rax
    mov rax, SYS_READ
    mov rsi, text
    mov rdx, 36 ;número de bits a leer en el archivo
    syscall

    ;close the file
    mov rax, SYS_CLOSE
    pop rdi
    syscall
    print text
    exit

