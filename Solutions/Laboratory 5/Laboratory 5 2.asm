; 5. Se da un fişier text. Sa se citeasca continutul fişierului, sa se contorizeze numărul de caractere speciale şi sa se afiseze aceasta valoare. Numele fişierului text este definit in segmentul de date.

bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll
import fclose msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    nume_fisier db "secv.txt", 0
    mod_citire db "r", 0
    
    dim_buffer equ 1000
    buffer times dim_buffer db 0
    
    format_rezultat db "Numarul de caractere speciale este: %d", 0
    
    handle_fisier dd 0 ; descriptorul de fisier
    
    contor_speciale dd 0

; our code starts here
segment code use32 class=code
    start:
        ; 1. Deschidem fisierul
        push dword mod_citire
        push dword nume_fisier
        call [fopen] ; EAX = descriptor fisier 
        
        mov dword [handle_fisier], eax
        
        ; verificam eroare de citire (EAX = 0)
        cmp eax, 0
        je final_inchidere ; iesire program
    
        ; 2. Citim continutul
        push dword [handle_fisier]
        push dword dim_buffer ;(max 1000)
        push dword 1 ; size (1 octet)
        push dword buffer
        call [fread] ; EAX = nr. de octeti cititi
        
        mov ebx, eax ; salvam nr. de octeti cititi
        
        ; 3. parcurgem si contorizam
        mov esi, buffer ; ESI = adresa de inceput a bufferului
        mov ecx, 0 ; ECX = contor
        
        loop_contor:
            cmp ebx, 0 ; verificare terminare buffer
            je final_contor
            
            mov al, byte[esi] ; AL = caracter curent
            
            ; Verificare !(litera, cifra, spatiu alb)
            
            ; Verificare ('a' <= Al <= 'z')
            cmp al, 'a'
            jb nu_este_litera ; AL < 'a'
            cmp al, 'z'
            jbe este_normal ; AL <= 'z'
            
            nu_este_litera:
                ; Verificare litera mare ('A' <= AL <= 'Z')
                cmp al, 'A'
                jb nu_este_litera_mare
                cmp al, 'Z'
                jbe este_normal ; AL <= 'Z'
            
            nu_este_litera_mare:
            ; Verificare cifra ('0' <= AL <= '9')
            cmp al, '0'
            jb nu_este_cifra
            cmp al, '9'
            jbe este_normal ; AL <= '9'
            
            nu_este_cifra:
            ; Verificare spatiu alb
            ; Verificare spatiu
            cmp al, ' '
            je este_normal ; este spatiu
            
            ; Verificare newline (10)
            cmp al, 10
            je este_normal
            
            ; Daca caracterul a trecut toate testele, este caracter speciale
            inc ecx
            jmp continua_bucla
            
            este_normal:
            ; Nu se intampla nimic
            
            continua_bucla:
                inc esi ; trecem la urmatorul caracter
                dec ebx ; decrementam contorul de caractere ramase
                jmp loop_contor
                
            final_contor:
            mov dword [contor_speciale], ecx ; salvam rezultatul
            
            ; 4. Afisare
            push dword [contor_speciale]
            push dword format_rezultat
            call [printf]
            add esp, 4*2
        
        final_inchidere:
            ; 4. inchidem fisierul
            cmp dword [handle_fisier], 0
            je final_exit ;nu se inchide daca nu a fost deschis
            
            push dword [handle_fisier]
            call [fclose]
            add esp, 4*1
            
        final_exit:
            ; exit(0)
            push    dword 0      ; push the parameter for exit onto the stack
            call    [exit]       ; call exit to terminate the program
