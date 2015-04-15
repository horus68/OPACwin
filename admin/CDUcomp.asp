<!DOCTYPE html>
<html lang="pt">

<%	
		vdir = "/" & Split(Request.ServerVariables("SCRIPT_NAME"), "/")(1)  
		host=  Request.ServerVariables("server_name")
		porta= Request.ServerVariables("server_port")
		strROOT = "http://" & host 
		if porta <>"80" then strROOT = strROOT & ":" & porta
		strROOT = strROOT & vdir
		http=strROOT
		base=request("base")
		sigla=request("sigla")
		Dim objXmlHttp
		Dim strHTML
		Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
	    if sigla="X" then cgi="relinst" else cgi="relbib"
		objXmlHttp.open "GET", http & "/cgi/www.exe/[in=" & cgi & ".in]?base="+lcase(base), False
		objXmlHttp.send
		strHTML = objXmlHttp.responseText
	    biblios=split(strHTML,",")

		for i=0 to ubound(biblios)-1	  
		  for j=0 to 9 
		   objXmlHttp.open "GET", http & "/cgi/www.exe/[in=getex.in]?base="+lcase(biblios(i))+"&expressao=CDU " & j & "$&lim_inicio=1&limites=9999999", False
		   objXmlHttp.send
		   if objXmlHttp.responseText="" then vv=0 else vv= Clng(objXmlHttp.responseText)
		   strBibs=strBibs & vv & ","
		  next 
          'response.write strBibs & "<br>"		  
		next
		'response.end
%>

 <title>Gráfico comparativo da coleção <%if sigla="X" then response.write "em toda a Rede" else response.write "no Agrupamento"%></title>
  <!--[if lt IE 9]><script language="javascript" type="text/javascript" src="../js/dist/excanvas.js"></script><![endif]-->
  
  <link rel="stylesheet" type="text/css" href="../js/dist/jquery.jqplot.css" />
  <link rel="stylesheet" type="text/css" href="../js/dist/examples/examples.css" />
  <!-- BEGIN: load jquery -->
  <script language="javascript" type="text/javascript" src="../js/dist/jquery.js"></script>
  <!-- END: load jquery -->
  
  <!-- BEGIN: load jqplot -->
  <script language="javascript" type="text/javascript" src="../js/dist/jquery.jqplot.js"></script>
  <script language="javascript" type="text/javascript" src="../js/dist/plugins/jqplot.donutRenderer.js"></script>
  <!-- END: load jqplot -->

  
  
 <script>
 var valores="<%=strBibs%>";	
    
	<% if sp<>"3" then %> 
	   var entidades="<%=strHTML%>";
	   var s=entidades.split(",");
	<%end if%>
	var t=valores.split(",");
	
	 $(document).ready(function(){
	 $.jqplot.config.enablePlugins = true;

	 k=1;
     for (i=0;i< t.length-1; i++)	
	 {     
			eval("s"+k+" = [['0 Generalidades', "+t[i++]+"], ['1 Filosofia. Psicologia', "+t[i++]+"], ['2 Religião',"+t[i++]+"], ['3 Ciências Sociais',"+t[i++]+"],['4 Vazia',"+t[i++]+"], ['5 Ciências Exatas e Naturais',"+t[i++]+"], ['6 Ciências Aplicadas',"+t[i++]+"],['7 Artes e Desporto',"+t[i++]+"], ['8 Linguística. Literatura',"+t[i++]+"], ['9 Geografia. Biografias. História',"+t[i]+"]]"); 
			k++;
	 }

	 var strDados='';
     for (j=1;j<k;j++) 
	 {
		var x=eval("s"+j); 
		flag=false;
		for (m=0;m<10;m++)
		{
		  eval("y='"+x[m]+"'");
		  var ind=y.indexOf(','); 
		  var tmp= y.substr(ind+1);		  
		  if (tmp !='0') flag=true;
		}
		if (flag) strDados = strDados+"s"+j+",";
	 }
	 newStr = strDados.substring(0, strDados.length-1); 
	 eval("plot2 = $.jqplot('chart2', ["+newStr+"], { seriesDefaults: { renderer:$.jqplot.DonutRenderer,  rendererOptions:{ sliceMargin: 2, innerDiameter: 60, fill:true,  dataLabels:'percent', showDataLabels:true,  startAngle: -90 }}, legend: { show: true, location: 'e', placement: 'inside' }})");  
		   
	 $('#chart2').bind('jqplotDataHighlight', function (ev, seriesIndex, pointIndex, data) { $('#info2').html('Unidade documental: '+s[seriesIndex]+', [CDU '+pointIndex+' : '+ data[1]+']'); } ); 
	 $('#chart2').bind('jqplotDataUnhighlight', function (ev) { $('#info2').html(''); } ); 
		   
	 $(document).unload(function() {$('*').unbind(); }); });
 
 
 </script>
 
   </head>
  <body>
        <br />
        <div style="margin-left:25px;font-size:0.8em;color:red"><% if sigla="X" then response.write "Toda a Rede" else response.write request("sBase") %> <span id="info2" style="color:#000"></span></div> 
        <div id="chart2" style="margin-top:0px; margin-left:20px; width:700px; height:400px;"></div>
		
  </body>		