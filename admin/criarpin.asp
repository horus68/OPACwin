<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta name="robots" content="follow,index" />
	<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	<title><%= sentidade %></title>	
	<link href="../css/default.css" rel="stylesheet" type="text/css" />
     <![if !IE]>
	<link href="../css/default1.css" rel="stylesheet" type="text/css" />
	<![endif]>
<script language="JavaScript" src="../js/tools.js"></script>
</head>
<body>
      <h3><span>Definição de permissões</span></h3>
      <script>
       function validadados() {
       var status=true;
       var msgconf="";
       var msg="";
       document.getElementById("activo").value= document.getElementById("v121").checked ? "1": "0";
       if (document.getElementById("v11").value=="")
        {msg= "O campo PIN é de preenchimento obrigatório."; status=false;}
       if (!status) alert ("ATENÇÂO! Existem erros no preenchimento do formulário.\n\n" + msg);
        return status;
       }
	   
       function voltar(){
        var str="<%=REQUEST("expressao")%>";
       nreg = str.replace(/[a-zA-Z]/g,"");
       bib = str.replace(/[0-9]/g,"");
       window.location.href= "../cgi/www.exe/[in=pleitor.in]?ut=<%= session("user") %>&expressao="+nreg+bib;
       }
      </script>
      <div id="principal">
      <div id="lblutilizador">Utilizador: <span id="utilizador"><%= SESSION("user") %> [ <a href="admin.asp?Logout=1">Sair</a> ]</span> </div><p class="fil">
      » <a href="admin.asp">Início</a> » <a href="admin.asp">Administração</a> » <a href="../cgi/www.exe/[in=pleitor.in]?ut=<%= lcase(SESSION("user")) %>&expressao=<%= REQUEST("expressao")%>"> Leitores </a> » Definição de permissões</p>
      <span style="float:right"><a href="javascript:voltar()"><img src="../imagens/close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a></span>
      <br>
	  <br>
	  <form name="pinleitor" id="pinleitor" action="../cgi/www.exe/[in=novpin.in]" method="post">
	  <input type="hidden" name="expressao" id="expressao" value="<%= REQUEST("expressao") %>">
	  <input type="hidden" name="ut" id="ut" value="<%= SESSION("user") %>">
	  <input type="hidden" name="activo" id="activo" value="">	
	  <fieldset class="leitor"><br>
	  <%
	  	strHTML = getUrl(strROOT & "/cgi/www.exe/[in=getlt.in]?expressao=" & REQUEST("expressao"))
	  %>
	  <h3 style="margin-left:50px"><%= DecodeUTF8(strHTML) %></h3>
	<div>
	<% 
	 num = stripALPHA(REQUEST("expressao"))
	 bib = stripNUM(REQUEST("expressao"))  
	%>
	<label for "v10"><span>Nº de leitor:</span></label><input size="10" type="text" name="v10" id="v10" value="<%=num %>" readonly>
	<label for "v100" class="esp">Biblioteca: &nbsp;&nbsp;</label><input size="10" type="text" name="v100" id="v100" value="<%= bib %>" readonly>
	<label for "v11" class="esp">PIN:</label>   <input size="10" type="text" name="v11" id="v11" value="" maxlength="4">
	</div>
	<br>
	<label for "v12"><span>Activo:</span></label><input type="radio" name="v12" id="v121" checked>Sim   <input type="radio" name="v12" id="v122" >Não<br><br>
	<label for "v13"><span>Mensagem:</span></label><textarea type="text" name="v13" id="v13"></textarea><br><br>
	<div align="center"><input type="submit" name="submit" value="Atualizar" onClick="return validadados();"></div><br>
	</fieldset>
	</form>
	</div>
	</div>
	<script>document.getElementById("v11").focus()</script>
</body>
