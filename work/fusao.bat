@echo off
cls
setlocal
set t0=%time: =0%
set ERRORLEVEL=0
set /a h=1%t0:~0,2%-100
set /a m=1%t0:~3,2%-100
set /a s=1%t0:~6,2%-100
set /a c=1%t0:~9,2%-100
set /a starttime = %h% * 360000 + %m% * 6000 + 100 * %s% + %c%
set /a LOGDATE = %date:~-4,4%%date:~-7,2%%date:~-10,2%
set BASESPATH=..\..\bases\
set CGIPATH=..\..\cgi\
set WTMPPATH=..\..\work\tmp\
set LOGSPATH=..\..\upload\logs\
set DBTMPPATH=..\basestmp\
set ISOSPATH=..\..\upload\isos\
cd utils
del /Q %DBTMPPATH%*.* >nul
mx %BASESPATH%_cnf "pft=@.\getdb.pft" now > ..\database.lst
echo ******** FusÆo das bases bibliogr ficas ********
echo ************************************************
echo In¡cio da rotina: %t0% [%LOGDATE%]
echo ******** Fusão das bases bibliográficas ******** >> %LOGSPATH%log_"%LOGDATE%".txt
echo ************************************************ >> %LOGSPATH%log_"%LOGDATE%".txt
echo Início da rotina: %t0% [%LOGDATE%] >> %LOGSPATH%log_%LOGDATE%.txt
echo Tratamento dos ficheiros ISO2709
mx null "pft=@.\dbdef.pft" count=1 now > %CGIPATH%dbdef.cip
mx %BASESPATH%_cnf "pft=@.\cipar.pft" now >> %CGIPATH%dbdef.cip
mx %BASESPATH%users "pft=@.\cipar1.pft" now >> %CGIPATH%dbdef.cip
mx %BASESPATH%users "pft=@.\mkisodb.pft" now > .\mkisodb.bat
call .\mkisodb.bat 
mx %BASESPATH%users "pft=@.\mkdblst.pft" now > .\mkdblst.bat
call .\mkdblst.bat
mx null "pft=@.\mkcatlg.pft" count=1 now > .\mkcatlg.bat
call .\mkcatlg.bat 
del .\mk*.bat > nul
del %WTMPPATH%*.tmp > nul
del %WTMPPATH%tmp_*.* > nul
set t=%time: =0%
echo Fim da rotina: %t% [%LOGDATE%]
echo Fim da rotina: %t% [%LOGDATE%] >> %LOGSPATH%log_%LOGDATE%.txt
set /a h=1%t:~0,2%-100
set /a m=1%t:~3,2%-100
set /a s=1%t:~6,2%-100
set /a c=1%t:~9,2%-100
set /a endtime = %h% * 360000 + %m% * 6000 + 100 * %s% + %c%
if %endtime% lss %starttime%  set /a endtime = %endtime% + 8640000 
set /a runtime = %endtime% - %starttime%
set runtime = %s%.%c%
set /a qs = %runtime% / 100
set /a mse = %runtime% - %qs% * 100
set /a qm = %qs% / 60
set /a se = %qs% - %qm% * 60
set /a he = %qm% / 60
set /a me = %qm% - %he% * 60
echo Tempo de execução: %he%h:%me%m:%se%s,%mse%0ms  >> %LOGSPATH%log_%LOGDATE%.txt
set BASESPATH=
set CGIPATH=
set WTMPPATH=
set LOGSPATH=
set DBTMPPATH=
set ISOSPATH=
cd ..
:FIM

