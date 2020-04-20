\ Calculation of digits of pi without floating-point
\ The algorithm calculate one digit at the time
\ Michel Jean, April 2020

1001 constant nbr-digits                \ number of digit - add one, the last digit is not printed
variable pos                            \ position in the array
variable ret                            \ carry (retenue in french ;-) )
nbr-digits  10 * 3 / constant nbr-cells \ initialisation on the number of cells
variable arr-cells nbr-cells cells allot

: initialisation ( -- ) \ initialisation of the array
      nbr-cells 0 do
        2 arr-cells i cells + !
        loop ;

: algo-base ( -- )
        pos @ 1 = if
        1 cells arr-cells + @ 10 * ret @ +
        dup
        10 mod arr-cells 1 cells + !
        10 / ret !
        else
                pos @ cells arr-cells + @ 10 * ret @ +
                2 pos @ * 1 -
                2dup
                mod arr-cells pos @ cells + !
                / pos @ 1 - * ret !
        then ;

: release-stack                 \ hold the last digit and release other digits of the stack
        depth 1 > if depth 1- roll . recurse else then ;

: release-stack+1               \ hold the last digit and release other digits of the stack + 1 modulo 10
        depth 1 > if 
        depth 1- roll 1+ 10 mod . 
        recurse else then ;

: set-predigit ( -- n )
        ret @ dup 9 < if release-stack else
        dup 10 = if release-stack+1 drop 0 else
        then then ;

: 1digit ( -- )                 \ calculate 1 digit at the time
        1 nbr-cells do
        i pos ! algo-base -1 +loop set-predigit ;

: run ( -- )
        0 ret ! initialisation
        20 0 do                \ 20 digits by line
        nbr-digits 20 / 0 do 1digit loop
        cr loop
        drop ;                  \ drop the last digit (value not safe)
run

