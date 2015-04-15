<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
referer=request.servervariables("http_referer") 
'if referer = "" then  
'   response.end
'end if
ip = Request.ServerVariables("REMOTE_ADDR")
strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getrates.in]?expr=MFN " & replace(request("expr"),"@@","") & "&ip=true" )
tabela=split(strHTML,",")
flag=false
if ubound(tabela)>1 then
  nreg=tabela(0)
  if ip=tabela(1) then flag=true
end if

'if not flag then
 if strHTML<>"" then
    getUrl(strROOT & "/cgi/www.exe/[in=updrates.in]?ip="+ip+"&mfn=" & nreg & "&voto=" & request("rating"))
 else
    tmp=split(request("expr"),"@@") 
    getUrl(strROOT & "/cgi/www.exe/[in=rates.in]?ip="+ip+"&expr1=" & tmp(0) & "&expr2=" & tmp(1) & "&voto=" & request("rating"))
	
 end if
 if ubound(tabela)>0 then 
   nvotos= Clng(tabela(3))+1
   vacum= Clng(tabela(2))   
 else 
   nvotos=1
   vacum=0
 end if  
 
 response.write (vacum+Clng(request("rating"))) & "#" & nvotos 
'else
'  response.write flag
'end if  
%>
