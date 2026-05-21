; Se da un şir de dublucuvinte conținând date împachetate (4 octeţi scrişi ca un singur dublucuvânt). Sa se obțină un nou şir de dublucuvinte, in care fiecare dublucuvânt se va obține după regula: suma octeţilor de ordin impar va forma cuvântul de ordin impar, iar suma octeţilor de ordin par va forma cuvântul de ordin par. Octeţii se considera numere cu semn, astfel ca extensiile pe cuvânt se vor realiza corespunzător aritmeticii cu semn.

; Exemplu:
; pentru şirul inițial:
; 127F5678h, 0ABCDABCDh, ...

; Se va obține:
; 006800F7h, 0FF56FF9Ah


bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf           ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    sir dd 127F5678h, 0ABCDABCDh
    len equ ($-sir)/4 ;lungimea sirului in dublucuvinte
    dest times dw 0
    sumap dd 0 ; variabila in care memoram suma octetilor "pari"
    sumai dd 0 ; variabila in care memoram suma octatilor "impari"
; our code starts here
segment code use32 class=code
    start:
        mov esi, sir
        mov edi, d
        mov ecx, len
        cld
        jecxz finish
        repeta:
            lodsd
                movsx bx, al
                mov edx, eax ; in ebx vom prelucra sumai, in edx vom prelucra sumap      
                shr edx, 8
                ; . . . finish
            
            
            
            
            
            stosd
        loop repeta 
            
        finish
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
