;1 Create a file and then write data in the file
;2 overwrite part of the content of the file
;3 append data to the file
;4 write data at a certain position in the file
;5 read data from the file
;6 read data from a certain position in the file
;7 delete the file

section.data    ;flags
    CREATE equ 1
    OVERWRITE equ 1
    APPEND equ 1
    O_WRITE equ 1 
    READ equ 1
    O_READ equ 1 ;reading operations
    DELETE equ 1

    ;SYSCALL SYMBOLS

    NR_READ equ 0
    NR_WRITE equ 1
    NR_OPEN equ 2
    NR_CLOSE equ 3
    NR_LSKEED equ 8
    NR_CREATE equ 85
    NR_UNLINK equ 87

    ;FILE FLAGS
    O_CREATE equ 00000100q
    O_APPEND equ 00002000q

    ;ACCESS MODE

    O_READONLY equ 000000q
    O_WRITE_ONLY  equ 000001q
    O_READ_WRITE equ 000002q

    S_USER_READ equ 00400q
    S_USER_WRITE equ 00200q

    NL equ 0xa
    bufferLenght equ 64
    fileName db "hacked.txt",0

    FD dq 0

    myText1 "1. Hello Everyone", NL, 0
    myText1_Len $-myText1-1
    myText2     "2. My name is fabian!", NL, 0
    myText2_Len $-myText2-1
    myText3 "3. THE CODE WORKS", NL, 0
    myText3_Len $-myText3-1
    myText4 "4. This code really works", NL, 0
    myText4_Len $-myText4-1

    ;ERROR MESSAGES DEFINED HERE

    Error_Create db "Error Creating file", NL, 0
    Error_Close db "Error Closing File", NL, 0
    Error_Write db "Error writing file", NL, 0
    Error_Open db "Error Opening file", NL, 0
    Error_Append db  "Error Appending to file", NL, 0
    Error_Delete db "Error Deleting File", NL, 0
    Error_Read db "Error Reading file", NL, 0
    Error_Print db "Error Printing file", NL, 0
    Error_Position db "Error Positioning file", NL, 0

    Ok_Create   db "File created and Opened : OK ", Nl, 0
    Ok_CLose db "File closed: OK", NL, 0
    Ok_Write db "File Written: OK", NL, 0
    Ok_Open db "File Opened: OK", NL, 0
    Ok_Append db "File Appended: OK", NL, 0
    Ok_Delete db "File Deleted: OK", NL, 0
    OK_Read db "File REad: Ok", NL,0
    Ok_Position db "Positioned in File : OK", NL, 0

section .bss
    buffer resb bufferLenght

section .text
    global main

main: 
    push rbp
    mov rbp, rsp

;CREATE FILE
%IF CREATE 
    mov rdi, fileName
    call createFile
    mov qword[FD], rax

    ;WRITE TO FILE 1

    mov rdi, qword[FD]
    mov rsi, myText1
    mov rdx, qword[myText1_Len]
    call writeFile
    
    ;CLOSE FILE

    mov rdi, qword[FD]
    call closeFile

%ENDIF
    
 