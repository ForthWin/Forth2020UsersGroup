\ Simple easter date calculator
\ Algorithm of Jean Meeus
\ First version by Michel Jean
\ Improved by Iruatã Souza

: easter ( year -- day )
    >R 19 R@ 19 MOD * R@ 100 / + R@ 100 / 4 /
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

: day ( easter -- )    31 MOD 1 + . ;
: march? ( easter -- flag )    31 / 3 = ;
: month ( easter -- )    
        march? IF   ." March "   ELSE   ." April "   THEN ;

: date ( year -- day month )
        easter dup day month ;
