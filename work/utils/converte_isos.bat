@echo off
if "%3%"=="Porbase" goto PB
if "%3%"=="Docbase" goto DBI
if "%3%"=="mrc" goto MC
if "%4%"=="ansi"  goto NEXT
mx iso=%1 iso=%2 gizmo=gpbmrc now -all
goto FIM
:NEXT
mx iso=%1 iso=%2 gizmo=gpbmrc gizmo=gans850 now -all
goto FIM
:MC
if "%4%"=="ascii" goto MC1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc gizmo=gans850  now -all
goto FIM
:MC1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc now -all
goto FIM
:PB
if "%4%"=="ascii" goto PB1 
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  gizmo=gans850  isotag1=915 now -all
goto FIM
:PB1
mx iso=marc=%1 iso=%2  gizmo=gpbmrc  isotag1=915 now -all
goto FIM
:DBI
if "%4%"=="ansi" goto DB1 
mx iso=%1  gizmo=gpbmrc  proc=@docb.prc iso=%2 -all now
goto FIM
:DB1
mx iso=%1  gizmo=gpbmrc  gizmo=gans850 proc=@docb.prc iso=%2 -all now
:FIM