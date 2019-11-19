\ -------------------------------------------------------------------------------
\ OpenGL functions.
\ -------------------------------------------------------------------------------
S" lib\include\float2.f" INCLUDED



WINAPI: wglCreateContext                USER32.DLL
WINAPI: wglMakeCurrent                  USER32.DLL
WINAPI: wglDeleteContext                USER32.DLL
WINAPI: glLineWidth                     USER32.DLL
WINAPI: glFinish                        USER32.DLL
WINAPI: SwapBuffers                     USER32.DLL               
WINAPI: glRotatef                       USER32.DLL
WINAPI: glTranslatef                    USER32.DLL
WINAPI: glTranslated                    USER32.DLL
WINAPI: glScalef                        USER32.DLL
WINAPI: glPushMatrix                    USER32.DLL
WINAPI: glPopMatrix                     USER32.DLL
WINAPI: glClear                         USER32.DLL
WINAPI: glClearDepth                    USER32.DLL
WINAPI: glDepthFunc                     USER32.DLL
WINAPI: glDepthFunc                     USER32.DLL
WINAPI: glDepthMask                     USER32.DLL
WINAPI: glColorMask                     USER32.DLL
WINAPI: glStencilFunc                   USER32.DLL
WINAPI: glStencilMask                   USER32.DLL
WINAPI: glFrontFace                     USER32.DLL
WINAPI: glStencilOp                     USER32.DLL
WINAPI: glClearStencil                  USER32.DLL
WINAPI: glCullFace                      USER32.DLL
WINAPI: glColor3f                       USER32.DLL
WINAPI: glColor3fv                      USER32.DLL
WINAPI: glColor3ub                      USER32.DLL
WINAPI: glColor4f                       USER32.DLL
WINAPI: glColor4ub                      USER32.DLL
WINAPI: glMatrixMode                    USER32.DLL
WINAPI: glLoadIdentity                  USER32.DLL
WINAPI: glBegin                         USER32.DLL
WINAPI: glVertex2f                      USER32.DLL
WINAPI: glVertex2d                      USER32.DLL
WINAPI: glVertex2i                      USER32.DLL
WINAPI: glVertex3f                      USER32.DLL
WINAPI: glrectf                         USER32.DLL
WINAPI: glTexGeni                       USER32.DLL
WINAPI: glEnd                           USER32.DLL
WINAPI: glEndList                       USER32.DLL
WINAPI: glNewList                       USER32.DLL
WINAPI: glListBase                      USER32.DLL
WINAPI: glGenLists                      USER32.DLL
WINAPI: glCallList                      USER32.DLL
WINAPI: glCallLists                     USER32.DLL
WINAPI: glDeleteLists                   USER32.DLL
WINAPI: glClipPlane                     USER32.DLL
WINAPI: glGetString                     USER32.DLL
WINAPI: glPushAttrib                    USER32.DLL
WINAPI: glPopAttrib                     USER32.DLL
WINAPI: glRasterPos2f                   USER32.DLL
WINAPI: glScissor                       USER32.DLL
WINAPI: glFlush                         USER32.DLL
WINAPI: glNormal3f                      USER32.DLL
WINAPI: glEnable                        USER32.DLL
WINAPI: glViewport                      USER32.DLL
WINAPI: glGetFloatv                     USER32.DLL
WINAPI: glShadeModel                    USER32.DLL
WINAPI: glLightModelfv                  USER32.DLL
WINAPI: glLightfv                       USER32.DLL
WINAPI: glPolygonMode                   USER32.DLL
WINAPI: glColorMaterial                 USER32.DLL
WINAPI: glFogi                          USER32.DLL
WINAPI: glFogf                          USER32.DLL
WINAPI: glFogfv                         USER32.DLL
WINAPI: glHint                          USER32.DLL
WINAPI: glBlendFunc                     USER32.DLL
WINAPI: glMaterialfv                    USER32.DLL
WINAPI: gluNewQuadric                   USER32.DLL
WINAPI: gluQuadricDrawStyle             USER32.DLL
WINAPI: gluQuadricTexture               USER32.DLL
WINAPI: gluQuadricNormals               USER32.DLL
WINAPI: gluBeginCurve                   USER32.DLL
WINAPI: gluEndCurve                     USER32.DLL
WINAPI: gluNewNurbsRenderer             USER32.DLL
WINAPI: glSelectBuffer                  USER32.DLL
WINAPI: glRenderMode                    USER32.DLL
WINAPI: glInitNames                     USER32.DLL
WINAPI: glLoadName                      USER32.DLL
WINAPI: glPushName                      USER32.DLL
WINAPI: glPopName                       USER32.DLL
WINAPI: glGetIntegerv                   USER32.DLL
WINAPI: gluBuild2DMipmaps               USER32.DLL
WINAPI: gluPickMatrix                   USER32.DLL
WINAPI: glReadPixels                    USER32.DLL
WINAPI: glPixelStorei                   USER32.DLL
WINAPI: glDepthRange                    USER32.DLL
WINAPI: gluDeleteQuadric                USER32.DLL
WINAPI: wglUseFontBitmaps               USER32.DLL
WINAPI: glBindTexture                   USER32.DLL
WINAPI: glGenTextures                   USER32.DLL
WINAPI: glDeleteTextures                USER32.DLL
WINAPI: glTexParameteri                 USER32.DLL
WINAPI: glTexImage2D                    USER32.DLL
WINAPI: glTexCoord2f                    USER32.DLL
WINAPI: glTexEnvi                       USER32.DLL
WINAPI: glTexEnvf                       USER32.DLL
WINAPI: glPixelTransferf                USER32.DLL
WINAPI: clear-buffer                    USER32.DLL
WINAPI: wglCreateContext                USER32.DLL
WINAPI: wglCreateContext                USER32.DLL
WINAPI: wglCreateContext                USER32.DLL



