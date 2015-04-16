<% 
If Not Session("LoggedIn") = True  Then response.redirect "admin.asp" %>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
  strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getpar.in]")
  valores= split(strHTML,",")

sigla=request("users")
base=request("base")
if sigla="" then sigla=request("sigla")
criterio=trim(request("criterio"))
sp= request("mnu")
op= request("op")
select case op
	case ""  
	    if criterio<>"$" and sigla="X" then
		  filtro= criterio
		  sfiltro=criterio
		else  
	     'if sigla<>"X" and lcase(base) <> lcase(sigla) then filtro=" AND SI " & sigla & criterio else filtro= criterio
		 if criterio<>"$" then 
		      ss= split(criterio,"AND") 
			  if sigla<>"X" and sp<>"3" then
			       if lcase(base) <> lcase(sigla) then filtro=ss(1) else filtro=criterio
			  else 
			       filtro=criterio
              end if			  
		  else 	  
			  if sigla<>"X" and (lcase(base) <> lcase(sigla)) then filtro= criterio else filtro=criterio 
		  end if	  
		  sfiltro =criterio
        end if
	case "AS","COL","CDU","TI","AU"
	     if sigla<>"X" then 
			filtro = replace(replace(criterio,"SI "+ucase(trim(sigla)),"")," AND ","")
		 else
		    filtro = criterio 
		 end if	
		 
	     sfiltro=filtro
	case else
         filtro="$"
		 sfiltro ="Geral"
end select
'response.write base
'response.end
Dim objXmlHttp
Dim strHTML
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getuser.in]?expressao=SIGLA " & ucase(sigla), False
objXmlHttp.send
strHTML = objXmlHttp.responseText
if strHTML<>"" then
siglaEXT= mid(strHTML,1,len(strHTML)-2)
end if
objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getuser.in]?expressao=SIGLA " & ucase(base), False
objXmlHttp.send
strHTML = objXmlHttp.responseText
if strHTML<>"" then
siglaBASE= mid(strHTML,1,len(strHTML)-2)
end if

if sp<>"3" then 

    if sigla<>"X" and lcase(base) <> lcase(sigla) then 
	    objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=relbib.in]?base="+lcase(base), False
		objXmlHttp.send
		strHTML = objXmlHttp.responseText
		entidades=split(strHTML,",")
	else
		objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=relbib.in]", False
		objXmlHttp.send
		strHTML = objXmlHttp.responseText
		entidades=split(strHTML,",")
		objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=relbib.in]?base="+lcase(base), False
		objXmlHttp.send
		strHTML1 = objXmlHttp.responseText
		biblios=split(strHTML1,",")
	end if

	strDados=""
	strDados1=""
	strBibs=""
	strBibs1=""
	totalREFS=0
	totalREFSB=0
	
	for i=0 to ubound(entidades)-1

	   if criterio="X" and lcase(base) <> lcase(sigla) then
	    objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getex.in]?base=" & lcase(entidades(i)) & "&expressao=$&lim_inicio=1&limites=9999999&d=" & now(), False
	   else
		objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getex.in]?base=" & lcase(entidades(i)) & "&expressao="+ server.URLEncode(filtro)+"&lim_inicio=1&limites=9999999&d=" & now(), False
	   end if
	   objXmlHttp.send
	   if objXmlHttp.responseText="" then vv=0 else vv= Clng(objXmlHttp.responseText)
	   strDados = strDados & vv & ","
	   totalREFS=totalREFS + vv
	   if sigla<>"X" or criterio<>"$" then
	   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getex.in]?base=" & lcase(entidades(i)) & "&expressao=$&lim_inicio=1&limites=9999999&d=&d=" & now() , False
	   objXmlHttp.send
	   if objXmlHttp.responseText="" then vv=0 else vv= Clng(objXmlHttp.responseText)
	   strDados1=strDados1 & vv & ","
	     
	   end if
	   
	next
    if sigla<>"X" and  lcase(base)=lcase(sigla) then
	
		for i=0 to ubound(biblios)-1
	  
		   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getex.in]?base=" & lcase(biblios(i)) & "&expressao="+ server.URLEncode(sfiltro)+"&lim_inicio=1&limites=9999999&d=" & now(), False
	   
		   objXmlHttp.send
		   if objXmlHttp.responseText="" then vv=0 else vv= Clng(objXmlHttp.responseText)
		   strBibs = strBibs & vv & ","
		   totalREFSB=totalREFSB + vv
		   if sigla<>"X" or criterio<>"$" then
		   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getex.in]?base=" & lcase(biblios(i)) & "&expressao=$&lim_inicio=1&limites=9999999&d=" & now(), False
		   objXmlHttp.send
		   if objXmlHttp.responseText="" then vv=0 else vv= Clng(objXmlHttp.responseText)
		   strBibs1=strBibs1 & vv & ","
		   end if
	   
		next

    end if	

