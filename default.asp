<!--#include file="admin/functions.asp"-->
<!--#include file="admin/config.asp"-->
<%
  strURL=strROOT & "/cgi/www.exe/[in=getpar.in]"
  strHTML=getUrl(strURL)
  valores= split(strHTML,",")
  session("portal")=valores(2)
  strURL=strROOT & "/cgi/www.exe/[in=getrates.in]?expr=MFN $"
  strHTML=getUrl(strURL)
  votos= split(strHTML,",")

  sversao = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "GERAL", "versao")
  surlRBE = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "GERAL", "urlRBE")
  surlPORTAL = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "GERAL", "urlPORTAL")
  sentidade = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "GERAL", "entidade")
  stitulo = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "PORTAL", "titulo")
%>

		
<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
	<meta http-equiv="X-UA-Compatible" content="IE=8"/>
	<meta name="robots" content="follow,index" />
	<title><%=stitulo%></title>
    <link href="css/default.css" rel="stylesheet" type="text/css" />
	<![if !IE]>
	<link href="css/default1.css" rel="stylesheet" type="text/css" />
	<![endif]>
	<script type="text/javascript" src="/opac/js/geral.js"></script>
	<script type="text/javascript" src="/opac/js/jquery-1.7.1.min.js"></script>
	<link type="text/css" rel="stylesheet" href="/opac/js/jqueryRater/style.css" />
	<script type="text/javascript" src="/opac/js/jqueryRater/jquery.rater.js"></script>
  <link rel="icon" href="favicon.ico" type="image/ico"/>
 	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
