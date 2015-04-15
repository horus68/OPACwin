<!--#include file="functions.asp"-->
<body style="text-align:center">
<div style="margin:0 auto">
   A enviar a mensagem de correio electrónico ...
</div>
<%  

assunto=Request("assunto")
remetente=request("Email")					
destinatario=Request("destino")
mensagem=Request("comentario") & "<br>" & Request("mensagem") & "<br><br>Remetido por:" & "<b>" & ucase(remetente) & "</b>" 			
if SendMail(assunto, remetente, destinatario, mensagem) Then
     if request("flag")="true" then 					
	     response.write "<script>window.resizeTo(0,0);alert('E-mail enviado com sucesso.');window.close();</script>" 				
     else   		  
	     response.write "<script>window.resizeTo(0,0);window.close();opener.window.alert('E-mail enviado com sucesso.');opener.window.close();</script>" 				
	 end if
 else 
     if request("flag")="true" then					
	      response.write "Lamentamos, mas ocorreu um erro ao enviar o e-mail."
     else   		  
         response.write "<script>window.resizeTo(0,0);window.close();opener.window.alert('Ocorreu um erro! Lamentamos, mas o seu pedido não foi enviado.');opener.window.close();</script>" 
     end if 
end if
%>
</body>