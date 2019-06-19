\ http://sametwice.com/8_line_mandelbrot
\ 8 line mandelbrot
fvariable ci fvariable c fvariable zi fvariable z
: f> f< not ;
: >2? z f@ fdup f* zi f@ fdup f* f+ 4.0e f> ;
: nextr z f@ fdup f* zi f@ fdup f* f- c f@ f+ ;
: nexti z f@ zi f@ f* 2.0e f* ci f@ f+ ;
: pixel c f! ci f! 0e z f! 0e zi f! 150 50 do nextr nexti zi f! z f! >2? if i unloop exit then loop bl ;
: left->right -1.5e 80 0 do fover fover pixel emit 0.026e f+ loop fdrop ;
: top->bottom -1e 40 0 do left->right cr 0.05e f+ loop fdrop ;
top->bottom \  bye
