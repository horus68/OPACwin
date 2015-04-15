<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
  tmp=split(request("exp")," ") 
  chk="AND,OR,NOT,$,+,-,PCH,AS,AU,TI,COL,ED,SI,DP,LED,O,A,OS,AS,UM,UMA,UNS,UMAS,DE,DO,DA,DOS,DAS,NO,NA,NOS,NAS,POR,PARA,COM,SI,CT,CDU,"
  Set fso = CreateObject("Scripting.fileSystemObject")
  Set file = fso.OpenTextFile (Server.MapPath(vdir & "/upload/logs/words.lst"), 8,True,0)
  for i=0 to ubound(tmp)
      if instr(chk,ucase(tmp(i))&",") =0 then
      'file.writeline lcase(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(replace(tmp(i),")",""),"(",""),"$",""),"PCH",""),"AS",""),"TI",""),"AU",""),"COL",""),"ED",""),"SI",""),"and",""))
      file.writeline lcase(replace(replace(replace(replace(tmp(i),")",""),"(",""),"$",""),"-",""))
	  end if
  next
  file.close
  set fso=nothing 

   
%>