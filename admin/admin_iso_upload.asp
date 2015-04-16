<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<link type="text/css" rel="stylesheet" href="../css/default.css" title="styles" />
<script language="JavaScript">
var flag=false;
var ob;
function fechar(){
if (flag)
{
clearTimeout(ob);
  window.close(); 
}
else {
	  flag=true;
	  ob=setTimeout("fechar()",3000); 
	  }
}
</script>
<script language="JavaScript">
function validar(user){
  var s=document.getElementById("FILE1").value;
  var pos= s.lastIndexOf('.');
  var fext= s.substring(pos+1);
  fext=fext.toUpperCase();
  var posi= s.lastIndexOf('\\');

  s= s.substring(posi+1,pos);
  s= s.toUpperCase();
  if (s=="")  { alert("O campo NOME do ficheiro não pode ficar vazio! \nUtilize o botão PROCURAR e repita a operação."); return false;}
  
  if (fext=='ISO')
  {
	  
	  if (s != user) 
	  {
		  var r=confirm("O sistema detetou que o nome do ficheiro ISO não confere com o nome do UTILIZADOR atual.\nATENÇÃO: O ficheiro ISO não será processado. \nTem a certeza que pretende continuar?")
		  if (r==true) return true; else return false;
	  }
  }
}
</script>
<style>
 td {font-size: 1em}
 td.fecho{font-size: 0.9em}
 body {margin-left:15px;margin-top:10px}
</style>
<%	If Session("LoggedIn") = True Then 
%>
		<!--estava aqui o topo da página-->

<%		If Request.QueryString("mode") = "doit" Then
			Server.ScriptTimeout = 1200		
			flag = UploadFile("iso")		
            response.write "<br><h3>Envio de ficheiros em formato ISO</h3>"
			If Flag = "None"  or Flag="ErroTipo" or Flag="ErroNome" or Flag="Existe" Then
			    Response.Write "<br><p align='center'>Não foi possível carregar o documento!<br>"
				select case Flag
									
					case "ErroTipo"
						Response.Write("<p align='center'>Erro: Tipo de ficheiro não permitido.<br>")				
					case "ErroNome"
					    Response.Write("<p align='center'>Erro: O nome do ficheiro tem de coincidir com a SIGLA do utilizador.<br>")				
					case "Existe"
						Response.Write("<p align='center'>Erro: O ficheiro já existe!<br>")				

				end select						
				Response.Write("<p align='center'>Use o botão Retroceder do Browser para tentar de novo ou clique <a  href='javascript:history.go(-1)'>aqui</a>!</p>")				
			Else			
				If Request.QueryString("window") = "yes" Then			
					Response.Write("<br><p align='center'>O documento foi carregado com successo. <a  href='#' onClick='window.close();'>Clique aqui para fechar a janela</a>!</p>")
					if right(trim(Flag),2)="on" then response.write "<script>fechar()</script>"
				Else				
					Response.Write("<br><p align='center'>O documento foi carregado com successo. <a  href='admin_home.asp'>Clique aqui para continuar</a>!</p>")
					Response.Write("<meta http-equiv='Refresh' content='1; URL=admin.asp'>")					
				End If													
			End If							
		Else
		%>
		</head>
		<body >
			<form id="frmupload" action="upload.asp" onsubmit="return validar('<%=session("user")%>')">

	

			    <table  border="0" width="100%" cellspacing="1" cellpadding="4">
			      <tr>
			        <td   colspan="2">
			          <b>Envio de ficheiros em formato ISO</b></td>				        
			      </tr>
			      <tr>
			        <td colspan="2" valign="top">
			          <b>Indique o nome do ficheiro (incluindo o caminho)</b>
			        </td>
			      </tr>
				  <tr>
				    <td valign="top" >Documento:
					</td>
					<td valign="top">
					  <input type="file" id="FILE1" name="FILE1" size="54">
					</td>
			      </tr>			      
			      <tr>			
					<td valign="top" align="center" colspan="2">
					  <input type="submit" value="Enviar">			
				    </td>
				  </tr>
				  <tr>
				     <td colspan=2 class="fecho"><input id="chkfecho" name="chkfecho" type="checkbox" checked> Fechar janela após conclusão da transferência</td>
				  </tr>
				   	
				  <tr>
				    <td   align="right" colspan="2">
						    
				      <% If Request.QueryString("window") = "yes" Then %>
						      
				        <a   href="#" onClick="window.close();">Fechar janela</a>
						        
				      <% Else %>
								
						<a   href="admin_home.asp">Voltar ao menu</a>
								
						<% End If %>
							  
				    </td>
				  </tr>				  			  		      				  			  		      
			    </table>
			
			</form>
	    </body>
<%		End if
 	Else  
	        %>
 <div id="upload"> 
  <img src="../imagens/logotipo.png">
  <br><br><br>
  <h3>Atenção! A sua sessão expirou!!!</h3>
  <p><%=session("nome")%></p>
  <p></p>
  <p>Por esse motivo terá que voltar a entrar no sistema para realizar a operação solicitada.</p>
   <script>   
		fechar();
    </script>
  </div>
 <%end if %>
		
