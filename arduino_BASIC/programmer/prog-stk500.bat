@echo off
chcp 1251
rem � ��������� ������� �������� �����
title -= avrdude STK500 AVR =-
set port=com6
set mk=m328p

set prog=stk500v2
rem set fwn=Digital_Solder_Staton.hex
set fwn=DSS31.hex
set tdir=%~d0%~p0bin\
set fw=%tdir%..\..\ab.hex
set eep=eep.eep
set lfuse=FF
rem set lfuse=C2
set hfuse=D2
:menu
cls
echo port=%port% mk=%mk% programmer=%prog% fuses %lfuse% %hfuse%
echo.
echo tdir=%tdir%
echo.
echo fw=%fw%
echo.
echo [I] read id
echo [W] write flash [R] read flash [V] verify flash
echo [G] write fuses [F] read fuses
echo [O] write eep   [E] read eep   [B] verify eep
echo.
echo [Q] Exit [C] Eease chip
echo _______________________
rem I read id
rem W write flash
rem G wtite fuse
rem O write rom
rem F read fuses
rem R read flash
rem E read rom
rem V verify flash
rem B veryfy rom
rem C erase chip
rem Q exit
choice /C IWGOFREVBCQ
if %ERRORLEVEL% == 1 goto id
if %ERRORLEVEL% == 2 goto wflash
if %ERRORLEVEL% == 3 goto wfuses
if %ERRORLEVEL% == 4 goto weep
if %ERRORLEVEL% == 5 goto rfuses
if %ERRORLEVEL% == 6 goto rflash
if %ERRORLEVEL% == 7 goto reep
if %ERRORLEVEL% == 8 goto vflash
if %ERRORLEVEL% == 9 goto veep
if %ERRORLEVEL% == 10 goto cerase
if %ERRORLEVEL% == 11 exit
goto menu
:id
%tdir%\avrdude.exe -c %prog% -p %mk% -P %port%  -v F
pause
cls
goto menu
:wflash
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -U flash:w:%fw%:a
pause
cls
goto menu
:wfuses
echo Write fuses ?
pause
pause
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -i 500 -U lfuse:w:0x%lfuse%:m
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -i 500 -U hfuse:w:0x%hfuse%:m
pause
cls
goto menu
:rfuses
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -i 500 -U hfuse:r:"hfuse.hex":h -U lfuse:r:"lfuse.hex":h -U efuse:r:"efuse.hex":h
pause
cls
goto menu
:rflash
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -i 100 -U flash:r:"read.hex":r
pause
cls
goto menu
:vflash
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -i 100 -U flash:v:"%fw%":a
pause
cls
goto menu
:cerase
echo Erase chip ?
pause
pause
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -i 500 -e
pause
cls
goto menu
:weep
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -U eeprom:w:%eep%:a
:reep
%tdir%\avrdude.exe -p %mk% -P %port% -c %prog% -U eeprom:r:%eep%:i
:veep
goto menu
pause