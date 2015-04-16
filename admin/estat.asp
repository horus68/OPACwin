<% 
If Not Session("LoggedIn") = True  Then response.redirect "admin.asp" %>
<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%
 strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getpar.in]")
 valores= split(strHTML,",")

Dim objXmlHttp
Dim strHTML
Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")

objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=relbib1.in]", False
objXmlHttp.send
strHTML = objXmlHttp.responseText
entidades=split(strHTML,",")

strDados=""
'response.end
for i=0 to ubound(entidades)-1
   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getnres.in]?base=reservas&expressao=REQ "+ucase(entidades(i))+ "&lim_inicio=1&limites=500000", False
   objXmlHttp.send
   strDados = strDados & objXmlHttp.responseText & ","
   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getnres.in]?base=reservas&expressao=SI "+ ucase(entidades(i))+" AND TU leitor&lim_inicio=1&limites=500000", False
   objXmlHttp.send
   strDados = strDados & objXmlHttp.responseText & ","
next
maxi= Max(split(strdados,","))

strDados1=""
'response.end
for i=0 to ubound(entidades)-1
   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getnres.in]?base=reservas&expressao=REQ "+ucase(entidades(i))+ "&lim_inicio=1&limites=500000", False
   objXmlHttp.send
   strDados1 = strDados1 & objXmlHttp.responseText & ","
   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getnres.in]?base=reservas&expressao=REQ "+ucase(entidades(i))+ " AND EST 1&lim_inicio=1&limites=500000", False
   objXmlHttp.send
   strDados1 = strDados1 & objXmlHttp.responseText & ","
next

strDados2=""
'response.end
for i=0 to ubound(entidades)-1 
   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getnres.in]?base=reservas&expressao=SI "+ ucase(entidades(i))+" AND TU leitor&lim_inicio=1&limites=500000", False
   objXmlHttp.send   
   strDados2 = strDados2 & objXmlHttp.responseText & ","
   objXmlHttp.open "GET", strROOT & "/cgi/www.exe/[in=getnres.in]?base=reservas&expressao=SI "+ ucase(entidades(i))+" AND TU leitor AND EST 1&lim_inicio=1&limites=500000", False
   objXmlHttp.send
   strDados2 = strDados2 & objXmlHttp.responseText & ","
next

Set objXmlHttp = Nothing
'response.write strDados & "<br>"
'response.write strDados1 & "<br>"
'response.write strDados2

'response.end 

%>
<html>  
<head>   
<title>Gráficos - <%=sentidade %></title> 
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=8, IE=9"/>
<link type="text/css" rel="stylesheet" href="../css/default.css" >
<![if !IE]>
<link type="text/css" rel="stylesheet" href="../css/default1.css"/>
<![endif]>
<link type="text/css" rel="stylesheet" href="../css/tabcontent.css"/>
<style>
table#users {width: 200px;font-size:1em}
</style>
<script type="text/javascript" src="../js/jquery.tools.min.js"></script> 
<script type="text/javascript" src="../js/tabcontent.js"></script> 
<script type="text/javascript" src="http://www.google.com/jsapi"></script>    
<script type="text/javascript">

	
	google.load("visualization", "1", {packages:["<% if valores(6)="S" then response.write "barchart" else response.write "corechart" end if%>"]});      
	google.setOnLoadCallback(drawChart);      
	google.setOnLoadCallback(drawChart1);      
	google.setOnLoadCallback(drawChart2); 
	
	function drawChart() {
	var entidades="<%=strHTML%>";
	var valores="<%=strDados%>"; 
	var s=entidades.split(",");
	var t=valores.split(",");
	var flag=false;
	for(i=0;i< t.length-1;i++) if (t[i]!=0) flag=true;
	if (flag==false) {document.getElementById("chart_div").innerHTML="<div style='position: relative; background: url(../imagens/no-graph.png); width: 385px; height: 296px;'><div style='position: absolute; top: 1em; lefght: 2em;padding: 4px;color:red;'><b>Não há dados para mostrar!</b></div></div>";return}    
	var data = new google.visualization.DataTable();     
	data.addColumn('string', 'Instituições');        
	data.addColumn('number', 'E.I.B'); 
	data.addColumn('number', 'Leitores');        
	data.addRows(s.length-1);
	
	document.getElementById("chart_div").innerHTML="";
	var j=0;
	for (i=0;i <s.length-1;i++)
	
	{	        
	    data.setValue(i, 0, s[i]);
		data.setValue(i, 1, parseFloat(t[j])); 
		data.setValue(i, 2, parseFloat(t[j+1])); 
		j=j+2;              
	}  
	
<%if valores(6)="S" then %> 
		 var chart = new google.visualization.BarChart(document.getElementById('chart_div'));

<% else %>
		 var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));  
		           
