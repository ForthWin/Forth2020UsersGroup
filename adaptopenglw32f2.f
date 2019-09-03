\ -------------------------------------------------------------------------------
\ OpenGL functions.
\ -------------------------------------------------------------------------------
\ S" lib\include\float2.f" INCLUDED

S" C:\ForthWin2\demos\adaptopenglw32f/Forthwin_Gldefs.f" INCLUDED

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
WINAPI: glDeleteTextures                OPENGL32.DLL
WINAPI: glTexParameteri                 OPENGL32.DLL
WINAPI: glTexImage2D                    OPENGL32.DLL
WINAPI: glTexCoord2f                    OPENGL32.DLL
WINAPI: glTexEnvi                       OPENGL32.DLL
WINAPI: glTexEnvf                       OPENGL32.DLL
WINAPI: glPixelTransferf                OPENGL32.DLL
\ WINAPI: clear-buffer                    OPENGL32.DLL
WINAPI: wglCreateContext                OPENGL32.DLL
WINAPI: wglCreateContext                OPENGL32.DLL
WINAPI: wglCreateContext                OPENGL32.DLL


