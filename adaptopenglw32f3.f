\ -------------------------------------------------------------------------------
\ OpenGL functions.
\ -------------------------------------------------------------------------------
\ S" lib\include\float2.f" INCLUDED

S" C:\ForthWin2\demos\adaptopenglw32f/Forthwin_Gldefs.f" INCLUDED

\ ' FS>DS alias DF>STACK   ( -- double )  ( fs: r -- )
\ ' SFS>DS alias  SF>STACK  ( -- float )  ( fs: r -- )

\  from win32forth's fkernel.f

VARIABLE NEXT-USER        \ offset of next defineable user variable


: NEWUSER       ( size "name" -- )      \ Creates a user. A user can be
                                \ a byte, cell, float, string or stack
                NEXT-USER @ SWAP OVER + NEXT-USER !
                USER ;




\ From win32forth's float.f

cell NEWUSER FLOATSP ( -- addr )                    \ W32F             Floating extra



macro: FSP_MEMORY    ( -- )
                FLOATSP [up] endm


\ Subroutine to check the depth of the float stack for underflow errors.
\ Input: eax = number of floats we need times b/float.
subr:   fstack-check
                mov     ecx, FSP_MEMORY
                cmp     ecx, eax
                js      short L$1
                ret     \ stack is fine, return to caller
L$1:            mov     eax, # ' FSTKUFLO       \ throw underflow error
                exec                            \ doesn't return to caller !!!
                end-code




code FS>DS      ( -- dfloat fs: r -- )    \ W32F           Floating extra
\ *G Move floating point number bits to the data stack as a 64-bit float.
\ ** This function is for passing floats to DLLs.
                fstack-check_1
                >fpu
                push    ebx
                push    ebx
                push    ebx
                fstp    double 0 [esp]
                pop     ebx
                float;



alias SFS>DS SF>STACK 

\ copy result of c function from the hw float stack
\ to the Win32Forth float stack

\ code FRESULT    ( x -- )  ( FS: -- r )
\                 mov     ecx, FLOATSP [up]
\                 fstp    FSIZE FLOATSTACK [ecx] [up]
\                 add     ecx, # B/FLOAT
\                 mov     FLOATSP [up], ecx
\                 pop     ebx
\                 next,
\                 end-code

8 value B/FLOAT

B/FLOAT 8 <> [if] cr .( B/FLOAT needs to be 8.) abort  [then]
 alias    fsqrt fsqr


: 4f' ( f: f3 f2 f1 f0 - ) ( - 32bfloat0 32bfloat1 32bfloat2 32bfloat3 )
        s" 2f' 2f' " evaluate ; immediate

: nf' ( f: fx..f0 - )  ( k - 32bfloat0..32bfloatx  )
        0 do sf>stack loop ;

' FS>DS alias d'

: 2d' ( f: f1 f0 - ) ( - d0 d1 )
         s" df>stack df>stack                   " evaluate ; immediate

: 3d' ( f: f2 f1 f0 - ) ( - d0 d1 d2 )
         s" df>stack df>stack df>stack          " evaluate ; immediate

: 4d' ( f: f3 f2 f1 f0 - ) ( - d0 d1 d2 d3 )
         s" df>stack df>stack df>stack df>stack " evaluate ; immediate

: nd' ( f: fx..f0 - )  ( k - dt0..dx  )
        0 do df>stack loop ;

0 value hbitmap
0 value qobj
0 value oglwin-base

include pixelfrm.f  \ PIXELFORMATDESCRIPTOR

\ : swap_rot ( n1 n2 n3 - n3 n2 n1 )   swap rot  ;

' 3reverse alias swap_rot




MODULE: HIDDEN
	

