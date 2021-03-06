\ ASTROLAB
\ Michel Jean 2019-2020 

\ ----------------------- LIST OF FUNCTIONS ---------------------
\ SECONDES IN FLOAT FOR MILLISECONDES
\ DAYS IN FLOAT
\ TOUTES LES MESURES SONT EN DEGREES DECIMAUX
\ SAUF POUR LES COORDONNES DES OBJETS CELESTES (AD ET DEC) EN RADIAN
\ TOUTES LES MESURES SONT EN DEGR�ES DECIMAUX
\ SAUF POUR LES COORDONN�S DES OBJETS CELESTES (AD ET DEC) EN RADIAN

\ H>TD ( N N F -- F) H M S -> H DECIMALE
\ H>DD ( N N F -- F ) RIGHT ASCENSION --- H M S -> DEGRE DECIMAL
\ A>DD ( N N F -- F ) ANGLE D M S -> DEGRE DECIMAL
\ D>R ( F -- F ) CONVERSION DEGRES EN RADIAN
\ R>D ( F -- F ) CONVERSION RADIAN EN DEGRES
\ DD>A ( F -- ) AFFICHAGE DD EN D M S
\ DD>H ( F -- ) AFFICHAGE DD EN H M S
\ JH>J ( N N N F -- F ) \ J H M S -> JOUR DECIMAUX
\ DATE>JD ( N N F -- F ) \ A M J -> JULIAN DAY
\ DATEJ>JD ( N N F -- F ) CALENDRIER JULIEN ( AVANT 1582 BC)
\ JOURD>HMS ( F -- ) JOURS EN DECIMAL ET AFFICHE J H M S
\ JD>DATE ( F -- ) \ DE JULIAN DAY AFFICHE : A M J H M S
\ JOUR-SEMAINE ( N N F -- ) DE A M J AFFICHE LE JOUR DE LA SEMAINE
\ DATE>ST ( N N F -- F )  A M J -> TEMPS SIDERAL A GREENWICH -- DEGRE DECIMALS
\ JD>ST ( F -- F ) JULIAN DAY-> TEMPS SIDERAL DEGRE DECIMALS
\ HORLOGE-LOCALE ( -- ) AFFICHE L'HEURE LOCAL, UNVERSEL, SIDERAL, LE JOUR JULIEN
\ HORLOGE ( N N N N N N -- ) \ ANNE MOIS JOUR HEURES MIN SEC, HORLOGE A GREENWICH
\ -------------------------------------------------------------------

REQUIRE TIME&DATE LIB/INCLUDE/FACIL.F 


20 SET-PRECISION

4E FVALUE TIMEZONE
69.71E FVALUE DELTATD \ DIFFERENCE ENTRE TD ET TU
23.43929111111111E FVALUE OBLIQUITE
0.42649840077232E FVALUE OBLR \ OBLIQUITE EN RADIAN

FVARIABLE LONGITUDE
FVARIABLE LATITUDE
FVARIABLE AD \ ASCENSION DROITE
FVARIABLE DEC \ DECLINAISON
FVARIABLE AZIMUTH
FVARIABLE ALTITUDE

VARIABLE DEGRES
VARIABLE HEURES
VARIABLE MINUTES

VARIABLE ANNEE
VARIABLE MOIS
FVARIABLE SECONDES
FVARIABLE JOUR

FVARIABLE STG \ TEMPS SIDERAL GREENWICH
FVARIABLE JD
FVARIABLE T
FVARIABLE B
FVARIABLE C
FVARIABLE D
FVARIABLE E
FVARIABLE F
FVARIABLE H
FVARIABLE X
FVARIABLE Y
FVARIABLE Z

\ LES SECONDES SONT TOUJOURS ENTR�ES EN FLOAT POUR LES MILLISECONDES
\ LES JOURS EN FLOAT POUR INT�GRER LE MOMENT DE LA JOURNEE
\ CONVERSION DE L'HEURE MINUTES SECONDES EN HEURE DECIMAL

