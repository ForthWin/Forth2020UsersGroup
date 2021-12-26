\ Program to calculate big factorial
\ Michel Jean - December 2021

create result 10000 cells allot \ Size of the result
0 value result_size 
0 value x

: calcul { carry product } 
    result_size 0 do
    i cells result + @ x * carry + -> product
    product 10 mod result i cells + !
    product 10 / -> carry
    loop 
    
    begin
    carry 0 > while
    carry 10 mod result result_size cells + !
    carry 10 / -> carry
    result_size 1+ to result_size
    repeat
;
: output ( -- )
    cr
    result_size 1- to result_size
    begin
    result_size 0 >= while
    result_size cells result + ? 
    result_size 1- to result_size
    result_size 30 mod 0 = if cr then \ number by line 
    repeat
;
: factorial { number }
    1 result 0 cells + !
    1 value result_size 
    2 value x
begin 
     x number <= while 
    0 0 calcul
    x 1+ to x
     repeat
    output 
;
500 factorial