: wglCreateContext ( hdc - hdrc )                   call wglCreateContext       ;
: wglMakeCurrent   ( hdc hrc - flag )          swap call wglMakeCurrent         ;
: wglDeleteContext ( hrc - flag )                   call wglDeleteContext       ;
: glLineWidth      ( f: width - )                f' call glLineWidth       drop ;
: glFinish         ( - )                            call glFinish          drop ;
: SwapBuffers      ( hdc - )                        call SwapBuffers       drop ;
: glRotatef        ( f: deg x y z - )           4f' call glRotatef         drop ;
: glTranslatef     ( f: x y z  - )              3f' call glTranslatef      drop ;
: glTranslated     ( f: x y z - )               3d' call glTranslated      drop ;
: glScalef         ( f: x y z  - )              3f' call glScalef          drop ;
: glPushMatrix     ( - )                            call glPushMatrix      drop ;
: glPopMatrix      ( - )                            call glPopMatrix       drop ;
: glClear          ( mask - )                       call glClear           drop ;
: glClearDepth     ( F: depth - )                d' call glClearDepth      drop ;
: glDepthFunc      ( dunc - )                       call glDepthFunc       drop ;
: glDepthMask      ( flag - )                       call glDepthMask       drop ;
: glColorMask      ( red green blue alpha - ) 4reverse call glColorMask    drop ;
: glStencilFunc    ( func ref mask - )     3reverse call glStencilFunc     drop ;
: glStencilMask    ( mask - ) 			    call glStencilMask 	   drop ;
: glFrontFace      ( mode - )                       call glFrontFace       drop ;
: glStencilOp      ( fail zfail zpass - )  3reverse call glStencilOp       drop ;
: glClearStencil   ( s - )                          call glClearStencil    drop ;
: glCullFace       ( mode - )                       call glCullFace        drop ;
: glColor3f        ( f: red green blue - )      3f' call glColor3f         drop ;
: glColor3fv       ( AdrRGB - )                     call glColor3fv        drop ;
: glColor3ub       ( red green blue - )    3reverse call glColor3ub        drop ;
: glColor4f        ( f: red green blue alpha - ) 4f' call glColor4f        drop ;
: glColor4ub       ( f: red green blue alpha - ) 4reverse call glColor4ub  drop ;
: glMatrixMode     ( mode - )                       call glMatrixMode      drop ;
: glLoadIdentity   ( - )                            call glLoadIdentity    drop ;
: glBegin          ( mode - )                       call glBegin           drop ;
: glVertex2f       ( f: x y - )                 2f' call glVertex2f        drop ;
: glVertex2d       ( f: x y - )                 2d' call glVertex2d        drop ;
: glVertex2i       ( x y - )                   swap call glVertex2i        drop ;
: glVertex3f       ( f: x y z - )               3f' call glVertex3f        drop ;
: glrectf          ( f: x1 y1 x2 y2 - )         4f' call glRectf           drop ;
: glTexGeni        ( coord pname param - ) 3reverse call glTexGeni         drop ;
: glEnd            ( - )                            call glEnd             drop ;
: glEndList        ( - )                            call glEndList         drop ;
: glNewList        ( list mode - )             swap call glNewList         drop ;
: glListBase       ( base - )                       call glListBase        drop ;
: glGenLists       ( range - lists )                call glGenLists             ;
: glCallList       ( list - )                       call glCallList        drop ;
: glCallLists      ( n type lists - )      swap_rot call glCallLists       drop ;
: glDeleteLists    ( list range )              swap call glDeleteLists     drop ;
: glClipPlane      ( plane *equation - )       swap call glClipPlane       drop ;
: glGetString      ( name - string$ )               call glGetString            ;
: glPushAttrib     ( mask - )                       call glPushAttrib      drop ;
: glPopAttrib      ( - )                            call glPopAttrib       drop ;
: glRasterPos2f    ( f: x y - )                 2f' call glRasterPos2f     drop ;
: glScissor        ( x y width height - )  4reverse call glScissor         drop ;
: glFlush          ( - )                            call glFlush           drop ;
: glNormal3f       ( nx ny nz - )               3f' call glNormal3f        drop ;
: glEnable         ( cap - )                        call glEnable          drop ;
: glDisable        ( cap - )                        call glDisable         drop ;
: glViewport       ( x y width height - )  4reverse call glViewport        drop ;
: glGetFloatv      ( pname *params - )         swap call glGetFloatv       drop ;
: glShadeModel     ( mode - )                       call glShadeModel      drop ;
: glLightModelfv   ( pname param - )           swap call glLightModelfv    drop ;
: glLightfv        ( light pname param - ) swap_rot call glLightfv         drop ;
: glPolygonMode    ( face mode - )             swap call glPolygonMode     drop ;
: glColorMaterial  ( face mode - )             swap call glColorMaterial   drop ;
: glFogi           ( pname  parm - )           swap call glFogi            drop ;
: glFogf           ( f: parm )  ( pname - ) f' swap call glFogf            drop ;
: glFogfv          ( pname parm - )            swap call glFogfv           drop ;
: glHint           ( target mode - )           swap call glHint            drop ;
: glBlendFunc      ( sfactor dfactor - )       swap call glBlendFunc       drop ;
: glMaterialfv     ( face pname param - ) swap_rot  call glMaterialfv      drop ;
: gluNewQuadric    ( - qobj )                       call gluNewQuadric          ;
: gluQuadricDrawStyle ( qobj style - )       swap call gluQuadricDrawStyle drop ;
: gluQuadricTexture ( *quadObject textureCoords - ) swap call gluQuadricTexture drop ;
: gluQuadricNormals   ( qobj normals - )       swap call gluQuadricNormals drop ;
: gluBeginCurve       ( *nobj - )                   call gluBeginCurve     drop ;
: gluEndCurve         ( *nobj - )                   call gluEndCurve       drop ;
: gluNewNurbsRenderer ( - *nobj )                   call gluNewNurbsRenderer    ;
: glSelectBuffer      ( size buffer -- )       swap call glSelectBuffer    drop ;
: glRenderMode        ( mode -- 0|#sel|val )        call glRenderMode           ;
: glInitNames         ( -- )                        call glInitNames       drop ;
: glLoadName          ( name -- )                   call glLoadName        drop ;
: glPushName          ( name -- )                   call glPushName        drop ;
: glPopName           ( -- )                        call glPopName         drop ;
: glGetIntegerv       ( pname *params -- )     swap call glGetIntegerv     drop ;
: gluBuild2DMipmaps ( target components width height format type *data -- )
                                        7 s-reverse call gluBuild2DMipmaps drop ;
: gluPickMatrix  ( f: x y width height -- ) ( viewport -- )
                                                4d' call gluPickMatrix     drop ;
: glReadPixels   ( f: x y width height -- ) ( format type  *pixels -- )
                             3reverse 2>r >r 4f' r> 2r> call glReadPixels  drop ;
: glPixelStorei  ( pname param -- )                swap call glPixelStorei drop ;
: glDepthRange   ( f: near far -- )                 2d' call glDepthRange  drop ;
: gluDeleteQuadric ( qobj -- )                       call gluDeleteQuadric drop ;
: wglUseFontBitmaps   ( ghdc 1st_char #chars baselist -- )
                                           4reverse call wglUseFontBitmaps drop ;
: glBindTexture    ( target name -- )           swap call glBindTexture    drop ;
: glGenTextures    ( n *textures -- )           swap call glGenTextures    drop ;
: glDeleteTextures ( n *textures -- )           swap call glDeleteTextures drop ;
: glTexParameteri ( target pname param -- ) 3reverse call glTexParameteri  drop ;
: glTexImage2D ( target level components width height border format type *pixels -- )
                                            9 s-reverse call glTexImage2D  drop ;
: glTexCoord2f    ( f: x y - )                      2f' call glTexCoord2f  drop ;
: glTexEnvi       ( target pname param -- )        3reverse call glTexEnvi drop ;
: glTexEnvf ( target pname - ) ( f: param -- ) swap f' -rot call glTexEnvf drop ;

: glPixelTransferf ( pname - ) ( f: param - )
                                             f' swap call glPixelTransferf drop ;

: clear-buffer ( - )         GL_COLOR_BUFFER_BIT GL_DEPTH_BUFFER_BIT OR glClear ;
