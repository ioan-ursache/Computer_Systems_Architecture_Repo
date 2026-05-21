bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

; our code starts here
segment code use32 class=code
    start:
        ; Exercises
        
        ; 1.
        mov AX, 1
        mov BX, 9
        add AX, BX
        
        mov AX, 1
        mov BX, 15
        add AX, BX
        
        mov AX, 128
        mov BX, 128
        add AX, BX
        
        mov AX, 5
        mov BX, 6
        sub AX, BX
        
        mov AX, 10
        mov BL, 4
        div BL
        
        mov AL, 256
        mov BL, 1
        mul BL
        
        mov AX, 256
        mov BL, 1
        div BL
        
        mov AX, 128
        mov BX, 127
        add AX, BX
        
        mov AL, 3
        mov BL, 4
        mul BL
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
