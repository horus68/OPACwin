<!--#include file="functions.asp"-->
<%
    response.write md5(session.sessionID)
%>