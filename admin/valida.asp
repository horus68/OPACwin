<%If Not Session("LoggedIn") = True  Then response.Redirect("admin.asp")%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
  strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getpar.in]")
  valores= split(strHTML,",")
%>
<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=stitulo%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<meta name="robots" content="follow,index" />
<link type="text/css" rel="stylesheet" href="../css/default.css" >
<![if !IE]>
<link type="text/css" rel="stylesheet" href="../css/default1.css"/>
<![endif]>
<style>
#users table th {color:#000; font-weight: bold; background-color: rgb(240,240,240)}
</style>
<script>
function filtrar (tipo)
{
   window.location.href="valida.asp?ut=<%=request("ut")%>&mnu=6&expressao=<%=request("expressao")%>&base=<%=request("base")%>&nregs=<%=request("nregs")%>&MFNde=<%=request("MFNde")%>&MFNate=<%=request("MFNate")%>&tipoerro="+tipo;
}
function ChkLinkHref(base,expressao)
{
   var loc="../cgi/www.exe/[in=vregisto.in]?base="+base+"&expressao="+expressao;
   var texto = "Visualização do registo";
   var janela =  "vregisto"; 
   popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=yes,width=500,height=300,left=100,top=50");
   ndoc=popup.document;
   ndoc.location.href=loc;
}

function correct(m,campo,base,expressao,texto)
{
   texto= texto.replace(/\^/g,"[$]");
   texto= texto.replace(/</g,"[menor]");
   texto= texto.replace(/>/g,"[maior]");
   var loc="../cgi/www.exe/[in=editreg.in]?base="+base+"&expressao="+expressao+"&campo="+campo+"&texto="+escape(texto)+"&ind="+m;
   var texto = "Edição do registo";
   var janela =  "edregisto"; 
   popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,width=510,height=330,left=100,top=50");
   ndoc=popup.document;
   ndoc.location.href=loc;
   if (window.focus) {popup.focus()} 

}
</script>
<body >    
<div id="principal"> 
 <div id="lblutilizador">Utilizador: <span id="utilizador">
        <% if session("user")="" then response.write "anónimo" else response.write ucase(session("user"))%><%if Session("LoggedIn") then%> &nbsp;[ <a href="admin.asp?Logout=1">Sair</a> ]<%else%> &nbsp;[ <a href="admin.asp">Entrar</a> ]<%end if%>
        </span> </div><p class="fil">» <a href="../default.asp">Início</a> » <a href="admin.asp?id=4">Administração</a> » Validação de registos
