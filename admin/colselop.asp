<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="robots" content="follow,index" />
	<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	<title><%=stitulo%></title>	
	<link href="../css/default.css" rel="stylesheet" type="text/css" />
   <![if !IE]>
	<link href="../css/default1.css" rel="stylesheet" type="text/css" />
	<![endif]>
	<script type="text/javascript" src="../js/users.js"></script>
</head>
<body>
   <h3><span>Gestão da coleção</span></h3>  
    <div id="principal"> 
	  <div id="lblutilizador">Utilizador: <span id="utilizador"> 	 
		     <% if session("user")="" then response.write "anónimo" else response.write ucase(session("user")) end if%><%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]<%end if%>
      </span> 
	  </div>
	   <p class="fil">	    
	    » <a href="../default.asp">Início</a> » <a href="admin.asp?id=3">Administração</a> » Avaliação das existências
		<div id="admbotoes" style="float:right"><a href="admin.asp?id=3"><img src="../imagens/close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a></div><h3>Avaliação das existências</h3>
	   <div style="border:solid 1px #999">
	     <%Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
			objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getuser.in]?expressao=SIGLA " & ucase(request("users")), False
			objXmlHttp.send
			strHTML = objXmlHttp.responseText
			if strHTML<>"" then
			siglaEXT= mid(strHTML,1,len(strHTML)-2)
			end if
		 %>
		 <dl style="margin: 60px 0 80px 40px;">
		 <dt><% if request("criterio")="X" then  response.write "Toda a rede" else response.write "Instituição: " & ucase(request("users")) & " (" & siglaEXT & ")"  end if%></dt>
		 <form name="frmselcri" id="frmselcri" action="../cgi/www.exe/[in=gescol.in]" method="post" onSubmit="return false">  
		 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
		 <input type="hidden" id="base" name="base" value="<% =lcase(request("base"))  %>">
		 <input type="hidden" name="lim_inicio" value="1">
		 <input type="hidden" name="expressao" id="expressao" value="">
		 <input type="hidden" id="op" name="op" value="<% if request("users")<>"" then response.write lcase(request("users")) else response.write "X" end if %>">
		 <input type="hidden" name="entidade" id="expressao" value="<%=sentidade%>">
		 <br />
		 <dd>Selecione o critério: &nbsp; 
		 <select name="opges" id="opges">
				    <option value="" selected>Por palavra</option>
					<option value="AS" >Por assunto</option>
				   <option value="CDU">Por CDU</option>
				   <option value="AU">Por autor</option>
				   <option value="TI">Por título</option>
				   <option value="COL">Por coleção</option>
				  		     
		 </select> <input type="text" size="60" id="termo" "name="termo"> Exata: <input type="checkbox"  id="PFX" name="PFX">
		 </dd>
		 <dd>Registos por página: &nbsp;<input type="text" size="10" id="limites" name="limites" value="25"></dd><br><br>
	     <div align="center"><input type="button" value="Pesquisar"    onClick="getOpCol();return false;"></div>
		</form>
		</dl>
      </div>
	</div>
</body>
</html>	 		
