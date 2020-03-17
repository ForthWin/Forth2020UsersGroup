\ -----------------------------------------------------------------------------
\  Pixel - simulation of old school screen 320 x 200 V2.0
\  Include a pseudo random number generator
\  For Forth2020
\  Michel Jean, march 2020
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
\ =================================================================
\ Colors - basic retro colors
\ =================================================================
variable color  

: gray #GRAY color ! ;
: yellow #YELLOW color ! ;
: orange #ORANGE color ! ;
: pink #PINK color ! ;
: red #RED color ! ;
: darkgreen #GREEN color ! ;
: green #LIME color ! ;
: blue #BLUE color ! ;
: lightblue #SKYBLUE color ! ;
: darkblue #DARKBLUE color ! ;
: purple #PURPLE color ! ;
: violet #VIOLET color ! ;
: brown #BROWN color ! ;
: black #BLACK color ! ;
: white #WHITE color ! ;
 
\ =================================================================
\ Screen 320-200
 =================================================================
: init-screen 
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
\ =================================================================

\ color by default
green

: pixel ( X Y -- )
color @ 4 4 3 roll 4 * 4 roll 4 * drawrect ;

: view enddraw ;                      \ affiche le buffer suivant

: finish CloseWindow DROP ;


