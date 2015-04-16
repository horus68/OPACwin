<% 
    myUA = Request.ServerVariables("HTTP_USER_AGENT") 
    ua = lcase(myUA)  
	Response.Write uA & "<br />" 
	vdir = "/" & Split(Request.ServerVariables("SCRIPT_NAME"), "/")(1)  
	host=  Request.ServerVariables("server_name")
	porta= Request.ServerVariables("server_port")
	strROOT = "http://" & host 
	if porta <>"80" then strROOT = strROOT & ":" & porta 
	strROOT = strROOT & vdir
	response.write strROOT & "<br />" 
	response.write Server.MapPath(vdir) & "<br />" 
	response.write(Request.ServerVariables("SERVER_SOFTWARE"))
%>
