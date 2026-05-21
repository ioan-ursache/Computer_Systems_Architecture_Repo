;12. Se da un număr natural negativ a (a: dword). Sa se afiseze valoarea lui in baza 10 şi in baza 16, in urmatorul format: "a = <base_10> (baza 10), a = <base_16> (baza 16)"

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll ; import printf function
                          
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a dd -23 ; negative number
    format db "a = <%d> (baza 10), a = <%x> (baza 16)", 0 ;string
    
    
; our code starts here
segment code use32 class=code
    start:
        push dword [a] ; push word (arg 3)
        push dword [a] ; push word (arg 2)
        push dword format ; push format (arg 1)
        call [printf] ; call function
        add esp, 4*3 ; clear stack
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
