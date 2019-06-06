\ ---------------------------------------------------------------------------------------
\  OpenGl for Windows
\  Fern of Win32forth  adapted by PeterForth (last modification Michel Jean, 5 june 2019)
\ ---------------------------------------------------------------------------------------


S" lib\include\float2.f" INCLUDED



MODULE: HIDDEN  \   <<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

WINAPI: CreateWindowExA		USER32.DLL
WINAPI: GetSystemMetrics	USER32.DLL
WINAPI: GetDC			USER32.DLL
WINAPI: ReleaseDC		USER32.DLL
WINAPI: ShowCursor		USER32.DLL
WINAPI: GetAsyncKeyState	USER32.DLL

WINAPI: ChoosePixelFormat	GDI32.DLL
WINAPI: SetPixelFormat		GDI32.DLL
WINAPI: SwapBuffers		GDI32.DLL

WINAPI: wglCreateContext	OPENGL32.DLL
WINAPI: wglMakeCurrent		OPENGL32.DLL
WINAPI: glHint			OPENGL32.DLL
WINAPI: glMatrixMode		OPENGL32.DLL
WINAPI: glClear			OPENGL32.DLL
WINAPI: glLoadIdentity		OPENGL32.DLL
WINAPI: glTranslated		OPENGL32.DLL
WINAPI: glPointSize		OPENGL32.DLL
WINAPI: glBegin			OPENGL32.DLL
WINAPI:	glVertex2d		OPENGL32.DLL
WINAPI:	glEnd			OPENGL32.DLL
WINAPI: glColor3b		OPENGL32.DLL
WINAPI: glRotated		OPENGL32.DLL
WINAPI: glLineWidth		OPENGL32.DLL
WINAPI: glPolygonMode		OPENGL32.DLL
WINAPI: glEnable		OPENGL32.DLL
WINAPI: glDisable		OPENGL32.DLL

WINAPI: gluPerspective		GLU32.DLL

0
2 -- nSize
2 -- nVersion
CELL -- dwFlags
1 -- iPixelType
1 -- cColorBits
1 -- cRedBits
1 -- cRedShift
1 -- cGreenBits
1 -- cGreenShift
1 -- cBlueBits
1 -- cBlueShift
1 -- cAlphaBits
1 -- cAlphaShift
1 -- cAccumBits
1 -- cAccumRedBits
1 -- cAccumGreenBits
1 -- cAccumBlueBits
1 -- cAccumAlphaBits
1 -- cDepthBits
1 -- cStencilBits
1 -- cAuxBuffers
1 -- iLayerType
1 -- bReserved
CELL -- dwLayerMask
CELL -- dwVisibleMask
CELL -- dwDamageMask
CONSTANT PIXELFORMATDESCRIPTOR
0 VALUE pfd		\ structure for opengl
PIXELFORMATDESCRIPTOR ALLOCATE THROW TO pfd
0x25 pfd dwFlags !
32 pfd cColorBits C! 
pfd FREE THROW

0 VALUE glhandle	\ handle window
0 VALUE glhdc		\ context handle

EXPORT

0.0E FVALUE X		\ x coordinate
0.0E FVALUE Y		\ Y coordinate
0.0E FVALUE X1		\  x1
0.0E FVALUE Y1		\  y1
0.0E FVALUE X2		\  x2
0.0E FVALUE Y2		\  y2
0.0E FVALUE X3		\  x3
0.0E FVALUE Y3		\  y3


\ The height of the screen image in pixels
: VScreen ( -> n )
	1 GetSystemMetrics ;

\ Screen width in pixels
: HScreen ( -> n )
	0 GetSystemMetrics ;
\ Cls
\ 
\ Number of float from float stack to data stack
: F>FL  ( -> f ) ( F: f -> )
	[                 
	0x8D C, 0x6D C, 0xFC C, 
	0xD9 C, 0x5D C, 0x00 C, 
	0x87 C, 0x45 C, 0x00 C, 
	0xC3 C, ] ;

