\ selfy is a computer program which takes no input and produces a copy of its 
\ own source code as its only output. The standard terms for these programs 
\ are "self-replicating programs" or Quine.

: selfy s" : selfy s over 9 type 34 emit space 2dup type 34 emit 9 /string type ;" over 9 type 34 emit space 2dup type 34 emit 9 /string type ;
