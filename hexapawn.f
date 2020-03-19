\ Hexapawn
\ Michel Jean 2019
WINAPI: GetTickCount KERNEL32.DLL

variable seed
GetTickCount seed !

: Random    ( -- x )  \ return a 32-bit random number x
    seed @
    dup 13 lshift xor
    dup 17 rshift xor
    dup 5  lshift xor
    dup seed !
    um* nip
;

variable position 8 cells allot
variable CJD  \ départ coup joueur
variable CJA	\ arrivé coup joueur
variable COD  \ départ coup ordi
variable COA	\ arrivé coup ordi
variable nbr-partie
variable nbr-gain-ordi
variable nbr-gain-joueur
variable position-code \ nbr de 9 chiffres associé à la position
variable index \ nbr de 2 chiffres accocié à la position
variable tirage \ nbr 0-2 résultat du tirage
variable reponse \ codes des coups possibles
variable coup-ordi \ coup stocké sous forme de deux chiffres

0 nbr-gain-ordi !
0 nbr-gain-joueur !
0 nbr-partie !

create liste-positions
                333122211 , 333212121 , 333221112 , 233231122 , 332132221 ,
		323312221 , 323213122 , 323321212 , 323123212 , 233132221 ,
		332231122 , 233212221 , 332212122 , 332121221 , 233121122 ,
		233311122 , 332113221 , 323122221 , 323221122 , 233212122 ,
		332212221 , 323112212 , 323211212 , 322331222 , 223133222 ,
		232113222 , 232311222 , 223331222 , 322133222 , 232132222 ,
		232231222 , 223312222 , 322213222 , 322312222 , 223213222 ,
		223111222 , 322111222 , 0 ,


create liste-reponses
                242536 , 143536 , 262514 , 265758 , 245958 ,
		154736 , 351469 , 474800 , 696800 , 243658 ,
		261458 , 353600 , 141500 , 242526 , 242526 ,
		263500 , 152400 , 360000 , 140000 , 353600 ,
		141500 , 153536 , 141535 , 475800 , 695800 ,
		246900 , 264700 , 475800 , 695800 , 245800 ,
		265800 , 473536 , 691514 , 154700 , 356900 ,
		350000 , 150000 ,

: intro
cr
." Hexapawn is a two-player game invented by Martin Gardner." cr
." On a board of size 3x3, each player begins with 3 pawns," cr
." As in chess, each pawn moved one square forward, " cr
." and capture diagonally ahead of it. " cr
." A player loses if he/she has no legal moves or " cr
." the other player reaches the end of the board with a pawn. " cr
;

: plateau-dessin ( -- )
cr
	." ------------- "   
	."    ------------- " cr   
3 0 do  ." | " 
        3 0 do 
                i j 3 * + cells position + @
        case 
		1 of ." O " endof
		3 of ." X " endof
                2 of ."   " endof
		endcase
        ." | "
        loop
        i case
        0 of ."    | 1 | 2 | 3 | " endof    
        1 of ."    | 4 | 5 | 6 | " endof    
        2 of ."    | 7 | 8 | 9 | " endof    
        endcase
	cr ." ------------- "
	."    ------------- " cr   
        loop
;

: position-depart
1 1 1 2 2 2 3 3 3 9 0 do position i cells + ! loop
;

: modifie-position-joueur
	2 position CJD @ 1- cells + ! \ reduire de 1 pour le 0
	1 position CJA @ 1- cells + !
;

: modifie-position-ordi
	coup-ordi @ 10 / 10 mod COD !
	coup-ordi @ 10 mod COA !
	2 position COD @ 1- cells + ! \ reduire de 1 pour le 0
	3 position COA @ 1- cells + !
;

: entre-coup
	cr ." Piece to move ? : "
	PAD DUP 4 ACCEPT EVALUATE CJD !  \ accept jusqu'a un nombre de 4 chiffres
	." to ?   : "
	PAD DUP 4 ACCEPT EVALUATE CJA !
;

