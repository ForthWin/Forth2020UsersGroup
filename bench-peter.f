.( Wait a bit while benchmarking...) CR

S" ~ygrek/spf/included.f" INCLUDED
S" C:\FORTHW2BIG\samples\bubble.f" INCLUDED
S" C:\FORTHW2BIG\samples\bench\queens.f" INCLUDED

WINAPI: GetTickCount KERNEL32.DLL

: (bench) ( -- n )
   GetTickCount
    MAIN
    test
   GetTickCount SWAP -
;


: bench ( -- n )
    0
    100 0
    DO (bench) + LOOP
;

bench . .(  ms) CR