<div id="admbotoes" style="float:right"><a href="admin.asp?id=4"><img src="../imagens/close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a><a href="javascript:window.print()"><img src="../imagens/imprimir.gif" border=0 title="Imprimir lista de erros" alt="Imprimir lista de erros"></a></div><h3>Validação de registos: listagem de erros </h3>
<%		
			if request("MFNde")="" then desde= "1" else desde=request("MFNde")
			if request("MFNate")="" then ate=request("nregs") else ate=request("MFNate")
			strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chkregs.in]?base=" & request("base") & "&expressao=" & request("expressao") & "&lim_inicio=" & Clng(desde) & "&limites=" & Clng(ate) & "&tipo=" & request("tipoerro")) 
			call mostra_tabela  
			
		   	
	Sub mostra_tabela		
			Set fso = CreateObject("Scripting.FileSystemObject")    
			spath= server.MapPath(vdir) & "\tmp\erros.txt"
	          'response.write spath
			  'response.end   
			
			Set MyFile = fso.OpenTextFile(spath, 1)
			
			response.write "<span id=""toterros"" class=""aviso"" style=""float:right;font-size:9pt""></span><span style="";font-size:9pt"">[Base de dados: " & trim(ucase(request("base"))) & " - Critério de pesquisa: " & ucase(request("expressao")) & " MFN: [" & request("MFNde") & " - " & request("MFNate") & "]</span>"
			
			response.write "<table id=""users""><th align=""center"" width=""50"">MFN</th><th align=""center"" width=""600"">Erros: &nbsp;&nbsp;<span style=""color:black; font-weight:bold;"">0 - <a href=""javascript:void(0)"" onclick=""filtrar('')"">Todos</a></span>&nbsp;&nbsp;<span style=""color:red; font-weight:bold"">1</span><span> - <a href=""javascript:void(0)"" onclick=""filtrar('1')"">Crítico</a></span> &nbsp;<span style=""color:rgb(255,255,0); font-weight:bold""> 2</span><span> - <a href=""javascript:void(0)"" onclick=""filtrar('2')"">Importante</a></span> &nbsp;<span style=""color:green; font-weight:bold"">3</span> - <a href=""javascript:void(0)"" onclick=""filtrar('3')"">Sugestão</a></span></th>"	
            m=0
			Do While Not MyFile.AtEndOfStream
				strwork = MyFile.ReadLine
			'	response.write strwork & "<br>"
				areg= split(strwork,"|")
				if trim(areg(0))<>"" and trim(areg(1))<>"" then
					response.write "<tr>"		
				    response.write "<td width=""50"" align=""center"">"
					response.write "<a href=""javascript:ChkLinkHref(&quot;" & request("base") & "&quot;,&quot;" & areg(0) & "&quot;)"">" & areg(0) & "</a></td>"
					response.write "<td style=""border:none"">"
					response.write "<table width=""100%""><th>Campo</th><th>Tipo</th><th>Mensagem</th><th align=""center"">Acção</th>"
					for j=1 to ubound (areg)
			          if trim(areg(j))<>"" then
							if isnumeric(areg(j)) then
							    'if j>1 then response.write "<br>"						      		
								response.write "<tr><td width=""40"" align=""center""><span class=""aviso"" >" & areg(j) & "</span></td>" 
								
								j=j+1
								response.write "<td align=""center"">"
								select case areg(j)
								  case "1" 
								      response.write "<span style=""color:red; font-weight:bold"">"
								  case "2"
								      response.write "<span style=""color:rgb(255,179,26); font-weight:bold"">"
								  case "3"
								      response.write "<span style=""color:green; font-weight:bold"">"
								  case else
								      response.write "<span>"
							    end select
							    response.write  areg(j) & "</span></td>"
							else
							    m=m+1
							    response.write "<td width=""80%"">&middot; " & replace(replace(areg(j),"<","&lt;"),">","&gt;") & "(<span style='font-size:0.8em'><a href='http://purl.pt/734/1/bloco_" & left(areg(j-2),1) & ".html' target='_blank_'>Ver Manual Unimarc</a></span>)</td><td align=""center"">"
								if valores(5)="N" then  
								   response.write "<img src=""../imagens/confirmar_stop.jpg"" alt=""Corrigir erros"" border=""0""></td></tr>"
								else 
								    response.write "<a id=""acc" & m &""" href=""javascript:correct("&m&",&quot;"& areg(j-2) &"&quot;,&quot;" & request("base") &"&quot;,&quot;" & areg(0) & "&quot;,&quot;" & replace(replace(replace(areg(j),"<","&lt;"),">","&gt;"),chr(34),"#") & "&quot;)""><img src=""../imagens/confirmar.jpg"" alt=""Corrigir erros"" border=""0""></a></td></tr>"
								end if	    
							end if
					  end if
					  
					next	
					response.write "</table>"
					response.write "</td></tr>"
			    end if
			loop
			if m=0 then response.write "<tr height=""120px""><td class=""aviso"" colspan=""3"" align=""center"">Não foram encontrados registos...</td></tr>"
			response.write "</table>"
		
			 select case request("tipoerro")
			 case "1"
				  str="[tipo 1]"      
			 case "2"
				  str="[tipo 2]"
			 case "3"
			      str="[tipo 3]"	  
			 case else	  
				  str=""
			 end select
				 
			response.write "<script>document.getElementById('toterros').innerHTML='" & m & " erros " & str & "';</script>"		
			response.write "<p style=""text-align:center"">Encontrados " & m & " erros</p>"
			response.write "<br>"
	end sub		
			
%>	
				
	