\ Number of float from float stack to data stack
: F>DL ( -> d ) ( F: f -> )
	FLOAT>DATA SWAP ;

\ Convert number on stack to float
: S>FL ( n -> f )
	DS>F F>FL ;

\ Convert number on stack to double
: S>DL ( n -> d )
	DS>F F>DL ;

\ Aspect ratio of width and height
: AScreen ( -> d )
	HScreen DS>F VScreen S>D D>F F/ F>DL ;

\ Output the specified number of lines on the screen (from point to 4)
: LineLoop ( n -> )
	DUP 0 > IF Y F>DL X F>DL glVertex2d DROP THEN
	DUP 1 > IF Y1 F>DL X2 F>DL glVertex2d DROP THEN
	DUP 2 > IF Y2 F>DL X2 F>DL glVertex2d DROP THEN
	DUP 3 > IF Y3 F>DL X3 F>DL glVertex2d DROP THEN
	DROP ;


\ Show cursor on screen
: ShowCursore ( -> )
	1 ShowCursor DROP ;

\ Hide screen cursor
: HideCursore ( -> )
	0 ShowCursor DROP ;

\ Output
: glClose ( -> )
	glhdc glhandle ReleaseDC 0 ExitProcess ;
      
    
: glClose2 ( -> )
	glhdc glhandle ReleaseDC  ;  \  0 ExitProcess ;
    
\ Checks if a key is pressed by a given code
: key ( n -- flag )
	GetAsyncKeyState ;


\ &&&&&&&&&&&&&&&&&&&&&       SCREEN  SIZE   &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
\ &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
\ Initialize gl window
: glOpen ( -> )
   800 600 0 0  VScreen  2 /   HScreen   2 /  50 50 0x90000000 S" edit" DROP DUP 8 CreateWindowExA
   \  WILL OPEN AT 1/4 SCREEN TOP LEFT 
  \ 0 0 800 660 VScreen HScreen 0 0 0x90000000 S" edit" DROP DUP 8 CreateWindowExA
 
  \  TO MAKE  FULL SCREEN  USE THIS LINE :
\ 0  0  0 0  VScreen  ( 2 /  )  HScreen  ( 2 / )  0 0 0x90000000 S" edit" DROP DUP 8 CreateWindowExA
\ &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
\ &&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 
 
 
 DUP TO glhandle GetDC TO glhdc
 pfd DUP glhdc ChoosePixelFormat glhdc SetPixelFormat DROP
 glhdc wglCreateContext glhdc wglMakeCurrent DROP
 0x1102 0xC50 glHint DROP
 0x1701 glMatrixMode DROP
 100 S>DL 1 DS>F 10 DS>F F/ F>DL AScreen 90 S>DL gluPerspective DROP
 0x1700 glMatrixMode DROP ;

\ Clear image buffer
: Cls ( -> )
	0x4000 glClear DROP ;

 \ Show image buffer (where we drew)
: View ( -> )
	glhdc SwapBuffers DROP ;

\ The unit matrix
: SingleMatrix ( -> )
	glLoadIdentity DROP ;


\ Shifts the current matrix by a vector (x, y, z).
: ShiftMatrix ( F: f f f -> )
	F>DL F>DL F>DL glTranslated DROP ;

\ Point size
: PointSize ( n -> )
	S>FL glPointSize DROP ;


\  DUP 0 > IF Y F>DL X F>DL glVertex2d DROP THEN

\  Display 2D point on the screen (X, Y)
: Point ( -> )
	0 glBegin DROP 1 LineLoop glEnd DROP ;

\ SET COLOR  (B G R)
: Color ( n n n -> )
	glColor3b DROP ;

\  Rotates the current matrix at a given angle around the specified vector.
\ z y x angle
: RotatedMatrix ( F: f f f f -> )
	F>DL F>DL F>DL F>DL glRotated DROP ;

