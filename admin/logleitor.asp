<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->

<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=stitulo%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %> 
<% Response.Expires = -1 %>
<!--#include file="md5.asp"-->
<link type="text/css" rel="stylesheet" href="../css/default.css" >
<![if !IE]>
<link type="text/css" rel="stylesheet" href="../css/default1.css"/>
<![endif]>
<script type="text/javascript" src="../js/md5.js"></script>
<script type="text/javascript" src="../js/rc4.js"></script>
<script type="text/javascript" src="../js/prototype.js"></script>
<script type="text/javascript">
<!--
function removeacento(texto){
var car,i,dim,p,linha_out="";
var trocarIsso = "àáâãäåçèéêëìíîïñòóôõöùüúÿÀÁÂÃÄÅÇÈÉÊËÌÍÎÏÑÒÓÔÕÖOÙÜÚŸ";
var porIsso    = "aaaaaaceeeeiiiinooooouuuyAAAAAACEEEEIIIINOOOOO0UUUY";
dim=texto.length;
for(i=0;i<dim;i++)
     {
       car=texto.charAt(i);
	   p=trocarIsso.lastIndexOf(car);

       car=(p>=0)?porIsso.charAt(p):car;
       linha_out=unescape(linha_out + car);
     }
  return(linha_out);

}

function addElement(s,n)
{

		window.opener.parent.parent.document.getElementById("utilizador").innerHTML=removeacento(s);
		window.opener.parent.parent.document.getElementById("basket").style.display="";
		var temp=window.opener.parent.parent.location.href.replace(/ut=guest/,"ut="+removeacento(s));
		
		temp=temp.replace(/nut=/,"nut="+n);
		//window.opener.parent.parent.location.hash=unescape(temp);
		window.opener.parent.parent.location.href=unescape(temp);
		
}
function refreshParent() {
  window.opener.location.href = window.opener.location.href;

  if (window.opener.progressWindow)
		
 {
    window.opener.progressWindow.close()
  }
  window.close();
}


//-->
</script>
<% Function writeLog (str) 
            Dim objFSO, objTStream
			on error resume next
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			Set objTStream = objFSO.openTextFile(Server.MapPath(vdir &"/upload/logs/admin.log"), 8, True)
			dia=day(now)
			mes=month(now)
			ano=year(now)
			hora=hour(now)
			minuto=minute(now)
			segundo= second(now)
			if len(segundo)=1 then segundo= "0" & segundo
			linha = dia & "-" & mes & "-" & ano & ";" & hora & ":" & minuto & ":" & segundo  & ";" & str
			objTStream.WriteLine linha & " [" & Request.ServerVariables("Remote_Addr") & "]" 
			objTStream.Close
			Set objTStream = nothing
			Set objFSO = nothing
			on error goto 0
	
 End Function 
 
Function log_erro(msg)
    on error resume next
    strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getmailusr.in]?expressao=SIGLA ADMIN&r=" & rnd())
	writeLog("LOGIN (insucesso) - Leitor:" & ucase(nu) & msg )
	response.write "<p>&nbsp;</p>"						 
	response.write "<h4 style=""font: 9pt Verdana;color:red"">Acesso negado. O leitor não tem acesso ao sistema...</h3>"
	response.write "<p style=""font: 8pt Verdana"">Mensagem:" & msg & "</p>"
	response.write "<p style=""font: 8pt Verdana"">Contacte o administrador em " & strHTML & "</p>"
	'Session("LogError")=Session("LogError")+1        
	response.write "<div align=""right"" style=""font: 8pt Verdana;margin-right:10px""><a href=""javascript:window.self.close();"" >Fechar</a></div>"
	on error goto 0
end function


