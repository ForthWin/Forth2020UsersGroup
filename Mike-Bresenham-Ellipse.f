\ Bresenham Ellipse 
\ Based on "A Fast Bresenham Type AlgorithmFor Drawing Ellipses"
\ https://dai.fmph.uniba.sk/upload/0/01/Ellipse.pdf

\ Bresenham Circle
\ based on a post on geeksforgeeks
\ https://www.geeksforgeeks.org/bresenhams-circle-drawing-algorithm/



S" dessin.f" INCLUDED    \ the OpenGL routines
S" rand.f" INCLUDED    \ little Xor Shift pseudo-random generator 



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


\ variables for plotting ellipse
0 value PE_X
0 value PE_Y
0 value RadiusError
0 value EllipseError
0 value TwoASquare
0 value TwoBSquare
0 value StoppingX
0 value StoppingY
0 value Xradius
0 value Yradius




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

 

create sinus
     0 ,  1745 ,  3490 ,  5234 ,  6976 ,  8716 , 10453 , 12187 , 13917 ,
 15643 , 17365 , 19081 , 20791 , 22495 , 24192 , 25882 , 27564 , 29237 ,
 30902 , 32567 , 34202 , 35837 , 37461 , 39073 , 40674 , 42262 , 43837 ,
 45399 , 46947 , 48481 , 50000 , 51504 , 52992 , 54464 , 55919 , 57358 ,
 58779 , 60182 , 61566 , 62932 , 64279 , 65606 , 66913 , 68200 , 69466 ,
 70711 , 71934 , 73135 , 74314 , 75471 , 76604 , 77715 , 78801 , 79864 ,
 80902 , 81915 , 82904 , 83867 , 84805 , 85717 , 86603 , 87462 , 88295 ,
 89101 , 89879 , 90631 , 91355 , 92050 , 92718 , 93358 , 93969 , 94552 ,
 95106 , 95630 , 96126 , 96593 , 97030 , 97437 , 97815 , 98163 , 98481 ,
 98769 , 99027 , 99255 , 99452 , 99619 , 99756 , 99863 , 99939 , 99985 ,
100000 ,

: (sinus)  4 * sinus + @ ;   ( angle - unsigned_sin*100000 )

: sin  ( angle - sin*100000 )
   dup abs dup
   360 > if  360 mod
         then dup
         91 < if (sinus)                                 \ < 90
              else dup 181 <
                   if 180 - abs (sinus)                   \ 91 - 179
                   else dup 271 <
                        if 180 - (sinus) negate            \ 180 - 269
                        else 360 - abs (sinus) negate      \ 270 - 360
                        then
                    then
                then
   swap 0< if negate
           then
 ;
\ 90 sin .s abort
: cos          ( angle - cos*100000 )
   90 - dup 0> >r
   abs sin r>
       if negate then
 ;




\ sinustest
800 value fromm 1 value scal1 1 value scal2
\ :  bbsinr   fromm  0 do  i  scal1 scal2  */   i sin 1000 /  300 + p5  loop ;  \  red
\ :  bbsinw  fromm  0 do  i  scal1 scal2  */    i sin 1000 /  300 + p3  loop ;  \ yellow white
\ :  bbsiny  fromm  0 do  i   i sin 1000 /  300 + p6  loop ;  \ white

\  : testsin  800 to fromm  20 0 do bbsinr  300 ms  bbsinw  100 ms loop  ;

\  :  circe   360  0 ?do   i cos 1000 /  200 +       i sin 1000 /  200 + p5  loop ;  \  red


:  CIR1  ( --)    \  ONLY FOR TESTING  
           \   INIT-MY-OPENGL  ( --)  
                  0.0E fto  X         0e0     fto  Y       Point	  
              0 0 p3  view 
              
                360  0 do       i sin 1000 /  200 +
                                i cos 1000 /  200 +
                ( 2dup )   p3   \ 5 PAUSE  
                                 \       ( BLACK p3 )  
                loop  
                   \ CR    ." -- END CIRCLE OK -- "     
                 VIEW  1000 pause 
            \ CR    ." ALL WELL "  
            1000 pause     \  view  3000 pause view  \ 6000 pause 
;  \  end circle


:  CIR2 ( --)    \  ONLY FOR TESTING  
            \   INIT-MY-OPENGL  ( --)  
           \ CR  ." CIRCLE 2"  
                  0.0E fto  X         0e0     fto  Y       Point	  
              0 0 p3      view 
              
                360  0 do       i sin 1000 /   30 +
                                i cos 1000 /   30 +
                ( 2dup )   p3   \ 5 PAUSE  
                                 \       ( BLACK p3 )  
                loop 
                      
                 VIEW  3000 pause view  3000 pause view  \ 6000 pause 
