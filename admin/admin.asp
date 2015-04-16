<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<!DOCTYPE html public "-//w3c//dtd xhtml 1.0 transitional//en" "http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><%=stitulo%></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<meta name="robots" content="follow,index" />
<meta http-equiv="X-UA-Compatible" content="IE=8, IE=9"/>
<link type="text/css" rel="stylesheet" href="../css/default.css" >
<![if !IE]>
<link type="text/css" rel="stylesheet" href="../css/default1.css"/>
<![endif]>
<link rel="stylesheet" type="text/css" href="../css/tabcontent.css" />
<script type="text/javascript" src="../js/geral.js"></script>
<script type="text/javascript" src="../js/prototype.js"></script>
<script type="text/javascript" src="../js/tabcontent.js"></script>		
<script type="text/javascript" src="../js/users.js"></script>
<script type="text/javascript" src="../js/md5.js"></script>
<script language="JavaScript" src="../js/jquery-1.5.2.min.js"></script> 
<script src="../js/jqPrint.js"></script>
<script>

$(document).ready(function(){ 
	 getfdados();       
});

function mudagrafop(ob)
{
  if (ob.checked && ob.id=='gcoltip2') document.getElementById("grafori").style.display='none'; else document.getElementById("grafori").style.display=''; 
}
function act_param_res()
{
var lres = document.getElementById('limres').value;
	 var mres = document.getElementById('maxres').value;
	 var estado = document.getElementById('estado1').checked? 'S':'N';
	 var ei = document.getElementById('ei1').checked? 'S':'N';
	 var eib = document.getElementById('eib1').checked? 'S':'N';
	 var valida = document.getElementById('valida1').checked? 'S':'N';
	 var gres = document.getElementById('gres1').checked?'S':'N';
	 var gcol = document.getElementById('gcol1').checked?'S':'N';
	// var grestip = document.getElementById('grestip1').checked?'S':'N';
	 var gcoltip = document.getElementById('gcoltip1').checked?'S':'N';
	 var params="v10="+lres+"&v20="+mres+"&v30="+estado+"&v40="+ei+"&v50="+eib+"&v60="+valida+"&v70="+gres+"&v80="+gcol+"&v100="+gcoltip;
	 url ="../cgi/www.exe/[in=updpar1.in]?"+params;
     window.location.href=url;

}

function addBtPrint(id) {
 var c= '<input class="no-printable" type="image" src="../imagens/imprimir.gif" onclick="javascript:printContents(&quot;'+id+'&quot;);return false;">';
 $("#bPrint").html(c);
}


function printContents(id) {
      
       $('#'+id).jqprint({
       });
    
}



function VRegisto(mfn,base) {
   var janela =  "vregisto"; 
   var loc = "../cgi/www.exe/[in=vregisto.in]?base="+base+"&expressao="+mfn;
   popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,width=580,height=370,left=150%,top=150%");
   ndoc=popup.document;
   ndoc.location.href=loc;
   if(window.focus) popup.focus();

}

