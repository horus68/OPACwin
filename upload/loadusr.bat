cls
@echo off
mx seq="%1.csv;" create=users now -all
mx %1 "proc='D.'" from=1 count=1 now -all copy=%1
call inverte %1