: H>TD ( N N F -- F)
	24E 36E2 F* F/
	DS>F 24E 60E F* F/
	DS>F 24E F/ F+ F+ ;

\ CONVERSION DE L'ANGLE, DEGRES MINUTES SECONDES, EN DEGRES DECIMAL --- D M S -> DD
: A>DD ( N N F -- F )
	SECONDES F! MINUTES ! DEGRES !
	DEGRES @ 0 < IF MINUTES @ NEGATE MINUTES ! SECONDES F@ FNEGATE SECONDES F! \ POUR LES DEGRÉS NÉGATIFS
	THEN
	DEGRES @ DS>F MINUTES @ DS>F 60E F/ SECONDES F@ 36E2 F/ F+ F+ ;

\ CONVERSION DE L'ASCENTION DROITE EN DEGRES DECIMAL --- H M S -> DD
: H>DD ( N N F -- F )
	A>DD 15E F* ;


\ CONVERSION DEGRES EN RADIAN
: D>R ( F -- F )
	180E FPI F/ F/ ;

\ CONVERSION RADIAN EN DEGRES
: R>D ( F -- F )
	180E FPI F/ F* ;

\ NE FONCTIONNE PAS EN N�GATIF !!!!!!!!!!!!!!!!!!
\ CONVERSION DEGRE DECIMAL EN D M S
: DD>A ( F -- )
	FDUP 0E F< IF -1E F* -1 >R ELSE 1 >R  THEN
	FDUP FLOOR F>DS R> * . 167 EMIT ."  "
	FDUP FDUP FLOOR F- 60E F* FLOOR F>DS DUP . 39 EMIT ."  "
	>R FDUP FLOOR F- R> DS>F 60E F/ F- 36E2 F* 
	4 SET-PRECISION F. 34 EMIT CR 20 SET-PRECISION ;

\ CONVERSION DEGRE DECIMAL EN H M S
: DD>H ( F -- )
	15E F/ 
	FDUP FLOOR F>DS . ." HRS "
	FDUP FDUP FLOOR F- 60E F* FLOOR F>DS DUP . ." MIN "
	>R FDUP FLOOR F- R> DS>F 60E F/ F- 36E2 F* 
	4 SET-PRECISION F. ." SEC " CR 20 SET-PRECISION ;

\ JULIAN DAY CONVERSIONS

: JH>J ( N N N F -- F ) \ CONVERSION JOUR HEURE MINUTES SECONDES EN JOUR DECIMAUX
	H>TD DS>F F+ ;

\ POUR LE CALENDRIER GREGORIEN
: DATE>JD ( N N F -- F ) \ IL FAUT ENTRER A M J (TEMPS UNIVERSEL) -> JD
	JOUR F! MOIS ! ANNEE !
	MOIS @ 3 < IF MOIS @ 12 + MOIS ! ANNEE @ 1 - ANNEE ! THEN
	ANNEE @ DS>F 100E F/ FLOOR T F!
	T F@ 4E F/ FLOOR 2E F+ T F@ F- B F!
	ANNEE @ DS>F 4716E F+ 365.25E F* FLOOR
	MOIS @ 1 + DS>F 30.6001E F* FLOOR
	F+ JOUR F@ F+ B F@ F+ 1524.5E F-
;

\ POUR LE CALENDRIER JULIEN ( AVANT 1582 BC)
: DATEJ>JD ( N N F -- F ) \ IL FAUT ENTRER A M J (TEMPS UNIVERSEL) -> JD
	JOUR F! MOIS ! ANNEE !
	MOIS @ 3 < IF MOIS @ 12 + MOIS ! ANNEE @ 1 - ANNEE ! THEN
	ANNEE @ DS>F 100E F/ FLOOR T F!
	0E B F!
	ANNEE @ DS>F 4716E F+ 365.25E F* FLOOR
	MOIS @ 1 + DS>F 30.6001E F* FLOOR
	F+ JOUR F@ F+ B F@ F+ 1524.5E F-
;

