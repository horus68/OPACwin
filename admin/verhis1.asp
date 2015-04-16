<!--#include file="config.asp"--> 
<!--#include file="functions.asp"-->
<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<link type="text/css" rel="stylesheet" href="../css/default.css" >
<![if !IE]>
<link type="text/css" rel="stylesheet" href="../css/default1.css"/>
<![endif]>
<script type="text/javascript" src="../js/sorttable.js"></script>
<script src="../js/tableH.js" type="text/javascript"></script>
<script type="text/javascript" src="../js/prototype.js"></script>
<title>Histórico de Pesquisas</title> 
<script language="VBScript" >
dim temp(10000,6)
Sub getRow()
   Dim oTbl, oRow
   Set oTbl=document.getElementById("users")
   i=0
   k=0
   for each orow in otbl.rows
      if k <otbl.rows.length-1 then
       Set ob=document.getElementById("row"&k)
       if ob.checked = True then
		   temp(i,1)= oRow.cells(1).innerHTML 
		   temp(i,2)= orow.cells(2).innerHTML 
		   temp(i,3)= orow.cells(3).innerHTML 
		   temp(i,4)= orow.cells(4).innerHTML
		   temp(i,5)= orow.cells(5).innerHTML
		   i=i+1
		end if
	   end if	
	   k=k+1
    next 
End Sub
 
</script>

<script type="text/javascript">
onload = function() {
    window.focus();
 }
 
 function usar_pesquisa(r)
 { 
   
	if (!document.getElementsByTagName || !document.createTextNode) return;
    var rows = document.getElementById('users').getElementsByTagName('tbody')[0].getElementsByTagName('tr');
    for (i = 0; i < rows.length; i++) {
        //rows[i].onclick = function() {
		  
		    var pos; var fim; var str;
			var nrow=rows[i].cells[0].innerText || rows[i].cells[0].textContent;
			if (r==nrow-1)
			{
			var termo=rows[i].cells[1].innerText || rows[i].cells[1].textContent;
			var formato=rows[i].cells[2].innerText || rows[i].cells[2].textContent;
			var tipodoc=rows[i].cells[3].innerText || rows[i].cells[3].textContent;
			var ini=rows[i].cells[4].innerText || rows[i].cells[4].textContent;
			var nreg=rows[i].cells[5].innerText || rows[i].cells[5].textContent;
			switch (tipodoc)
			{
			case "Todos": tipodoc="XX";
			              break;		
			}
			switch (termo)
			{
			case "Qualquer termo": termo="$";
			              break;		
			}
			switch (formato)
			{
			case "Completo": formato="wiusr";
			              break;		
			case "Abreviado": formato="wiabr";
			              break;		
			case "Boletim": formato="wibol";
			              break;		
			case "NP 405": formato="winp405";
			              break;		
			case "Títulos": formato="witit";
			              break;		
			case "ISBD" : formato="wicmp";
                           break;			
						  
			}
			
            strUrl = window.opener.location.href;
			
			if (termo.indexOf('(...)') != -1 ) 
			{  
			  temp=termo.split(' (...)');
			  str=temp.join("$");
			  termo=str;
			  
			  
			}  
            
			pos= strUrl.indexOf("expressao=");
			fim= strUrl.indexOf("&",pos+9);
			str= strUrl.substr(pos+10,fim-pos-10);
			strUrl = strUrl.replace(str,termo);
			
			pos= strUrl.indexOf("TDOC=");
			if (pos !=-1)
			{
			fim= strUrl.indexOf("&",pos+4);
			str= strUrl.substr(pos+5,fim-pos-5);
			strUrl = strUrl.replace(str,tipodoc);
			}
			pos= strUrl.indexOf("lim_inicio=");
			fim= strUrl.indexOf("&",pos+10);
			str= strUrl.substr(pos+11,fim-pos-11);
			strUrl = strUrl.replace(str,ini);
			
			pos= strUrl.indexOf("limites=");
			fim= strUrl.indexOf("&",pos+7);
			str= strUrl.substr(pos+8,fim-pos-8);
			strUrl = strUrl.replace(str,nreg);
			
            pos= strUrl.indexOf("formato=");
			fim= strUrl.indexOf("&",pos+7);
			str= strUrl.substr(pos+8,fim-pos-8);
			strUrl = strUrl.replace(str,formato);

			window.opener.location.href = strUrl.substr(0,strUrl.length-1);
			
			  if (window.opener.progressWindow)
				{
				window.opener.progressWindow.close()
				}
			  window.close();
			}
    }		

}
</script>
</head>
<body  style="margin-left:30px;text-align:left">

