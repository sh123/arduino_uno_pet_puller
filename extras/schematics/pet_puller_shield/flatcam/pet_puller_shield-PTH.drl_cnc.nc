(G-CODE GENERATED BY FLATCAM v8.994 - www.flatcam.org - Version Date: 2020/11/7)

(Name: pet_puller_shield-PTH.drl_cnc)
(Type: G-code from Geometry)
(Units: MM)

(Created on Friday, 14 February 2025 at 21:29)

(This preprocessor is the default preprocessor used by FlatCAM.)
(It is made to work with MACH3 compatible motion controllers.)


(TOOLS DIAMETER: )
(Tool: 1 -> Dia: 0.70104)
(Tool: 2 -> Dia: 0.7619999999999999)
(Tool: 3 -> Dia: 0.8000999999999999)
(Tool: 4 -> Dia: 0.8000999999999999)
(Tool: 5 -> Dia: 0.8000999999999999)
(Tool: 6 -> Dia: 0.8000999999999999)
(Tool: 7 -> Dia: 0.89916)
(Tool: 8 -> Dia: 0.94996)
(Tool: 9 -> Dia: 1.0007599999999999)
(Tool: 10 -> Dia: 1.0998199999999998)
(Tool: 11 -> Dia: 1.6001999999999998)
(Tool: 12 -> Dia: 1.69926)

(FEEDRATE Z: )
(Tool: 1 -> Feedrate: 300)
(Tool: 2 -> Feedrate: 300)
(Tool: 3 -> Feedrate: 300)
(Tool: 4 -> Feedrate: 300)
(Tool: 5 -> Feedrate: 300)
(Tool: 6 -> Feedrate: 300)
(Tool: 7 -> Feedrate: 300)
(Tool: 8 -> Feedrate: 300)
(Tool: 9 -> Feedrate: 300)
(Tool: 10 -> Feedrate: 300)
(Tool: 11 -> Feedrate: 300)
(Tool: 12 -> Feedrate: 300)

(FEEDRATE RAPIDS: )
(Tool: 1 -> Feedrate Rapids: 1500)
(Tool: 2 -> Feedrate Rapids: 1500)
(Tool: 3 -> Feedrate Rapids: 1500)
(Tool: 4 -> Feedrate Rapids: 1500)
(Tool: 5 -> Feedrate Rapids: 1500)
(Tool: 6 -> Feedrate Rapids: 1500)
(Tool: 7 -> Feedrate Rapids: 1500)
(Tool: 8 -> Feedrate Rapids: 1500)
(Tool: 9 -> Feedrate Rapids: 1500)
(Tool: 10 -> Feedrate Rapids: 1500)
(Tool: 11 -> Feedrate Rapids: 1500)
(Tool: 12 -> Feedrate Rapids: 1500)

(Z_CUT: )
(Tool: 1 -> Z_Cut: -1.9)
(Tool: 2 -> Z_Cut: -1.9)
(Tool: 3 -> Z_Cut: -1.9)
(Tool: 4 -> Z_Cut: -1.9)
(Tool: 5 -> Z_Cut: -1.9)
(Tool: 6 -> Z_Cut: -1.9)
(Tool: 7 -> Z_Cut: -1.9)
(Tool: 8 -> Z_Cut: -1.9)
(Tool: 9 -> Z_Cut: -1.9)
(Tool: 10 -> Z_Cut: -1.9)
(Tool: 11 -> Z_Cut: -1.9)
(Tool: 12 -> Z_Cut: -1.9)

(Tools Offset: )
(Tool: 1 -> Offset Z: 0.0)
(Tool: 2 -> Offset Z: 0.0)
(Tool: 6 -> Offset Z: 0.0)
(Tool: 7 -> Offset Z: 0.0)
(Tool: 8 -> Offset Z: 0.0)
(Tool: 9 -> Offset Z: 0.0)
(Tool: 10 -> Offset Z: 0.0)
(Tool: 11 -> Offset Z: 0.0)
(Tool: 12 -> Offset Z: 0.0)