: JOURD>HMS ( F -- S) \ PREND LES JOURS EN DECIMAL ET AFFICHE J H M S
	JOUR F@ FDUP FLOOR F- 24E F* FDUP FLOOR F>DS HEURES !
		FDUP FLOOR F- 60E F* FDUP FLOOR F>DS MINUTES !
		FDUP FLOOR F- 60E F*  SECONDES F!
	JOUR F@ FLOOR F>DS . ." - "HEURES @ . ." H " MINUTES @ . ." M " 
	4 SET-PRECISION SECONDES F@ F. ." S" CR 20 SET-PRECISION
;

: AFFICHAGE-DATE ( -- ) \ AFFICHAGE SCIENTIFIQUE
	ANNEE @ . MOIS @
	CASE
		1 OF ." JANUARY " ENDOF
		2 OF ." FEBRUARY " ENDOF
		3 OF ." MARCH " ENDOF
		4 OF ." APRIL " ENDOF
		5 OF ." MAI " ENDOF
		6 OF ." JUNE " ENDOF
		7 OF ." JULY " ENDOF
		8 OF ." AUGUST " ENDOF
		9 OF ." SEPTEMBER " ENDOF
		10 OF ." OCTOBER " ENDOF
		11 OF ." NOVEMBER " ENDOF
		12 OF ." DECEMBER " ENDOF
	ENDCASE
 JOURD>HMS
;

: JOUR-SEMAINE ( N N F -- )
DATE>JD 1.5E F+ F>DS 7 MOD
CASE
		0 OF ." SUNDAY " ENDOF
		1 OF ." MONDAY " ENDOF
		2 OF ." TUESDAY " ENDOF
		3 OF ." WEDNESDAY " ENDOF
		4 OF ." THURSDAY " ENDOF
		5 OF ." FRIDAY " ENDOF
		6 OF ." SATURDAY " ENDOF
ENDCASE
;


\ TEMPS SIDERAL ( TS ) A GREENWICH -- EN DEGRES
: DATE>ST ( N N F -- F )  		\ A M J -> DEGRE DECIMALS
	DATE>JD FDUP 2451545.0E F- 36525E F/ Z F! 
	2451545.0E F- 360.98564736629E F* 280.46061837E F+ 
	0.387933E-3 Z F@ FDUP F* F* F+ 
	Z F@ FDUP FDUP F* F* 38710000E F/ F- 
	FDUP 360E F/ FLOOR 360E F* F- 	\ MODULO 360
;

: JD>ST ( F -- F )  		\ JULIAN DAY-> DEGRE DECIMALS
	FDUP 2451545.0E F- 36525E F/ Z F! 
	2451545.0E F- 360.98564736629E F* 280.46061837E F+ 
	0.387933E-3 Z F@ FDUP F* F* F+ 
	Z F@ FDUP FDUP F* F* 38710000E F/ F- 
	FDUP 360E F/ FLOOR 360E F* F- 	\ MODULO 360
;

: OBJET ( N N F N N F -- ) \ H M SE D M SE ENREGISTRE ASSENTION ET D�CLINAISON 
	A>DD D>R DEC F! H>DD D>R AD F! 
;
: POSITION ( N N F N N F -- ) \ D M SE LONGITUDE LATITUDE
	A>DD LATITUDE F! A>DD LONGITUDE F! 
	." ---------- OBSERVER POSITION ------------" CR
	LONGITUDE F@ ." LONGITUDE : " DD>A
	LATITUDE F@  ." LATITUDE : " DD>A	
	." -----------------------------------------" CR
;
: MAISON ( -- ) \ POSITION DE L'OBSERVATEUR
	73 35 16.12E 45 30 31.82E \ Montreal
;

: HORLOGE ( N N N N N N -- ) \ A M J M S REVOIS LE TEMPS SID�RAL RELATIF
	DS>F SECONDES F! MINUTES ! HEURES ! DS>F JOUR F! MOIS ! ANNEE ! 
	JOUR F@ HEURES @ MINUTES @ SECONDES F@ H>TD F+ JOUR F!
	cr ." ---------------- TIME -------------------" CR
	AFFICHAGE-DATE
	." JULIAN DAY : " ANNEE @ MOIS @ JOUR F@ DATE>JD FDUP F. CR
	." SIDERAL TIME : " FDUP JD F! JD>ST FDUP STG F! DD>H 
	." -----------------------------------------" CR