else
	  sfiltro= ucase(sigla)
	  
	  totalCDU=1
	  if lcase(base) <> lcase(sigla) then filtro=" AND SI " & sigla else filtro=""
	  'GET", strROOT & "/cgi/www.exe/[in=getex.in]?base=ensaio&expressao=SI "+ucase(sigla)+filtro+ " AND CDU " & i & "$&lim_inicio=1&limites=500000
	  for i=0 to 9   
	   'response.write strROOT & "/cgi/www.exe/[in=getex.in]?base="+base+"&expressao=CDU " & i & filtro & "&lim_inicio=1&limites=500000" & "<br>"  
	   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getex.in]?base="+base+"&expressao=CDU " & i & "$" & filtro & "&lim_inicio=1&limites=9999999&d=" & now(), False
	   objXmlHttp.send
	   strDados = strDados & objXmlHttp.responseText & ","
	   if objXmlHttp.responseText<>"" then
	      totalCDU=totalCDU + Clng(objXmlHttp.responseText)
	   end if	  
	  next
	  objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=relbib.in]?base="+lcase(base), False
	  objXmlHttp.send
	  strHTML1 = objXmlHttp.responseText
	  biblios=split(strHTML1,",")
	
end if
'response.write strDados & "<br>"
'response.write strDados1
'response.end 
Set objXmlHttp = Nothing

