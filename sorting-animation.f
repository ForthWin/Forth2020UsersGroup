\ Programme de visualisation d'algorithmes de tri.
\ 6 algorithmes : Bubble, Heap, Insert, Merge, Shell, Quick.

S" pixel.f" INCLUDED

160 CONSTANT nbr-elements
160 CONSTANT nbr-tirages

\ =============================
\ Genere la liste aleatoire
\ =============================


variable ensemble nbr-elements cells allot
variable elementA \ element arrivé
variable elementD \ element de départ
variable positionD \ position  départ
variable positionA \ position arrivé
variable compteur \ compteur pour analyse

: initialise-ensemble
	nbr-elements 1 - positionD !
	nbr-elements 0 do
	i ensemble i cells + !
	loop ;

: tire-une-element \ tire une element du paquet, memorise l'element et sa position
	positionD @ random dup cells ensemble + @ elementA ! positionA ! ;

: prend-element-dessus
	ensemble positionD @ cells + @ elementD ! ;

: inverse-elements \ inverse les elements dans la pile
	elementA @ ensemble positionD @ cells + !
	elementD @ ensemble positionA @ cells + ! ;


\ fonction principale

: melange
	nbr-tirages 0 do
	tire-une-element
	prend-element-dessus
	inverse-elements
	positionD @ 1 - positionD !
	loop ;

\ ================
\ Affichage
\ ================

: affichage
	nbr-elements 0 do
	i 2 * 0 i 2 * i cells ensemble + @ draw-line \ double la largeur de la ligne
	i 2 * 1 + 0 i 2 * 1 + i cells ensemble + @ draw-line
	loop view cls \ important de vider le buffer! 
;

: animation ( pause -- )
	affichage
	compteur @ 1+ compteur !
	pause ;
	
\ ================
\ Bubble sort
\ ================

: inverse-bubble ( addr1 addr2 -- ) 
	dup cells ensemble + swap 1+ cells ensemble + swap
	over @ over @        ( read values )
	swap rot ! swap !   ( inverse range values )
    5 animation
;

: comparaison-bubble ( position --  position vpos vpos1+ ) \ compare avec la cellule un cran au dessus
	dup dup cells ensemble + @ 
	swap 1+ cells ensemble + @ ( 2dup )
	> if inverse-bubble else ( 2drop ) drop then
;

: bubble-sort
	nbr-elements 1- 0 do 
	nbr-elements 1- i - 0 do
	i comparaison-bubble
  loop loop
;


\ ====================
\ Heap sort
\ ====================
 
: precede                         ( n1 n2 a -- f)
	>r cells r@ + @ swap cells r> + @ swap < ;

: inverser-heap ( n1 n2 a --)
	>r cells r@ + swap cells r> + over @ over @ swap rot ! swap ! 
	50 animation
;

: r'@ r> r> r@ swap >r swap >r ;
 
: Descendre ( a e s -- a e s)
  swap >r swap >r dup                  
  begin dup 2* 1+ dup r'@ <                
  while                                
    dup 1+ dup r'@ <                   
    if over over r@ precede if swap then
    then drop over over r@ precede              
  while                                
    tuck r@ inverser-heap                  
  repeat then drop drop r> swap r> swap         
;
 
: Heap-sort ( -- )
  ensemble nbr-elements
  over >r dup 1- 1- 2/                         
  begin                                
    dup 0< 0=                          
  while                                
    Descendre 1- repeat drop 1- 0                                
  begin over 0 >                           
  while over over r@ inverser-heap              
  Descendre swap 1- swap              
  repeat drop drop drop r> drop ;

\ ====================
\ Shell sort
\ ====================

: Shell  ( adr n h -- adr n h)
  over >r tuck ?do                                  
    i swap >r 2dup cells + @ -rot                
    begin dup r@ - dup >r 0< 0=            
    while                              
      -rot over over r@ cells + @      
      < >r rot r> 
	  25 animation
    while                              
      over r@ cells + @ >r             
      2dup cells + r> swap ! drop r> 
	  25 animation
    repeat then                       
    rot >r 2dup cells +                
    r> swap ! r> drop drop r>
  loop r> swap 
  25 animation ;