;

: HORLOGE-LOCALE ( -- N ) \ REVOIS LE TEMPS SID�RAL � GREENWICH
	TIME&DATE
	ANNEE ! MOIS ! DS>F JOUR F! 
	HEURES ! MINUTES ! DS>F SECONDES F!
	JOUR F@ HEURES @ MINUTES @ SECONDES F@ H>TD F+ JOUR F!
	cr ." ---------------- TIME -------------------" CR
	AFFICHAGE-DATE
	JOUR F@ TIMEZONE 24E F/ F+ JOUR F! 
	." UT : " JOUR F@ JOURD>HMS
	." JULIAN DAY : " ANNEE @ MOIS @ JOUR F@ DATE>JD FDUP F. CR 
	." SIDERAL TIME : " FDUP JD F! JD>ST FDUP STG F! DD>H 
	." -----------------------------------------" CR
;

\ ---------- CORRECTIONS POUR LA NUTATION ---------------

-2.787E FVALUE NUTATION \ EN SECONDES
23 26 09.498E A>DD FVALUE OBLIQUITE-VRAIE \ EN DEGR�

: CORRECTION-NUTATION-TEMPS \ CORRECTION DU TEMPS SIDERAL PAR LA NUTATION
	STG F@ 0 0 NUTATION 15E F/ OBLIQUITE-VRAIE D>R FCOS F* H>DD F+ STG F! 
;

\ -------------------------------------------------------

: HEURE-ANGULAIRE ( -- ) \ CALCUL L'HEURE ANGULAIRE LOCALE EN RADIAN
	STG F@ LONGITUDE F@ F- AD F@ R>D F- D>R H F! \ ATTENTION L'ASCENSION EST EN RADIAN
;

: CALCUL-AZIMUTH ( -- ) 
	H F@ FSIN T F! H F@ FCOS LATITUDE F@ D>R FSIN F* DEC F@ FTAN LATITUDE F@ D>R FCOS  F* F- B F! 
	T F@ B F@ F/ FATAN
	FPI F+ \ AZIMUTH PART DU NORD -- AJOUT DE 180 DEGRE
	R>D B F@ 0E F< IF 180E F+ THEN 
	FDUP 360E F/ FLOOR 360E F* F- 	\ MODULO 360
	AZIMUTH F!
;

: CALCUL-ALTITUDE ( -- )
	LATITUDE F@ D>R FSIN DEC F@ FSIN F* LATITUDE F@ D>R FCOS DEC F@ FCOS H F@ FCOS F* F* F+ FASIN R>D
	ALTITUDE F! 
;

\ ----------- ETOILES FIXES -------------
: BETELGEUSE 5 55 10E 7 24 25.43E OBJET ." BETELGEUSE" CR ;
: ALDEBARAN 4 35 55.2E 16 30 33.48E OBJET ." ALDEBARAN" CR ;
: POLARIS 2 31 49E 89 15 50.78E OBJET ." POLARIS" CR ;
: VEGA 18 36 56E 38 47 1.29E OBJET ." VEGA" CR ;
: SIRIUS 6 45 08.9E -16 42 58E OBJET ." SIRIUS" CR ;
: CAPELLA 5 16 41E 45 59 52.76e OBJET ." CAPELLA" CR ;
: REGULUS 10 8 22E 11 58 1.95e OBJET ." REGULUS" CR ;
: ARCTURUS 14 15 39.67E 19 10 56.67e OBJET ." ARCTURUS" CR ;
: RIGEL 05 14 32.3E -08 12 06e OBJET ." RIGEL" CR ;
: PROCYON 07 39 18.1E 05 13 29e OBJET ." PROCYON" CR ;

: INITIALISATION-POS-MOMENT
	MAISON POSITION
	HORLOGE-LOCALE	
