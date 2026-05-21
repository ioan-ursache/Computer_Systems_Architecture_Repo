bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 30
    b dw 20
    c dd 100
    d dq 1500
    
    ; a+d  = 1530
    ; b+d = 1520
    ; c - (a + d) + (b + d) = 100 - 1530 + 1520 = 100 - 10 = 90

; our code starts here
segment code use32 class=code
    start:
        ; c - (a + d) + (b + d) 
           
        mov al, [a]
        mov ah, 0 ; al -> ax word
        mov dx, 0 ; ax -> dx:ax dword
        
        push dx
        push ax
        pop eax ; dx:ax -> eax
        
        add eax, [d] ; a + d = A
        
        mov ebx, eax
        
        mov ax, [b] 
        mov dx, 0
        
        push dx
        push ax
        pop eax 
        
        add eax, [d] ; b + d = B
        
        add ebx, eax ; B + A
        
        mov eax, [c]
        sub eax, ebx ; c - (B + A)
        
        ;
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