<% end if%>
	chart.draw(data, {width: 355, height: 296, enableTootlTip: true,  axisFontSize: 11, is3D: true, colors:[{color:'blue', darker:'gray'} ,{color:'red', darker:'gray'}], title: ''});
	        
}    
	function drawChart1() {
	var entidades="<%=strHTML%>";
	var valores="<%=strDados1%>"; 
	var s=entidades.split(",");
	var t=valores.split(",");
	
	var flag=false;
	for(i=0;i< t.length-1;i++) if (t[i]!=0) flag=true;
	if (flag==false) {document.getElementById("chart_div1").innerHTML="<div style='position: relative; background: url(../imagens/no-graph.png); width: 385px; height: 296px;'><div style='position: absolute; top: 1em; lefght: 2em;padding: 4px;color:red;'><b>Não há dados para mostrar!</b></div></div>";return}    
	var data = new google.visualization.DataTable();     
	data.addColumn('string', 'Instituições');        
	data.addColumn('number', 'Totais'); 
	data.addColumn('number', 'Confirmados');        
	data.addRows(s.length-1);
	
	document.getElementById("chart_div1").innerHTML="";
	j=0;
	for (i=0;i <s.length-1;i++)
	
	{	        
	    data.setValue(i, 0, s[i]);
	
		data.setValue(i, 1, parseFloat(t[j])); 
		data.setValue(i, 2, parseFloat(t[j+1]));  
		j=j+2;             
	}  
	
<%if valores(6)="S" then %> 
		 var chart = new google.visualization.BarChart(document.getElementById('chart_div1'));
		
		 <% else %>
		 var chart = new google.visualization.ColumnChart(document.getElementById('chart_div1'));  
		      
		<% end if%>
	chart.draw(data, {max:<%=maxi%>, width: 555, height: 296, enableTootlTip: true,  axisFontSize: 11, is3D: true, colors:[{color:'blue', darker:'gray'} ,{color:'cyan', darker:'gray'}], title: ''});
	        
}    

function drawChart2() {
	var entidades="<%=strHTML%>";
	var valores="<%=strDados2%>"; 
	var s=entidades.split(",");
	var t=valores.split(",");
	var flag=false;
	for(i=0;i< t.length-1;i++) if (t[i]!=0) flag=true;
	if (flag==false) {document.getElementById("chart_div2").innerHTML="<div style='position: relative; background: url(../imagens/no-graph.png); width: 385px; height: 296px;'><div style='position: absolute; top: 1em; lefght: 2em;padding: 4px;color:red;'><b>Não há dados para mostrar!</b></div></div>";return}    
	var data = new google.visualization.DataTable();     
	data.addColumn('string', 'Instituições');        
	data.addColumn('number', 'Totais'); 
	data.addColumn('number', 'Confirmados');        
	data.addRows(s.length-1);
	
	document.getElementById("chart_div2").innerHTML="";
	j=0;
	for (i=0;i <s.length-1;i++)
	
	{	        
	    data.setValue(i, 0, s[i]);	
		data.setValue(i, 1, parseFloat(t[j])); 
		data.setValue(i, 2, parseFloat(t[j+1]));   
		j=j+2;            
	}  
	
<%if valores(6)="S" then %> 
		 var chart = new google.visualization.BarChart(document.getElementById('chart_div2'));
		
		 <% else %>
		 var chart = new google.visualization.ColumnChart(document.getElementById('chart_div2'));  

		<% end if%>
	chart.draw(data, { max:<%=maxi%>, width: 555, height: 296, enableTootlTip: true,  axisFontSize: 11, is3D: true, colors:[{color:'red', darker:'gray'} ,{color:'cyan', darker:'gray'}], title: ''});
	        
}    


</script>  
</head>
<%dim valores
valores= split(strDados,",")
flag=0
for i=0 to ubound(valores)-1
   if valores(i)<>"" then flag=1
next  
%>   
<body>  
<div>
<div id="principal">
<div id="lblutilizador">Utilizador: <span id="utilizador"> 	 
		     <% if session("user")="" then response.write "anónimo" else response.write ucase(session("user")) end if%><%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]<%end if%>
      </span> 
	  </div>
	   <p class="fil">» 	    
	     <a href="../default.asp">Início</a> » <a href="admin.asp?id=2&mnres=2">Administração</a> » Reservas [entidades requisitantes]