;
: POSITION-OBJET ( -- ) 
	CORRECTION-NUTATION-TEMPS
	HEURE-ANGULAIRE \ CALCUL L'HEURE ANGULAIRE LOCALE AVEC AD DE L'OBJET
	." ------------ OBJECT POSITION ------------" CR
	CALCUL-AZIMUTH ." AZIMUTH : " AZIMUTH F@ DD>A
	CALCUL-ALTITUDE ." ALTITUDE : "  ALTITUDE F@ DD>A
	." -----------------------------------------" CR
;

: EPHEMERIS-DAY ( -- ) \ TAKE JD - STOCK T (EPHEMERIS DAY - DYNAMICAL TIME) EN T 
	JD F@ 2451545.0E F- 36525E F/ T F! ;

\ --------------------------------------------------------
\                         SUN
\ --------------------------------------------------------

: LONGITUDE-SUN ( -- )  \ STOCK LONGITUDE DU SOLEIL EN B
	T F@ FDUP F* 0.0003032E F* T F@  36000.76983E F* F+ 280.46645E F+ 
	FDUP 360E F/ FLOOR 360E F* F- B F! ;
	
: ANOMALIE-SUN ( -- ) \ ANOMALIE DU SOLEIL EN C
	357.52910E 35999.05030E T F@ F* F+ 0.0001559E T F@ FDUP F* F* F- 
	0.00000048E T F@ FDUP FDUP F* F* F* F-  
	FDUP 360E F/ FLOOR 360E F* F- C F! ;

: EXCENTRICITE-EARTH-ORBIT	\ EXCENTRICITE DE l'ORBITE TERRESTRE EN D
	0.016708617E 0.000042037E T F@ F* F- 0.0000001236E T F@ FDUP F* F* F- D F! ;

: CENTER-SUN ( -- ) \ EQUATION DE CENTRE EN E
	1.914600E 0.004817E T F@ F* F- 0.000014E T F@ FDUP F* F* F- C F@ D>R FSIN F*
	0.019993E 0.000101E T F@ F* F- C F@ 2E F* D>R FSIN F* F+
	0.000290E C F@ 3E F* D>R FSIN F* F+ E F! ;

: SUN ( -- ) \ CALCUL LA POSITION EQUATORIAL DU SOLEIL
	EPHEMERIS-DAY
	LONGITUDE-SUN
	ANOMALIE-SUN
	EXCENTRICITE-EARTH-ORBIT
	CENTER-SUN
	
	B F@ E F@ F+ F F! \ VRAIE LONGITUDE DU SOLEIL EN F
	
	F F@ 0.00569E F- 0.00478E 
	125.04E 1934.136E T F@ F* F- D>R FSIN F* F- H F! \ LONGITUDE APPARENTE
	
	\ CORRECTION OBLIQUITE 
	\ A FAIRE !!!
	
	\ ASSENSION APPARENTE
	OBLIQUITE-VRAIE D>R FCOS H F@ D>R FTAN F* FATAN 
	H F@ D>R FCOS 0E F< IF FPI F+ THEN AD F! 
	
	\ DECLINAISON APPARENTE
	OBLIQUITE-VRAIE D>R FSIN H F@ D>R FSIN F* FASIN DEC F!
	
	." SUN" CR
;

\ --------------------------------------------------------
\                         MOON          !Work in progres!!
\ --------------------------------------------------------
: LONGITUDE-MOON ( -- ) \ store in B
        218.3164591E 481267.88134236E T f@ f* f+
        0.0013268E T f@ FDUP f* f* f-
        T f@ FDUP FDUP f* f* 538841E f/ f+
        T f@ FDUP FDUP FDUP f* f* f* 65194000E f/ f- 
	FDUP 360E F/ FLOOR 360E F* F- 	\ MODULO 360
        B f!
;

: RUN
	HORLOGE-LOCALE
	MAISON POSITION
	SUN POSITION-OBJET
        BETELGEUSE POSITION-OBJET
;