: coup-valide?
	CJD @ 9 > CJD @ 1 < or if ." Invalid move!" entre-coup recurse else
	CJA @ 9 > CJA @ 1 < or if ." Invalid move!" entre-coup recurse else
	CJD @ 1- cells position + @ 1 = not if ." Invalid move!" entre-coup recurse else
	CJD @ CJA @ - 3 = CJA @ 1- cells position + @ 2 = and if modifie-position-joueur else
	CJD @ CJA @ - 2 = CJA @ 1- cells position + @ 3 = and if modifie-position-joueur else
	CJD @ CJA @ - 4 = CJA @ 1- cells position + @ 3 = and if modifie-position-joueur else
	." Invalid move!" entre-coup recurse then then then then then then
;


: code-position ( -- n) \ transforme la position en un nombre
	position 0 cells + @ 100000000 *
	position 1 cells + @ 10000000 *
	position 2 cells + @ 1000000 *
	position 3 cells + @ 100000 *
	position 4 cells + @ 10000 *
	position 5 cells + @ 1000 *
	position 6 cells + @ 100 *
	position 7 cells + @ 10 *
	position 8 cells + @ + + + + + + + +
	position-code !
;
: nouvelle-partie?
cr ." Number of games played : " nbr-partie @ . cr
." Victories - Humain : " nbr-gain-joueur ? ." - Forth2020 : " nbr-gain-ordi ? cr
cr ." Press any key for a new game."  cr key drop
;

: modifie-reponse
tirage @
	case
		0 of reponse @ coup-ordi @ 10000 * - liste-reponses index @ cells + ! endof
		1 of reponse @ coup-ordi @ 100 * - liste-reponses index @ cells + ! endof
		2 of reponse @ coup-ordi @ - liste-reponses index @ cells + ! endof
		endcase
;
: elimine-position
reponse @ 0 = if 0 liste-positions index @ cells + ! then
;
: apprentissage
	modifie-reponse
	elimine-position
;

: machine-gagne ( -- )
	plateau-dessin
	cr ." I win :-) !" cr
	nbr-gain-ordi @ 1+ nbr-gain-ordi !
	nbr-partie @ 1+ nbr-partie !
	position-depart
	nouvelle-partie?
;
: joueur-gagne ( -- )
	cr ." You win :-( !" cr
	nbr-gain-joueur @ 1+ nbr-gain-joueur !
	nbr-partie @ 1+ nbr-partie !
	apprentissage
	position-depart
	nouvelle-partie?
;
: ordi-gagne?
COA @ 6 > if machine-gagne then
index @ 11 = coup-ordi @ 36 = and if machine-gagne then
index @ 12 = coup-ordi @ 14 = and if machine-gagne then
index @ 13 = coup-ordi @ 26 = and if machine-gagne then
index @ 14 = coup-ordi @ 24 = and if machine-gagne then
index @ 21 = coup-ordi @ 35 = and if machine-gagne then
index @ 22 = coup-ordi @ 15 = and if machine-gagne then
index @ 34 = coup-ordi @ 35 = and if machine-gagne then
index @ 29 = coup-ordi @ 24 = and if machine-gagne then
index @ 30 = coup-ordi @ 26 = and if machine-gagne then
index @ 31 = coup-ordi @ 35 = and if machine-gagne then
index @ 32 = coup-ordi @ 15 = and if machine-gagne then
index @ 17 = index @ 18 = or if machine-gagne then
;

: tirage-coup (  -- )
	3 random dup tirage !
		case
		0 of reponse @ 10000 / 100 mod endof
		1 of reponse @ 100 / 100 mod endof
		2 of reponse @ 100 mod endof
		endcase
	coup-ordi !
;

: reponses-position ( n -- )  \ trouve les réponses à une position donnée
	code-position
	38 0 do i cells liste-positions + @ position-code @ = if i dup index !
    cells liste-reponses + @ reponse !
	begin tirage-coup coup-ordi @ 0 = not until
	modifie-position-ordi leave
	else i 37 = if joueur-gagne then then loop
;

: partie
position-depart
plateau-dessin
BEGIN
	entre-coup
	coup-valide?
	plateau-dessin
        1000 pause
	reponses-position
	ordi-gagne?
	plateau-dessin
	
AGAIN
;

intro
partie