\ \ Output 2D line (X, Y, X1, Y1)
: Line ( -> )
	1 glBegin DROP
	Y F>DL X F>DL glVertex2d DROP
	Y1 F>DL X1 F>DL glVertex2d DROP
	glEnd DROP ;

\ Draw line width
: LineSize ( n -> )
	S>FL glLineWidth DROP ;

\ Print 2D triangle (X,Y,X1,Y1,X2,Y2)
: Triangle ( -> )
	4 glBegin DROP
	Y F>DL X F>DL glVertex2d DROP
	Y1 F>DL X1 F>DL glVertex2d DROP
	Y2 F>DL X2 F>DL glVertex2d DROP
	glEnd DROP ;

\ Drawing shapes with a wire style
: GlLine ( -> )
	0x1B01 0x408 glPolygonMode DROP ;

\ Drawing shapes painted style
: GlFill ( -> )
	0x1B02 0x408 glPolygonMode DROP ;

\ 2D rectangle (X,Y,X1,Y1)
: Rectangle ( -> )
	7 glBegin DROP
	Y F>DL X F>DL glVertex2d DROP
	Y F>DL X1 F>DL glVertex2d DROP
	Y1 F>DL X1 F>DL glVertex2d DROP
	Y1 F>DL X F>DL glVertex2d DROP
	glEnd DROP ;

\ Smoothing
: Smoothing ( -> )
	0xB10 glEnable DROP ;

\ Remove smoothing
: NoSmoothing ( -> )
	0xB10 glDisable DROP ;

\ 2D quadrilateral (X,Y,X1,Y1,X2,Y2,X3,Y3)
: Tetragon ( -> ) 
	7 glBegin DROP
	Y F>DL X F>DL glVertex2d DROP
	Y1 F>DL X1 F>DL glVertex2d DROP
	Y2 F>DL X2 F>DL glVertex2d DROP
	Y3 F>DL X3 F>DL glVertex2d DROP
	glEnd DROP ;

\ 2D angle (X,Y,X1,Y1,X2,Y2)
: Corner ( -> )
	3 glBegin DROP
	Y F>DL X F>DL glVertex2d DROP
	Y1 F>DL X1 F>DL glVertex2d DROP
	Y2 F>DL X2 F>DL glVertex2d DROP
	glEnd DROP ;

\ STARTLOG

;MODULE  \ >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
 

0 VALUE msec					\ for synchronization
0 VALUE msei
0.0E FVALUE theta				\ matrix rotation angle

\ \ Checks if a key is pressed by a given code
\  : key ( n -- flag )  	GetAsyncKeyState ;


\  xxxxxxxxxxxxxxxxxxxxxxxxxx RANDOM DEFINITION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 
 
MODULE: _RND

WINAPI: GetTickCount KERNEL32.DLL
0 VALUE RndNum  
EXPORT
0 VALUE RndEnd  
: Seed ( u -> )  	TO RndNum ;
     : RndInit ( -> )    4294967295 TO RndEnd GetTickCount Seed ;
         : Random32 ( -> u ) RndNum 0x8088405 * 1+ DUP TO RndNum ;
              : Random ( -> u )   RndEnd Random32 UM* NIP ;
                   : Choose ( u -> u ) Random32 UM* NIP ;
;MODULE
 
 : random  Choose ; 


\  xxxxxxxxxxxxxxxxxxxxxxxxxEND OF RANDOM xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 

variable point_num
fvariable prob0
fvariable prob1
fvariable prob2
fvariable prob3
fvariable r
fvariable xx
fvariable yy
variable case_flag
fvariable p0
fvariable p1
fvariable p2
fvariable xtemp 
fvariable ytemp 
        
: SET-DOT  .S KEY   ;   

\ Here are the probabilities for the affine transformation in floating point
\  double prob[4] = { 0.85, 0.92, 0.99, 1.00 };

