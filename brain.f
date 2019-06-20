\ -----------------------------------------------------------------------------
\  Brain's Brain
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


: pixel-vert
0 100 0 Color pixel-affiche ;

: pixel-rouge
0 0 100 Color pixel-affiche ;

: pixel-noir
0 0 0 Color pixel-affiche ;


\ ===========================================================

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
*monde @ + c@
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

: brain
dup
centre etat c! \ l'état est 1 ou 0, vivant ou mort
somme-moore total c!

etat @ 0 = total @ 2 = and if 1 etat c! else
etat @ 1 = if 2 etat c! else \ introduit un état réfractaire
etat @ 2 = if 0 etat c! else
0 etat c!
then then then
etat c@
;
\ =========================================

: initialisation ( -- ) \ monde aléatoire
*monde @ dim-monde 0 fill
dim-monde 0 do 16 random
1 = if 1 *monde @ i + c! then loop
;

: regenere-monde
dim-monde 0 do i brain *monde-buf @ i + c! loop
*monde tampon 1 cells move
*monde-buf *monde 1 cells move
tampon *monde-buf 1 cells move
;

: dessine-monde ( -- )
largeur-monde 0 do
	hauteur-monde 0 do
		largeur-monde i * j + *monde @ + c@ 1 = if
			j i pixel-vert else
		largeur-monde i * j + *monde @ + c@ 2 = if
			j i pixel-rouge else
				j i pixel-noir

then then
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

