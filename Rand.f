\ Simple but efficient 32bits Pseudo-Random generator
\ XorShift https://en.wikipedia.org/wiki/Xorshift

variable seed
seed seed ! \ use adress of seed to initialize the seed

: Random    ( -- x )  \ return a 32-bit random number x
    seed @
    dup 13 lshift xor
    dup 17 rshift xor
    dup 5  lshift xor
    dup seed !
    um* nip
;