\ based on a post on geeksforgeeks
\ https://www.geeksforgeeks.org/bresenhams-circle-drawing-algorithm/


S" demos/opengl2/PETER-OPENGL1.F" INCLUDED    \ here is the OpenGL routines
\ REQUIRE   glOpen	demos/opengl2/PETER-OPENGL1.F    \ here is the OpenGL routines



0 value xtemp \  xtemp=0
0 value ytemp \  ytemp=0
0 value radius \  radius=0

\ variables for plotting circle
0 value PC_X
0 value PC_Y
0 value Xchange
0 value Ychange
0 value RadiusError
0 value CX
0 value CY
0 value R
0 value pc_d



\  INIT-MY-OPENGL          \ INITILIZE  OPENGL  VIEWPORT, MUST BE CLEANED, BUT WORKS

: BLUE    200 200 100 Color  ;

0e0  fvalue xn  0e0 fvalue yn

: SET-DOT    (  xn xy  --)        
               s>f  fto yn   s>f  fto  xn    \ temporary buffer
          xn    80e0   F/    fto    X   \    x  f.
          yn    80e0   F/    fto    Y    \  y  f.    cr  
         Point	        ;


 : P3  ( X Y --)   SET-DOT ;    
 
 : P5  ( X Y --)   SET-DOT ;      
 : P6  ( X Y --)   SET-DOT ;      

: MS PAUSE ;

\ CODE FOR MISSING 0>
: 0>  0 > ;


\ ------------------------------------------
\ code for missing >=
\ ------------------------------------------
: >= ( n1 n2 -- flag ) 
  2dup >   \ copy both numbers, test for >
  rot rot  \ bring original 2 numbers to tos
  =        \ test for =
  or       \ or both flags for either or
;

\ missing <=
: <=  2dup < rot rot = or ;
 : F> F< 0= ;
 : F>S  ( --n) F>D  D>S  ;    \   float to integer)  

: F2DUP         ( fs: r1 r2 -- r1 r2 r1 r2 )       \ W32F          Floating extra
\ *G Duplicate the top 2 FP stack entries.
                fover fover ;



0e FVALUE win.xleft
0e FVALUE win.xright
0e FVALUE win.ybot
0e FVALUE win.ytop
0e FVALUE win.xdif
0e FVALUE win.ydif


variable SXoffs
variable SXdiff
variable SYoffs
variable SYdiff

1.0e FVALUE PenX
1.0e FVALUE PenY


 

: SCALE         \ F: <x> <y> --- <>  <> --- <x> <y>
                win.ybot  F-  win.ydif F/  SYdiff @ S>F F*  F>S SYoffs @ +
                win.xleft F-  win.xdif F/  SXdiff @ S>F F*  F>S SXoffs @ +
                SWAP ;

\ -- Won't plot a point that doesn't fall within the window.
: PLOT-POINT  ;  \    PenX win.xleft win.xright       \ <color> --- <>
 \               F2DUP F> IF FSWAP THEN 
  \                FWITHIN 0= IF DROP EXIT THEN 
  \              PenY win.ybot  win.ytop
  \              F2DUP F> IF FSWAP THEN 
  \                FWITHIN 0= IF DROP EXIT THEN 
  \              PenX PenY SCALE ROT SET-DOT ;
 
\  : xypos        ( x y -- )
\                 to prev-y  to prev-x ;

 




: DrawCircle

CX PC_X +   CY PC_Y +  SET-DOT
CX PC_X -   CY PC_Y +  SET-DOT  
CX PC_X -   CY PC_Y -  SET-DOT  
CX PC_X +   CY PC_Y -  SET-DOT  
CX PC_Y +   CY PC_X +  SET-DOT  
CX PC_Y -   CY PC_X +  SET-DOT  
CX PC_Y -   CY PC_X -  SET-DOT  
CX PC_Y +   CY PC_X -  SET-DOT  

;


: Bresenham       

0 TO PC_X
R TO PC_Y
3 2 R * - to pc_d \ pc_d = 3-2*R
DrawCircle

BEGIN
   PC_Y PC_X >= \ WHILE PC_Y >= PC_X
WHILE
     \ For each pixel we will draw 8 pixels
     PC_X 1+ TO PC_X   \ PC_X = PC_X+1
     \ check for decision parameter and correspondingly update d, PC_X and PC_Y
     pc_d 0>   \ if pc_d>0
     if
       PC_Y 1- TO PC_Y \ PC_Y = PC_Y -1
       pc_d 4  PC_X PC_Y - * + 10 + to pc_d  \ pc_d = pc_d + 4*(PC_X - PC_Y) + 10
     else 
       pc_d 4 PC_X * 6 + + to pc_d   \ pc_d = pc_d + 4*PC_X + 6
     then

     DrawCircle

REPEAT ;       



: circle  INIT-MY-OPENGL 2  PointSize   \ CIR1 CIR2 ;
            	 

BLUE
\                  0.0E fto  X         0e0     fto  Y       Point	  
\              0 0 p3       

   20 0 DO
         200 random 200 random 200 random color
         800 RANDOM  TO CX 800 RANDOM TO CY 400 RANDOM to R
         Bresenham view 400 PAUSE
        loop 
   20000 pause
glclose
;

\ Create concentric circles situated at center (200,10) with R=100, decreasing radius by 10 
: Concentric_Circles INIT-MY-OPENGL 2  PointSize

blue 

200 0 do
    400 TO R
   20 0 DO
         200 random 200 random 200 random color
         200 CX 20 TO CY R 10 - to R
         Bresenham  view
         400 PAUSE
        loop view
   20000 pause
glclose
           
;

Concentric_Circles     