%>
<!DOCTYPE html>  
<head>   
<title>Gráficos - <%=sentidade %></title> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=8, IE=9"/>
<link type="text/css" rel="stylesheet" href="../css/default.css"/>
<![if !IE]>
<link type="text/css" rel="stylesheet" href="../css/default1.css"/>
<![endif]>
<link type="text/css" rel="stylesheet" href="../css/tabcontent.css"/>
<link id="ui-theme" rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.10.0/themes/ui-lightness/jquery-ui.css"/>
<link rel="stylesheet" type="text/css" href="../css/jquery.jui_dropdown.css"/>
<script src="../js/tableH.js" type="text/javascript"></script>
<script type="text/javascript" src="http://code.jquery.com/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="http://code.jquery.com/ui/1.10.0/jquery-ui.min.js"></script>
<script type="text/javascript" src="../js/jquery.jui_dropdown.min.js"></script>
<script type="text/javascript" src="../js/tabcontent.js"></script>
<script type="text/javascript" src="../js/rainbow.js"></script>
<script>
var base='<%=base%>';
function start() {
    if (!document.getElementsByTagName || !document.createTextNode) return;
    var rows = document.getElementById("users").getElementsByTagName("tbody")[0].getElementsByTagName("tr");
    for (i = 1 ; i < rows.length; i++) {
	    rows[i].title="Clique para ver a coleção desta entidade";
        rows[i].onclick = function() {
			window.location.href="graficos.asp?base="+this.cells[0].firstChild.nodeValue.toLowerCase()+"&op=<%=request("op")%>&criterio=<%=request("criterio")%>&voltar=true&sigla="+ this.cells[0].firstChild.nodeValue;
	 		//document.getElementById("frmseluser").submit();
        }
    }
}
function ver_grafcomp() {
   var loc ="CDUcomp.asp?base=<%=request("base")%>&sBase=<%=siglaBase%>&sigla=<%=sigla%>"; 
   popup=window.open(loc,"ID","toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,width=740,height=450,left=50,top=50"); 
   if (window.focus) {popup.focus()}
   return false;
}
function verCDU(bib) {
				    window.location.href="graficos.asp?base="+base.toLowerCase()+"&op=<%=request("op")%>&mnu=3&criterio=<%=trim(request("criterio"))%>&voltar=true&sigla="+bib;
}
</script>
<script type="text/javascript" src="http://www.google.com/jsapi"></script> 
 <script type="text/javascript">
	<% if sp<>"3" then %>           
		google.load("visualization", "1", {packages:["<%if valores(9)="N" then response.write "corechart" else if valores(7)="S" then response.write "barchart" else response.write "corechart" end if end if%>"]});      
	<%else%>
		google.load("visualization", "1", {packages:["corechart"]});
	<%end if%>
	google.setOnLoadCallback(drawChart); 
	
	function drawChart() {
	
		var valores="<%=strDados%>";	
		<% if sp<>"3" then %> 
		   var entidades="<%=strHTML%>";
		   var s=entidades.split(",");
		<%end if%>
		var t=valores.split(",");
		var scaleH=t.length<5? 1.4: 1;
		var flag=false;
		for(i=0;i< t.length-1;i++) if (t[i]!=0) flag=true;
		if (flag==false) {document.getElementById("chart_div").innerHTML="<div style='position: relative; background: url(../imagens/no-graph.png); width: 450px; height: 270px;'><div style='position: absolute; top: 1em; lefght: 2em;padding: 4px;color:red;'><b>Não há dados para mostrar!</b></div></div>";return}    
		var data = new google.visualization.DataTable(); 
		<% if sp<>"3" then %> 
			   var c2='Instituições';  
			   var nr= s.length-1;
			<% else %>
			   var c2='CDU'; 
			   var nr=10; 		   
			<% end if%>   	    
		eval("data.addColumn('string', '"+c2+"')");        		
		data.addColumn('number', 'Refªs');    
		eval("data.addRows("+nr+")");
		document.getElementById("chart_div").innerHTML="";   
		for (i=0;i <nr;i++)
		{	        
		<% if sp="3" then %> var c3= 'CDU '+i <%else%>var c3= s[i]<%end if%>   
		    data.setValue(i, 0, c3);
		    data.setValue(i, 1, parseFloat(t[i]));               
		}  
		<% if sp<>"3" then %> 
			<%if valores(9)="N"   then  %>    /* or (sigla<>"X" and lcase(sigla)<>lcase(base)) */
			  var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
			  chart.draw(data, {width: 555, height: 270, enableTootlTip: true, is3D: true,title: ''});      
			<% else %>
			<%if valores(7)="S" then %> 
			 var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
			 var h=t.length*37*scaleH;
			 <% else %>
			 var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));  
			  var h=270;  	
			<% end if%>
			var larg=550;
			chart.draw(data, {width: larg, height: h, vAxis: {minValue:0}, enableTootlTip: true,  axisFontSize: 12, is3D: true, legend:'none',title:'',tooltipFontSize:12});   
		<% end if%>
	<%else%>
		var chart = new google.visualization.PieChart(document.getElementById('chart_div'));
		chart.draw(data, {width: 555, height: 340, enableTootlTip: true, is3D: true, 
		           chartArea:{left:20,top:50,width:"100%",height:"75%"},
		           legend: {position: 'right', textStyle: {color: 'blue',fontSize: 12}},
				   tooltip: {fontSize:14},
				   pieSliceTextStyle: {fontSize:14},
		           slices:[{color:'#58ACFA'},{color:'#FE9A2E'},{color:'#C9BC67'},{color:'#5A9971'},{},{color:'#868A08'},
				   {color:'#970A89'},{color:'#4D5F97'},{color:'#D2B12A'},{color:'#FE642E'}]});      
	<%end if%>        

   }	
    <% if sp<>"3" and strBibs1<>"" then %>
		google.setOnLoadCallback(drawChart1); 	
		function drawChart1() {
		
        
		var valores1="<%=strBibs%>";
		<% if sp<>"3" then %> 
		   var biblios="<%=strHTML1%>"; 
		   var u=biblios.split(",");

		<%end if%>

		var z=valores1.split(",");
		var flag=false;
		for(i=0;i< z.length-1;i++) if (z[i]!=0) flag=true;
		if (flag==false) {document.getElementById("chart_div1").innerHTML="<div style='position: relative; background: url(../imagens/no-graph.png); width: 350px; height: 270px;'><div style='position: absolute; top: 1em; lefght: 2em;padding: 4px;color:red;'><b>Não há dados para mostrar!</b></div></div>";return}    
		var data = new google.visualization.DataTable(); 
		<% if sp<>"3" then %> 
		   var c2='Instituições';  
		   var nr= u.length-1;
		<% else %>
		   var c2='CDU'; 
		   var nr=10; 		   
		<% end if%>   
		eval("data.addColumn('string', '"+c2+"')");          	
		data.addColumn('number', 'Referências');   
		eval("data.addRows("+nr+")");
		
		document.getElementById("chart_div1").innerHTML="";     
		for (i=0;i < nr;i++)      
		{	        
		<% if sp="3" then %> var c3= 'CDU '+i <%else%>var c3= u[i]<%end if%>	
			data.setValue(i, 0, c3);	        
			data.setValue(i, 1, parseFloat(z[i]));               
		}
		var chart = new google.visualization.ColumnChart(document.getElementById('chart_div1'));  
		<% if sp<>"3" then %> var titulo=""; <%else%> var titulo='Distribuição por classe da CDU';<%end if%>
			eval("chart.draw(data, {width: 540, height: 270, vAxis: {minValue:0}, enableTootlTip: true,  axisFontSize: 12, is3D: true, legend:'none',title:'"+titulo+"'})");   
			
	   }    
   <% end if%>
   