: Shell-sort  
	ensemble nbr-elements
	dup begin dup 2 = if 2/ else 5 11 */ 
	then dup while Shell 
	repeat drop 2drop ;


\ ================
\ Merge sort
\ ================

: merge-step ( r mid l -- r mid+ l+ )
  over @ over @ < if
    over @ >r
    2dup - over dup cell+ rot move
    r> over !
	50 animation
    >r cell+ 2dup = if rdrop dup else r> 
  then
  then cell+
  
  ;

: merge ( r mid lt -- r l )
  dup >r begin 2dup > while merge-step repeat 2drop r> ;
 
: mid ( l r -- mid ) over - 2/ cell negate and + ; \ pour Merge et Quick
 
: sort ( r l -- r l )
  2dup cell+ > NOT if exit then
  swap 2dup mid recurse rot recurse merge 
;
 
: Merge-sort ( -- )
ensemble nbr-elements   
cells over + swap sort 2drop ;

 
\ ================
\ Quick sort
\ ================
 
: inverser    ( addr1 addr2 -- ) 
  over @ over @        
  swap rot ! swap !   
  50 animation
 ;
 
: partition ( l r -- l r r2 l2 )
  2dup mid @ >r ( r: pivot )
  2dup
  begin
    swap begin  dup @  r@  < while 1 cells+ repeat
    swap begin  r@ over @  < while 1 cells - repeat
    2dup > not if 2dup inverser  >r cell+ r> 1 cells -  then
    2dup >
  until
  r> drop 
  ;
 
: qsort ( l r -- )
  partition  swap rot
  2dup < if recurse else 2drop then
  2dup < if recurse else 2drop then 
  ;
 
: Quick-sort ( -- )
  ensemble nbr-elements 
  dup 2 < if 2drop exit then  1- cells over + qsort ;

\ ====================
\ Insert sort
\ ====================

: insert ( start end -- start )
  dup @ >r
  begin 2dup <			
  while
    r@ over cell- @ <		
  while
    cell- dup @ over cell+ !		
  repeat then r> swap !
  100 animation
  ;		
 
: Insert-sort ( -- )
  ensemble nbr-elements
  1 ?do dup i cells + insert loop drop ;

	
\ ====================
\ Affichage
\ ====================  

: initialisation
	set-screen
    0 compteur !
	initialise-ensemble
	melange ;

: B-sort
	initialisation
	cyan
	affichage
	1000 pause
	Bubble-sort
	cr ." Bubble sort : done after " compteur ? ." permutations."
	1000 pause ;

: H-sort	
	initialisation
	0 75 100 color
	affichage
	1000 pause
	Heap-sort
	cr ." Heap sort : done after " compteur ? ." permutations."  ;
	
: S-sort
	initialisation
	Red
	affichage
	1000 pause
	Shell-sort
	cr ." Shell sort : done after " compteur ? ." permutations." ;
	
: M-sort
	initialisation
	100 20 100 color
	affichage
	1000 pause
	Merge-sort
	cr ." Merge sort : done after " compteur ? ." permutations." ;
		
: Q-sort
	initialisation
	green
	affichage
	1000 pause
	Quick-sort
	cr ." Quick sort : done after " compteur ? ." permutations."  ;
	
: I-sort
	initialisation
	yellow
	affichage
	1000 pause
	Insert-sort
	cr ." Insert sort : done after " compteur ? ." permutations." ;
	
: run
cr ." Six sorting algorithms!" cr
." For Bubble sort type : B-sort" cr
." For Shell sort type : S-sort" cr
." For Heap sort type : H-sort" cr
." For Merge sort type : M-sort" cr
." For Quick sort type : Q-sort" cr
." For Insert sort type : I-sort" cr ;

2drop
run
 
 
