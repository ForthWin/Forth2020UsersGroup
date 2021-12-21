variable resultat 10000 cells allot 
variable grandeur_res 
variable reste
variable produit
variable x
variable nombre

: multiplie ( -- ) 
    0 reste !
    grandeur_res @ 0 do
    i cells resultat + @ x @  * reste @ + produit !
    produit @ 10 mod resultat i cells + !
    produit @ 10 / reste !
    loop 
    
    begin
    reste @ 0 > while
    reste @ 10 mod resultat grandeur_res @ cells + !
    reste @ 10 / reste !
    grandeur_res @ 1+ grandeur_res !
    repeat
;
: affichage ( -- )
    ." La factoriel de " nombre ? ." est : " cr
    grandeur_res @ 1- grandeur_res !
    begin
    grandeur_res @ 0 >= while
    grandeur_res @ cells resultat + ? 
    grandeur_res @ 1- grandeur_res !
    repeat
;
: factoriel ( -- )
    nombre !
    1 resultat 0 cells + !
    1 grandeur_res !
    2 x !
    
    begin 
     x @ nombre @ <= while 
    multiplie
    x @ 1+ x !
     repeat
    affichage 
;
500 factoriel