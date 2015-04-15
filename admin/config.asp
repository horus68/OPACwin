<%
 vdir = "/" & Split(Request.ServerVariables("SCRIPT_NAME"), "/")(1)  
 host=  Request.ServerVariables("server_name")
 porta= Request.ServerVariables("server_port")
 strROOT = "http://" & host 
 if porta <>"80" then strROOT = strROOT & ":" & porta
 strROOT = strROOT & vdir
 sentidade = ReadIniFile(Server.MapPath( vdir & "/cgi/cgi.ini"), "GERAL", "entidade")
 stitulo = ReadIniFile(Server.MapPath( vdir & "/cgi/cgi.ini"), "PORTAL", "titulo")
 slogo = ReadIniFile(Server.MapPath( vdir & "/cgi/cgi.ini"), "PORTAL", "imglogo")
%>