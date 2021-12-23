\ Program to calculate big factorial
\ Michel Jean - December 2021

create result 10000 cells allot \ Size of the result
variable result_size 
variable carry
variable product
variable x
variable number

: calcul ( -- ) 
    0 carry !
    result_size @ 0 do
    i cells result + @ x @  * carry @ + product !
    product @ 10 mod result i cells + !
    product @ 10 / carry !
    loop 
    
    begin
    carry @ 0 > while
    carry @ 10 mod result result_size @ cells + !
    carry @ 10 / carry !
    result_size @ 1+ result_size !
    repeat
;
: output ( -- )
    ." The factorial of " number ? ." is : " cr
    result_size @ 1- result_size !
    begin
    result_size @ 0 >= while
    result_size @ cells result + ? 
    result_size @ 1- result_size !
    repeat
;
: factorial ( -- )
    number !
    1 result 0 cells + !
    1 result_size !
    2 x !
    
    begin 
     x @ number @ <= while 
 calcul
    x @ 1+ x !
     repeat
    output 
;
500 factorial