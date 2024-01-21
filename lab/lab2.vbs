dim SB1, SB2 'bits 0, 1 
dim LS1, LS2, LS3 'bits 2,3,4
dim LVS1, LVS2, LVS3 'coils 0,1,2 
dim TE1 'inp reg 0 
dim TV1 'hold reg 0
dim level 'hold reg 10
dim counter 'hold reg 11

' скрипт викликається кожні 500 мс
' 0=DO, 1=DI, 2=AI, 3=AO 
' виходи на обєкт
LVS1 = GetRegisterValue (0, 0)
LVS2 = GetRegisterValue (0, 1)
LVS3 = GetRegisterValue (0, 2)
TE1 = GetRegisterValue (2, 0)
TV1 = GetRegisterValue (3, 0)
level = GetRegisterValue (3, 10)
counter = GetRegisterValue (3, 11) + 1

dim t 
t =  (TE1 * 0.9 + TV1 * 0.1) * 0.8  
TE1 = 2000 + t

dim dl
dl = 250
if LVS1=1 then level = level + dl
if LVS2=1 then level = level + dl
if LVS3=1 then level = level - dl
if level>10000 then level = 10000
if level<0 then level = 0

' входи з датчиків
SetRegisterValue 1, 0, LS1
SetRegisterValue 1, 1, LS2
SetRegisterValue 1, 2, LS3
SetRegisterValue 2, 0, TE1
SetRegisterValue 3, 10, level
SetRegisterValue 3, 11, counter
'SetRegisterValue 3, 12, LVS1
