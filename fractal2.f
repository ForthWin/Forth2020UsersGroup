\ Programme pour un fractal de mendelbrot
 
 ALSO GRAPHICS DEFINITIONS      \ all the graphic words  is inside this 
                                \ vocabulary
: init 
  S" Mandelbrot" DROP    \ title
  960 1080 DEFWINDOW        \ 2 x 240-270  define a window size
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
color @ 1 1 3 roll 4 roll drawrect ;

: print enddraw ;                      \ affiche le buffer suivant

: finish CloseWindow DROP ;

\ définit la zone que l'on dessine
200 constant iteration_max
fvariable x1
fvariable x2
fvariable y1
fvariable y2


variable image_x \ 27 x 24
variable image_y
fvariable zoom 
400e zoom f!

\ calcul la taille de l'image
: dimension
x2 f@ x1 f@ f- zoom f@ f* f>ds abs image_x !
y2 f@ y1 f@ f- zoom f@ f* f>ds abs image_y !
image_x ? image_y ?
;

dimension

fvariable c_r
fvariable c_i
fvariable z_r
fvariable z_i
fvariable tmp
variable iteration

: mandelbrot

image_y @ 0 do 
        image_x @ 0 do
        i ds>f zoom f@ f/ x1 f@ f+ c_r f!
        j ds>f zoom f@ f/ y1 f@ f+ c_i f!
        0e z_r f!
        0e z_i f!
        0 iteration !
                BEGIN
                z_r f@ tmp f!
                z_r f@ fdup f* z_i f@ fdup f* f- c_r f@ f+ z_r f!
                z_i f@ 2e f* tmp f@ f* c_i f@ f+ z_i f!
                iteration @ 1 + iteration !
                
                z_r f@ fdup f* z_i f@ fdup f* f+ 4e f< iteration @ iteration_max < and not
                UNTIL
                iteration @ iteration_max = if #black color ! i j pixel else 
                iteration @ 10 < if 44278190080  iteration @ 255 * 10 / 16777216 *  + color ! i j pixel else
                iteration @ 20 < if 44278190080  iteration @ 255 * 20 / 65536 * + color ! i j pixel else   
                iteration @ 30 < if 4278190335  iteration @ 255 * 10 / 256 * + color ! i j pixel else
                4278190080  iteration @ 255 * iteration_max / + color ! i j pixel
                        then then then then  
loop loop ;

: zoom0
400e zoom f!
-2.1e x1 f!
0.6e x2 f!
-1.2e y1 f!
1.2e y2 f!
dimension
mandelbrot print
;

: zoom1
4000e zoom f!
-0.635e x1 f!
-0.365e x2 f!
-0.74e y1 f!
-0.5e y2 f!
dimension
mandelbrot print
;


: zoom2
40000e zoom f!
-0.392e x1 f!
-0.365e x2 f!
-0.649e y1 f!
-0.625e y2 f!
dimension
mandelbrot print
;

: zoom2b
40000e zoom f!
-0.38e x1 f!
-0.353e x2 f!
-0.654e y1 f!
-0.63e y2 f!
dimension
mandelbrot print
;

: zoom3
400000e zoom f!
-0.3657e x1 f!
-0.363e x2 f!
-0.6424e y1 f!
-0.6400e y2 f!
dimension
mandelbrot print
;
init
2000 pause zoom0
2000 pause zoom1
2000 pause zoom2b
8000 pause finish
