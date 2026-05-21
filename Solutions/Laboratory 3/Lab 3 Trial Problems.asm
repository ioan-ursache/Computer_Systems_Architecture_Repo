;Se da un sir de caractere format din litere mici.

;Sa se transforme acest sir in şirul literelor mari corespunzător.

bits 32

global start

extern exit,printf ; tell nasm that exit exists even if we won't be defining it

import exit msvcrt.dll ; exit is a function that ends the calling process. It is defined in msvcrt.dll

import printf msvcrt.dll

; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)

segment data use32 class=data

s db 'a', 'b', 'c', 'm','n' ; declararea şirului iniţial s

l equ $-s ; stabilirea lungimea şirului iniţial l

d times l db 0 ; rezervarea unui spațiu de dimensiune l pentru şirul destinație d şi iniţializarea acestuia


segment code use32 class=code

start:

mov ecx, l ;punem lungimea in ECX pentru a putea realiza bucla loop de ecx ori

mov esi, 0

jecxz Sfârșit

Repeta:

mov al, [s+esi]

mov bl, 'a'-'A' ; pentru a obține litera mare corespunzătoare literei mici, vom scădea din codul ASCII

; al literei mici diferența dintre 'a'-'A'

sub al, bl

mov [d+esi], al

inc esi

loop Repeta

Sfârșit:;terminarea programului


; exit(0)

push dword 0 ; push the parameter for exit onto the stack

call [exit] ; call exit to terminate the program