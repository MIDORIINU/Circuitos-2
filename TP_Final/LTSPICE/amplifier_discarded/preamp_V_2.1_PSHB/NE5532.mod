* NE5532 - Texas Instruments
* 
* The following parameters are modeled:
* 1. Open loop gain and phase with RL and CL effects
* 2. AC/DC Common mode rejection ratio
* 3. AC/DC Power supply rejection ratio
* 4. Slew rate
* 5. Input voltage noise with 1/f
* 6. Input curent noise with 1/f
* 7. Input bias current with common mode and temperature effects
* 8. Input offset current with temperature effects
* 9. Input offset voltage with temperature effects
* 10. Input impedance
* 11. Output current through the supply rails
* 12. Output current limit 
* 13. Output voltage swing from rails with RL effects
* 14. Output impedance
* 15. Quiescent current vs Supply voltage with temperature effects
* 16. Maximum supply voltage breakdown
* 17. Overload recovery / No phase reversal
* 18. Input common mode voltage range
*
* Connections:
*              Non-Inverting Input
*              | Inverting Input
*              | | +Supply Voltage
*              | | | -Supply Voltage
*              | | | | Output
*              | | | | | 
.SUBCKT NE5532 1 2 3 4 5

D1 8 10 DX
D3 7 10 DX
D2 9 8 DX
D4 9 7 DX
E4 7 19 15 0 1
R9 16 15 1
R7 11 12 1
R8 13 11 1
G3 0 15 11 14 0.000004
L1 16 0 80u
E1 12 0 1 0 1
E2 13 0 2 0 1
E5 19 22 21 0 1
R13 0 21 1.4k
E3 14 4 3 4 0.5
R10 0 16 1000k
C2 0 2 4p
C1 1 0 4p
C3 1 2 4p
E6 22 25 26 0 1
G2 2 0 6 0 1
R4 6 0 1E-6 TC=-3.1e-3
I1 0 6 0.21
G1 1 0 6 0 0.98
R2 1 2 100k
R1 0 1 200Meg
R3 2 0 200Meg
R24 39 0 1
C4 39 0 105E-5
G10 0 39 36 0 1
G9 0 36 30 8 130000
R23 36 0 1
D9 36 37 DX
D11 38 36 DX
G16 49 3 3 42 0.025
G17 4 49 42 4 0.025
R32 3 49 40
R33 49 4 40
R34 56 49 1
G15 48 4 42 49 0.01
G14 47 4 49 42 0.01
D17 3 48 DX
D15 3 47 DX
D16 4 47 DY
D18 4 48 DY
D19 49 54 DX
E13 54 3 51 49 1000
V7 50 51 0.8
D20 55 49 DX
E14 55 4 53 49 1000
V8 53 52 1.5
E11 3 50 49 56 18
G11 0 40 39 0 1
R25 40 0 1
C5 57 0 1.75E-7
V3 20 0 0.235
D5 20 21 DN
R30 47 0 1G
R31 48 0 1G
R20 0 34 0.00002
V5 33 0 0.235
D7 33 34 DNC
G7 0 2 34 0 1
R19 0 32 0.00002
V4 31 0 0.235
D6 31 32 DNC
G6 0 1 32 0 1
G12 0 41 40 0 1
R26 41 0 1
C6 41 0 750p
C8 49 42 1p
D13 42 43 DX
E9 43 0 45 42 1000
D14 44 42 DX
E10 44 0 46 42 1000
R21 3 4 36k
D8 4 3 DB
G8 3 4 35 0 1
R22 0 35 1 TC=1.5e-3
I3 0 35 0.0032
E8 25 30 29 0 1
R18 0 29 1
I2 29 0 0.0006
L5 56 5 300n
R35 56 5 50
E12 4 52 49 56 18
G4 0 23 3 4 0.00001
R14 24 23 1
L3 24 0 200u
R15 0 24 10k
G5 0 26 23 0 1
R16 27 26 1
L4 27 0 0.3u
R17 0 27 2
R28 49 45 1
I4 49 45 0.65
R29 49 46 1
I5 46 49 0.65
G13 0 42 41 0 1
R27 42 0 1
C7 42 0 750p
R5 7 1 50
R6 8 2 50
V2 3 10 3.7
V1 9 4 2
R36 40 57 0.63
D10 0 37 DSRP
D12 38 0 DSRN

.model DX D(IS=1E-15)
.model DY D(IS=1E-15 BV=50)
.model DN D(KF=70e-13 T_ABS=27)
.model DNC D(KF=60e-4 T_ABS=27)
.model DB D(BV=46 T_ABS=27)
.model DSRP D(BV=9.5K T_ABS=27)
.model DSRN D(BV=9.5K T_ABS=27)

.ENDS NE5532