</script>  

</head>
<%dim v1
v1= split(strDados,",")


flag=0
for i=0 to ubound(v1)-1
   if v1(i)<>"" then flag=1

next  
if lcase(base) <> lcase(sigla) then nomeAGRUP= " ["& siglaBASE &"]"
if sp="3" then menu=3 else menu=2

%> 
  
<body <% if (sp<>"3" and sigla<>"X" and lcase(sigla)=lcase(base)) or sigla="X" then response.write "onload='start()'" %>> 

<div id="principal">
<div id="lblutilizador">Utilizador: <span id="utilizador"> 
    <% if session("user")="" then response.write "anónimo" else response.write ucase(session("user"))%><%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]<%end if%>
    </span> </div><p class="fil">» <a href="../default.asp">Início</a> » <a href="admin.asp?id=3">Administração</a> » <% if sp="3" then %><a href="../cgi/www.exe/[in=mnucol.in]?mnu=3"><% else %><a href="colselop.asp?ut=<%=ucase(session("user"))%>&base=<%=lcase(base)%>&criterio=<%=sigla%>&users=<%=sigla%>"><% end if %>Avaliação de existências</a> » <% if sp<>"3" then %><a href="javascript:history.back()">Lista de Títulos</a> »<% end if %>  Gráficos</p>
