\ Program to calculate big factorial
\ Michel Jean - December 2021

create answer 10000 cells allot \ Size of the answer
0 value answer_size 

: calcul { x | carry product } 
    answer_size 0 do
    i cells answer + @ x * carry + to product
    product 10 mod answer i cells + !
    product 10 / to carry
    loop 
    
    begin
    carry 0 > while
    carry 10 mod answer answer_size cells + !
    carry 10 / to carry
    1 +to answer_size
    repeat
;
: output ( -- )
    cr
    answer_size 1- to answer_size
    begin
    answer_size 0 >= while
    answer_size cells answer + ? 
    answer_size 1- to answer_size
    answer_size 30 mod 0 = if cr then \ number by line 
    repeat
;
: factorial { input | x }
    1 answer 0 cells + !
    1 to answer_size
    2 to x 
    begin 
     x input <= while 
	x calcul
     x 1+ to x
     repeat
    output 
;
