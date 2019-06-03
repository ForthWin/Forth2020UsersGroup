\ Easter date calculatorV2
\ Simple dialog sample for input and output
\ Easter computation
\ First version by Michel Jean
\ Greatly improved by Iruatã Souza
\ May/June 2019
\ Warning : disable case-insensivity

REQUIRE S>NUM ~nn/lib/s2num.f
REQUIRE WL-MODULES ~day\lib\includemodule.f
NEEDS ~day\wfl\wfl.f

101 CONSTANT yearID

CDialog SUBCLASS CPswDialog

CString OBJ year


: easter ( year -- day )
    year @ STR@ S>NUM >R \ transform string in number and stock in return stack
    19 R@ 19 MOD * R@ 100 / + R@ 100 / 4 /
    - R@ 100 / R@ 100 / 8 + 25 / - 1 + 3 / - 15 +
    30 MOD  R@ 100 / 4 MOD 2 * R@ 100 MOD 4 / 2 * +
    19 R@ 19 MOD * R@ 100 / + R@ 100 / 4 /
    - R@ 100 / R@ 100 / 8 + 25 / - 1 + 3 / - 15 + 30
    MOD - R@ 100 MOD 4 MOD - 32 + 7 MOD + 7 R@ 19 MOD
    11 19 R@ 19 MOD * R@ 100 / + R@ 100 / 4 /
    - R@ 100 / R@ 100 / 8 + 25 / - 1 + 3 / - 15 + 30
    MOD * + 22 R@ 100 / 4 MOD 2 * R@ 100 MOD 4 / 2 *
    + 19 R@ 19 MOD * R@ 100 / + R@ 100 /
    4 / - R@ 100 / R@ 100 / 8 + 25 / - 1 + 3 / - 15
    + 30 MOD - R@ 100 MOD 4 MOD - 32 + 7 MOD * + 451 / * -
    114 +
    R> DROP
;

: day ( easter -- )    31 MOD 1 + ;
: march? ( easter -- flag )    31 / 3 = ;
: month ( easter -- )    march? IF   S" March "   ELSE   S" April "   THEN ;


C: IDOK ( code -- )
    yearID SUPER getItemStrText year !
    DROP IDOK SUPER endDialog
;

: report ( -- addr u )
	DUP easter DUP
    <#
	day . month HOLDS
	S"  Easter date is " HOLDS
        year @ STR@ HOLDS S" In " HOLDS  0.
				#>
    SUPER showMessage
;

;CLASS

0 0 102 66
WS_POPUP WS_SYSMENU OR WS_CAPTION OR DS_MODALFRAME OR
DS_SETFONT OR DS_CENTER OR

DIALOG: EntreeDialog Easter date calculator

      8 0 FONT MS Sans Serif
  yearID 45  20 51 14 ES_NUMBER ( autorise only numbers ) EDITTEXT
     IDOK  5 45 40 14 0 PUSHBUTTON OK
 IDCANCEL 55 45 40 14 0 PUSHBUTTON Annuler
      104  6  7 37  8 0 LTEXT Enter Year

DIALOG;

CPswDialog NEW dialog

: bye S" Good Bye!" dialog showMessage ;

: windows ( -- )
    EntreeDialog 0 dialog showModal IDOK =
    IF
     dialog report
    ELSE bye 0
    THEN
;

: main ( -- )
DO windows DUP 0 = IF LEAVE DROP THEN DROP LOOP 0 ;

main
