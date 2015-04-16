<%
    response.Charset= "iso-8859-1"
  	Dim objXmlHttp
	Dim strHTML
	Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
	objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getcodigo.in]", False
	objXmlHttp.setRequestHeader "Content-Type", "application/x-www-form-urlencoded; charset=utf-8"
	objXmlHttp.send
	
	'On Error Resume Next  

	'Wait for up to 15 seconds to receive the data.   
	If objXmlHttp.ReadyState <> 4 Then  
	  objXmlHttp.WaitForResponse 15   
	End If  
	  
	If (objXmlHttp.ReadyState <> 4) Or (objXmlHttp.Status <> 200) Then  
	  'Abort the request.   
	  objXmlHttp.Abort   
	  strHTML = "<p class=""aviso"">Servidor indisponível.<br>Não é possível continuar...</p>"
	  response.write strHTML
	  response.end   
	End if
    response.write  objXmlHttp.responseText
 
%>