WINAPI: wglCreateContext                OPENGL32.DLL
WINAPI: wglMakeCurrent                  OPENGL32.DLL
WINAPI: wglDeleteContext                OPENGL32.DLL
WINAPI: glLineWidth                     OPENGL32.DLL
WINAPI: glFinish                        OPENGL32.DLL
WINAPI: SwapBuffers                     GDI32.DLL
WINAPI: glRotatef                       OPENGL32.DLL
WINAPI: glTranslatef                    OPENGL32.DLL
WINAPI: glTranslated                    OPENGL32.DLL
WINAPI: glScalef                        OPENGL32.DLL
WINAPI: glPushMatrix                    OPENGL32.DLL
WINAPI: glPopMatrix                     OPENGL32.DLL
WINAPI: glClear                         OPENGL32.DLL
WINAPI: glClearDepth                    OPENGL32.DLL
WINAPI: glDepthFunc                     OPENGL32.DLL
WINAPI: glDepthFunc                     OPENGL32.DLL
WINAPI: glDepthMask                     OPENGL32.DLL
WINAPI: glColorMask                     OPENGL32.DLL
WINAPI: glStencilFunc                   OPENGL32.DLL
WINAPI: glStencilMask                   OPENGL32.DLL
WINAPI: glFrontFace                     OPENGL32.DLL
WINAPI: glStencilOp                     OPENGL32.DLL
WINAPI: glClearStencil                  OPENGL32.DLL
WINAPI: glCullFace                      OPENGL32.DLL
WINAPI: glColor3f                       OPENGL32.DLL
WINAPI: glColor3fv                      OPENGL32.DLL
WINAPI: glColor3ub                      OPENGL32.DLL
WINAPI: glColor4f                       OPENGL32.DLL
WINAPI: glColor4ub                      OPENGL32.DLL
WINAPI: glMatrixMode                    OPENGL32.DLL
WINAPI: glLoadIdentity                  OPENGL32.DLL
WINAPI: glBegin                         OPENGL32.DLL
WINAPI: glVertex2f                      OPENGL32.DLL
WINAPI: glVertex2d                      OPENGL32.DLL
WINAPI: glVertex2i                      OPENGL32.DLL
WINAPI: glVertex3f                      OPENGL32.DLL
\ WINAPI: glrectf                         GDI32.DLL
WINAPI: glTexGeni                       OPENGL32.DLL
WINAPI: glEnd                           OPENGL32.DLL
WINAPI: glEndList                       OPENGL32.DLL
WINAPI: glNewList                       OPENGL32.DLL
WINAPI: glListBase                      OPENGL32.DLL
WINAPI: glGenLists                      OPENGL32.DLL
WINAPI: glCallList                      OPENGL32.DLL
WINAPI: glCallLists                     OPENGL32.DLL
WINAPI: glDeleteLists                   OPENGL32.DLL
WINAPI: glClipPlane                     OPENGL32.DLL
WINAPI: glGetString                     OPENGL32.DLL
WINAPI: glPushAttrib                    OPENGL32.DLL
WINAPI: glPopAttrib                     OPENGL32.DLL
WINAPI: glRasterPos2f                   OPENGL32.DLL
WINAPI: glScissor                       OPENGL32.DLL
WINAPI: glFlush                         OPENGL32.DLL
WINAPI: glNormal3f                      OPENGL32.DLL
WINAPI: glEnable                        OPENGL32.DLL
WINAPI: glViewport                      OPENGL32.DLL
WINAPI: glGetFloatv                     OPENGL32.DLL
WINAPI: glShadeModel                    OPENGL32.DLL
WINAPI: glLightModelfv                  OPENGL32.DLL
WINAPI: glLightfv                       OPENGL32.DLL
WINAPI: glPolygonMode                   OPENGL32.DLL
WINAPI: glColorMaterial                 OPENGL32.DLL
WINAPI: glFogi                          OPENGL32.DLL
WINAPI: glFogf                          OPENGL32.DLL
WINAPI: glFogfv                         OPENGL32.DLL
WINAPI: glHint                          OPENGL32.DLL
WINAPI: glBlendFunc                     OPENGL32.DLL
WINAPI: glMaterialfv                    OPENGL32.DLL
WINAPI: gluNewQuadric                   Glu32.dll
WINAPI: gluQuadricDrawStyle             Glu32.dll
WINAPI: gluQuadricTexture               Glu32.dll
WINAPI: gluQuadricNormals               Glu32.dll
WINAPI: gluBeginCurve                   Glu32.dll
WINAPI: gluEndCurve                     Glu32.dll
WINAPI: gluNewNurbsRenderer             Glu32.dll
WINAPI: glSelectBuffer                  Opengl32.dll
WINAPI: glRenderMode                    OPENGL32.DLL
WINAPI: glInitNames                     OPENGL32.DLL
WINAPI: glLoadName                      OPENGL32.DLL
WINAPI: glPushName                      OPENGL32.DLL
WINAPI: glPopName                       OPENGL32.DLL
WINAPI: glGetIntegerv                   OPENGL32.DLL
WINAPI: gluBuild2DMipmaps               Glu32.dll
WINAPI: gluPickMatrix                   Glu32.dll
WINAPI: glReadPixels                    OPENGL32.DLL
WINAPI: glPixelStorei                   OPENGL32.DLL
WINAPI: glDepthRange                    OPENGL32.DLL
WINAPI: gluDeleteQuadric                Glu32.dll
\ WINAPI: wglUseFontBitmaps               Opengl32.dll
WINAPI: glBindTexture                   OPENGL32.DLL
WINAPI: glGenTextures                   OPENGL32.DLL
WINAPI: glDel