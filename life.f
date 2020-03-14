\ -----------------------------------------------------------------------------
\  Game of Life
\  Cellular Automata
\  Michel Jean 2019 update 2020
\ -----------------------------------------------------------------------------
S" pixel.f" Included

320 constant largeur-monde \
200 constant hauteur-monde
largeur-monde hauteur-monde * constant dim-monde

variable pos-X
variable pos-Y

0 pos-X !
0 pos-Y !

\ ===================================

create  monde dim-monde allot
create  monde-buf dim-monde allot

variable *monde
variable *monde-buf
variable tampon

variable total \ nbr voisins
variable etat

' monde *monde !
' monde-buf *monde-buf !

: centre ( n -- )
*monde @ + c@
;
\ 9 voisins possibles
: est ( n -- )
	1 + dim-monde mod *monde @ + c@ ;

: ouest ( n -- )
	1 - dim-monde mod *monde @ + c@ ;

: nord ( n -- )
	largeur-monde - dim-monde mod *monde @ + c@ ;

: sud ( n -- )
	largeur-monde + dim-monde mod *monde @ + c@ ;

: nord-est ( n -- )
	largeur-monde - 1 + dim-monde mod *monde @ + c@ ;

: nord-ouest ( n -- )
	largeur-monde - 1 - dim-monde mod *monde @ + c@ ;

: sud-est ( n -- )
	largeur-monde + 1 + dim-monde mod *monde @ + c@ ;

: sud-ouest ( n -- )
	largeur-monde + 1 - dim-monde mod *monde @ + c@ ;

\ voisinage de moore

: somme-moore ( n -- ) \ returne le nombre de voisins
	dup nord-ouest
	swap dup nord
	swap dup nord-est
	swap dup est
	swap dup sud-est
	swap dup sud
	swap dup sud-ouest
	swap ouest
	+ + + + + + +
;

\ regles de conway
: conway
	dup
	centre etat c!
	somme-moore total c!

	total @ 3 = if 1 etat c! else
	total @ 2 = if ( reste pareil ) else
	0 etat c!
	then then
	etat c@
;

\ =========================================

: initialisation ( -- ) \ monde aléatoire
	*monde @ dim-monde 0 fill
	dim-monde 0 do 10 random
	1 = if 1 *monde @ i + c! then loop
;

: regenere-monde
	dim-monde 0 do i conway *monde-buf @ i + c! loop
	*monde tampon 1 cells move
	*monde-buf *monde 1 cells move
	tampon *monde-buf 1 cells move
;

: dessine-monde ( -- )
	largeur-monde 0 do
	hauteur-monde 0 do
		largeur-monde i * j + *monde @ + c@ 1 = if
                j i green pixel else
		j i black pixel

	then
	loop loop
;

: run
	initialisation
        init-screen	
	dessine-monde
	BEGIN 
		dessine-monde
		regenere-monde
		view
		10 pause
        KEY?	UNTIL
        finish
;

: message 
." Game of life " cr
." Type run to start" cr
." Press any key to stop" cr
;

message

