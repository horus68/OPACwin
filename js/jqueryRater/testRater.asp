<%
		if Request.QueryString("error") = "true" then
			response.write "Error rating entry! This is a simulated error message created at the server."
        else
		rating = 7 + CDbl(Request.Form("rating"))
		result = rating / 3
		response.write result
		end if
%>