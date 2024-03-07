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
    NR_LSEEK equ 8
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

    myText1 db "1. Hello Everyone", NL, 0
    myText1_Len db $-myText1-1
    myText2   db  "2. My name is fabian!", NL, 0
    myText2_Len db $-myText2-1
    myText3 db "3. THE CODE WORKS", NL, 0
    myText3_Len  db $-myText3-1
    myText4 db "4. This code really works", NL, 0
    myText4_Len  db $-myText4-1

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
    
 
 %IF OVERWRITE

 ;OPEN FILE 
    mov rdi, fileName
    call openFile
    mov qword[FD], rax

    ;WRITE TO FILE #2 OVERWRITE

    mov rdi, qword[FD]
    mov rsi, myText2
    mov rdx, myText2_Len
    call writeFile

    ;CLOSE THE FILE
    mov rdi, [FD]
    call closeFile

%ENDIF

%IF APPEND

;OPEN AND APPEND TO A FILE AND THEN CLOSE
;open file to append
    mov rdi, fileName
    call appendFile
    mov qword[FD], rax

    ;write to a file #3 append

    mov rdi, qword[FD]
    mov rsi, myText3
    mov rdx, qword[myText3_Len]
    call writeFile

    ;close file

    mov rdi, qword[FD]
    call closeFile

%ENDIF

%IF O_WRITE
;Open and overwrite at an offset in a file, then close it
;open file

    mov rdi, fileName
    call openFile
    mov qword[FD], rax

    ;position file at offset
    mov rdi, qword[FD]
    mov rsi, qword[myText2_Len]
    mov rdx, 0
    call positionFile

    ;write to file at offset
    mov rdi, qword[FD]
    mov rsi, myText4
    mov rdx qword[myText4_Len]
    call writeFile

    ;Close file

    mov rdi, qword[FD]
    call closeFile

    %ENDIF

%IF READ
;OPEN AND READ FROM A FILE AND THEN CLOSE IT
    ;OPEN FILE TO READ  
    mov rdi, fileName
    call openFile
    mov qword[FD], rax

    ;read from a file

    mov rdi, qword[FD]
    mov rsi, buffer
    mov rdx, bufferLenght
    call readFile
    mov rdi, rax
    call printString
    mov rdi, qword[FD]
    call closeFile

    %ENDIF

%IF O_READ
    ;open file to read
    mov rdi, fileName
    call openFile
    mov qword[FD], rax

    ;position file at offset
    
    mov rdi, qword[FD]
    mov rsi, qword[myText2_Len]
    mov rdx, 0
    call positionFile

    ;read from file 
    mov rdi, qword[FD]
    mov rsi, buffer
    mov rdx, 10
    call readFile
    mov rdi, rax
    call printString

    ;close file
    move rdi, qword[FD]
    call closeFile

    %ENDIF

%IF DELETE
    ;DElete a file
    ;delete file 

    move rdi, fileName 
    call deleteFile

    %ENDIF

    leave
    ret

;+++++++++++++++++++++FILE MANIPULATION FUNCTIONS++++++++

global readFile

readFile
    mov rax, NR_READ
    syscall 
    cmp rax, 0
    jl readerror

    mov byte[rsi+rax], 0
    mov rax, rsi
    mov rdi, OK_Read
    push rax
    call printString
    pop rax
    ret

readerror:
    mov rdi, Error_Read
    call printString
    ret 

;DELETE file function

global deleteFile
deleteFile:
    mov rax, NR_UNLINK
    syscall 
    cmp rax, 0
    jl deleteerror
    mov rdi, Ok_Delete
    call printString

deleteerror:        
    mov rdi, Error_Delete
    call printString
    ret

;Append file function

global appendFile

appendFile:
    mov rax, NR_OPEN
    mov rsi, O_READ_WRITE|O_APPEND
    syscall
    cmp rax, 0
    jl appenderror
    mov rdi, Ok_Append
    push rax
    call printString
    pop rax
    ret

    appenderror:
    mov rdi, Error_Append
    call printString
    ret

;Open file function

global openFile

openFile:
    mov rax, NR_OPEN
    mov rsi, O_READ_WRITE
    syscall
    cmp rax, 0
    jl openerror

    mov, rdi Ok_Open
    push rax
    call printString
    pop rax
    ret

    openerror:
    mov rdi, Error_Open
    call printString
    ret

;Write file function

global writeFile
writeFile:
    mov rax, NR_WRITE
    syscall 
    cmp rax, 0
    jl writeerror

    mov rdi, Ok_Write
    call printString
    ret

    writeerror:
    mov rdi, Error_Write
    call printString
    ret

;Position file function

global positionFile

positionFile:
    mov rax, NR_LSEEK
    syscall
    cmp rax, 0
    jl positionerror

    mov rdi, Ok_Position
    call printString
    ret 
    

    positionerror:
    mov rdi, Error_Position
    call printString
    ret

;Close file function 

global closeFile

closeFile:
    mov rax, NR_CLOSE
    syscall
    
    cmp rax, 0
    jl closeerror

    mov rdi, Ok_CLose
    call printString
    ret 

    closeerror:
    mov rdi, Error_Close
    call printString
    ret

;Create file function
global createFile

createFile:
    mov rax, NR_CREATE
    mov rsi, S_USER_READ|S_USER_WRITE
    syscall

    cmp rax, 0
    jl createerror

    mov rdi, Ok_Create
    push rax 
    call printString
    pop rax
    ret

    createerror:
    mov  rdi Error_Create
    call printString
    ret


;PRINT FEEDBACK 

global printString
printString:
    mov, r12, rdi
    mov rdx, 0
    
    strLoop:
    cmp byte[r12,0], 0
    je strDone
    inc rdx 
    inc r12
    jmp strLoop



    strDone:
    cmp rdx, 0
    je prtDone

    mov rsi, rdi
    mov rax, 1
    mov rdi, 1
    syscall
    prtDone:
        ret









