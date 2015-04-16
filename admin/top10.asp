<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"%>
<!DOCTYPE html public "-//w3c//dtd html 4.01 transitional//en">
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<TITLE><%=stitulo%></TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<link type="text/css" rel="stylesheet" href="../css/default.css"/>
<![if !IE]>
<link href="../css/default1.css" rel="stylesheet" type="text/css"/>
<![endif]>
<script type="text/javascript" src="../js/sorttable.js"></script>
<script src="../js/tableH.js" type="text/javascript"></script>
<STYLE type="text/css">
@media print {
     table#users {width:17cm;font-size: 10pt;}
}
@media print {
     table#users td {border:solid 1px;}
}
</STYLE>
    <link rel="icon" href="../favicon.ico" type="image/ico"/>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
</head>
<%

	strHTML=getUrl(strROOT & "/cgi/www.exe/[in=topres.in]?expressao=$")
	adados=split(strHTML,",")
	m= ubound(adados)\8

	redim top10(m,8)
	for i=0 to ubound(adados)-1 
	       j= i mod 8
		   k= i \ 8
	       top10(k,j) = adados(i)
	next
    redim adados(m,2)
	for i=0 to ubound(top10)
		   adados(i,0)=top10(i,0)
		   adados(i,1)=top10(i,2)
	next	
	call DualSorter(adados, 1)
	redim adados1(m,2)  
	for i=0 to ubound(top10)
		   adados1(i,0)=top10(i,2)
		   adados1(i,1)=top10(i,4)
	next
    call DualSorter(adados1, 0)
	redim adados2(m,2)
	for i=0 to ubound(top10)
		   adados2(i,0)=top10(i,2)
		   adados2(i,1)=top10(i,3)
	next
	call DualSorter(adados2, 0)
	redim adados3(m,2)
	for i=0 to ubound(top10)
		   adados3(i,0)=top10(i,2)
		   adados3(i,1)=top10(i,5)
	next
	call DualSorter(adados3, 0)
	redim adados4(m,2)
	for i=0 to ubound(top10)
		   adados4(i,0)=top10(i,2)
		   adados4(i,1)=top10(i,7)
	next
	call DualSorter(adados4, 0)
%>
<body>

<div id="principal"> 
    <div id="lblutilizador">Utilizador: <span id="utilizador">
        <% if session("user")="" then response.write "anónimo" else response.write ucase(session("user"))%><%if Session("LoggedIn") then%> &nbsp;[ <a href="admin.asp?Logout=1">Sair</a> ]<%else%> &nbsp;[ <a href="admin.asp">Entrar</a> ]<%end if%>
        </span> </div><p class="fil">» <a href="../default.asp">Início</a> » <a href="admin.asp?id=2&mnres=2">Administração</a> » Top leitores
	    <div id="admbotoes" style="float:right"><a href="admin.asp?id=2&mnres=2"><img src="../imagens/close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a><a href="javascript:window.print()"><img src="../imagens/imprimir.gif" border=0 title="Imprimir lista dos Top10 leitores" alt="Imprimir lista dos Top10 leitores""></a></div><h3>O 10 leitores com mais pedidos de reserva <img src="../imagens/thumb_up.png" align="absmiddle"  border=0></h3>

<table id="users" class="sortable" summary="Listagem de acessos ao sistema de administração" onMouseOver="javascript:trackTableHighlight(event, &quot;#FFFF99&quot;);"
  onMouseOut="javascript:highlightTableRow(0);">
  <thead><th width="90">Nº leitor</th><th>Instituição</th><th>Nome</th><th>Pedidos</th><th>Confirmados</th><th>Foto</th></thead>   
<% if ubound(adados)<1 then %>   
<tr height="200"><td colspan="6" align="center">Ficheiro vazio</td></tr>
<% else 
    qtd=0
	for i=0 to ubound(adados)
	  if isnumeric(adados(i,0)) and adados(i,0)<>"" then
	    qtd=qtd+1 
%>
<tr><td align="center" width="70"><%=adados(i,0)%></td><td align="center"><%=adados4(i,1)%></td><td>&nbsp;<%=adados1(i,1)%></td><td align="center"><%=adados(i,1)%></td><td align="center"><%=adados2(i,1)%></td><td align="center"  width="50"><img src="<% if adados3(i,1)<>"" then response.write replace(adados3(i,1),"../../","../") else response.write "../imagens/no_photo.jpg" end if%>" width="50"></td></tr> 
<%     end if
       if qtd=10 then exit for
     next 
  end if%>
</table><br><br>
