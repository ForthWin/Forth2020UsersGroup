\ Simple demo for Circle design with graph.f 

REQUIRE Point	~pi/lib/wincon/graph.f 

800 600 ConSize \ Size of the windows
20 20 ConMove \ position of the windows 

0x00FF00 Color
3 3 length 3 - height 3 - 100 100 RRect \ Draw a rectangle with round ends : x y x1 y1 ll lh

0x0000FF Color
6 6 length 6 - height 6 - 100 100 RRect 

0x00FF00 Color
100 100 100 Circle \ X Y Dimeter

0x0000FF Color
400 300 160 Circle

0x00FFFF Color
300 500 180 200 Ellips \ X Y X1 Y1

BEGIN
ConRefresh
AGAIN
