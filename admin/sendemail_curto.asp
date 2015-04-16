<!--#include file="functions.asp"--> 
<%  
assunto=Request.QueryString("assunto")
remetente=request.QueryString("Email")					
destinatario=Request.QueryString("destino")
mensagem= Request.QueryString("mensagem") & "<br><br>Remetido por:" & "<b>" & ucase(remetente) & "</b>" 
'response.write assunto & "<br>"
'response.write remetente & "<br>"
'response.write destinatario & "<br>"
'response.write mensagem & "<br>"			
'response.end
if SendMail(assunto, remetente, destinatario, mensagem) then
    response.Charset="ISO-8859-1"
	response.write "<center>"
    response.write "AVISO de " & assunto & " enviado com sucesso...[email: " & destinatario & "]"
	response.write "</center>"
else
    response.write "FALHOU o envio do aviso de " & assunto & " [email: " & destinatario & "]"
end if

%>