function showDBanom() {
     var url;
     var diff= $("#MFNate").val()-$("#MFNde").val()+1;
     var expr= $("#canom").val();
     var subc= $("#scanom").val();
     var oper= $("#opanom").val();
	 if (oper=='in' || oper=='notin')
	 var cs = $('#case').attr('checked') ? 1 : 0; 
     var nocc= (oper=='in' || oper=='notin')? (cs==0? $("#txtanom").val().toUpperCase(): $("#txtanom").val()): $("#ncanom").val();
     $("#anomalias").html('<p class="aviso"><img src="navimages/wait18trans.gif" align="absmiddle"> Aguarde um momento</p>');
     switch(expr){
	 case '005': case '010': case '011': case '021': case '035': case '100': 
	 case '101': url ="../cgi/www.exe/[in=getDBanom.in]?base=";break;
	 case '200': 
	 case '205':  
	 case '210': 
	 case '215': 
	 case '225': url ="../cgi/www.exe/[in=getDBanom1.in]?base=";break;  
	 case '300': case '307':  case '465':  case '467': case '500': case '600': case '606': 
	 case '675': case '700':  case '701':  case '702':  case '710':  case '711':  case '712':  case '720':  case '721':  case '722':  case '801': 
	 case '856': case '859':  case '921':  case '922':  case '923':  case '955': 
	 case '966': url ="../cgi/www.exe/[in=getDBanom2.in]?base=";break;
	 }
	 <% if lcase(session("user"))="admin" then %>
	 url = url+$("select#base option").filter(":selected").val();
	 <% else %>
	 url = url+$("#base").val();
     <% end if%>
     url= url+"&expr="+expr+"&lim_inicio="+$("#MFNde").val()+"&limites="+ diff+"&subc="+subc+"&nocc="+nocc+"&oper="+oper+"&cs="+cs+"&d="+new Date().getTime(); 
	 new Ajax.Request(url, {     
        method:"get",  
		onSuccess: function(transport){       
		var response = transport.responseText; 
                $("#anomalias").html(response); 
		
        },    
     onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
}

function getfdados(){
     <% if lcase(session("user"))="admin" then %>
	 var user = $("select#base2 option").filter(":selected").val();
	 <% else %>
     var user="<%=lcase(session("user"))%>";
	 <% end if %>
	 if (user=='' || user==null) return;
     var url ="getftime.asp?file="+user+".iso";
     new Ajax.Request(url, {     
        method:"get",  
		onSuccess: function(transport){       
		var response = transport.responseText; 
		if (response!="\n") {var aresp= response.split("#");$("#time").html(aresp[0]);$("#fsize").html(" ("+Math.floor(aresp[1]/1000)+" kb)");$("#fiso").html(user+".iso");} 
        else {
		     $("#time").html("---"); 
			 $("#fsize").html("---");
			 }
				
        },    
     onFailure: function(){$("#time").html("----"); $("#fsize").html(""); }  }); 
     var url ="chkiso.asp?file="+user+".iso";
     new Ajax.Request (url, {
     method:"get",   
     onSuccess: function(transport) {    
     var response = transport.responseText; 
      if (response !='Erro')
	  {
      var url ="../cgi/www.exe/[in=getpariso.in]?ut="+user.toUpperCase()+"&resp="+response;
      new Ajax.Request (url, {
      method:"get",   
      onSuccess: function(transport) {    
      var response = transport.responseText; 
      var aresp= response.split("%%");
      $("#soft").html(aresp[0]);
      $("#codepage").html(aresp[1]);
      if (aresp[1]!=aresp[2])
		  if (aresp[2]=="Erro") 
		  {
			 $("#fiso").html('<img style="cursor:pointer" src="../imagens/stop.gif" width="15" border="0" align="absmiddle" title="Ficheiro ISO NÃO ENCONTRADO ou não foi possível ler o ficheiro.">');
		  } else 
			  if (aresp[2]=="misc") 
			    $("#alerta").html('<img style="cursor:pointer" src="../imagens/question.png" width="15" border="0" align="absmiddle" title="Codificação do ficheiro ISO aparentemente com mistura do padrão ANSI com o padrão ASCII.\r\nATENÇÂO: convém notar que o método heurístico de validação não é absolutamente garantido">');
			  else 
			    $("#alerta").html('<img style="cursor:pointer" src="../imagens/aviso.gif" width="15" border="0" align="absmiddle" title="Codificação do ficheiro ISO aparentemente NÃO CONFERE com a parametrização.\r\nATENÇÂO: convém notar que o método heurístico de validação não é absolutamente garantido">');
     else   $("#alerta").html('<img style="cursor:pointer" src="../imagens/checked.jpg" width="15" border="0" align="absmiddle" title="Codificação do ficheiro ISO aparentemente VÁLIDA.\r\nATENÇÂO: convém notar que o método heurístico de validação não é absolutamente garantido">');
     }, 
     onFailure: function() {alert("Ocorreu um erro. Contacte o administrador.")}
      });
     } else {$("#soft").html("----"); $("#codepage").html("");$("#alerta").html('<img style="cursor:pointer" src="../imagens/stop.gif" width="15" border="0" align="absmiddle" title="Ficheiro ISO NÃO ENCONTRADO ou não foi possível ler o ficheiro.">');}	  
   }, 
   onFailure: function() {alert("Ocorreu um erro. Contacte o administrador.")}
   });   

}

function checkValInput(ob){
    if (isNaN(ob.value)) ob.value='1';
}

function getbiblio()
 {
     var selObj = $('v100');
	 if (selObj == null) return;
	 var selIndex = selObj.selectedIndex==-1?  0: selObj.selectedIndex;
	 if (selIndex==0) {$('labelbib').innerHTML=""; return};
	 //alert(selObj.options[selIndex].text);
	 
	  url ="../cgi/www.exe/[in=getuser.in]?expressao=SIGLA " + selObj.options[selIndex].text;
	  new Ajax.Request(url, {     
        method:"get",  
		onSuccess: function(transport){       
		var response = transport.responseText; 
		$("labelbib").innerHTML=response;
      },    
	   onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
}

function attachFile(){
  document.forms[0]['file'].click();
  alert(document.forms[0]['file'].value);
  var pos = document.forms[0]['file'].value.lastIndexOf('\\');
  var fich = document.forms[0]['file'].value.substr(pos+1);
  var img=document.createElement('img');
  img.setAttribute('src','../imagens/'+fich);
  $('imgLeitor').appendChild(img)
  
  return;
}

function getDirImg(){
        window.open("images.asp?op=novo", "ImgUpload", "width=500, height=340, dependent=yes, left=150 , top=150, menubar=no, scrollbars=no,status=yes");		
}
function muda_base(ob){
   for(var i=0;i<ob.length;i++)
      if (ob.options[i].selected) break;
   if (ob.id=='base2') {document.getElementById("fiso").innerHTML = ob.options[i].value+".iso"; getfdados(); return }
   if (ob.id=='base') {document.getElementById("nocat1").innerHTML ="<center><img src='navImages/wait18Trans.gif' border='0'></center>";}
   else {document.getElementById("nocat2").innerHTML ="<center><img src='navImages/wait18Trans.gif' border='0'></center>";
     document.getElementById("exportparam").style.display="none";
   }
             		   
   url ="../cgi/www.exe/[in=getmfns.in]?base=" + ob.options[i].value+"&d="+new Date().getTime();
   new Ajax.Request(url, {     
   method:"get",  
   onSuccess: function(transport){       
   var response = transport.responseText;  
   if (ob.id=='base')
   {
	   document.getElementById("anomalias").innerHTML='';
	   document.getElementById("nregs").value=response;
	   document.getElementById("MFNate").value=response;
	   if (response=="") { 
		 document.getElementById("validar").style.display="none";
		 document.getElementById("nocat1").innerHTML="<center>Nota: Este utilizador não tem catálogo na REDE</center>";
	   } else
	   {
		 document.getElementById("validar").style.display="";
		 document.getElementById("nocat1").innerText="";
	   }			   
   }else{
	   document.getElementById("limites").value=response;
	   document.getElementById("MFNate1").value=response;
	   if (response=="") {
		 //document.getElementById("validar").style.display="none";
		 document.getElementById("nocat2").innerHTML="<center>Nota: Este utilizador não tem catálogo na REDE</center>";
	   } else
	   {
		 //document.getElementById("validar").style.display="";
		 document.getElementById("exportparam").style.display="";
		 document.getElementById("nocat2").innerText="";
	   }
	  
	 }  
  },    
   onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
}

function muda_oper(ob) {
   for(var i=0;i<ob.length;i++)
      if (ob.options[i].selected) break;
   switch (ob.options[i].value) {
     case 'in': 
	 case 'notin':{$("#inputTextoAnom").show();$("#case-sensitive").show(); $("#inputOcorrAnom").hide();break;}
	 default: {$("#inputOcorrAnom").show();$("#inputTextoAnom").hide();$("#case-sensitive").hide();break;}
   }
}


function muda_campo(ob) {
    var subc;
	$("#anomalias").html('');
	document.getElementById('scanom').options.length = 0;
    for(var i=0;i<ob.length;i++)
      if (ob.options[i].selected) break;
    switch (ob.options[i].value) {
     case '005': subc=new Array();break;
	 case '010': subc=new Array('','a','b','d','z');break;
	 case '011': subc=new Array('','a','b','d','y','z');break;
	 case '021': subc=new Array('','a','b','z');break;
	 case '035': subc=new Array('','a','z');break;
	 case '100': subc=new Array('','a');break;
	 case '101': subc=new Array('','a','b','c','d','e','f','g','h','i','j');break;
	 case '200': subc=new Array('','a','b','c','d','e','f','g','h','i','v','z','5');break;
	 case '205': subc=new Array('','a','b','d','f','g');break;
	 case '210': subc=new Array('','a','b','c','d','e','f','g','h');break;
	 case '215': subc=new Array('','a','c','d','e');break;
	 case '225': subc=new Array('','a','d','e','f','h','i','v','x');break;
	 case '300': subc=new Array('','a');break;
	 case '307': subc=new Array('','a');break;
	 case '465': subc=new Array('');break;
	 case '467': subc=new Array('');break;
	 case '500': subc=new Array('','a','b','h','i','j','k','l','m','n','q','r','s','u','v','w','x','y','z','2','3');break;
	 case '600': subc=new Array('','a','b','c','d','f','g','j','p','t','x','y','z','2','3');break;
	 case '606': subc=new Array('','a','j','x','y','z','2','3');break;
	 case '675': subc=new Array('','a','v','z');break;
	 case '700': subc=new Array('','a','b','c','d','f','g','p','3','4');break;
	 case '701': subc=new Array('','a','b','c','d','f','g','p','3','4');break;
	 case '702': subc=new Array('','a','b','c','d','f','g','p','3','4','5');break;
	 case '710': subc=new Array('','a','b','c','d','e','f','g','h','p','3','4');break;
	 case '711': subc=new Array('','a','b','c','d','e','f','g','h','p','3','4');break;
	 case '712': subc=new Array('','a','b','c','d','e','f','g','h','p','3','4','5');break;
	 case '720': subc=new Array('','a','f','3','4');break;
	 case '721': subc=new Array('','a','f','3','4');break;
	 case '722': subc=new Array('','a','f','3','4','5');break;
	 case '801': subc=new Array('','a','b','c','g','2');break;
	 case '856': subc=new Array('','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z');break;
	 case '859': subc=new Array('','a','u','z');break;
	 case '921': subc=new Array('');break;
	 case '922': subc=new Array('');break;
	 case '923': subc=new Array('');break;
	 case '955': subc=new Array('');break;
	 case '966': subc=new Array('','a','c','e','l','m','p','s','0','1','2','3','4','5');break;
	 default: subc=new Array(); break;
	} 
	var $input = $("select[name='scanom']")
	$(subc).each(function(i, v){ 
      $input.append($("<option>", { value: v, html: v }));
	});
}


String.prototype.trim = function () {
return this.replace(/^\s*(\b.*\b|)\s*$/, '');
}
function Right(str, n)
{
      if (n <= 0)
          return "";
      else if (n > String(str).length)
          return str;
      else
   {
          var iLen = String(str).length;
          return String(str).substring(iLen, iLen - n);
      }
}

function chkfields(){
      document.getElementById("msgISO").style.display="";
	  
      var tmp=document.getElementById("expfile").value.toLowerCase();
	  var msg="";
      var x=document.getElementById("MFNate1").value;
	  var y=document.getElementById("MFNde1").value;
	  if (isNaN(y)) document.getElementById("MFNde1").value="1";
	  if (isNaN(x))  document.getElementById("MFNate1").value="9999999";
	  if (document.getElementById("expfile").value=="") msg="Erro: Falta indicar o nome do ficheiro de destino";
	  else if (Right(tmp,3) != "iso") msg="Erro: O ficheiro de destino deve ter a entensão ISO";
	  if (msg != "") {document.getElementById("expfile").focus();document.getElementById("expfile").select();alert(msg);} 
	  else { 
	  document.getElementById("msgISO").innerHTML='<br><span style="margin-left:-60px;color:red;font-size:0.8em;text-align:center">A processar... Aguarde um momento. </span>';
	  url ="../cgi/www.exe/[in=export3.in]?base="+document.getElementById("base1").value+"&expfile="+tmp+"&isofilepath=../tmp/&user=<%=lcase(session("user"))%>&tmppath=../tmp/&lim_inicio=" + document.getElementById("MFNde1").value+ "&limites="+document.getElementById("MFNate1").value+"&expressao=$";
	  new Ajax.Request(url, {     
	  method:"get",  
	  onSuccess: function(transport){       
	  var response = transport.responseText;
	  document.getElementById("msgISO").innerHTML=response; 
	  },    
	   onFailure: function(){ alert("Ocorreu um erro. Contacte o administrador.") }  }); 
      }
}
function limpa_msg(){
   document.getElementById('msgISO').innerHTML='';
}

function setText(){
var txt=document.getElementById('expfile');
if (txt.fireEvent)
	{
	txt.fireEvent('onchange');
	}
if (document.createEvent)
{
	var evt= document.createEvent('HTMLEvents');
	if (evt.initEvent)
	{
		evt.initEvent ('change',true,true);
	}
	if (txt.dispatchEvent)
	{
		txt.dispatchEvent(evt);
	}
}
}
</script>
    <link rel="icon" href="../favicon.ico" type="image/ico"/>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
</head>
<% Function URLDecode(str) 
			str = Replace(str, "+", " ") 
			For i = 1 To Len(str) 
				sT = Mid(str, i, 1) 
				If sT = "%" Then 
					If i+2 <= Len(str) Then 
						sR = sR & _ 
							Chr(CLng("&H" & Mid(str, i+1, 2))) 
						i = i+2 
					End If 
				Else 
					sR = sR & sT 
				End If 
			Next 
            URLDecode = sR 
        End Function 
%>
<% Function writeLog (str) 
            Application.Lock()
			Dim objFSO, objTStream
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
			Application.Unlock
 End Function 
%>
<% Response.CacheControl = "no-cache" %>
<% Response.AddHeader "Pragma", "no-cache" %> 
<% Response.Expires = -1 %>

<body >    
<%if not  Request.QueryString("Logout") = "1" then%>
	<form style="margin: 0px; padding: 0px;">
	<input type="file" name="file" style="display: none" />
	</form>    
	<%If Not Session("LoggedIn") = True  Then %>
			<h3><span>Autenticação de utilizadores</span></h3>
			<div id="principal"> 
			<p class="fil">» <a href="../default.asp">Início</a> » Entrada no Sistema de Administração </p>		
	<%else%>			
			<h3><span>Administração do sistema</span></h3>
			<div id="principal"> 
			<div id="lblutilizador">Utilizador: <span id="utilizador"> 
        <% if session("user")="" then response.write "anónimo" else response.write ucase(session("user"))%><%if Session("LoggedIn") then%> [ <a href="admin.asp?Logout=1">Sair</a> ]<%end if%>
        </span> </div><p class="fil">» <a href="../default.asp">Início</a>
		<%if request("op")="add" then %>
		» <a href="admin.asp<% if request("tipo")="lt" then response.write "?mnut=2" else response.write "?mnut=1" %>">Administração</a> » Novo utilizador</p>
		<%else%>
		 » Administração </p>
		<% end if%>				
	 <%end if%>
<% end if
If Request.QueryString("Logout") = "1" Then
    writeLog("LOGOUT - " & ucase(session("user")))
	Session("LoggedIn") = False
	session.Abandon()
	Response.Write("<meta http-equiv='Refresh' content='0; URL=admin.asp'>")
	response.end
End If

If Session("LogError") < 3 Then
		If Not Session("LoggedIn") = True Then			
				If Request.QueryString("Login") = "1" Then
				      
					  dim nm, pw, metodo  
  					  metodo = Request.ServerVariables("REQUEST_METHOD")  
					  if metodo = "POST" then  
							nm=ucase(Server.HTMLEncode(Replace(Request.Form("nickname"),"'","''"))) 
			 				pw = trim(lcase(Server.HTMLEncode(Replace(Request.Form("Password"),"'","''"))))
							strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chkperm.in]?expressao=SIGLA "& nm)
							pos=instr(strHTML,"^c")
                            
							if pos>0 and mid(strHTML,pos+2,1)="1" then 
							    							    
								strHTML=getUrl(strROOT & "/cgi/www.exe/[in=chkuser.in]?expressao=SIGLA "& nm)
                            else
							    writeLog("LOGIN (insucesso) - " & ucase(nm))
								response.write "<h3 style=""margin-top:50px;color:red"">Acesso negado. O utilizador não tem permissões de administração no sistema...</h3>"
								response.write "<br>Contacte o administrador"
								Session("LogError")=Session("LogError")+1        
								response.end
							end if 							
													
							snh=OnlyAlphaNumericChars(Server.HTMLEncode(strHTML))             
							
						      'response.write "'"+snh+"'" & "<br>"
							  'response.write "'"+pw+"'" & "<br>"
							  'response.write strcomp(snh,pw,0) & "<br>"
							  'response.end
							  if strcomp(snh,pw,0)=0 then
								Session("LoggedIn") = True
								Session("user")= nm
								writeLog("LOGIN (sucesso) - " & ucase(session("user"))) 
								strPath=URLDecode(request("reqPath"))
								'response.write strPath
								'response.end
								if strPath<>"" then
								if instr(strPath,"admin")=0 then
									if instr(strPath,"www.exe")>0 then
										posi=instr(strPath,"ut=")
										if posi>0 then 
											posf= instr(posi,strPath,"&")
											termo= mid(strPath,posi,posf-posi)			
											strPath=replace(strPath,termo,"ut=" & session("user"))
									
										end if
										
									end if
									response.redirect strPath
								end if
							   end if
							   response.write "<p>&nbsp;</p>"
							   Response.Write("<p >Bem-vindo.</p>")
							   Response.Write("<p > Aguarde um momento ou <a href='admin.asp'>clique aqui</a> para entrar!</p>")
							   Response.Write("<meta http-equiv='Refresh' content='2; URL=../default.asp'>")
							else
							   Session("LoggedIn") = false   
							end if     
							if not Session("LoggedIn") then
							   writeLog("LOGIN (insucesso) - " & ucase(nm))
							   response.write "<p>&nbsp;</p>"
							   Response.Write("<br /><br /><p >Dados incorretos. Por favor <a href=""admin.asp"">tente novamente</a>.</p>")
							   Session("LogError")=Session("LogError")+1        
							end if
					end if				
				Else
		%>	
				
					<form name="Login" action="admin.asp?Login=1" method="post" onSubmit="Password.value = hex_md5(Password.value);">
					<input type="hidden" name="reqPath" value="<%=server.URLEncode(replace(replace(replace(request.ServerVariables("HTTP_REFERER"),"%5B","["),"%5D","]"),"%3D","="))%>">
					<table  border="0" cellpadding="1" cellspacing="4" >					 
					  <tr>									
					  	<td align="right" valign="middle"> Nome: </td>
						<td valign="middle"><input type="text" name="Nickname" size="20"></td>					
					  </tr>
					  <tr>								
					     <td align="right" valign="middle"> Senha: </td>
					     <td ><input type="password" name="Password" size="20"><input type="submit" value="Ok" onClick="return Password.value!=''"></td>					
					  </tr> 					  					 
					</table>
					</form> 		       
<%				End If
	
		Else 
			 
						
%>			 
            
			
			<% if request("op")<>"" then %>
			    
				<div id="admbotoes" style="float:right"><a href="admin.asp<% if ucase(session("user"))="ADMIN" then if request("tipo")="lt" then response.write "?mnut=2" else response.write "?mnut=1" end if else response.write "?id=5" %>"><img src="../imagens/close.gif" border=0 title="Voltar à página anterior" alt="Voltar à página anterior"></a></div><h3>Novo utilizador</h3>

                   <% select case request("tipo")
				       case "ut" %>
						     <form name="frminuser" id="frminuser" action="" method="post">  
							 <input type="hidden" name="ut" value="admin">
							 <input type="hidden" name="base" value="users">
							 <fieldset class="users"><legend>Campos</legend><br />
							<div>
							<label for="v1"><span>Código ID</span></label><input class="esp" type="text" id="v1" name="v1" value=""onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label class="esp" for="v2">Sigla</label><input class="esp" type="text" id="v2" name="v2" value=""  onBlur="chgColor(this,false);this.value=this.value.toUpperCase();" onFocus="chgColor(this,true)">
							<label class="esp" for="v21">Agrupamento</label><input type="text" class="agrup" id="v21" name="v21" value=""  onBlur="chgColor(this,false);this.value=this.value.toUpperCase();" onFocus="chgColor(this,true)">
							</div>
							<label for="v3" ><span>Nome</span></label> <input class="extra" type="text" id="v3" name="v3" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v4" ><span>Morada</span></label> <input class="extra" type="text" id="v4" name="v4" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v5" ><span>Concelho</span></label> <input class="extra" type="text" id="v5" name="v5" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v6" ><span>Cod. Postal</span></label> <input class="extra" type="text" id="v6" name="v6" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v7" ><span>Senha</span></label><span id="pwd" style="float:right"></span> <input class="extra" type="password" id="v7" name="v7" value=""   maxlength="18" onKeyUp="pwdRob(this)" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="confirma" ><span>Confirmar</span></label><input  class="extra" type="password" id="confirma" name="confirma" value=""   maxlength="18" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">				
							<label for="v9" ><span>Telefone</span></label><input class="extra" type="text" id="v9" name="v9" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v10" ><span>Fax</span></label><input class="extra"type="text" id="v10" name="v10" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v11" ><span>Email</span></label><input class="extra" type="text" id="v11" name="v11" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v12" ><span>Pág. Web</span></label><input class="extra"type="text" id="v12" name="v12" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v18" ><span>Blogue</span></label><input class="extra" type="text" id="v18" name="v18" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v23" ><span>Lat.(GPS)</span></label><input type="text" class="coords" id="v23" name="v23" value="" size="25" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v22" class="esp">Long.(GPS)</label><input class="coords" type="text" id="v22" name="v22" value="" size="24" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">												
							<label for="v24" ><span>Software</span></label><select class="extra" id="v24" name="v24" onblur="chgColor(this,false)" onfocus="chgColor(this,true)">
							<option value="">Não definido</option><option value="Bibliobase" >Bibliobase</option><option value="Porbase" >Prisma/Horizon</option><option value="DocBase" >DocBase</option><option value="GIB" >GIB</option></select>
							<select class="extra" id="v26" name="v26" style="width:50px;margin-bottom:3px" onblur="chgColor(this,false)" onfocus="chgColor(this,true)">
							<option value="ansi">Ansi</option><option value="ascii" >Ascii</option></select>
							<label class="esp" for="v25">Estatuto</label><select class="coords1" id="v25" name="v25"  onblur="chgColor(this,false)" onfocus="chgColor(this,true)">
							<option value="0">Autónoma</option><option value="1">Não autónoma</option></select>
							<label for="v17" ><span>Resp./Coord.</span></label><input class="extra" type="text" id="v17" name="v17" value=""   onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
				  
							<br /><br /><center><input  type="submit" name="bt1" value="Confirmar" onClick="return chkuser();">
							<input type="button" name="bt2" value="Cancelar" onClick="javascript:history.back()"></center>
							</fieldset>
						 </form>
					 <% case "lt" %>
					   	     <form name="frminleitor" id="frminleitor" action="" method="post">  
							 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
							 <input type="hidden" name="base" value="leitor">
								<% 
								  strLT=getUrl(strROOT & "/cgi/www.exe/[in=getnlt.in]")					  
								%>
							 <fieldset class="users"><legend>Campos</legend><br />
							<div>
							<label for="v1" ><span>Nº leitor </span></label><input type="text" id="v1" name="v1" value="<%=strLT%>" size="12" readonly>
							<label class="esp" ></label>
							<label class="esp" for="v3" >Data nasc. </label><input type="text" id="v3" name="v3" value="" size="12" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label class="esp" ></label>
							</div>
							<div>
							<label for="v20"><span>Biblioteca</span></label>
							<%if ucase(session("user"))="ADMIN" then%>
							    <select id="v20" name="v20" onChange="javascript:getbiblio()" style="margin-bottom:3px">
								<option value="">Selecionar</option>
								<% 
								  strHTML=getUrl(strROOT & "/cgi/www.exe/[in=relinstB.in]")
								  entidades=split(strHTML,",")
								  for i=0 to ubound(entidades)-1
									 response.write "<option value='" & entidades(i) & "'>" & entidades(i) & "</option>"
								  next							  
								%>
								</select>
							<% else %>
								<input type="text" name="v20" id="v20" readnoly value="<%=ucase(session("user"))%>">							   
							<%end if%>	
							<label class="esp1" id="labelbib" name="labelbib"></label>
							</div>
							<div id="imgLeitor"><img id="imlt" name="imlt" src="../imagens/no_photo.jpg" width="100" height="105" alt="Foto do(a) leitor(a)"></div>
							<label for="v2" ><span>Nome</span></label><input class="extra1" type="text" id="v2" name="v2" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v4" ><span>Morada</span></label><input class="extra1" type="text" id="v4" name="v4" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v5" ><span>Concelho</span></label><input class="extra1" type="text" id="v5" name="v5" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v6" ><span>Cod. Postal</span></label><input class="extra1" type="text" id="v6" name="v6" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v7" ><span>Telefone</span></label><input class="extra1" type="text" id="v7" name="v7" value="" size="64" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v8" ><span>Profissão</span></label><input class="extra2" type="text" id="v8" name="v8" value="" size="87" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v9" ><span>E-mail</span></label><input class="extra2" type="text" id="v9" name="v9" value="" size="87" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v10" ><span>Pág. Web</span></label><input class="extra2" type="text" id="v10" name="v10" value="" size="87" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)">
							<label for="v11" ><span>Foto</span></label><input class="extra" type="text" id="v11" name="v11" value="" size="81" onBlur="chgColor(this,false)" onFocus="chgColor(this,true)"><input type="button" name="btim" onClick="javascript:getDirImg();" value=" ... " style="font: 8pt Verdana;height:22px;">
				  
							<br /><br /><center><input  type="submit" name="bt1" value="Confirmar" onClick="return chkleitor();">
							<input type="button" name="bt2" value="Cancelar" onClick="javascript:history.back()"></center>
							</fieldset>
						 </form>
					 <% end select %>	 
            <% else  %>
                <br><br>
	 <ul id="tabs" class="shadetabs">
<%if lcase(session("user"))="admin" then %>		  
      <li><a href="#" rel="tab1" class="selected">Utilizadores</a></li>											  
      <li><a href="#" rel="tab2">Acessos </a></li>
<% else %>
      <li><a href="#" rel="tab3" class="selected">&nbsp;&nbsp;&nbsp;Perfil&nbsp;&nbsp;&nbsp;</a></li> 												
      <li><a href="#" rel="tab4">O meu catálogo</a></li>					
<% end if %>            
      <li><a href="#" rel="tab6">Reservas</a></li>       
      <li><a href="#" rel="tab7">Coleção</a></li>	  
      <li><a href="#" rel="tab9">Bases de dados</a></li>	
<%if lcase(session("user"))<>"admin" then %>
      <li><a href="#" rel="tab10">Utilizadores</a></li>
<% else %>
      <li><a href="#" rel="tab10">Parametrizações</a></li>	  
<% end if %>
      <!--<li><a href="#" rel="tab11">Web 2.0</a></li>--> 	  
	 </ul>
	 <div id="painel">      			
     				<div id="tab1" class="tabcontent">					     						  
						   <dl style="margin-left:5px;margin-top:15px;">
						   <dt style="font: 10pt Arial"><a href="admin.asp?mnut=1" <% if request("mnut")="1" or request("mnut")="" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>">Institucionais</a><a href="admin.asp?mnut=2" <% if request("mnut")="2" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>">Individuais</a></dt><br><br>
						   </dl>
						   <dl class="tabsubmenu">
						   <% select case request("mnut")
						     		 
					         case "","1" %> 

							<dd><a href="../cgi/www.exe/[in=relusers.in]?ut=<%=ucase(session("user"))%>&d=<%=datediff("s", "1/1/1970 12:00:00 AM", now())%>">Editar entidade</a></dd>
							<form name="frmnovouser" action="admin.asp" method="post" >
							<input type="hidden" name="ut" value="admin">
				    		<input type="hidden" name="op" value="add">
							<input type="hidden" name="tipo" value="ut">
							</form>	
							<dd><a href="javascript:document.frmnovouser.submit()">Criar novo</a></dd> 
							<form name="frmlistauser" action="../cgi/www.exe/[in=listuser.in]" method="post" >
					   		<input type="hidden" name="ut" value="admin">

				 			</form>  
							<dd><a href="javascript:document.frmlistauser.submit()">Lista geral</a></dd>
							<%case "2"%>
							
							 <dd><a href="../cgi/www.exe/[in=pesqleitor.in]?expressao=$&ut=<%=ucase(session("user"))%>&from=1&to=25">Editar leitor</a></dd>
							<form name="frmnovoleitor" action="admin.asp" method="post" >
							<input type="hidden" name="ut" value="admin">
				    		<input type="hidden" name="op" value="add">
							<input type="hidden" name="tipo" value="lt">

							</form>	
							<dd><a href="javascript:document.frmnovoleitor.submit()">Criar novo</a></dd>
							<form name="frmlistaleitor" action="../cgi/www.exe/[in=listleitor.in]" method="post" >
					   		<input type="hidden" name="ut" value="admin">
							<input type="hidden" name="expressao" value="$">
				 			</form>  
							<dd><a href="javascript:document.frmlistaleitor.submit()">Lista geral</a></dd>
							<%end select %>
							</dl>
					    
					</div> 
					<div id="tab2" class="tabcontent">
					 	
						 <br />
						 <dl class="tabmainmenu"> 		 				
							 
								<form name="frmdisplog" action="displog.asp"  method="post" >
								   <input type="hidden" name="ut" value="admin">

								</form>
							<dd><a href="javascript:document.frmdisplog.submit()">Visualizar acessos ao sistema de administração</a></dd>
								<form name="frmcleanlog" action="cleanlog.asp" method="post" >
								   <input type="hidden" name="ut" value="admin">

								</form>
							<dd><a href="javascript:document.frmcleanlog.submit()"  OnClick= "return confirm('Tem memsmo a certeza que quer reiniciar o ficheiro de acessos ao sistema de administração [LOGS]?')">Reiniciar o ficheiro de acessos</a></dd> 
						</dl>		
                    </div>
					   
					
		     
                 <div id="tab3" class="tabcontent">
					 	
						 <br />
				 <dl class="tabmainmenu"> 		 
				 
				 <dd><a href="../cgi/www.exe/[in=seluser.in]?ut=<%=ucase(session("user"))%>&base=users&expressao=SIGLA <%=ucase(session("user"))%>" >Editar ficha de utilizador</a></dd>
				 </dl>
				 </div>
				<div id="tab4" class="tabcontent">
						
						 <br />

				<dl class="tabmainmenu"> 				    
				  
				 <%  
				   dim uflag
				   on error resume next
		           Set fs = CreateObject("Scripting.fileSystemObject")
				   if fs.FileExists(Server.MapPath(vdir & "/bases/" & lcase(session("user"))& ".mst"))=true then	         				  
					  strHTML=getUrl(strROOT & "/cgi/www.exe/[in=relbases.in]")
					  entidades=split(strHTML,",")
					  'response.write strHTML
					  for i=0 to ubound(entidades)-1
						  if strcomp(ucase(entidades(i)),ucase(session("user")),0)=0 then 
							   uflag=true
							   exit for
						  end if 	   
					  next
                  end if
				  on error goto 0
				  if  uflag then %>
				     <dd><a href="catind.asp?id=0&base=<%=lcase(session("user"))%>">Pesquisa simplificada</a></dd>
					 <dd><a href="catind.asp?id=1&base=<%=lcase(session("user"))%>">Pesquisa orientada</a></dd>
					 <dd><a href="catind.asp?id=2&base=<%=lcase(session("user"))%>">Pesquisa avançada</a></dd>
					 <dd><a href="catind.asp?id=3&base=<%=lcase(session("user"))%>">Pesquisa por termos</a></dd>
				  <%
				   else 
				     response.write "Nota: Este utilizador não tem catálogo na REDE" 
				     if ucase(session("user"))<>"ADMIN" then writeLog("AVISO: O utilizador " & ucase(session("user")) & " não está definido em 'database.lst'")
				  end if
				  %>
				  </dl>			              				
				 </div>
				    
                 <div id="tab6" class="tabcontent">
					     <dl style="margin-left:5px;margin-top:15px;">
  					     <dt style="font: 10pt Arial"><a href="admin.asp?id=2&mnres=1" <% if request("mnres")="1" or request("mnres")="" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Listagens</a>
						 <a href="admin.asp?id=2&mnres=2" <% if request("mnres")="2" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Estatísticas</a>
						
						 </dl>
						 <dl class="tabsubmenu1">

						 <% select case request("mnres")
						 
						    case "","1" %> 
						 <dt>Estado da reserva</dt><br>
						 <dd>
						 <form name="frmgesres" id="frmgesres" action="../cgi/www.exe/[in=gesres.in]" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" name="dbmin" value="<%=lcase(session("user"))%>">
						 <input type="hidden" name="base" value="reservas">
						 <input type="hidden" name="lim_inicio" value="1">
						 <input type="hidden" name="limites" value="9999999">
						 <input type="hidden" name="express" id="express" value="<% if ucase(session("user"))="ADMIN" then %>$<% else %>AGR <%=ucase(session("user"))%> OR BIB <%=ucase(session("user"))%><%end if%>">

						 <select name="estado" id="estado">
						   <option value="X" selected>[Todas]</option>
						   <option value="0">Pendentes</option>
						   <option value="1">Confirmadas</option>   
						 </select>
						 <input type="button" value="Selecionar" onClick="getActionRes();return false;">
						 
						 </form>

						    <% case "2"%>
						 <dd><form name="frmestat" id="frmestat" action="estat.asp" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" id="mnu" name="mnu" value="2">

						 <a href="javascript:document.frmestat.submit();">Pedidos de Reserva [entidades requisitantes] </a>
						 </form></dd>
						 <dd><form name="frmestat1" id="frmestat1" action="estat1.asp" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" id="mnu" name="mnu" value="2">

						 <a href="javascript:document.frmestat1.submit();">Pedidos de Reserva [entidades requisitadas] </a>
						 </form></dd>
						  <dd><form name="frmtop10" id="frmtop10" action="top10.asp" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" id="mnu" name="mnu" value="2">

						 <a href="javascript:document.frmtop10.submit();">Os 10 leitores que mais reservam </a>
			             </form></dd>
						
						 <% end select %>
					  </dl>
				   </div>
				  <div id="tab7" class="tabcontent">
						
						 
						 <dl style="margin-left:80px;margin-top:67px">
						 <dt>Avaliação das existências</dt><br>
						 <dd>
						 <form name="frmgescol" id="frmgescol" action="" method="post" >  
						 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
						 <input type="hidden" name="base" value="opac">
						 <input type="hidden" name="lim_inicio" value="1">
						 <input type="hidden" name="limites" value="9999999">
						 <input type="hidden" id="mnu" name="mnu" value="">
						 <input type="hidden" name="expressao" id="expressao" value="">

						 Procurar em: <select name="criterio" id="criterio">
						   <option value="X" selected>[Toda rede]</option>
						   <option value="i">Por Instituição</option>
						   <option value="c">Por CDU</option>  
						 </select>
						 <input type="button" value="Selecionar" onClick="getOp(); return false;">
						 
						 </form>
						 </dd>
						</dl>
					</div>	 
				
				  <div id="tab9" class="tabcontent">				 
						 
						 <% if lcase(session("user"))="admin" then 
								strHTML=getUrl(strROOT & "/cgi/www.exe/[in=relinstB.in]")
								entidades=split(strHTML,",")				   
						  end if
						  if lcase(session("user"))="admin" then
						      if ubound(entidades)>0 then
						        strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getmfns.in]?base=" & lcase(entidades(0)))
							  end if	
						  else
						        strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getmfns.in]?base=" & lcase(session("user")))
						  end if		
						  totregs=strHTML
						  
						  %>
						   
						   <dl style="margin-left:5px;margin-top:15px;">
						   <dt >
						   <a href="admin.asp?id=4&mnbases=1" <% if request("mnbases")="1" or request("mnbases")="" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Validar registos</a>
						   <a href="admin.asp?id=4&mnbases=2" <% if request("mnbases")="2" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Exportar registos</a>
						   <a href="admin.asp?id=4&mnbases=3" <% if request("mnbases")="3" then response.write "class=""tabfakeon""" else response.write "class=""tabfakeoff"""%>>Enviar ficheiros para o servidor</a>
						   </dt><br>
						   </dl>
						   <dl class="tabsubmenu1">
						   <% select case request("mnbases")
						     		 
					       case "","1" 
						   Set fs = CreateObject("Scripting.fileSystemObject")
						   if uflag or ucase(session("user"))="ADMIN"  then
						   
						   %> 
						     
							 <form name="frmvalid" id="frmvalid" action="valida.asp" method="post">  
							 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
							 <input type="hidden" id="mnu" name="mnu" value="6">
							<div id="caixa" style="float:left:width:90%">
                                  <b>Listagem de erros</b>
						   	<div>  
		
							  <p>
							  <% if lcase(session("user"))="admin" then %>
							  Base de dados: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							  <select id="base" name="base" style="width:80px;" onChange="muda_base(this)">
							  <% for i=0 to ubound(entidades)-1 %>
								 <option value="<%=lcase(entidades(i))%>"><%=entidades(i)%></option>
							  <% next%>
							  </select> &nbsp;&nbsp;
							 <% else %>
								<input type="hidden" id="base" name="base" value="<%=lcase(session("user"))%>"> 
							 <%end if%>
							 <input type="hidden" id="nregs" name="nregs" value="<%=totregs%>">
							 <input type="hidden" name="expressao" id="expressao" value="$">
							 MFN's: de <input type="text" id="MFNde" name="MFNde" value="1" size="7" onkeyup="checkValInput(this)">&nbsp; até <input type="text" id="MFNate" name="MFNate" value="<%=totregs%>" size="7" onkeyup="checkValInput(this)">
							<input type="submit" value="Ok" id="validar" name="Submit">		
							 </p>
							 </div>
                               <br />
                              <b>Análise seletiva (campo/subcampo/nº de ocorrências ou texto)</b>
						   	<div> 
							<p >
							  Campo: &nbsp;&nbsp;&nbsp;<select id="canom" name="canom" onChange="muda_campo(this)">
								<option value="005">005-Identificador da versão</option>
								<option value="010">010-ISBN </option>
								<option value="011">011-ISSN</option>
								<option value="020">020-Número bibliográfico nacional</option>
								<option value="021">021-Depóstito legal</option>
								<option value="035">035-Outros números de identificação</option>
								<option value="100">100-Dados gerais de processamento</option>
								<option value="101">101-Língua</option>
								<option value="200">200-Título e menção de responsabilidade</option>
								<option value="205">205-Edição</option>
								<option value="210">210-Publicação</option>
								<option value="215">215-Descrição física</option>
								<option value="225">225-Séries</option>
								<option value="300">300-Notas gerais</option>
								<option value="307">307-Notas (descrição física)</option>
								<option value="465">465-</option>
								<option value="467">467-</option>
								<option value="600">600-Assunto (nome de pessoa)</option>
								<option value="606">606-Assunto (nome comum)</option>
								<option value="675">675-Classificação Decimal Universal</option>
								<option value="700">700-Menção de respons. principal (pessoa)</option>
								<option value="701">701-Outra menção de respons. (pessoa)</option>
								<option value="702">702-Menção de respons. secundária (pessoa)</option>
								<option value="710">710-Menção de respons. principal (coletividade)</option>
								<option value="711">711-Outra menção de respons. (coletividade)</option>
								<option value="712">712-Menção de respons. secundária (coletividade)</option>
								<option value="720">720-Menção de respons. principal (família)</option>
								<option value="721">721-Outra menção de respons. (família)</option>
								<option value="722">722-Menção de respons. secundária (família)</option>
								<option value="801">801-Origem do registo</option>
								<option value="856">856-URL</option>
								<option value="859">859-</option>
								<option value="921">921-Nível hierárquico</option>
								<option value="922">922-Nível bibliográfico</option>
								<option value="930">930-Cota sumário</option>
								<option value="955">955-</option>
								<option value="966">966-Exemplar</option>
								
							  </select>
									
							  &nbsp;&nbsp;Subcampo: <select id="scanom" name="scanom">
								<option value="" selected></option>
							  </select>	
							  </p>
							  <p>
				      			Operador: <select id="opanom" name="opanom" onChange="muda_oper(this)">
								<option value="<"><</option>
								<option value="=" selected>=</option>
								<option value=">">></option>
								<option value="in">contém</option>
								<option value="notin">não contém</option>
							  </select>
				      		  &nbsp;<span id="inputOcorrAnom">Ocorr(as): <input type="text" id="ncanom" size="2" value="0"  onKeyup="checkValInput(this)"></span>
                              &nbsp;<span id="inputTextoAnom" style="display:none">Texto <input type="text" id="txtanom" size="12" value="" ></span>
							  <span id="case-sensitive" style="display:none"><img src="../imagens/case_sensitive.png" align="absmiddle"/><input type="checkbox" value="" id="case" style="margin:-8px 0 0 0;vertical-align:bottom;font-size:1.6m"></span>&nbsp;
				      		  &nbsp;<input type="button" value="Ok" onclick="showDBanom();">
				   			  <div  id="anomalias" style="width:625px"></div>
							</p>
							</div>  
					
							</div>
							</form>
							<div id="nocat1" style="margin:30px 0 0 -80px"></div> 
							 <br />
                           <% else 
						      response.write "Nota: Este utilizador não tem catálogo na REDE" 
						  end if %>				  
						    
						 <% case "2" %>	
						  						  
						 <% if uflag or ucase(session("user"))="ADMIN"  then %>
						<dt>Exportação de registos [formato ISO 2709]</dt><br><br>
						 				
						 <input type="hidden" name="user" value="<%=lcase(session("user"))%>">
						 <input type="hidden" name="isofilepath" value="../tmp/">
						 <input type="hidden" name="tmppath" value="../tmp/">
						 <input type="hidden" name="lim_inicio" value="1">
						 <input type="hidden" name="limites" id="limites" value="<%=totregs%>">
						 
						 <input type="hidden" name="expressao" id="expressao" value="$">
						 
						 <% if lcase(session("user"))="admin" then %>
						 
						  Base de dados: 
						  <select id="base1" name="base" style="width:80px;vertical-align:text-top" onChange="muda_base(this)">
						  <% for i=0 to ubound(entidades)-1 %>
						     <option value="<%=lcase(entidades(i))%>"><%=entidades(i)%></option>
						  <% next%>
						  </select> 
					
						 <% else %>
						 	<input type="hidden" id="base1" name="base" value="<%=lcase(session("user"))%>"> 
						 <%end if%>
						 MFN's: de <input type="text" id="MFNde1" name="MFNde" value="1" size="7">&nbsp; até <input type="text" id="MFNate1" name="MFNate" value="<%=totregs%>" size="7"  onkeyup="checkValInput(this)">
						 <br><br>
						 <div id="exportparam"> 
						 Nome do ficheiro:	
						 <input type="text" id="expfile" name="expfile" size="30" onChange="limpa_msg();" onClick="setText();"> <input type="button" name="exportar" value="Exportar" onClick="chkfields();">
						 <br>
						 </div>
						 <div id="nocat2" style="margin:0 0 0 -80px"></div> 
						 <div id="msgISO" style="display:none;text-align:center"></div>
						  <% else 
						      response.write "Nota: Este utilizador não tem catálogo na REDE" 
						  end if %>
					<%case "3" %>

					 <form>
					 <dd><a href="#" onClick="javascript:window.open('admin_iso_upload.asp?window=yes', 'DocUpload', 'width=600, height=200, dependent=yes, left=150 , top=150, menubar=no, scrollbars=no,status=yes');">Enviar ficheiros bibliográficos para o servidor(ISO 2709)</a></dd>
					 </form>
					
						 <div style="padding-left:20px">
						    <br />
						    <p>Último carregamento: &nbsp;&nbsp;
							 <% if lcase(session("user"))="admin" then %>
							  Selecione a base de dados: 
							  <select id="base2" name="base" style="width:80px" onChange="muda_base(this)">
							  <% for i=0 to ubound(entidades)-1 %>
								 <option value="<%=lcase(entidades(i))%>"><%=entidades(i)%></option>
							  <% next%>
							  </select>
							  </p>
							 <% end if %>
							<div style="display:inline-block">
							<ul style="padding-left:40px;list-style-type: none;">
								<li><div style="width:100px;display:inline-block">ISO 2709: </div> <span class="aviso" id="fiso"></span><span class="aviso" id="fsize"></span></li>
								<li><div style="width:100px;display:inline-block">Data/hora:</div> <span class="aviso" id="time"></span></li>
								<li><div style="width:100px;display:inline-block">Software:</div> <span class="aviso" id="soft"></span></li>
								<li><div style="width:100px;display:inline-block">Codificação:</div> <span class="aviso" id="codepage"></span>&nbsp;<span class="aviso" id="alerta"></span></li>
							</ul> 
							</div>   
						</div>
									 	
					<% end select%>
					</dl>	
					</div>
					<%if lcase(session("user"))<>"admin" then %>	 	
   					<div id="tab10" class="tabcontent">						
						 <br />
						 <dl class="tabmainmenu">
						 <dd><a href="../cgi/www.exe/[in=pesqleitor.in]?expressao=SI <%=ucase(SESSION("user"))%>&ut=<%=ucase(SESSION("user"))%>&from=1&to=25">Editar leitor</a></dd>
							<form name="frmnovoleitor1" action="admin.asp" method="post" >
							<input type="hidden" name="ut" value="<%=ucase(SESSION("user"))%>">
							<input type="hidden" name="op" value="add">
							<input type="hidden" name="tipo" value="lt">
						
							</form>	
							<dd><a href="javascript:document.frmnovoleitor1.submit()">Criar novo</a></dd>
							<form name="frmlistaleitor1" action="../cgi/www.exe/[in=listleitor.in]" method="post" >
							<input type="hidden" name="ut" value="<%=ucase(SESSION("user"))%>">
							<input type="hidden" name="expressao" value="SI <%=ucase(SESSION("user"))%>">
							</form>  
							<dd><a href="javascript:document.frmlistaleitor1.submit()">Lista geral</a></dd>						
						</dl>
					</div>	 
					<% else 
					 if lcase(session("user"))="admin" then 
						strHTML=getUrl(strROOT & "/cgi/www.exe/[in=getpar.in]")
						valores=split(strHTML,",")
		   
					 end if%>	  
   					<div id="tab10" class="tabcontent">						
						
						 <dl style="margin-left:10px;margin-top:5px;">
					      <fieldset class="tabparam" style="float:right"><legend>Sistema</legend>
						   <label for="estado" class="param">Estado   :</label><input type="radio" name="estado" id="estado1" <% if valores(2)="S" then response.write " checked" end if %>>Em linha <input type="radio" name="estado" id="estado2" <% if valores(2)="N" then response.write " checked" end if %>>Manutenção 
						   
						 </fieldset>	
						 <fieldset class="tabparam"><legend>Reservas</legend>
						   <label for="limres" class="param">Limite máx. :</label><input type="text" name="limres" id="limres" value="<%=valores(0)%>" size="2">
						   <label for="maxres" >&nbsp;Nº de Dias  :</label> &nbsp;<input type="text" name="maxres" id="maxres" value="<%=valores(1)%>" size="2"><br>
						   <form name="frmsetcal" id="frmsetcal" action="calendario.asp" method="post" style="margin:6px;font-size:0.9em;height:20px">  
							 <input type="hidden" name="ut" value="<%=ucase(session("user"))%>">
							 <input type="hidden" id="mnu" name="mnu" value="2">
							 <input type="hidden" name="expressao" id="expressao" value="">
						     <input type="button" onClick="javascript:document.frmsetcal.submit();" value="Férias e feriados">
						   </form>

						 </fieldset>
					
						  <fieldset class="tabparam" style="float:right"><legend>Bases bibliográficas</legend>
						   <label for="valida" class="param">Validação :</label><input type="radio" name="valida" id="valida1"  <% if valores(5)="S" then response.write " checked" end if %>>Ativado <input type="radio" name="valida" id="valida2"  <% if valores(5)="N" then response.write " checked" end if %>>Desativado 
						 </fieldset>
						 <fieldset class="tabparam"><legend>Empréstimo</legend>
						   <label for="empind" class="param">Individual :</label><span name="empind" ><input type="radio" name="ei" id="ei1"  <% if valores(3)="S" then response.write " checked" end if %>>Ativado <input type="radio" name="ei" id="ei2"  <% if valores(3)="N" then response.write " checked" end if %>>Desativado</span><br><span style="clear:left"></span> 
						   <label for="empbib" class="param" >Interbibliotecas :</label><span name="empbib"><input type="radio" name="eib" id="eib1"  <% if valores(4)="S" then response.write " checked" end if %>>Ativado <input type="radio" name="eib" id="eib2"  <% if valores(4)="N" then response.write " checked" end if %>>Desativado</span> 
						 </fieldset>
							
						 <fieldset class="tabparam1"><legend>Gráficos [tipo/orientação]</legend>
						   <label for="gres" class="param">Reservas :</label><input type="radio" name="gres" id="gres1"  <% if valores(6)="S" then response.write " checked" end if %>>Horizontal <input type="radio" name="gres" id="gres2"  <% if valores(6)="N" then response.write " checked" end if %>>Vertical<br><span style="clear:left"></span>
						   <label for="gcol" class="param">Coleção :</label><input type="radio" name="gcoltip" id="gcoltip1"  <% if valores(9)="S" then response.write " checked" end if %> onClick="mudagrafop(this)">Colunas <input type="radio" name="gcoltip" id="gcoltip2"  <% if valores(9)="N" then response.write " checked " end if %> onClick="mudagrafop(this)">Circular <span id="grafori" <% if valores(9)="N" then response.write "style=display:none"  end if %>><input type="radio" name="gcol" id="gcol1"  <% if valores(7)="S" then response.write " checked" end if %>>Horizontal <input type="radio" name="gcol" id="gcol2"  <% if valores(7)="N" then response.write " checked" end if %>>Vertical</span>
						   
						 </fieldset>
						 <div style="margin-top:20px;text-align:center;"><input type="button" value="Atualizar" onClick="act_param_res()"> </div>					
						</dl>
					</div>
					<!--<div id="tab11" class="tabcontent">							
						 <dl style="margin-left:80px;margin-top:67px;">
  					     <dd><a href="/opac/cgi/www.exe/[in=lstcomm.in]?expr=$&ut=<%=session("user")%>">Comentários</a></dd>
						 <dd><a href="lstvotos.asp?id=7" >Votações</a></dd>				
						 </dl>
					</div>-->	 					
                    <%end if%>
			   </div>
			</div>
		  <%end if%>		
		  
		    
		<script type="text/javascript">
       <% if request("op")="" then %>
		var menus=new ddtabcontent("tabs")
		menus.setpersist(true)
		menus.setselectedClassTarget("link") //"link" or "linkparent"
		menus.init()
	
		</script>
		
		<script>menus.expandit(<% if request("id")="" then response.write 0 else response.write request("id") end if%>)</script> 
		<%end if%>
     <%
       end if
	   	
	Else
		writeLog("LOGIN (insucesso): nº máx de tentativas")
		Response.Write("<br /><br /><p>Esgotou as três tentativas de ENTRADA no sistema de administração. <br />Terá de fechar esta janela e iniciar nova sessão!</p>")
		
	End If
%>
     
</div>
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

sub lista_bases

end sub
 
%>
