\ -----------------------------------------------------------------------------
\  Game of Life with "Echo"
\  Cellular Automata
\  Michel Jean June 2019
\ -----------------------------------------------------------------------------

S" pixel.f" INCLUDED

320 constant largeur-monde \
200 constant hauteur-monde
largeur-monde hauteur-monde * constant dim-monde


variable pos-X
variable pos-Y

0 pos-X !
0 pos-Y !


\ ===============================================================
create  monde dim-monde allot
create  monde-buf dim-monde allot

variable *monde
variable *monde-buf
variable tampon

variable total \ nbr voisins
variable etat

' monde *monde !
' monde-buf *monde-buf !

: last-bit ( n -- )
2 mod ;

: centre ( n -- )
*monde @ + c@ last-bit
;

\ 9 voisins possibles
: est ( n -- )
	1 + dim-monde mod *monde @ + c@ last-bit ;

: ouest ( n -- )
	1 - dim-monde mod *monde @ + c@ last-bit ;

: nord ( n -- )
	largeur-monde - dim-monde mod *monde @ + c@ last-bit ;

: sud ( n -- )
	largeur-monde + dim-monde mod *monde @ + c@ last-bit ;

: nord-est ( n -- )
	largeur-monde - 1 + dim-monde mod *monde @ + c@ last-bit ;

: nord-ouest ( n -- )
	largeur-monde - 1 - dim-monde mod *monde @ + c@ last-bit ;

: sud-est ( n -- )
	largeur-monde + 1 + dim-monde mod *monde @ + c@ last-bit ;

: sud-ouest ( n -- )
	largeur-monde + 1 - dim-monde mod *monde @ + c@ last-bit ;

\ voisinage de moore

: moore ( n -- ) \ returne le nombre de voisins

	dup nord-ouest
	swap dup nord
	swap dup nord-est
	swap dup est
	swap dup sud-est
	swap dup sud
	swap dup sud-ouest
	swap ouest
;

: somme-moore
moore
+ + + + + + +
;

\ regles de conway avec echo
: conway-echo1
	dup
	centre etat c! \ l'état est 1 ou 0, vivant ou mort
	somme-moore total c!
	total @ 3 = if 3 etat c! else
	total @ 2 = if ( reste pareil ) else
	0 etat c!
	then then
	etat c@
;


: conway-echo
	dup
	centre etat c! \ l'état est 1 ou 0, vivant ou mort
	somme-moore total c!

	etat @ 0 = total @ 3 = and if 1 etat c! else
	etat @ 1 = total @ 3 = and if 3 etat c! else
	etat @ 1 = total @ 2 = and if 3 etat c! else
	etat @ 1 = if 2 etat c! else
	0 etat c!
	then then then then
	etat c@
;
\ =========================================

: initialisation ( -- ) \ monde aléatoire
	*monde @ dim-monde 0 fill
	dim-monde 0 do 8 random
	1 = if 1 *monde @ i + c! then loop
;

: regenere-monde
	dim-monde 0 do i conway-echo *monde-buf @ i + c! loop
	*monde tampon 1 cells move
	*monde-buf *monde 1 cells move
	tampon *monde-buf 1 cells move
;

: dessine-monde ( -- )
	largeur-monde 0 do
	hauteur-monde 0 do
		largeur-monde i * j + *monde @ + c@ 1 = if
				j i blue pixel else
		largeur-monde i * j + *monde @ + c@ 2 = if
				j i red pixel else
		largeur-monde i * j + *monde @ + c@ 3 = if
				j i green pixel else
				j i black pixel

	then then then
	loop loop
;

: run

	initialisation
	set-screen
	dessine-monde
	BEGIN
	dessine-monde
	regenere-monde
	view
	key? if key 83 = if cr exit then then
	10 pause
	AGAIN
;

: depart
	cr ." Type run to start"
	cr ." Type s to stop" cr ;

depart
