::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFAtXcCCNK2W2CbQY+9Td/e+CjGwzcKIPeZvY0rGcHOkQ5UuqfJUitg==
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFAtXcCCNK2W2CbQY+9Td/e+CjGwzcKIPeZvY0rGcHMYB70DKVLgJlkpbjMgECQkWewquDg==
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
::Config
@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)
color 0f
SET "empty_line=,                                                                            ,"
CALL :CenterText "[FreeNAND Patcher Tool]" "title"
CALL :CenterText "by Zayne64 and Javier107" "creator"
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
IF NOT EXIST "nand" CALL :Error "Source NAND doens't exist or is corrupted"

:Start
::Finds the drive letter for the SD Card
FOR %%D IN ( "A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z" ) DO (
  FOR %%F IN ( "%%~D:\hiya.dsi","%%~D:\sys","%%~D:\title","%%~D:\ticket","%%~D:\shared1","%%~D:\shared2" ) DO (
    IF NOT "%%~D"=="%SystemRoot:~0,1%" IF "%SDdrive%"=="" IF EXIST "%%~F" (
      IF EXIST "%%~D:\hiya.dsi" IF EXIST "%%~D:\sys" IF EXIST "%%~D:\title" IF EXIST "%%~D:\ticket" IF EXIST "%%~D:\shared1" IF EXIST "%%~D:\shared2" SET SDdrive=%%~D
    )
  )
)

::If the sd card wans't found throws error
IF "%SDdrive%"=="" (
    CALL :Error "Could not find SD Card with DSi EmuNAND"
)

::If this executes sd card was found
:SDFound
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "SD Card found on drive (%SDdrive%:\)" "sdfound" "false"
CALL :CenterText "Is that drive letter correct?" "sdask" "false"
CALL :CenterText "Y = yes     N = no" "ask" "false"
echo %sdfound%
echo %sdask%
CALL :CT "0e" "%ask%"
echo.
SET /p "sdanswer="
IF "%sdanswer%"=="" goto :SDFound
CALL :ToLC "sdanswer"
IF NOT "%sdanswer:~0,1%"=="y" IF NOT "%sdanswer:~0,1%"=="n" goto :SDFound

::Checks for source nand's integrity
IF EXIST "nand\hiya.dsi" IF EXIST "nand\sys" IF EXIST "nand\title" IF EXIST "nand\ticket" IF EXIST "nand\shared1" IF EXIST "nand\shared2" SET SNintegrity=true
IF NOT "%SNintegrity%"=="true" CALL :Error "Source NAND doens't exist or is corrupted"
GOTO :%sdanswer:~0,1%FIRST

:nFIRST
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "Insert the letter of the" "txt1" "false"
CALL :CenterText "drive where your SD Card is located" "txt2" "false"
echo %txt1%
echo %txt2%
echo.
SET /p "driveanswer="
IF NOT "%driveanswer%"=="" SET "tmp_drive=%driveanswer:~0,1%"
IF NOT "%driveanswer%"=="" CALL :ToUC "tmp_drive"
IF EXIST "%tmp_drive%:\hiya.dsi" IF EXIST "%tmp_drive%:\sys" IF EXIST "%tmp_drive%:\title" IF EXIST "%tmp_drive%:\ticket" IF EXIST "%tmp_drive%:\shared1" IF EXIST "%tmp_drive%:\shared2" SET integrity=true
SET SDdrive=%tmp_drive%
IF "%tmp_drive%"=="%SystemRoot:~0,1%" SET integrity=false
IF NOT "%integrity%"=="true" CALL :Error "Could not find SD Card with DSi EmuNAND"

:yFIRST
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "Before the nand is injected on the" "warning" "false"
CALL :CenterText "SD Card, would you like to backup your SD files?" "bakask" "false"
CALL :CenterText "(The backup proccess can take a while)" "backwarn" "false"
CALL :CenterText "Y = yes     N = no" "ask" "false"
echo %warning%
echo %bakask%
CALL :CT "07" "%backwarn%"
CALL :CT "0e" "%ask%"
echo.
SET /p "bakanswer="
IF "%bakanswer%"=="" goto :yFIRST
CALL :ToLC "bakanswer"
IF NOT "%bakanswer:~0,1%"=="y" IF NOT "%bakanswer:~0,1%"=="n" goto :yFIRST
GOTO :%bakanswer:~0,1%SECOND

:ySECOND
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "Copying files from SD to the folder" "baktxt1" "false"
CALL :CenterText "backup. DO NOT REMOVE THE SD CARD OR POWER OFF THE PC" "baktxt2" "false"
CALL :CenterText "(Please be patient, this proccess can take a while)" "baktxt3" "false"
echo %baktxt1%
echo %baktxt2%
CALL :CT "07" "%baktxt3%"
IF NOT EXIST "backup" md "backup">NUL
xcopy "%SDdrive%:\" "backup" /e /y>NUL
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "Backup proccess finished. Now the source" "baktxt4" "false"
CALL :CenterText "NAND will be injected onto the SD Card" "baktxt5" "false"
CALL :CenterText "Press ENTER to continue" "baktxt6" "false"
echo %baktxt4%
echo %baktxt5%
echo.
CALL :CT "0e" "%baktxt6%"
pause>NUL

