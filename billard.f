\ -----------------------------------------------------------------------------
\  Cellular Automaton
\  Margolus neighborhood
\  Two phase gas
\  Reversible
\  Michel Jean June 2019
\ -----------------------------------------------------------------------------

S" pixel.f" INCLUDED

320 constant largeur-monde \
200 constant hauteur-monde
largeur-monde hauteur-monde * constant dim-monde


create  monde dim-monde allot
create  monde-buf dim-monde allot

variable *monde
variable *monde-buf
variable tampon



variable position \ position dans la liste
variable pos-quad \ position dans un quad
variable etat
variable opp
variable c-w
variable cc-w

' monde *monde !
' monde-buf *monde-buf !

: last-bit ( n -- )
2 mod ;


: centre ( n -- )
*monde @ + c@
;

\ 9 voisins possibles ( monde borné, pas besoin de modulo)
	: est ( n -- )
	1 + *monde @ + c@ ;

: ouest ( n -- )
	1 - *monde @ + c@ ;

: nord ( n -- )
	largeur-monde - *monde @ + c@ ;

: sud ( n -- )
	largeur-monde + *monde @ + c@ ;

: nord-est ( n -- )
	largeur-monde - 1 + *monde @ + c@ ;

: nord-ouest ( n -- )
	largeur-monde - 1 - *monde @ + c@ ;

: sud-est ( n -- )
	largeur-monde + 1 + *monde @ + c@ ;

: sud-ouest ( n -- )
	largeur-monde + 1 - *monde @ + c@ ;

\ détermine la valeur pour les trois positions du quad

\ 0 1  positions dans le différents quadrants
\ 2 3
: p-quad0 ( n -- ) \ détermine sa position dans le premier quad
	largeur-monde /mod swap last-bit swap last-bit 2 * +
;

: p-quad1 ( n -- ) \ détermine sa position dans le second quad
	p-quad0 3 - abs
;

: ?opp
	pos-quad c@ 0 = if position @ sud-est else
	pos-quad c@ 1 = if position @ sud-ouest else
	pos-quad c@ 2 = if position @ nord-est else
	position @ nord-ouest
	then then then
;

: ?c-w \ sens horaire
	pos-quad c@ 0 = if position @ est else
	pos-quad c@ 1 = if position @ sud else
	pos-quad c@ 2 = if position @ nord else
	position @ ouest
	then then then
;

: ?cc-w \ sens anti-horaire
	pos-quad c@ 0 = if position @ sud else
	pos-quad c@ 1 = if position @ ouest else
	pos-quad c@ 2 = if position @ est else
	position @ nord
	then then then
;
\
: regles
	position @ centre etat c! \ enregistre l'état
	?opp opp !
	?c-w c-w !
	?cc-w cc-w !

\ ne faire que les état ou il y a un changement
	etat c@ 0 = c-w @ 0 = opp @ 1 = cc-w @ 0 = and and and if 1 etat c! else
	etat c@ 1 = c-w @ 0 = opp @ 0 = cc-w @ 0 = and and and if 0 etat c! else
	etat c@ 1 = c-w @ 0 = opp @ 1 = cc-w @ 0 = and and and if 0 etat c! else
	etat c@ 0 = c-w @ 1 = opp @ 0 = cc-w @ 1 = and and and if 1 etat c!
	then then then then
	etat c@
;


\ =========================================
: borne-monde
	largeur-monde 0 do 1 *monde @ i + c! loop \ bar haut
	largeur-monde 0 do 1 *monde @ i largeur-monde + + c! loop \ bar haut
	largeur-monde 0 do 1 *monde @ dim-monde largeur-monde - i + + c! loop \ bar bas
	largeur-monde 0 do 1 *monde @ dim-monde largeur-monde 2 * - i + + c! loop \ bar bas
	hauteur-monde 0 do 1 *monde @ largeur-monde i * + c! loop \ cloison gauche
	hauteur-monde 0 do 1 *monde @ largeur-monde i * 1 + + c! loop \ cloison gauche
	hauteur-monde 0 do 1 *monde @ largeur-monde i *
	largeur-monde + 1 - + c! loop \ cloison droite
	hauteur-monde 0 do 1 *monde @ largeur-monde i *
	largeur-monde + 2 - + c! loop \ cloison droite
;

: ilot \ cree un ilot central
	hauteur-monde 2 / 0 do
	largeur-monde 3 / 0 do
	15 random 1 = if
	1 *monde @
	largeur-monde i hauteur-monde 3 / +
	* j largeur-monde 3 / + +
	+ c! then
	loop loop
;

: espace-tot
	dim-monde 0 do 1000 random
	1 = if 1 *monde @ i + c! then loop
;

: initialisation ( -- ) \ monde aléatoire borné
	*monde @ dim-monde 0 fill
	espace-tot
	ilot
	borne-monde
;

: initialisation1 ( -- ) \ monde aléatoire
	*monde @ dim-monde 0 fill
	dim-monde 0 do 1000 random
	1 = if 1 *monde @ i + c! then loop
	borne-monde
;

: regenere-mondeA
	dim-monde 0 do i dup position ! p-quad0 pos-quad c!
	regles *monde-buf @ i + c! loop
	*monde tampon 1 cells move
	*monde-buf *monde 1 cells move
	tampon *monde-buf 1 cells move
;

: regenere-mondeB
	dim-monde 0 do i dup position ! p-quad1 pos-quad c!
	regles *monde-buf @ i + c! loop
	*monde tampon 1 cells move
	*monde-buf *monde 1 cells move
	tampon *monde-buf 1 cells move
;


: dessine-monde ( -- )
largeur-monde 0 do
	hauteur-monde 0 do
		largeur-monde i * j + centre etat c!
			etat @ 1 = if
				j i green pixel else
				j i black pixel

then
loop loop

;

: depart
	initialisation
        init	
	dessine-monde
	view
;

: propagation
	BEGIN
	dessine-monde
	view
	1 pause
	regenere-mondeA
	dessine-monde
	view
	1 pause
	regenere-mondeB
	\ key? if key 83 = if cr exit then then
	AGAIN
        finish
;

: run
	cr ." Presse any key to start"
	cr ." Type s to stop" cr
	depart
	1000 pause
	\ Readkey \ whait for a key and read it
	\ cr drop \ because ascii number is in the stack
	propagation

;

run
