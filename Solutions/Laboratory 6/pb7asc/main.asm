; 7. Se dau trei şiruri de caractere. Sa se afişeze cel mai lung prefix comun pentru fiecare din cele trei perechi de cate doua şiruri ce se pot forma.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
import printf msvcrt.dll  ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
                          
; extern extractPrefixLem                 
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s1 db "prefixword",0
    s2 db "prefixwordsuffix",0
    s3 db "prefixwordsufficient",0
    len1 equ $-s1
    len2 equ $-s2
    len3 equ $-s3
    
    entryformat db "The strings chosen are:", 10, "1. %s", 10,"2. %s", 10, "3. %s", 0
    exitformat db "The maximum prefix length found in the strings is %d", 0

; our code starts here
segment code use32 class=code
    start:
        push s3
        push s2
        push s1
        push entryformat
        call [printf]
        add esp, 4*4 ; clear stack
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