if request("op")="vp" then

      if not session("LeitorIn") then
	           response.write "<br><br>"
			   response.write "<center><h3 class=""aviso"">AVISO</h3></center> " 
			   response.write "<p style=""font:10pt bold Arial"">Não é possível continuar...A sua sessão expirou!</p>"
			   response.write "<div align=""right""> » <a style=""font:10pt bold Arial"" href=""javascript:window.self.close();"">Fechar</a> &nbsp;</div>"
			   response.End 
			
      end if
 
	  metodo = Request.ServerVariables("REQUEST_METHOD")  
	  if metodo = "POST" then  
			op = trim(Server.HTMLEncode(Replace(Request.Form("oldpin"),"'","''"))) 
			np = trim(Server.HTMLEncode(Replace(Request.Form("novopin"),"'","''")))
									
			strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getpin.in]?expressao=NL " & trim(session("nuser")))
			avalores=split(strHTML,",")
			'response.write RC4(np) & "<br>"
			'response.write md5(avalores(1))
			'response.write avalores(0) & "<br>"
		    'response.write np 
			'response.end
			if strcomp(md5(avalores(1)), op,0)=0 then 
	
				strHTML=getUrl(strROOT & "/cgi/www.exe/[in=savepin.in]?v11=" & np & "&from=" & avalores(0))
				strHTML=OnlyAlphaNumericChars(Server.HTMLEncode(strHTML)) 
				if strHTML="Erro" then				    
					response.write "<p style=""margin-top:55px"">Ocorreu um erro durante a alteração do PIN!</p>"
				else
				   response.write "<p style=""margin-top:55px"">A alteração do PIN foi concluída com sucesso!</p>"
				end if
				response.write "<p>&nbsp;</p><div align=""right"" style=""font: 9pt Verdana""><a href=""javascript:window.self.close();"" >Fechar</a>&nbsp&nbsp;</div>"
				response.end   
			else 
			   response.write "<br><br>"
			   response.write "<center><h3 class=""aviso"">AVISO</h3></center> " 
			   response.write "<p style=""font:10pt bold Arial"">O PIN anterior não confere com o valor guardado.</p>"
			   response.write "O PIN do leitor mantém-se inalterado..."
			   response.write "<div align=""right""> » <a style=""font:10pt bold Arial "" href=""javascript:history.back()"">Voltar</a> &nbsp;</div>"
			   response.End
			end if    
			
		end if	
		
