bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start

; declare external functions needed by our program
extern exit ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    s db 1, 5, 3, 8, 2, 9 ; initial sequence
    l equ $-s ; length of S (which is 6)
    
    ; The maximum possible length of D1 and D2 is l/2
    ; Since l is 6, max length is 3. l is too large for allocation.
    ; But using 'l' as size is safe since we only write up to index l/2 - 1.
    d1 times l db 0 ; elements from even positions of S
    d2 times l db 0 ; elements from odd positions of S

segment code use32 class=code
    start:
        
        mov ecx, l ; insert length of s into ecx
        
        mov esi, 0 ; Read index for S (0-based)
        mov edi, 0 ; Write index for D1 (even positions)
        mov ebx, 0 ; Write index for D2 (odd positions)
        
        ; Could have been performed using fewer indexes
        
        jecxz empty_seq ; jump if sequence is empty
        
        split:
            ; Check the current read index (esi) for parity (even/odd)
            mov eax, esi
            test eax, 1 ; Check the least significant bit (1 if odd, 0 if even)
            
            ; Read the element from S
            mov al, [s+esi]
            
            jz is_even_pos ; Jump if result of TEST is 0 (even position)
            
            is_odd_pos:
                mov [d2+ebx], al ; Copy element to D2 at index ebx
                inc ebx ; Increment D2 write index
                jmp next_element ; also, not that neccessary: this was implemented to jump past is_even_pos segment
            
            is_even_pos:
                mov [d1+edi], al ; Copy element to D1 at index edi
                inc edi ; Increment D1 write index
            
            next_element:
                inc esi ; Increment S read index, apparently, not really required
                
        loop split ; Decrement ecx and loop if not zero
        
        empty_seq:
        
        ; exit
        push dword 0 ; push the parameter for exit onto the stack
        call [exit] ; call exit to terminate the program