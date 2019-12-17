\ makemoney 2.1 - written by Leendert A. Hartog
\ modifications by Iruatä Souza

: str, ( a u -- )     dup c,  here  over allot  swap cmove ;
: $var ( a u -- )     create str, ;
: $.   ( 'var -- )    count type ;

: /string ( a u n -- a+n u-n )    tuck -  >r + r> ;

: signed ( a u -- a' u' -1|1 )
    over c@ [char] - <> if 1 exit then  1 /string  -1 ;

: number ( a u -- n a' u' )    2>r 0. 2r>  >number  2>r d>s 2r> ;

\ integer's returned a' u' is the string after the decimal point
: integer ( a u -- a' u' int )       number  dup 0 > if 1 /string then  rot ;
: iscale ( n -- n' )                 100 * ;
: fractional ( a u -- frac )         number drop drop ;
: fscale ( dec-places n -- 10^n )    swap 1 = if 10 * then ;

: makemoney ( 'var -- n )
    count signed >r
    integer iscale >r  2 min tuck  fractional fscale  r> +
    r> * ;

\ testmoney...
S" 1234" $var amount1
S" 1234.56" $var amount2
S" 1234." $var amount3
S" 1234.5" $var amount4
S" 1234.567" $var amount5
S" -1234" $var amount6
S" -1234.56" $var amount7
S" -1234." $var amount8
S" -1234.5" $var amount9
S" -1234.567" $var amount10

amount1  dup $. space makemoney . CR
amount2  dup $. space makemoney . CR
amount3  dup $. space makemoney . CR
amount4  dup $. space makemoney . CR
amount5  dup $. space makemoney . CR
amount6  dup $. space makemoney . CR
amount7  dup $. space makemoney . CR
amount8  dup $. space makemoney . CR
amount9  dup $. space makemoney . CR
amount10 dup $. space makemoney . CR