<div id="admbotoes" style="float:right"><a href="../admin/admin.asp?id=2&mnres=2"><img src="../imagens/close.gif" border=0 alt="Voltar à página anterior"></a><% if flag=1 then %><a href="javascript:window.print()"><img src="../imagens/imprimir.gif" border=0 alt="Imprimir esta página"></a><%end if%></div><h3>Reservas [entidades requisitantes]</h3>  
    <ul id="tabs" class="shadetabs">
	   <li><a href="#" rel="tab1" class="selected">Totais</a></li>
	   <li><a href="#" rel="tab2" >E.I.B.</a></li>
	   <li><a href="#" rel="tab3" >Leitores</a></li>
    </ul>
	
	<div id="painel">
		<div  id="tab1" class="tabcontent">
			<br />
			<b>A) Pedidos [Total]:</b>
			<table>
			<tr>
			<td><div id="chart_div" style="width:560px">A carregar dados... Aguarde um momento, por favor</div></td>
			<td>
			<%
			if flag=1 then
			%>
			<table id="users">
			<th>Entidade</th>
			<th>E.I.B.</th>
			<th>Leitores</th>
			<%
			dados=split(strdados,",")
			total1=0
				j=0
				for i=0 to ubound(entidades)-1
				   response.Write("<tr><td>" & entidades(i) & "</td><td align=""right"">" & dados(j)  & "</td><td align=""right"">" & dados(j+1)  & "</td></tr>") 
				   j=j+2
				   'total1= total1+ Clng(dados(i))
				next

			'response.write "<tr><td>Total</td><td align=""right""><b>" & total1 & "</b></td></tr>"
			%>
			</table>
			<br />
			<% end if%>
			</td>
			</tr>
			</table>  
		</div>
		<div  id="tab2" class="tabcontent">
		    <br />
			<b>B) Pedidos totais vs confirmados: [Empréstimo interbibliotecas]</b>
			<table>
			<tr>
			<td><div id="chart_div1" style="width:560px;">A carregar dados... Aguarde um momento, por favor</div></td>
			<td>
			<%
			if flag=1 then
			%>
			<table id="users">
			<th>Entidade</th>
			<th>Totais</th>
			<th>Confirmados</th>
			<%
			dados=split(strdados1,",")
			total1=0
				j=0
				for i=0 to ubound(entidades)-1
				   response.Write("<tr><td>" & entidades(i) & "</td><td align=""right"">" & dados(j)  & "</td><td align=""right"">" & dados(j+1)  & "</td></tr>") 
				   j=j+2
				   'total1= total1+ Clng(dados(i))
				next

			'response.write "<tr><td>Total</td><td align=""right""><b>" & total1 & "</b></td></tr>"
			%>
			</table>
			<br />
			<% end if%>
			</td>
			</tr>
			</table>
		</div>
		<div  id="tab3" class="tabcontent">
			<br />
			<b>C) Pedidos totais vs confirmados: [Leitores]</b>
			<table>
			<tr>
			<td><div id="chart_div2" style="width:560px;">A carregar dados... Aguarde um momento, por favor</div></td>
			<td>
			<%
			if flag=1 then
			%>
			<table id="users">
			<th>Entidade</th>
			<th>Totais</th>
			<th>Confirmados</th>
			<%
			dados=split(strdados2,",")
			total1=0
				j=0
				for i=0 to ubound(entidades)-1
				   response.Write("<tr><td>" & entidades(i) & "</td><td align=""right"">" & dados(j)  & "</td><td align=""right"">" & dados(j+1)  & "</td></tr>") 
				   j=j+2
				   'total1= total1+ Clng(dados(i))
				next

			'response.write "<tr><td>Total</td><td align=""right""><b>" & total1 & "</b></td></tr>"
			%>
			</table>
			<br />
			<% end if%>
			</td>
			</tr>
			</table>  
		</div>	
	</div>
	<script type="text/javascript">
	  var menus=new ddtabcontent("tabs")
	  menus.setpersist(true)
	  menus.setselectedClassTarget("link")
	  menus.init()
	</script>
	<script>menus.expandit(<% if request("id")="" then response.write 0 else response.write request("id") end if%>)</script>
  </div>
</div>
</body>
</html>
