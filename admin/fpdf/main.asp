<%@language=vbscript%>
<!--#include file="fpdf.asp"-->
<head>
<title>Lista de siglas</title>
</head>
<%
vdir = "/" & Split(Request.ServerVariables("SCRIPT_NAME"), "/")(1)  
host=  Request.ServerVariables("server_name")
porta= Request.ServerVariables("server_port")
strROOT = "http://" & host 
if porta <>"80" then strROOT = strROOT & ":" & porta
strROOT = strROOT & vdir
Dim i,pdf
Dim objXmlHttp
Dim strHTML
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=relusersB.in]", False
objXmlHttp.send
strHTML = objXmlHttp.responseText
entidades=split(strHTML,vbcrlf)
 
Set pdf=CreateJsObject("FPDF")
pdf.CreatePDF()
pdf.SetPath("fpdf/")
pdf.SetFont "Arial","",16
pdf.Open()
pdf.LoadModels("basico") 
tabela="Morada,Concelho,Cod. Postal,Telefone,Fax,Email,Pag. Web,Coord"
tt=split(tabela,",")
pdf.AddPage()
for i=0 to ubound(entidades)-1
   user=split(entidades(i),"%")
   s=""
   for j=2 to ubound(user)-1
      if user(j)<>"" then
       s=s+tt(j-2)+ " : "+user(j)+vbcrlf
	  end if 
   next
   pdf.PrintChapter user(0)+" : "+user(1), user(ubound(user)), s
   
next
pdf.Output()

 


%>