;  \  end circle


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


: Bresenham_Circle       

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


: Plot4EllipsePoints

CX PE_X  + CY PE_Y +  set-dot
CX PE_X  - CY PE_Y +  set-dot
CX PE_X  - CY PE_Y -  SET-DOT
CX PE_X  + CY PE_Y -  SET-DOT

;

: Bresenham_Ellipse ( cx, cy, Xradius, Yradius -- ) \ Start Bresenham Ellipse algorithm

Xradius dup * 2 * to TwoASquare  \ TwoASquare = 2*Xradius*Xradius
Yradius dup * 2 * to TwoBSquare  \ TwoBSquare = 2*Yradius*Yradius

Xradius to PE_X    \ PE_X = Xradius
0       to PE_Y    \ PE_y = 0
Yradius dup * 1 2 Xradius * - * to Xchange \ Xchange = Yradius*Yradius*(1-2*Xradius)
Xradius dup * to Ychange                   \ Ychange = Xradius*Xradius
0 to EllipseError                          \ EllipseError = 0
TwoBSquare Xradius * to StoppingX          \ StoppingX = TwoSquare*Xradius
0                    to StoppingY          \ StoppingY = 0

Begin

   StoppingX StoppingY >=

While \ While StoppingX >= StoppingY

  Plot4EllipsePoints ( PE_X, PE_Y )
  PE_Y 1+ to PE_Y   \ PE_Y = PE_Y + 1
   StoppingY TwoASquare + to StoppingY       \ Stoppingx = StoppingX + TwoASquare
   EllipseError Ychange + to EllipseError    \ EllipseError = EllipseError + Ychange
   Ychange TwoASquare +   to Ychange         \ Ychange = Ychange + TwoASquare

   2 EllipseError * Xchange + 0>
   if \ if 2*EllipseError + Xchange > 0
      PE_X 1- to PE_X                        \ PE_X = PE_X - 1
      StoppingX TwoBSquare - to StoppingX    \ StoppingX = StoppingX - TwoBSquare
      EllipseError Xchange + to EllipseError \ EllipseError = EllipseError + Xchange
      Xchange TwoBSquare +   to Xchange      \ Xchange = Xchange + TwoBSquare
   then

Repeat

\ 1st point set is done; start the 2nd set of points

0 to PE_X                                   \ PE_X = 0
YRadius to PE_Y                             \ PE_Y = Yradius
Yradius dup * to Xchange                    \ Xchange = Yradius*Yradius
Xradius dup * 1 2 Yradius * - * to Ychange  \ Ychange = Xradius*Xradius*(1-2*Yradius)
0 to EllipseError                           \ EllipseError = 0
0 to StoppingX                              \ StoppingX = 0
TwoASquare Yradius * to StoppingY           \ StoppingY = TwoASquare * Yradius

Begin

StoppingX StoppingY <=

While  \ while StoppingX <= StoppingY
     Plot4EllipsePoints
     PE_X 1+ to PE_X                         \ PE_X = PE_X + 1
      StoppingX TwoBSquare + to StoppingX    \ StoppingX = StoppingX + TwoBSquare
      EllipseError Xchange + to EllipseError \ EllipseError = EllipseError + Xchange
      Xchange  TwoBSquare  + to Xchange      \ Xchange = Xchange + TwoBSquare

      2 EllipseError * Ychange + 0>
      if      \  if  2*EllipseError + Ychange > 0
          PE_Y 1- TO PE_Y                        \ PE_Y = PE_Y - 1
          StoppingY TwoASquare - to StoppingY    \ StoppingY = StoppingY - TwoASquare
          EllipseError Ychange + to EllipseError \ EllipseError = EllipseError + Ychange
          Ychange TwoASquare   + to Ychange      \ Ychange= Ychange + TwoASquare
      then
repeat
;



: circle  Dessin 2  PointSize  
            	 
100 0 do
	255 Random 255 Random 255 Random Color
	500 Random 300 - TO CX 500 Random 250 - TO CY 300 Random to R
	Bresenham_Circle loop 
	view

;

: Ellipse   Dessin 2 PointSize 
            	 

100 0 do
         255 random 255 random 255 random color
         500 Random 300 - TO CX 500 Random 250 - TO CY 250 RANDOM to XRadius 250 RANDOM to YRadius 
         Bresenham_Ellipse 
        loop
        VIEW  

;
Ellipse
        
     