85e-2 prob0 f! 92e-2 prob1 f!  99e-2 prob2 f! 1e prob3 f!

\ 10000  point_num !  \ point_num is maximum numbers to plot



: S>F    S>D D>F ;         \ *******  this is very important  !!! 
\ ----------------------------------------------------------------


\ -----------------------------------------------
\ start of FractalFern
\ ------------------------------------------------

: FractalFern   \ start the routine
\  int i;
\  point2 p;
\ int point_num = 500000;
\ --------------------------------------: main ( -- ) 
       glOpen						 
				 
             0.0E 0.0E -5.0E ShiftMatrix			 
             theta 0.0E 0.0E 1.0E RotatedMatrix  
                 TIMER@ DROP TO msei  msei msec <> IF   msei TO msec
		Cls		
            0 100 0 Color                
            1  PointSize	        \ *****   size of each pixel ! 
            VIEW
\ -----------------------ATTENTION HERE  -------------------------

100000  point_num !  \ point_num is maximum numbers to plot
\ calculate_points
\ Compute and plot the points.
\ get random numbers and convert them to floating

 100 random s>d d>f 100e f/  p0 f!           \  p0 = drand48 ( );
 100 random s>d d>f 100e f/  p1 f!           \ p1 = drand48 ( );


point_num @ 0
   do    \   for ( i = 0; i < point_num; i++ )
    100 random s>d d>f 100e f/   r   f!         \ r = random number float variable
     r f@ prob0 f@ f<    \ if ( r < prob[0] )
     if
       p0 f@ 85e-2 f* p1 f@ 4e-2 f*  f+ 0e1   f+   xx f! \   x =   0.85 * p[0] + 0.04 * p[1] + 0.0;
       p0 f@ -4e-2 f* p1 f@ 85e-2 f* f+ 1.6e f+    yy f! \   y = - 0.04 * p[0] + 0.85 * p[1] + 1.6;
     else
        r f@  prob1 f@ f<  \  if ( r < prob[1] )
        if
            p0 f@ 20e-2 f* p1 f@ -26e-2 f* f+ ( 0e f+ )    xx f! \   x =   0.20 * p[0] - 0.26 * p[1] + 0.0;
            p0 f@ 23e-2 f* p1 f@ 22e-2 f*  f+ 1.6e f+     yy f! \   y =   0.23 * p[0] + 0.22 * p[1] + 1.6;
        else
               r f@ prob2 f@ f<                                \  if ( r < prob[2] )
               if
                  p0 f@ -15e-2 f* p1 f@ 28e-2 f* f+             xx f! \    x = - 0.15 * p[0] + 0.28 * p[1] + 0.0;
                  p0 f@ 26e-2 f* p1 f@ 24e-2 f* f+  44e-2 f+    yy f! \    y =   0.26 * p[0] + 0.24 * p[1] + 0.44;
               else
                 0e  xx f! \    x =   0.00 * p[0] + 0.00 * p[1] + 0.0;
                 p1 f@ 16e-2 f* yy f! \    y =   0.00 * p[0] + 0.16 * p[1] + 0.0;
               then
       then
     then
                Xx f@ p0 f!     \   p0 = x;
                Yy f@ p1 f!    \    p1= y;

     p0 f@ 100e   f* f>d d>s    ytemp !    \ multiply y times 100 to scale it upand shift it down and store it in ytemp
     p1 f@ 100e   f* f>d d>s    xtemp !    \ multiply x times 100 to scale it up and store it in xtemp


\  Plot the new point.
            xtemp @ s>f  80e0  F/ 5e f- ( FDUP F. )   fto  X  
            ytemp @ s>f  80e0  F/  ( FDUP F. )   fto  Y  
    Point	
            VIEW 
			
   
 loop 
 
; 
: run
FractalFern
." End of the drawing"
\ 10000 pause          \ 10 seconds before closing OPENgl
\ glclose
;
run