<br>
		<p style="font: bold 10pt Arial ">Histórico de pesquisas</p>
		<%
		Dim histArray 
		Dim histMaxUsed
		histArray = Session("histArray")
		histMaxUsed = Session("histMaxUsed")
        'chave="AU ,TI ,DP ,COL ,CDU ,AS "
        'eti=split(chave,",")		
		if histMaxUsed <>"" then
            if histMaxUsed =-1 then
				response.write "<h3><center>Histórico vazio</center></h3>"		
			else
                response.write "<form name=""frmtabela"" id=""frmTabela"" method=""post"" action="""">"
                response.write "<div style=""float:right;padding-right:5px;"">Acções: <select   name=""box"" id=""box""><option value=""1"">Apagar marcadas</option><option value=""2"">Apagar todas</option></select><input type=""button""  onclick=""getRow()"" value=""Ok""></div>"       
                response.write "</form>"
				response.write "<table class=""sortable"" id=""users"" summary=""Histórico de pesquisa"" onMouseOver=""javascript:trackTableHighlight(event, &quot;#FFFF99&quot;);""  onMouseOut=""javascript:highlightTableRow(0);"" >"	
				response.write "<th>ID</th><th>Expressão de pesquisa</th><th>Formato</th><th>Tipo de documento</th><th align=""center"">Início</th><th align=""center"">Reg/pág.</th><th></th><th></th>"		
				for i=0 to histMaxUsed 
				  select case  histArray(1,i)
				  case "XX"
				     tdoc="Todos"
				  end select 	 
				  select case  histArray(0,i)
				  case "$"
				     termo="Qualquer termo"
					 criterio="Em qualquer campo"
				  case else
                     
					 termo= histArray(0,i)
		'			 flag_e=false
		'			 for k=0 to ubound(eti)-1
		'			    pos=instr(termo,eti(k))
		'				
		'				if pos>0 then 
		'				   ind=k
		'				   flag_e=true
         '                  exit for
			'			end if   
			'		 next	
'
'					 if flag_e then 
'					    etiqueta=eti(ind)
'						termo=trim(mid(termo,pos+len(etiqueta)))
'						etiqueta=trim(etiqueta)
'					 else 
'					    etiqueta=""
'					 end if
					 if right(termo,1)="$" then
					    dim exp
					    exp=split(termo,"AND")
						temp= join(exp,"(...) AND ")
                        exp= split(termo,"OR")
  						temp= join(exp,"(...) OR")
						termo=temp
					    termo=left(termo,len(termo)-1) & " (...)"					 
					 end if
'					 if instr(chave,etiqueta)>0 then
'						select case etiqueta
'						case "AU"
'							criterio="No campo AUTOR"
'						case "TI"
'							criterio="No campo TÍTULO"
'						case "AS"
'							criterio="No campo ASSUNTO"
'						case "COL"
'							criterio="No campo COLEÇÃO"
'						case "DP"
'							criterio="No campo DATA DE PUBLICAÇÃO"
'						case "CDU"
'							criterio="No campo CDU"
'						end select	
'					else
'					    criterio="Em qualquer campo"
'					end if
			
				  end select
				  select case  histArray(4,i)
				  case "wiusr"
				      formato="Completo"
				  case "wiabr"
				      formato="Abreviado"
				  case "winp405"
				      formato="NP 405"
				  case "wibol"
				      formato="Boletim"
				  case "wicmp"
				      formato="ISBD"
				  case "witit"
				      formato="Títulos"					  
				  end select
				  response.write "<tr><td>"& i+1 &"</td><td>" & termo & "</td><td>"& formato &"</td><td>"& tdoc &"</td><td align=""center"">"& histArray(2,i) & "</td><TD align=""center"">"&histArray(3,i)&"</td><td><input type=""checkbox"" name=""row" & i & """ id=""row" & i & """ ></td><td><img onclick=""javascript:usar_pesquisa("& i &")"" style=""cursor:pointer"" src=""../imagens/refresh.gif"" width=""18"" title=""Usar pesquisa""></td></tr>"
				next
				response.write "</table>"
            end if			
		else 
				response.write "<br><br><h3><center>Sessão terminada (Histórico vazio)</center></h3>"		
			
		end if	
		%>		
</body>
