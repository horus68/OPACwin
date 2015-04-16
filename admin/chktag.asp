<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
  response.charset="iso-8859-1"
  strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chktags.in]?expr="& server.urlencode(request("tag")&"##"&replace(request("mfn"),"@@",""))&"&d=" &now())
  if strHTML<>"" then
     valores=split(strHTML,",")
	 if valores(1) <> request("ltr") then
        response.redirect "/opac/cgi/www.exe/[in=updtags.in]?ip="&request("ip")&"&ltr="&request("ltr")&"&from=" &strHTML
	 end if
  else
     tmp=split(request("mfn"),"@@")   
     response.redirect "/opac/cgi/www.exe/[in=newtag.in]?tag="& server.urlencode(request("tag"))&"&ip="&request("ip")&"&expr1="&tmp(0)&"&expr2="&tmp(1)&"&leitor="&request("ltr")&"&mfn="&request("nreg")
  end if
  response.write "<head><meta http-equiv=""refresh"" content=""2;URL=vertags.asp?user="& request("ltr")& "&mfn=" & server.urlencode( request("mfn")) & "&nreg=" & request("nreg")&"""></head>"
  response.write "<link href=""../css/default.css"" rel=""stylesheet"" type=""text/css"" />"
  response.write "<![if !IE]>"
  response.write "<link href=""../css/default1.css"" rel=""stylesheet"" type=""text/css"" />"
  response.write "<![endif]>"
  response.write "</head>"
  response.write "<body><p class=""aviso"" style=""margin-top: 100px"">ATENÇÃO: A etiqueta introduzida já existe</p></body>"

%>