(Z_MOVE: )
(Tool: 1 -> Z_Move: 2)
(Tool: 2 -> Z_Move: 2)
(Tool: 3 -> Z_Move: 2)
(Tool: 4 -> Z_Move: 2)
(Tool: 5 -> Z_Move: 2)
(Tool: 6 -> Z_Move: 2)
(Tool: 7 -> Z_Move: 2)
(Tool: 8 -> Z_Move: 2)
(Tool: 9 -> Z_Move: 2)
(Tool: 10 -> Z_Move: 2)
(Tool: 11 -> Z_Move: 2)
(Tool: 12 -> Z_Move: 2)

(Z Toolchange: 18.0 mm)
(X,Y Toolchange: 0.0000, 0.0000 mm)
(Z Start: None mm)
(Z End: 0.5 mm)
(X,Y End: None mm)
(Steps per circle: 64)
(Preprocessor Excellon: default)

(X range:    9.0289 ...   70.9897  mm)
(Y range:    2.3436 ...   52.0895  mm)

(Spindle Speed: 20000 RPM)
G21
G90
G94

G01 F300.00

M5
G00 Z18.0000
T1
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 0.7010 ||| Total drills for tool T1 = 15)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X10.7180 Y7.9240
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X62.7880 Y38.1500
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X62.5340 Y44.2460
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X57.7080 Y38.1500
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X57.4540 Y44.2460
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X36.1180 Y24.5991
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X36.1180 Y29.6791
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X33.5780 Y27.1391
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X29.5140 Y5.3840
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X24.4340 Y5.3840
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X20.6240 Y46.6590
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X20.6240 Y51.7390
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X20.4589 Y39.6740
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X20.4589 Y44.7540
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X15.7980 Y7.9240
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T2
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 0.7620 ||| Total drills for tool T2 = 10)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X46.5320 Y29.4277
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X62.4070 Y11.6477
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X59.2320 Y11.6477
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X54.1520 Y14.1877
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X54.1520 Y29.4277
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X51.6120 Y14.1877
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X51.6120 Y29.4277
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X49.0720 Y14.1877
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X49.0720 Y29.4277
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X46.5320 Y14.1877
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T6
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 0.8001 ||| Total drills for tool T6 = 2)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X23.8422 Y31.8000
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X27.6420 Y31.8000
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T7
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 0.8992 ||| Total drills for tool T7 = 2)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X19.3286 Y4.1140
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X21.8686 Y4.1140
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T8
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 0.9500 ||| Total drills for tool T8 = 4)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X68.5843 Y15.4831
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X68.5843 Y7.9850
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X68.5843 Y10.4843
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X68.5843 Y12.9837
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T9
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 1.0008 ||| Total drills for tool T9 = 36)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X11.7543 Y3.0523
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X70.4893 Y21.9143
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X70.4893 Y24.4137
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X70.4893 Y31.4393
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X70.4893 Y33.9387
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X70.1540 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X70.1540 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X67.6140 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X67.6140 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X65.0740 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X65.0740 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X62.5340 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X62.5340 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X59.9940 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X59.9940 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X57.4540 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X57.4540 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X54.9140 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X52.3740 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X52.3740 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X49.8340 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X48.3151 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X47.2940 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X45.7751 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X44.7540 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X43.2351 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X42.2140 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X40.6951 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X39.6740 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X38.1551 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X37.1340 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X35.6151 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X34.5940 Y51.1040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X33.0751 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X30.5351 Y2.8440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X14.2537 Y3.0523
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T10
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 1.0998 ||| Total drills for tool T10 = 6)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X19.0137 Y18.0840
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X26.1257 Y40.4360
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X26.1257 Y42.9760
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X26.1257 Y45.5160
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X19.0137 Y13.0040
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X19.0137 Y15.5440
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T11
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 1.6002 ||| Total drills for tool T11 = 2)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X9.8290 Y24.4340
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X25.0690 Y24.4340
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G01 F300.00

M5
G00 Z18.0000
T12
G00 X0.0000 Y0.0000                
M6
(MSG, Change to Tool Dia = 1.6993 ||| Total drills for tool T12 = 2)
M0
G00 Z18.0000

G01 F300.00
M03 S20000
G00 X69.6028 Y45.7624
G01 Z-1.9000
G01 Z0
G00 Z2.0000
G00 X69.6028 Y40.7611
G01 Z-1.9000
G01 Z0
G00 Z2.0000
M05
G00 Z0.50