<div id="admbotoes" style="float:right"><a href="javascript:history.go(-1);"><img src="../imagens/close.gif" border=0 alt="Voltar à página anterior"></a><% if flag=1 then %><a href="javascript:window.print()"><img src="../imagens/imprimir.gif" border=0 alt="Imprimir esta página"></a><%end if%></div><h3>Referências por instituição</h3>
<div> 
<% 'if request("voltar") then response.write "javascript:history.go(-1);" else if sigla="X" then response.write "../admin/admin.asp#tab7" else response.write "../cgi/www.exe/[in=mnucol.in]?mnu="& menu %>
<span style="float:right;">
	<% 
	 if (lcase(base)= lcase(sigla)) and (sp<>"3") then
	   if  ubound(biblios)>0 then
			response.write "<div id=""drop"">"
			response.write "<div id=""launcher_container"">"
			if ubound(biblios)>1 then
			response.write "<a id=""vgraf"" href=""javascript:void(0)"" onclick=""ver_grafcomp()""><img src=""../imagens/comparative.gif"" align=""absmiddle"" alt=""Gráfico comparativo da CDU"" title=""Gráfico comparativo da CDU"" border=""0"" width=""32""></a>"
			end if
			response.write "<input style=""width:32px;height:32px;padding:0;border:none"" type=""image"" src=""../imagens/biblios.gif"" id=""launcher4"" title=""Distribuição da CDU por unidade documental""/>"
			response.write "<div>" 
			response.write "<ul id=""menu4"">"
  		
			for i=0 to ubound(biblios)-1
					response.write "<li id='"&biblios(i)&"'><a href=""javascript:verCDU('"&biblios(i)&"');"">" & biblios(i) & "</a></li>"
			next		
			response.write "</ul>"
			response.write "</div>"
			response.write "</div>"
			response.write "</div>"
	 		
	%>
			<script>
			    
				$(function() {
				  if ($("#drop").name =="undefined") return;
				  $("#drop").jui_dropdown({
					launcher_id: 'launcher4',
					launcher_container_id: 'launcher_container',
					menu_id: 'menu4',
					launcherUIShowText: false,
					launchOnMouseEnter: true,
					launcherUISecondaryIconClass: 'ui-icon-gear',
					menuClass: 'menu4',
					containerClass: 'container4',
					my_position: 'right top',
					at_position: 'right bottom',
					onSelect: function(event, data) {
					  base= data.id;
					}
				  });
				 
				});
				</script>
			<%
		else
		   response.write "<div id=""launcher_container"">"
	       response.write "<a id=""vgraf""	href=""javascript:void(0)"" onclick=""verCDU('"&base&"')""><input style=""width:32px;height:32px;padding:0;border:none"" type=""image"" src=""../imagens/biblios.gif"" id=""launcher4"" title=""Distribuição por CDU""/></a>"	
		   response.write "</div>"
		end if	
        
	end if
    if sigla="X" then 
		 response.write "<div id=""launcher_container"">"
	     response.write "<a id=""vgraf""	href=""javascript:void(0)"" onclick=""ver_grafcomp()""><img src=""../imagens/comparative.gif"" alt=""Gráfico comparativo da CDU"" title=""Gráfico comparativo da CDU"" border=""0"" width=""32""></a>"	
		 response.write "</div>"
	end if	 
%>
</span>


<span style="font-size:0.9em"> critério: [<%if sp<>"3" then  response.write sfiltro else  response.write sigla & " (<span style=""color:red"">" & trim(siglaEXT) & "</span>)"%>] <% if sp<>"3" then%>em <% if sigla <>"X" then response.write sigla & " (<span style=""color:red"">" & trim(siglaEXT) & "</span>)" & nomeAGRUP  else response.write "Toda a rede"%><% end if%></span> 
</div>
<div style="clear:both;margin-bottom:5px"></div>
<%
flagtabs=false
if sp<>"3" then
   if sigla<>"X" then 
      if  lcase(sigla)=lcase(base) then
	    if ubound(biblios)>0 then   
		  flagtabs=true 
		end if 
	  end if 
	end if 
 end if 
 if flagtabs then %>
         <ul id="tabs" class="shadetabs"> 
           <li><a href="#" rel="tab1" class="selected">Distribuição na Rede</a></li>											  
           <li><a href="#" rel="tab2">Distribuição no Agrupamento  </a></li>														
		 </ul>
	   
		 <div id="painel">      			
     		 <div id="tab1" class="tabcontent">	
			 <br />
<%			 
 else
    response.write "<div id=""painel"">"  
 end if 
			 if sp<>"3" and sigla<>"X" and lcase(sigla)=lcase(base) then response.write "<b>A) Distribuição na REDE</b>"  else response.write "<br />" 
			 if sp="3" then response.write "<b>Distribuição por CDU</b>"
			 %>
			 <table>
				<tr>
				<td><div id="chart_div" style="width:550px;">A carregar dados... Aguarde um momento, por favor</div></td>
				<td>
			<%
			if flag=1 then
				%>
				 
				
				<table id="users" class="graficos" onMouseOver="javascript:trackTableHighlight(event, &quot;#FFFF99&quot;);" onMouseOut="javascript:highlightTableRow(0);">
				<th><%if sp<>"3" then%>Entidade<%else%>&nbsp;CDU<%end if%></th>
				<th>Ref.ªs</th>
				<% response.write "<th title=""Nº de refªs / Total encontrado para todas as entidades""> A </th>"
				   if sigla<>"X" or criterio<>"$" then    
					 if sp<>"3" then response.write "<th title=""Nº de refªs / Total de referências por entidade""> B </th>" 
				   end if
				dados=split(strdados,",")
				dados1=split(strdados1,",")
				on error resume next
				total1=0
				if sp="3" then
					for i=0 to 9
					   response.Write("<tr><td align=""center"">" & i & "</td><td align=""right"">" & dados(i) & "</td>")
					   response.Write("<td align=""right"">" & formatpercent(dados(i)/totalCDU,1) & "</td></tr>") 
					   'total1= total1+ Clng(dados(i))
					next
					
				else
					
					for i=0 to ubound(entidades)-1
					   response.Write"<tr "
					   if entidades(i)=sigla then response.write "style=""background-color:yellow""" 
					   response.write "><td>" & entidades(i) & "</td><td align=""right"">" & dados(i)  & "</td><td align=""right"">" & formatpercent(dados(i)/totalREFS,1) & "</td>"
					   if dados(i)=0 and dados1(i)=0 then dados1(i)=1 
					   if sigla<>"X" or criterio<>"$" then response.Write("<td align=""right"">" & formatpercent(dados(i)/dados1(i),1) & "</td>")
					   response.write ("</tr>") 
					   'total1= total1+ Clng(dados(i))
					next
				end if
				'response.write "<tr><td>Total</td><td align=""right""><b>" & total1 & "</b></td></tr>"
				%>
				</table>
			<% end if
			%> </td>
			  </tr>
			 </table>
			
