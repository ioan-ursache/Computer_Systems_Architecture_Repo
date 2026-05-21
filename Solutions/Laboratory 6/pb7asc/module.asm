bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global extractPrefixLen        

; our data is declared here (the variables needed by our program)
; segment data use32 class=data

; extractPrefixLen
; r
segment code use32 class=code
    extractPrefixLen;
        push EBP
        mov EBP, ESP ; copy the stack pointer
        
        push esi
        push edi
        push ecx
        
        
    
        ret 4 ; bytes to be released from the stack
