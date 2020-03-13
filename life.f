\ -----------------------------------------------------------------------------
\  Game of Life
\  Cellular Automata
\  Michel Jean 2019 update 2020
\ -----------------------------------------------------------------------------

 
 ALSO GRAPHICS DEFINITIONS      \ all the graphic words  is inside this 
                                \ vocabulary

\ ==================== Random ====================================

WINAPI: GetTickCount KERNEL32.DLL

variable seed
GetTickCount seed !


: Random    ( -- x )  \ return a 32-bit random number x
    seed @
    dup 13 lshift xor
    dup 17 rshift xor
    dup 5  lshift xor
    dup seed !
    um* nip
;
\ ==================================================================

 

: init 
  S" Graphique" DROP    \ title
  800 1280 DEFWINDOW        \ 4 x 200-320  define a window size
  60  DEFFPS                   \ 60 frame per second
  DROP ( DROP )
  BEGINDRAW
  #BLACK    
  CLRBKG                          \ Efface les deux buffers 
  ENDDRAW 
  DROP
  #BLACK
  CLRBKG                          \ #WHITE OR #BLACK BACKGR.
  ENDDRAW 
   \ CloseWindow DROP 
;

variable color  \ couleur par default
#lime color !

: pixel ( X Y -- )
color @ 4 4 3 roll 4 * 4 roll 4 * drawrect ;

:  view enddraw ;                      \ affiche le buffer suivant

: finish CloseWindow DROP ;

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
                #lime color ! j i pixel else
		        #black color ! j i pixel

	then
	loop loop
;

: run
	initialisation
        init	
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

