; Se dau cuvintele A si B. Se cere cuvântul C format astfel:

;- biţii 0-2 ai lui C coincid cu biţii 10-12 ai lui B

;- biţii 3-6 ai lui C au valoarea 1

;- biţii 7-10 ai lui C coincid cu biţii 1-4 ai lui A

;- biţii 11-12 ai valoarea 0

;- biţii 13-15 ai lui C coincid cu inversul biților 9-11 ai lui B


; Vom obține cuvântul C prin operații succesive de "izolare". Numim operația

; de izolare a biţilor 10-12 ai lui B, păstrarea intacta a valorii acestor

; biţi, si inițializarea cu 0 a celorlalți biţi. Operațiunea de izolare se

; realizează cu ajutorul operatorului AND între cuvântul B şi masca

; 0001110000000000. Odată biții izolați, printr-o operație de rotire se

; deplasează grupul de biți doriți in poziția dorita. Cuvântul final se

; obține prin aplicarea operatorului OR între rezultatele intermediare

; obținute in urma izolării şi rotirii.

; Observație: rangul biților se numără de la dreapta la stânga


bits 32 ;asamblare si compilare pentru arhitectura de 32 biţi

; definim punctul de intrare in programul principal

global start


extern exit ; indicăm asamblorului că exit există, chiar daca noi nu o vom defini

import exit msvcrt.dll; exit este o funcție care încheie procesul, este definita in msvcrt.dll

; msvcrt.dll conține exit, printf şi toate celelalte funcții C-runtime importante

segment data use32 class=data ; segmentul de date în care se vor defini variabilele

a dw 0111011101010111b

b dw 1001101110111110b

c dw 0

segment code use32 class=code ; segmentul de cod

start:


mov bx, 0 ; în registrul BX vom calcula rezultatul


mov ax, [b] ; izolăm biții 10-12 ai lui b

and ax, 0001110000000000b

mov cl, 10

ror ax, cl ; rotim 10 poziții spre dreapta

or bx, ax ; punem biţii in rezultat


or bx, 0000000001111000b ; facem biţi 3-6 din rezultat să aibă valoarea 1


mov ax, [a] ; izolăm biții 1-4 ai lui a

and ax, 0000000000011110b

mov cl, 6

rol ax, cl ; rotim 6 poziții spre stânga

or bx, ax ; punem biții în rezultat


and bx, 1110011111111111b ; facem biţi 11-12 din rezultat să aibă valoarea 0


mov ax, [b]

not ax ; inversăm valoarea lui b

and ax, 0000111000000000b ; izolăm biţi 9-11 ai lui b

mov cl, 4

rol ax, cl ; deplasăm biții 4 poziții spre stânga

or bx, ax ; punem biţii în rezultat


mov [c], bx ; punem valoarea din registru în variabila rezultat


push dword 0 ;se pune pe stivă codul de retur al funcției exit

call [exit] ;apelul funcției sistem exit pentru terminarea execuției programului