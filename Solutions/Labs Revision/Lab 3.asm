bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db  2h;
    b dw  100h;
    c dd  10000h; 
    d dq  100000000h; 

; our code starts here
segment code use32 class=code
    start:
        ; 
        xor eax, eax ; empty out eax
        xor edx, edx
        mov al, [a] ; edx:eax = all
        
        adc eax, [d]
        add edx, [d+2]
        
        mov ebx, eax
        mov ecx, edx 
        ; ecx:ebx = edx:eax
        
        xor eax, eax
        xor edx, edx
        mov ax, [b]
        
        adc eax, [d]
        adc edx, [d+2]
        
        adc eax, ebx
        add edx, ecx
        
        mov ebx, eax
        mov ecx, edx
        
        xor eax, eax
        xor edx, edx
        
        mov eax, [c]
        
        sbb eax, ebx
        sub edx, ecx
        
        
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

