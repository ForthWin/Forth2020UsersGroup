\ Test 2 for GUI
\ simple primarity test
\ Michel Jean, June 2019
\ Warning : disable case-insensivity

REQUIRE S>NUM ~nn/lib/s2num.f
REQUIRE WL-MODULES ~day\lib\includemodule.f
NEEDS ~day\wfl\wfl.f

101 CONSTANT nombreID

CDialog SUBCLASS CPswDialog

CString OBJ nombre


VARIABLE root
VARIABLE div
VARIABLE nbr

: root? ( n1 -- n2 ) \ calculate square root of the number
    2 16 0 DO 2DUP / + 2 / LOOP NIP 1 +
;

: test ( -- )
   BEGIN
   div @ 2 + div ! \ check odd number only
   nbr @ div @ MOD 0 = div @ root @ < NOT OR UNTIL
   div @ root @  < NOT IF S"  is prime " ELSE
   div @ . S"  is dividing by " THEN
;



: prime? ( -- )
   nombre @ STR@ S>NUM DUP nbr ! \ transform string in number

	DUP 0 = IF DROP S"  !!! Input a number > 0" ELSE
	DUP 1 = IF DROP S"  is not a prime" ELSE
	DUP 2 = IF DROP S"  is prime" ELSE
        DUP 2 MOD 0 = IF DROP S"  is dividing by 2 " ELSE   \ check if even
	1 div ! root? root ! test THEN THEN THEN THEN
;


C: IDOK ( code -- )
    nombreID SUPER getItemStrText nombre !
    DROP IDOK SUPER endDialog
;

: report ( -- addr u )

    <# prime? HOLDS
       nombre @ STR@ HOLDS 0. #>
    SUPER showMessage
;

;CLASS

0 0 102 66
WS_POPUP WS_SYSMENU OR WS_CAPTION OR DS_MODALFRAME OR
DS_SETFONT OR DS_CENTER OR

DIALOG: EntreeDialog Primarity test

      8 0 FONT MS Sans Serif
  nombreID 45  20 51 14 ES_NUMBER ( autorise only numbers ) EDITTEXT
     IDOK  5 45 40 14 0 PUSHBUTTON OK
 IDCANCEL 55 45 40 14 0 PUSHBUTTON Annuler
      104  6  7 37  8 0 LTEXT Enter

DIALOG;

CPswDialog NEW dialog

: bye S" Good Bye!" dialog showMessage ;

: windows ( -- )
    EntreeDialog 0 dialog showModal IDOK =
    IF
    dialog report
    ELSE bye -1
    THEN
;

windows

: run ( -- )
DO windows DUP -1 = IF LEAVE THEN LOOP 0 ;

run
