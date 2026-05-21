bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dw 0110100101011010b ; 0110 1001 0101 1010
    b dw 0101100011001101b ; 0101 1000 1100 1101
    c dd 0
    
; our code starts here
segment code use32 class=code
    start:
        mov EBX, 0
    
        mov EAX, 1111100000000000b
        and EAX, [a] ; 0110 1000 0000 0000
        shr EAX, 11
        or EBX, EAX
        ; ebx = 0000 0000 0000 0000 0000 0000 0000 1101
        
        or EBX, 0000111111100000b
        ; ebx = 0000 0000 0000 0000 0000 1111 1110 1101
        
        mov EAX, 0000111100000000b
        and EAX, [b] ; 0000 1000 0000 0000
        shl EAX, 4
        
        or EBX, EAX
        ; ebx = 0000 0000 0000 0000 1000 1111 1110 1101
        
        mov EAX, [a]
        shl EAX, 8
        
        or EBX, EAX
        ; ebx = 0110 1001 0101 1010 1000 1111 1110 1101
        
        mov [c], EBX
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