</head>
<body>
    <h3><span>Catálogos</span></h3>
    <div id="principal"> 
      <div id="lblutilizador"><span id="utilizador">  
        <% if session("user")="" then response.write "<b>Área reservada:</b> " else response.write "Utilizador: " &  DecodeUTF8(session("user"))%><%if Session("LoggedIn") or session("LeitorIn") then%> [ <a href="logout.asp?sys=admin">Sair</a> ]<%else%> &nbsp;<a href="javascript:void(0)" onClick="window.open('admin/logleitor.asp','login','width=360,height=170,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,copyhistory=no,resizable=no')">LEITORES</a> | <a href="admin/admin.asp">ADMINISTRADORES</a> <%end if%>
        </span>
	  </div>  
      <p class="fil">» Início<%if Session("LoggedIn") then%> » <a href="admin/admin.asp">Administração</a><% end if%></p>
      <% if session("portal")="N" then %>
	     <br>
	     <h3 style="color:red">O catálogo encontra-se em MANUTENÇÃO.<br> Retomaremos o serviço logo que possível...</h3>
	   <%else %>
	  <div>
		  <div style="width:250px;float:left;"> 
		  <h2>Selecione o tipo de pesquisa:</h2>
		  <ul style="line-height:1.8em">
			<li><a href="/opac/catpesq.asp?id=0&bd=col">Simplificada</a></li>
			<li><a href="/opac/catpesq.asp?id=1&bd=col">Orientada</a></li>
            <% if ucase(session("user"))="ADMIN" or session("LeitorIn") then %>
			<li><a href="/opac/catpesq.asp?id=3&bd=col">Palavra-chave</a></li>
           <%end if%>
		  </ul>
		  </div>
		  <div style="float:right;width:370px;">	
           
			<span style="float:right"><% if session("nuser")<>"" then %><a  href="javascript:void(0)"   onclick="javascript:alterarPin()"><img src="imagens/person.gif"  border="0" alt="Aletar o meu PIN" align="absmiddle"></a><% end if%> <%if (session("user")<>"" and session("user")<>"ADMIN") or session("nuser")<>"" then %><a href="javascript:void(0)" onclick="javascript:build_reservas(&quot;<%=session("user")%>&quot;,&quot;<%=session("nuser")%>&quot;)"><img src="imagens/basket_3.gif"  border="0" alt="As minhas reservas" align="absmiddle"></a><%end if%></span>		  
		  <%
		   if ubound(votos)>0 then 
		   %>
		   <fieldset style="width:350px;margin:10px 15px 0 0;padding:10px"><legend>Top títulos</legend>
		     <br />
			 <table style="font-size:0.9em">
			 <% on error resume next
                s="":t="":u="":x=""
			    for i=1 to ubound(votos)-1 step 4
				criterio=replace(replace(votos(i),"^a",""),"^b","")

				strURL=strROOT & "/cgi/www.exe/[in=gettit.in]?base=opac&expr=" & criterio   '& string(7 - Len(votos(i)),"0") & votos(i)
				strHTML=getUrl(strURL)

				if strHTML<>"" then
					tmp=split(strHTML,"£")
					
					if ubound(tmp)>2 then
						med=Clng(tmp(2))/Clng(tmp(3))
						s=s & med & "#":t=t & tmp(0) & "§":z=z & tmp(4) & "§"             'string(7 - Len(votos(i)),"0") & votos(i) & "," 				
					end if
				end if
			     next
			     if s<>"" then
   
					v=split(s,"#"):	t0=split(t,"§"): t3=split(z,"§")
					
					sortArrayD v, t0, t3
					if session("user")="" then us="guest" else us=session("user") 
					limite=4
					if ubound(v)<5 then limite=ubound(v)-1
					for i=0 to limite
					 response.write "<tr><td width=""220""> <a style=""text-decoration:none"" href=""/opac/cgi/www.exe/[in=pesqger.in]?base=opac&expressao="+t3(i)+"&limites=25&lim_inicio=1&formato=wiusr&id=0&nomenu=catpesq.asp&ut="& us & "&nut=" &session("nuser") &""">" &replace(replace(t0(i),"<",""),">","") &"</a></td><td><span class=""ui-rater""><span class=""ui-rater-starsOff"" style=""width:90px;""><span class=""ui-rater-starsOn"" style=""width:"&round(v(i)*18,0)&"px""></span></span></span> (" & round(v(i),1) & ") </td></tr>"   '<td> votos:" & string(4 - Len(t2(i)),chr(160)) & t2(i) &"</td>
					next
			     end if
			     on error goto 0		
			 %>
			 </table>
             <br />			 
		   </fieldset>
	   <% end if %>
	   </div>
	  <div style="clear:left"></div>
	  <br />
	  <div  style="display:inline;font-size:0.9em"><img src="imagens/seta-destaque.gif" alt="Dicas de pesquisa">&nbsp;<a style="text-decoration:none" href="/opac/docs/dicas.pdf" target="_blank">Dicas de pesquisa</a></div></br >
	  <div align="right"><p class="fil"><img src="imagens/seta-destaque.gif" alt="Contactos e siglas">&nbsp;<a href="/opac/admin/fpdf/main.asp" target="_blank">Contactos e siglas</a></p></div>
	  <div align="right" style="clear:both"><a style="text-decoration:none" href="<%=surlPORTAL%>" target="_top">&copy; Catálogo Coletivo: <%=sentidade%></a></div>
	  <!--Software: <%=sversao%> - <%=surlRBE%> -->
      </div> 
	</div>
	<% end if%>
</body>
</html>
<%sub sortArrayD(byref arrShort, byref t0, byref t3)

    for i = UBound(arrShort) - 1 To 0 Step -1
        for j= 0 to i
            if arrShort(j)<arrShort(j+1) then
                temp=arrShort(j+1)
				tmp0=t0(j+1)
				
				tmp3=t3(j+1)
                arrShort(j+1)=arrShort(j)
				t0(j+1)=t0(j)
				
				t3(j+1)=t3(j)
                arrShort(j)=temp
				t0(j)=tmp0
				
				t3(j)=tmp3
            end if
        next
    next
 
end sub%>