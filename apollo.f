\ CLASSIC LUNAR LANDER
\ MICHEL JEAN, MAY 2020
\ INSPIRED BY : RAFAEL DELIANO 2017, AHL DAVID 1978, BILL COTTER 1977

: introduction

cr ." THIS IS A COMPUTER SIMULATION OF AN APOLLO LUNAR" cr
." LANDING CAPSULE" cr
." THE ON-BOARD COMPUTER HAS FAILED (IT WAS MADE BY" cr
." XEROX) SO YOU HAVE TO LAND THE CAPSULE MANUALLY." cr
." SET BURNS RATE OF RETRO ROCKETS TO ANY VALUE BETWEEN" cr
." 0 (FREE FALL) AND 200 (MAXIMUM BURN) POUNDS PER SECOND." cr
." SET NEW BURN RATE EVERY 10 SECONDES" cr
." CAPSULE WEIGHT 32500 LBS; FUEL WEIGHT 16500 LBS." cr
." GOOD LUCK" cr
;

fvariable mt    \ masse of carburant
fvariable x     \ distance of the surface of the moon
fvariable v     \ velocity m/s
fvariable t     \ time 

fvariable s     \ burn rate kg/s
variable allu   \ burn rate lbs/s

fvariable mtn   \ new carburant mass
fvariable mtavr \ average carburant mass
fvariable mavr  \ average mass
fvariable vavr  \ average velocity
fvariable gxs   \ compensation of the gravity
fvariable gx    \ gravity at x
fvariable vn    \ new velocity


7257.6e fconstant mc \ mass of the LEM
10.0e fconstant dt \ burn time in sec
3050.0e fconstant lsp \ impulsion of the carburant Newton*sec/kg
  
: initialisation
        7484.4e mt f! \ masse carburant
        193121.3e x f! \ distance en m
        1609.34e v f! \ vitesse m/s
        0.0e allu f!
        0.0e t f!
;

: gravity       \ gravity force in function distance
        7.349e22 x f@ 1.7349e6 f+ 
        fdup f* f/ 6.674e-11 f* gx f! 
;

: mass          \ mass of the LEM
        t f@ dt f+ t f! 
        mt f@ s f@ dt f* f- mtn f! 
        mt f@ mtn f@ f+ 2e f/ mtavr f!
        mtavr f@ mc f+ mavr f!
;

: allumage      \ verify and transform burn lbs/sec to kg/sec
        allu @ 200 > if cr ." MAXIMUM BURN IS 200 " 200 allu ! then
        allu @ 0 d>f 0.4536e f* s f!
;

: speed         \ speed of descent
        gx f@ mavr f@  f* lsp s f@ f* f- mavr f@ f/ gxs f!
        v f@ gxs f@ dt f* f+ vn f!
        v f@ vn f@ f+ 2e f/ vavr f! 
;

: position      \ new position
         x f@ vavr f@ dt f* f- 0.5e gxs f@ f* dt fdup f* f* f- x f!  
;

: calcul        \ main calcul routine
        allumage 
        mass
        gravity
        speed
        position      
        mtn f@ 0e f< if 0e mtn f! then \ mass carburant can't be negative
        mtn f@ mt f!
        vn f@ v f!
        0 allu ! \ cut gas!
;

: affichage
        cr
        t f@ f>d drop . ." SEC  |  "
        x f@ 3.28084e f* f>d drop dup 5280 / .  ." MI "
        5280 mod . ." FT  |  "
        v f@ 2.237e f* f>d drop . ." MPH  | " 
        mt f@ 2.20462e f* f>d drop . ." LB_FUEL  " 
;

: input-gas
        cr ." BURN RATE (0 to 200) : "
	PAD DUP 3 ACCEPT EVALUATE allu !
;

: landing
        cr ." ON THE MOON AT "  t f@ f>d drop . ." SECONDES "
        cr ." IMPACT VELOCITY "  v f@ 2.237e f* f>d drop . ." MPH " 
        cr ." FULL LEFT "  mt f@ 2.20462e f* f>d drop . ." LBS  " cr 
        v f@ 0.54e f< if ." PERFECT LANDING NEIL" cr else
        v f@ 4.5e f< if ." ROUGH LANDING" cr else
        v f@ 25e f< if ." THE LEM IS BROKEN. A RESCUE MISSION" cr
        ." HAVE TO RECOVER YOU" cr else
        ." YOU HAVE CREATED A NEW CRATER ON THE MOON" cr
        then then then
        ." FOR RETRY, TYPE 'GO' " 

;

: go    
        initialisation
        BEGIN
       affichage
        mt f@ 1e f< not if 
        input-gas
        then
        calcul
        x f@ 0.5e f< UNTIL
        landing
;

introduction
go

