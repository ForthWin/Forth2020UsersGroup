\ -----------------------------------------------------------------------------
\  Lichens
\  Cellular Automata
\  Michel Jean 2019
\ -----------------------------------------------------------------------------

S" Rand.f" INCLUDED 
S" Dessin.f" INCLUDED

240 constant largeur-monde \
440 constant hauteur-monde
largeur-monde hauteur-monde * constant dim-monde

fvariable p0
fvariable p1

variable pos-X
variable pos-Y

0 pos-X !
0 pos-Y !

: pixel-affiche ( --)
   s>d d>f 24e  f/ 9e F- p0 f!           \  X
   s>d d>f 24e  f/ 5e F- p1 f!           \ Y
   p0 f@ fto  X  
   p1 f@ fto  Y  
   Point
  
;

: pixel-cyan
100 100 0 Color pixel-affiche ;

: pixel-noir
0 0 0 Color pixel-affiche ;

\ ============================================

create  monde dim-monde allot
create  monde-buf dim-monde allot

variable *monde
variable *monde-buf
variable tampon

variable total \ nbr voisins
variable etat \ etat de la cellule

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

\ regles lichens
: lichens
dup
centre etat c!
somme-moore total c!

total @ 3 = if 1 etat c! ELSE
total @ 4 = if 0 etat c! ELSE
total @ 7 = if 1 etat c! ELSE
total @ 8 = if 1 etat c!
then then then then
etat c@
;

\ =========================================

: initialisation ( -- ) \ monde aléatoire
*monde @ dim-monde 0 fill
dim-monde 0 do 100 random
1 = if 1 *monde @ i + c! then loop
;

: regenere-monde
dim-monde 0 do i lichens *monde-buf @ i + c! loop
*monde tampon 1 cells move
*monde-buf *monde 1 cells move
tampon *monde-buf 1 cells move
;


: dessine-monde ( -- )
largeur-monde 0 do
	hauteur-monde 0 do
		largeur-monde i * j + *monde @ + c@ 1 = if
			j i pixel-cyan else
				j i pixel-noir

then
loop loop

;

: run
initialisation
Dessin
dessine-monde
do
dessine-monde
regenere-monde
view
10 pause
loop
;

run 