<% 

response.write "</div>" 
if sp<>"3" then
   if sigla<>"X" then 
      if  lcase(sigla)=lcase(base) then
	    if ubound(biblios)>0 then  
%>	   

		   <div id="tab2" class="tabcontent">
		    <br />
     		<b>B) Distribuição no Agrupamento</b>
			<table>
			<tr>
			<td><div id="chart_div1" style="width:540px;">A carregar dados... Aguarde um momento, por favor</div></td>
			<td >
<%
			if flag=1 then
%>
				<table id="users1" class="graficos" >
				<th><%if sp<>"3" then%>Entidade<%else%>CDU<%end if%></th>
				<th>Ref.ªs</th>
				<% response.write "<th title=""Nº de refªs / Total encontrado para todas as entidades""> A </th>"
				   if sigla<>"X" or criterio<>"$" then    
					 if sp<>"3" then response.write "<th title=""Nº de refªs / Total de referências por entidade""> B </th>" 
				   end if
				dados=split(strBibs,",")
				dados1=split(strBibs1,",")
				on error resume next
				total1=0
				if sp="3" then
					for i=0 to 9
					   response.Write("<tr><td>" & i & "</td><td align=""right"">" & dados(i) & "</td>")
					   response.Write("<td align=""right"">" & formatpercent(dados(i)/totalCDU,1) & "</td></tr>") 
					   'total1= total1+ Clng(dados(i))
					next
				else
					
					for i=0 to ubound(biblios)-1
					   response.Write"<tr "
					   if biblios(i)=sigla then response.write "style=""background-color:yellow""" 
					   response.write "><td>" & biblios(i) & "</td><td align=""right"">" & dados(i)  & "</td><td align=""right"">" & formatpercent(dados(i)/totalREFSB,1) & "</td>"
					   if dados(i)=0 and dados1(i)=0 then dados1(i)=1 
					   if sigla<>"X" or criterio<>"$" then response.Write("<td align=""right"">" & formatpercent(dados(i)/dados1(i),1) & "</td>")
					   response.write ("</tr>") 
					   'total1= total1+ Clng(dados(i))
					next
				end if
				'response.write "<tr><td>Total</td><td align=""right""><b>" & total1 & "</b></td></tr>"
				%>
				</table>
			<% end if%>
			</td>
		  </tr>
		 </table>
		</div>
        </div>
		<script type="text/javascript">
			var menus=new ddtabcontent("tabs")
			menus.setpersist(true)
			menus.setselectedClassTarget("link") //"link" or "linkparent"
			menus.init()
		</script>
		<script>menus.expandit(<% if request("id")="" then response.write 0 else response.write request("id") end if%>)</script> 
<%    end if
     end if
   end if
 end if%>

 <p>Legenda: <ul> <li><b>coluna A</b> - Nº de refªs / Total de refªs para o critério de pesquisa </li>     <% if sp<>"3" and sigla<>"X" or (criterio<>"$" and sp<>"3") then %><li><b>coluna B</b> - Nº de refªs / Total de refªs por entidade</li><% end if%></ul></p>
 </div> 
 
</body>
</html>
