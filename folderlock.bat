@ECHO OFF
title Folder Locker

if EXIST "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" goto UNLOCK
if NOT EXIST Locker goto MDLOCKER

:CONFIRM
echo Deseja bloquear a pasta Locker (Y/N)
set/p "cho=>"

if %cho%==Y goto LOCK
if %cho%==y goto LOCK
if %cho%==n goto END
if %cho%==N goto END

echo Invalid choice.
timeout 1
goto :CONFIRM

:LOCK

ren Locker "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
attrib +h +s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
echo Folder locked
goto :End

:UNLOCK
CLS
:HInput
::Version 3.0     
SetLocal DisableDelayedExpansion
Echo Entre com sua senha:
Set pass=
Rem Save 0x08 character in BS variable
For /F %%# In (
'"Prompt;$H&For %%# in (1) Do Rem"'
) Do Set "BS=%%#"

:HILoop
Set "Key="
For /F "delims=" %%# In (
'Xcopy /L /W "%~f0" "%~f0" 2^>Nul'
) Do If Not Defined Key Set "Key=%%#"
Set "Key=%Key:~-1%"
SetLocal EnableDelayedExpansion
If Not Defined Key Goto :HIEnd
If %BS%==^%Key% (Set /P "=%BS% %BS%" <Nul
Set "Key="
If Defined pass Set "pass=!pass:~0,-1!"
) Else Set /P "=*" <Nul
If Not Defined pass (EndLocal &Set "pass=%Key%"
) Else For /F delims^=^ eol^= %%# In (
"!pass!") Do EndLocal &Set "pass=%%#%Key%"
Goto :HILoop
:HIEnd
Echo.
Echo Sua senha eh: "%pass%"

IF NOT "%pass%"=="123" GOTO :FAIL

attrib -h -s "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}"
ren "Control Panel.{21EC2020-3AEA-1069-A2DD-08002B30309D}" Locker
echo Pasta desbloqueada com sucesso!

GOTO :End

:FAIL
echo Senha Errada
timeout 1
goto :UNLOCK

:MDLOCKER

md Locker

echo Pasta Locker criada com sucesso!

timeout 5

goto :End

:End
