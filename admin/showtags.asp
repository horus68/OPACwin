<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
  response.charset="iso-8859-1"
  strHTML=getUrl(strROOT & "/cgi/www.exe/[in=gettags.in]?expr="& request("expr"))
  tmp=split(strHTML,",")
  strHTML=""
  for i=0 to ubound(tmp)-1 step 2
     strHTML= strHTML & tmp(i) & ","
  next
  response.write strHTML
  
%>