:nSECOND
::Ask if keep configuration
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "Would you like to keep your settings" "CFGwarning" "false"
CALL :CenterText "from your NAND on your SD Card?" "CFGwarn" "false"
CALL :CenterText "Y = yes     N = no" "CFGask" "false"
echo %CFGwarning%
echo %CFGwarn%
CALL :CT "0e" "%CFGask%"
echo.
SET /p "CFGanswer="
IF "%CFGanswer%"=="" goto :nSECOND
CALL :ToLC "CFGanswer"
IF NOT "%CFGanswer:~0,1%"=="y" IF NOT "%CFGanswer:~0,1%"=="n" goto :nSECOND
IF "%CFGanswer:~0,1%"=="n" SET keep_cfg=false

::Inject NAND
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "Injecting source NAND onto SD Card" "injecttxt1" "false"
CALL :CenterText "DO NOT REMOVE THE SD CARD OR POWER OFF THE PC" "injecttxt2" "false"
CALL :CenterText "(Please be patient, this proccess can take a while)" "injecttxt3" "false"
echo %injecttxt1%
echo %injecttxt2%
CALL :CT "07" "%injecttxt3%"
echo.

::Patch shared1 and shared2
IF "%keep_cfg%"=="false" xcopy "nand\shared1" "%SDdrive%:\shared1" /e /y>NUL
IF "%keep_cfg%"=="false" xcopy "nand\shared2" "%SDdrive%:\shared2" /e /y>NUL

::Inject NAND
xcopy "nand\sys" "%SDdrive%:\sys" /e /y>NUL
xcopy "nand\title" "%SDdrive%:\title" /e /y>NUL
xcopy "nand\ticket" "%SDdrive%:\ticket" /e /y>NUL

:End
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "Successfully finished. Press ENTER to exit" "finished" "false"
CALL :CT "0a" "%finished%"
pause>nul
exit





::Functions
:Error
cls
CALL :CT "b1" "%empty_line%"
CALL :CT "b1" "%title%"
CALL :CT "b1" "%creator%"
CALL :CT "b1" "%empty_line%"
echo.
CALL :CenterText "ERROR" "error_line" "false"
CALL :CT "0c" "%error_line%"
CALL :CenterText "Error Description : %~1" "error_desc" "false"
echo %error_desc%
echo.
CALL :CenterText "Press ENTER to exit" "end" "false"
CALL :CT "0e" "%end%"
pause>nul
exit
:CenterText
SET "tmp_var_pt1=,                                      "
SET "tmp_var_pt2=                                       ,"
IF "%~3"=="false" (
  SET "tmp_var_pt1=                                       "
  SET "tmp_var_pt2=                                        "
)
echo %~1%> tmp.tmp
FOR %%? IN (tmp.tmp) DO ( SET /A text_length=%%~z? - 2 )
del /q /s tmp.tmp>NUL
SET /A tmp_nmb=%text_length% / 2
SET /A tmp_result=%tmp_nmb%+%tmp_nmb%
SET /A removeTP2=39-%tmp_nmb%
SET /A removePT2=39-%removeTP2%
SET /A removePT1=39-%tmp_nmb%-1
IF NOT "%tmp_result%"=="%text_length%" SET /A removePT1=39-%tmp_nmb%-2
SET "part_1=!tmp_var_pt1:~0,%removePT1%!"
SET "part_2=!tmp_var_pt2:~%removePT2%!"
SET "%~2=%part_1%%~1%part_2%"
goto :eof
:CT
echo off
echo %DEL% > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
:ToLC
FOR %%i IN ("A=a" "B=b" "C=c" "D=d" "E=e" "F=f" "G=g" "H=h" "I=i" "J=j" "K=k" "L=l" "M=m" "N=n" "O=o" "P=p" "Q=q" "R=r" "S=s" "T=t" "U=u" "V=v" "W=w" "X=x" "Y=y" "Z=z") DO (
  CALL SET "%~1=!%~1:%%~i!"
)
goto :eof
:ToUC
FOR %%i IN ("a=A" "b=B" "c=C" "d=D" "e=E" "f=F" "g=G" "h=H" "i=I" "j=J" "k=K" "l=L" "m=M" "n=N" "o=O" "p=P" "q=Q" "r=R" "s=S" "t=T" "u=U" "v=V" "w=W" "x=X" "y=Y" "z=Z") DO (
  CALL SET "%~1=!%~1:%%~i!"
)
goto :eof