end if
If Session("LogError") < 3 Then			
	If Request.QueryString("Login") = "1" Then
		      
		  dim nm, pw, metodo  
		  metodo = Request.ServerVariables("REQUEST_METHOD")  
		  if metodo = "POST" then  
				nut=ucase(Server.HTMLEncode(Replace(Request.Form("utilizador"),"'","''"))) 
				pin = trim(lcase(Server.HTMLEncode(Replace(Request.Form("pin"),"'","''"))))
				randomize
				strHTML=getUrl(strROOT & "/cgi/www.exe/[in=pinlt.in]?expressao=NL " & nut & "&r=" & rnd())
				registo= split(strHTML,"%%")
				'response.write strHTML 
				'response.end
				if ubound(registo)>0  then
				    temp="0"
					if registo(2)=0 then 
						log_erro "- DESATIVADO - " & registo(3) 
						response.end
					else
						strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getlt.in]?expressao=NR " & nut &  "&r=" & rnd())
                        if strHTML="" then 
						     log_erro "Este utilizador não está registado na base de leitores!"
							 response.End
						end if	 
						nomelt= left(strHTML,len(strHTML)-2)
						
					end if	
				else
					log_erro "Por favor, verifique os dados introduzidos."
					response.end
				end if 							
				Set objXmlHttp = Nothing						
	  
			    if strcomp(pin,md5(registo(1)),0)=0 and trim(nomelt)<>"" then
				  
					Session("LeitorIn") = True
					Session("nuser")=nut
					anomes=split(nomelt)
					nomelt=""
					chave="de,da,do,dos,das"
					for i=0 to ubound(anomes)
                        if instr(chave, trim(anomes(i)))=0 then 					
					   		nomelt=nomelt & iif( i>1 and i<ubound(anomes) , mid(anomes(i),1,1) & ". ", anomes(i) & " ")
					    end if		 
					next
					Session("user")= nomelt
					session("entidade")=bib
					'response.write nomelt & "<br>"
					'response.write bib & "<br>"
					'response.end
					writeLog("LOGIN (sucesso) - " & nut & ":" & ucase(session("user"))) 
				        
							%><script>refreshParent();</script><%
				else
				
				   Session("LeitorIn") = false   
				   session("user")=""
				   session("nuser")=""
				
				end if     
				if not Session("LeitorIn") then
				   writeLog("LOGIN (insucesso) - " & ucase(nut)) 
				   response.write "<p>&nbsp;</p><p>&nbsp;</p>"
				   Response.Write("<p align=""center"">Dados incorretos. Por favor <a href=""logLeitor.asp"">tente novamente</a>.</p>")
				   Session("LogError")=Session("LogError")+1        
				end if
			end if	
   else

		%>
		<head>
		 <title>Leitor - entrada no sistema</title>
    <link rel="icon" href="../favicon.ico" type="image/ico"/>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
		</head>
		<body onLoad="window.focus();" style="margin-left:30px;text-align:left">
		<%
		if request("op")="ap" and session("LeitorIn") then
		%>
		<br>
		<p style="font: bold 10pt Arial ">Leitores - alteração do código PIN</p>
		<form name="Login" action="logleitor.asp?op=vp" method="post" onSubmit="oldpin.value = hex_md5(oldpin.value);novopin.value = novopin.value;">
		<input type="hidden" name="reqPath" value="<%=server.URLEncode(replace(replace(replace(request.ServerVariables("HTTP_REFERER"),"%5B","["),"%5D","]"),"%3D","="))%>">
		<table style="font: 9pt Arial"  border="0" cellpadding="1" cellspacing="0" >					 
		  <tr>									
			<td  valign="middle">PIN anterior: </td>
			<td valign="middle"> <input type="password" name="oldpin" size="10"></td>
			<td width="20">&nbsp;</td>												
			<td  valign="middle">Novo PIN:</td>
			<td > <input  type="password" name="novopin" size="10"></td>					
		  </tr> 					  					 
		</table> 
		 <br> <div align="center"><input style="font: 9pt Arial" type="submit" value="Confirmar" onClick="return novopin.value!=''"></div>
		</form>
		<div align="right" style="font: 9pt Arial"><a href="javascript:window.self.close();" >Fechar</a>&nbsp; </div>  		      
		
		<% else %>
		<br>
		<p style="font: bold 10pt Arial ">Leitores - acesso ao sistema</p>
		<form name="Login" action="logLeitor.asp?Login=1" method="post" onSubmit="pin.value = hex_md5(pin.value);">
		<input type="hidden" name="reqPath" value="<%=server.URLEncode(replace(replace(replace(request.ServerVariables("HTTP_REFERER"),"%5B","["),"%5D","]"),"%3D","="))%>">
		<table style="font: 9pt Arial"  border="0" cellpadding="1" cellspacing="0" >					 
		  <tr>									
			<td  valign="middle"> Nº de leitor: </td>
			<td valign="middle"> <input type="text" name="utilizador" size="10"></td>					
		     <td width="40"></td>								
			 <td  valign="middle">PIN:</td>
			 <td > <input  type="password" name="pin" size="10"></td>					
		  </tr> 					  									
		</table>
		<br><div align="center"> <input type="submit" value="Entrada" onClick="return (pin.value!='')"></div>
		</form>
		<div align="right" style="font: 9pt Arial"><a href="javascript:window.self.close();" >Fechar</a> &nbsp;</div>  		      
		<% end if %>
		</body>
<% end if
Else
		writeLog("LOGIN (insucesso): nº máx de tentativas")
		Response.Write("<br /><p>&nbsp;</p><p>Esgotou as três tentativas de ENTRADA. <br />Terá de fechar esta janela e iniciar nova sessão!</p>")
	
End If

%>
<%
Public Function OnlyAlphaNumericChars(ByVal OrigString)
'***********************************************************
'INPUT:  Any String
'OUTPUT: The Input String with all non-alphanumeric characters 
'        removed
'EXAMPLE Debug.Print OnlyAlphaNumericChars("Hello World!")
         'output = "HelloWorld")
'NOTES:  Not optimized for speed and will run slow on long
'        strings.  If you plan on using long strings, consider 
'        using alternative method of appending to output string,
'        such as the method at
'        http://www.freevbcode.com/ShowCode.Asp?ID=154
'***********************************************************
    Dim lLen
    Dim sAns 
    Dim lCtr     
	Dim sChar
    
    OrigString = Trim(OrigString)
    lLen = Len(OrigString)
    For lCtr = 1 To lLen
        sChar = Mid(OrigString, lCtr, 1)
        If (Mid(OrigString, lCtr, 1) >="0" and Mid(OrigString, lCtr, 1) <="9") or (Mid(OrigString, lCtr, 1) >="a" and Mid(OrigString, lCtr, 1) <="z") Then
            sAns = sAns & sChar
        End If
   
    Next
        
    OnlyAlphaNumericChars = sAns

End Function



%>
