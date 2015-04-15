<!--#include file="admin/functions.asp"-->
<!--#include file="admin/config.asp" -->

 <% 
   referer=request.servervariables("http_referer") 
   if referer = "" then  
		response.end
   end if
   getUrl(strROOT & "/cgi/www.exe/[in=iduser.in]")%>
  <%  
			  redim u1(2,1000)
			  dim siglas
			  Set ObjectoFicheiro = CreateObject("Scripting.fileSystemObject")
			  Set LerTexto = ObjectoFicheiro.OpenTextFile (Server.MapPath("/opac/bases/users.idx"), 1)
			  i=0
			  While NOT LerTexto.AtEndOfStream
			  linha= LerTexto.ReadLine 
			  siglas=split(linha,"=")
			  u1(0,i)=siglas(0)
			  u1(1,i)=siglas(1)
			  i=i+1
			  Wend
			  redim preserve u1(2,i)
			  redim u2(i,2)
			  for i=0 to ubound(u2)-1
			      u2(i,0)=u1(0,i)
				  u2(i,1)=u1(1,i)
			  next
			  DualSorter u2,0
			  Set LerTexto = nothing
			  'response.write i
			  'response.end
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
	<script language="JavaScript" src="js/geral.js"></script> 
    <script language="JavaScript" src="js/jquery-1.5.2.min.js"></script> 
	<script>
	function ChkLinkHref(tipo,formato,linha_in)
	{
	  var dim=0;
	  var tmp="",car="";
	  tmp=ConvUp(linha_in);
	  tmp=FindRepChar(unescape(tmp),"`","\"");
	  var param="/opac/cgi/www.exe/[in=pesqger.in]?base=opac&ut=<%=session("user")%>&formato="+formato+"&lim_inicio=1&limites=1&id=2";
		  param+="&user=<%=session("user")%>&nut=<%=session("nuser")%>&expressao=";
	  dim=tmp.length;
	  car=tmp.charAt(dim-1);
	  return(param);
	}

    function trocaobj(ob){
    var ihtml;
     ihtml="<select size=\"1\" class=\"trm\" name=\"Termo\" ><option value=\"\"></option>";
	 <%for i=0 to ubound(u1)-1%>
        ihtml +="<option value=\"<%=u2(i,0)%>\"><%=u2(i,1)%></option>";
     <%next%> 
     ihtml += "</select>";
  
    switch (ob.name)
     {
      case "PRFX": if(ob.value=="SI") document.getElementById("txtTermo").innerHTML=ihtml.replace("Termo","termo");  else document.getElementById("txtTermo").innerHTML="<input type=\"text\" size=\"59\" name=\"termo\" maxlength=\"80\">";break;
      case "PRFX1":if(ob.value=="SI") {document.getElementById("td1").innerHTML=ihtml.replace("Termo","Termo1");}  else {document.getElementById("td1").innerHTML="<input type=\"text\" size=\"59\" name=\"Termo1\" maxlength=\"80\">"};break;
      case "PRFX2":if(ob.value=="SI") {document.getElementById("td2").innerHTML=ihtml.replace("Termo","Termo2");}  else {document.getElementById("td2").innerHTML="<input type=\"text\" size=\"59\" name=\"Termo2\" maxlength=\"80\">"};break;
      case "PRFX3":if(ob.value=="SI") {document.getElementById("td3").innerHTML=ihtml.replace("Termo","Termo3");}  else {document.getElementById("td3").innerHTML="<input type=\"text\" size=\"59\" name=\"Termo3\" maxlength=\"80\">"};break;
      case "PRFX4":if(ob.value=="SI") {document.getElementById("td4").innerHTML=ihtml.replace("Termo","Termo4");}  else {document.getElementById("td4").innerHTML="<input type=\"text\" size=\"59\" name=\"Termo4\" maxlength=\"80\">"};break;
      case "PRFX5":if(ob.value=="SI") {document.getElementById("td5").innerHTML=ihtml.replace("Termo","Termo5");}  else {document.getElementById("td5").innerHTML="<input type=\"text\" size=\"59\" name=\"Termo5\" maxlength=\"80\">"};break;
      case "PRFX6":if(ob.value=="SI") {document.getElementById("td6").innerHTML=ihtml.replace("Termo","Termo6");}  else {document.getElementById("td6").innerHTML="<input type=\"text\" size=\"59\" name=\"Termo6\" maxlength=\"80\">"};break;
      case "PRFX7":if(ob.value=="SI") {document.getElementById("td7").innerHTML=ihtml.replace("Termo","Termo7");}  else {document.getElementById("td7").innerHTML="<input type=\"text\" size=\"59\" name=\"Termo7\" maxlength=\"80\">"};break;
     } 
    }
	
   function SwapFilter() {
      $('#txtfilter').html('[Tipo='+$('#tdoc :selected').text()+' ; Formato='+$('#formato :selected').text()+' ; Rp='+$('#limites :selected').text()+ ($('#dp').val() !=''? ' ; AP='+ $('#dp').val():'') + ($("#truncatura").length > 0 ? ($("#truncatura").is(':checked') ? ' ; Exata=sim':' ; Exata=não'):'')+']');
   }   
   $(document).ready(function(){ 
   //$('.radioButton').click(function() { 
      //var f=$(this).attr("checked");
      //$('.radioButton').attr("checked", true); 
      //$(this).attr("checked", f); 
   //});
   
   SwapFilter();
   $('#slickbox').hide(); 
   $('#slick-show').click(function() {
	 if ($(this).attr('src')=='imagens/arrow_down.gif') {
	    url=$(this).attr('src').replace(/arrow_down.gif/,'arrow_up.gif');
		$(this).attr('alt','esconder filtros');
	    $(this).attr('title','esconder filtros');
     }else{
       	url=$(this).attr('src').replace(/arrow_up.gif/,'arrow_down.gif'); 
		$(this).attr('alt','mostrar filtros');
	    $(this).attr('title','mostrar filtros');
	 }	
	 $(this).attr('src',url);
	 $('#slickbox').toggle(400);
    return false;
   });
  });

</script>
	<link rel="icon" href="favicon.ico" type="image/ico"/>
	<link rel="shortcut icon" href="favicon.ico" type="image/x-icon"/>
</head>

<body>

    <h3><span>Catálogos</span></h3>
    <div id="principal"> 
	
	<div id="lblutilizador"><span id="utilizador"> 
        <% if session("user")="" then 
		    response.write "Utilizador: anónimo"
		  elseif session("LeitorIn") then 
		    response.write "Utilizador: " & DecodeUTF8(session("user")) 
		  else response.write "Utilizador: " & ucase(session("user")) 
		  end if%>
		  <%if Session("LoggedIn") or session("LeitorIn") then%> [ <a href="logout.asp?sys=admin">Sair</a> ]<%end if%>
        </span>
		</div>
      <p class="fil" >» <a href="default.asp">Início</a> »
        <% 
		select case request.querystring("bd")
		case "col"
		    base="opac"
			designacao="Coletivo"
		case else
		    designacao=ucase(request("bd"))
		end select
		select case request("id")
		case 1 
		     response.write "Pesquisa orientada"
		case 0
		     response.write "Pesquisa simplificada"
		case 2
		     response.write "Pesquisa avançada"
		case 3
		     response.write "Pesquisa por palavra-chave"
		end select
		%>
      </p>
	  <span style="float:right;"><% if session("nuser")<>"" then %><a  href="javascript:void(0)"   onclick="javascript:alterarPin()"><img src="imagens/person.gif"  border="0" alt="Aletar o meu PIN" align="absmiddle"></a><% end if%> <%if (session("user")<>"" and session("user") <> "ADMIN") or session("nuser")<>"" then %><a href="javascript:void(0)" onclick="javascript:build_reservas(&quot;<%=DecodeUTF8(session("user"))%>&quot;,&quot;<%=session("nuser")%>&quot;)"><img src="imagens/basket_3.gif"  border="0" alt="As minhas reservas" align="absmiddle"></a><%end if%></span>		  

      <p>&nbsp;</p>
      <% if request.querystring("id")=1 then %>
      <form action="cgi/www.exe/[in=pesqger.in]" method="get" onSubmit="return ValidaData(this)">
        <input type="hidden" name="expressao" value>
        <input type="hidden" name="lim_inicio" value="1">
        <input type="hidden" name="nomemnu" value="catpesq.asp?bd=<%=request.querystring("bd")%>">
		<input type="hidden" name="id" value="1">
        <input type="hidden" name="base" value="<%=base%>">
        <% if Session("LoggedIn") or session("LeitorIn") then %>
        <input type="hidden" name="ut" value="<%=DecodeUTF8(session("user"))%>">
        <% else %>
        <input type="hidden" name="ut" value="guest">
        <% end if%>
		<input type="hidden" name="nut" value="<%=session("nuser")%>">
		<input type="hidden" name="ent" value="<%=session("entidade")%>">
		Filtros: <img id="slick-show" src="imagens/arrow_down.gif" border="0" alt="mostrar filtros" title="mostrar filtros" align="absmiddle" style="cursor:pointer" width="24"/><span  style="font-size:0.8em;color:red;margin-left:15px" id="txtfilter"></span><br />
		
		<div style="margin-top: 12px;width:600px;"> 
		<div id="slickbox">
        Tipo de documento: 
        <select  size="1" name="TDOC" id="tdoc" onchange="SwapFilter()">
          <option selected value="XX">Todos os documentos</option>
          <option value="AM">Monografia (texto impresso)</option>
          <option value="BM">Monografia (texto manuscrito)</option>
          <option value="CM">Partituras musicais - Impressas</option>
          <option value="DM">Partituras musicais - Manuscritas</option>
          <option value="EM">Material cartográfico - Impresso</option>
          <option value="FM">Material cartográfico - Manuscrito</option>
          <option value="GM">Material de projeção e vídeo</option>
          <option value="IM">Registos sonoros não musicais</option>
          <option value="JM">Registos sonoros msicais</option>
          <option value="KM">Material gráfico a duas dimensões</option>
          <option value="LM">Produtos de computador</option>
          <option value="MM">Multimédia</option>
          <option value="RM">Artefatos 3D e realia</option>
          <option value="AA">Analítico</option>
          <option value="AS">Publicação periódica</option>
        </select>
        Ano de publicação: 
        <input type="text" size="4" name="DP" id="dp" maxlength="4" onchange="SwapFilter()">
         
        <p>Formato de visualização: 
          <select  size="1" name="formato" id="formato" onchange="SwapFilter()">
            <option selected value="wiusr">Completo</option>
            <option value="wiabr">Abreviado</option>
            <option value="winp405">Norma NP405</option>
            <option value="wicmp">ISBD</option>
            <option value="witit">Títulos</option>
            <option value="wibol">Boletim</option>
          </select>
          Registos por página: 
          <select size="1" name="limites" id="limites" onchange="SwapFilter()">
            <option value="5">5</option>
            <option value="10">10</option>
            <option selected value="25">25</option>
            <option value="50">50</option>
            <option value="100">100</option>
            <option value="250">250</option>

          </select>
        </p>
		</div>
		</div>
        <table>
          <th>Operador</th>
          <th>Campo</th>
          <th>Termo</th>
          <th>Truncatura</th>
          <tr> 
            <td> </td>
            <td> <select size="1" name="PRFX1">
                <option selected value="AU">Autor</option>
                <option value="TI">Título</option>
                <option value="AS">Assunto</option>
                <option value="COL">Coleção</option>
                <option value="ISBN">ISBN</option>
                <option value="ISSN">ISSN</option>
                <option value="CDU">CDU</option>
                <option value="LED">Local</option>
                <option value="PAL">Palavra</option>
                <option value="CT">Cota</option>
                <option value="SI">Biblioteca</option>
              </select> </td>
            <td><input type="text" size="59" name="Termo1" maxlength="80"> </td>
            <td><input type="checkbox" value="$" name="TR1" checked> </td>
          </tr>
          <tr> 
            <td><select size="1" name="OP2">
                <option value="OR">OU</option>
                <option selected value="AND">E</option>
                <option value="AND NOT">NÃO</option>
                <!--<option value="(G)">Campo</option>
                <option value="(F)">Ocorrência</option>-->
              </select> </td>
            <td> <select size="1" name="PRFX2">
                <option value="AU">Autor</option>
                <option selected value="TI">Título</option>
                <option value="AS">Assunto</option>
                <option value="COL">Coleção</option>
                <option value="ISBN">ISBN</option>
                <option value="ISSN">ISSN</option>
                <option value="CDU">CDU</option>
                <option value="LED">Local</option>
                <option value="PAL">Palavra</option>
                <option value="CT">Cota</option>
                <option value="SI">Biblioteca</option>
              </select> 
            <td><input type="text" size="59" name="Termo2" maxlength="80"> </td></td>
            <td><input type="checkbox" value="$" name="TR2" checked> </td>
          </tr>
          <tr> 
            <td> <select size="1" name="OP3">
                <option value="OR">OU</option>
                <option selected value="AND">E</option>
                <option value="AND NOT">NÃO</option>
                <!--<option value="(G)">Campo</option>
                <option value="(F)">Ocorrência</option>-->
              </select> </td>
            <td> <select size="1" name="PRFX3">
                <option value="AU">Autor</option>
                <option value="TI">Título</option>
                <option selected value="AS">Assunto</option>
                <option value="COL">Coleção</option>
                <option value="ISBN">ISBN</option>
                <option value="ISSN">ISSN</option>
                <option value="CDU">CDU</option>
                <option value="LED">Local</option>
                <option value="PAL">Palavra</option>
                <option value="CT">Cota</option>
                <option value="SI">Biblioteca</option>
              </select> </td>
            <td><input type="text"  size="59" name="Termo3" maxlength="80"> </td>
            <td><input type="checkbox" value="$" name="TR3" checked> </td>
          </tr>
          <tr> 
            <td><select size="1"  name="OP4">
                <option value="OR">OU</option>
                <option selected value="AND">E</option>
                <option value="AND NOT">NÃO</option>
                <!--<option value="(G)">Campo</option>
                <option value="(F)">Ocorrência</option>-->
              </select> </td>
            <td> <select size="1" name="PRFX4">
                <option value="AU">Autor</option>
                <option value="TI">Título</option>
                <option value="AS">Assunto</option>
                <option selected value="COL">Coleção</option>
                <option value="ISBN">ISBN</option>
                <option value="ISSN">ISSN</option>
                <option value="CDU">CDU</option>
                <option value="LED">Local</option>
                <option value="PAL">Palavra</option>
                <option value="CT">Cota</option>
                <option value="SI">Biblioteca</option>
              </select> </td>
            <td><input type="text"  size="59" name="Termo4" maxlength="80"> </td>
            <td><input type="checkbox" value="$" name="TR4" checked> </td>
          </tr>
          <tr> 
            <td><select size="1" name="OP5">
                <option value="OR">OU</option>
                <option selected value="AND">E</option>
                <option value="AND NOT">NÃO</option>
                <!--<option value="(G)">Campo</option>
                <option value="(F)">Ocorrência</option>-->
              </select> </td>
            <td> <select size="1" name="PRFX5">
                <option value="AU">Autor</option>
                <option value="TI">Título</option>
                <option value="AS">Assunto</option>
                <option value="COL">Coleção</option>
                <option selected value="ISBN">ISBN</option>
                <option value="ISSN">ISSN</option>
                <option value="CDU">CDU</option>
                <option value="LED">Local</option>
                <option value="PAL">Palavra</option>
                <option value="CT">Cota</option>
                <option value="SI">Biblioteca</option>
              </select> </td>
            <td><input type="text" size="59" name="Termo5" maxlength="80"> </td>
            <td><input type="checkbox" value="$" name="TR5" checked> </td>
          </tr>
          <tr> 
            <td><select size="1"  name="OP6">
                <option  value="OR">OU</option>
                <option selected value="AND">E</option>
                <option value="AND NOT">NÃO</option>
                <!--<option value="(G)">Campo</option>
                <option value="(F)">Ocorrência</option>-->
              </select> </td>
            <td> <select size="1" name="PRFX6">
                <option value="AU">Autor</option>
                <option value="TI">Título</option>
                <option value="AS">Assunto</option>
                <option value="COL">Coleção</option>
                <option value="ISBN">ISBN</option>
                <option value="ISSN">ISSN</option>
                <option value="CDU">CDU</option>
                <option value="LED">Local</option>
                <option selected value="PAL">Palavra</option>
                <option value="CT">Cota</option>
                <option value="SI">Biblioteca</option>
              </select> </td>
            <td><input type="text"  size="59" name="Termo6" maxlength="80"> </td>
            <td><input type="checkbox" value="$" name="TR6" checked> </td>
          </tr>
          <tr> 
            <td><select size="1"  name="OP7">
                <option value="OR">OU</option>
                <option selected value="AND">E</option>
                <option value="AND NOT">NÃO</option>
                <!--<option value="(G)">Campo</option>
                <option value="(F)">Ocorrência</option>-->
              </select> </td>
            <td> <select size="1" name="PRFX7">
                <option value="AU">Autor</option>
                <option value="TI">Título</option>
                <option value="AS">Assunto</option>
                <option value="COL">Coleção</option>
                <option value="ISBN">ISBN</option>
                <option value="ISSN">ISSN</option>
                <option value="CDU">CDU</option>
                <option value="LED">Local</option>
                <option  value="PAL">Palavra</option>
                <option value="CT">Cota</option>
                <option selected value="SI">Biblioteca</option>
              </select> </td>
            <!--<td><input type="text" size="30" name="Termo7" maxlength="80"> </td>-->
			<td id="td7">  
			    <select name="Termo7" style="width:390px;"><option value=""></option>
				 <%for i=0 to ubound(u2)-1%>
                     <option value=<%=u2(i,0)%>><%=u2(i,1)%></option>
                  <%next%> 
              </select> </td>
            <td><input type="checkbox" value="$" name="TR7" checked> </td>
          </tr>
        </table>
        <br>
        <div align="right"> 
          <input type="submit" value="Pesquisar" onClick="return ValidaExpress(this.form)" name="Submit">
          <input type="reset" value="Limpar" name="Reset">
        </div>
      </form>
      <% elseif request.QueryString("id")=0 then%>
      <form action="cgi/www.exe/[in=pesqger.in]" method="get">
        <input type="hidden" name="base" value="<%=base%>">
        <input type="hidden" name="expressao" value>
        <input type="hidden" name="html_form" value="opac">
        <input type="hidden" name="lim_inicio" value="1">
        <input type="hidden" name="nomemnu" value="catpesq.asp?bd=<%=request.querystring("bd")%>">
		<input type="hidden" name="id" value="0">
        <% if Session("LoggedIn") or session("LeitorIn") then %>
        <input type="hidden" name="ut" value="<%=DecodeUTF8(session("user"))%>">
        <% else %>
        <input type="hidden" name="ut" value="guest">
        <% end if%>
		<input type="hidden" name="nut" value="<%=session("nuser")%>">
		<input type="hidden" name="ent" value="<%=session("entidade")%>">
         
		 Filtros: <img id="slick-show" src="imagens/arrow_down.gif" border="0" alt="mostrar filtros" title="mostrar filtros" align="absmiddle" style="cursor:pointer" width="24"/><span  style="font-size:0.8em;color:red;margin-left:45px" id="txtfilter"></span><br />
         <div style="margin-top: 12px;width:600px;"> 

		  <div id="slickbox">
		  <p>Tipo de documento: 
          <select  size="1" name="TDOC" id="tdoc" onchange="SwapFilter()">
            <option selected value="XX">Todos os documentos</option>
            <option value="AM">Monografia (texto impresso)</option>
            <option value="BM">Monografia (texto manuscrito)</option>
            <option value="CM">Partituras musicais - Impressas</option>
            <option value="DM">Partituras musicais - Manuscritas</option>
            <option value="EM">Material cartográfico - Impresso</option>
            <option value="FM">Material cartográfico - Manuscrito</option>
            <option value="GM">Material de projeção e vídeo</option>
            <option value="IM">Registos sonoros não musicais</option>
            <option value="JM">Registos sonoros musicais</option>
            <option value="KM">Material gráfico a duas dimensões</option>
            <option value="LM">Produtos de computador</option>
            <option value="MM">Multimédia</option>
            <option value="RM">Artefatos 3D e realia</option>
            <option value="AA">Analítico</option>
            <option value="AS">Publicação periódica</option>
          </select>
          Ano de publicação: 
          <input type="text" size="4" name="DP" id="dp" maxlength="4" onchange="SwapFilter()">
          </p>
		 <p> Formato de visualização: 
          <select  size="1" name="formato" id="formato" onchange="SwapFilter()">
            <option selected value="wiusr">Completo</option>
            <option value="wiabr">Abreviado</option>
            <option value="winp405">Norma NP405</option>
            <option value="wicmp">ISBD</option>
            <option value="witit">Títulos</option>
            <option value="wibol">Boletim</option>
          </select>
          &nbsp;&nbsp;&nbsp;Registos/página: 
          <select size="1" name="limites" id="limites" onchange="SwapFilter()">
            <option value="5">5</option>
            <option value="10">10</option>
            <option selected value="25">25</option>
            <option value="50">50</option>
            <option value="100">100</option>
            <option value="250">250</option>
          </select>

         </p> 
		 <br />
		 </div>
		 
		 </div>
        <div id="caixa"> 
		  <div style="float:right">    
			<input type="submit" value="Pesquisar" onClick="return ValidaExpress_3(this.form)" name="Submit">
			<input type="reset" value=" Limpar " name="Reset">
		  </div>
		  <span class="txtexp">Palavra/Expressão</span>: 
          <input type="text" size="68" name="termo" id="simptrm" maxlength="80">
		</div>
	
        
      </form>
	  <%else %>
	    <form action="cgi/www.exe/[in=pesqger.in]" method="get">
        <input type="hidden" name="base" value="<%=base%>">
        <input type="hidden" name="expressao" value>
		<input type="hidden" name="lim_inicio" value="1">
        <input type="hidden" name="nomemnu" value="catpesq.asp?bd=<%=request.querystring("bd")%>">
		<input type="hidden" name="id" value="2">
        <% if Session("LoggedIn") or session("LeitorIn") then %>
        <input type="hidden" name="ut" value="<%=DecodeUTF8(session("user"))%>">
        <% else %>
        <input type="hidden" name="ut" value="guest">
        <% end if%>
		<input type="hidden" name="nut" value="<%=session("nuser")%>">
		<input type="hidden" name="ent" value="<%=session("entidade")%>">
        Filtros: <img id="slick-show" src="imagens/arrow_down.gif" border="0" alt="mostrar filtros" title="mostrar filtros" align="absmiddle" style="cursor:pointer" width="24"/><span  style="font-size:0.8em;color:red;margin-left:20px" id="txtfilter"></span><br />
		<div style="margin-top: 12px;width:600px;"> 
		  <div id="slickbox">
		  <p>  Tipo de documento: 
          <select  size="1" name="TDOC" id="tdoc" onchange="SwapFilter()">
            <option selected value="XX">Todos os documentos</option>
            <option value="AM">Monografia (texto impresso)</option>
            <option value="BM">Monografia (texto manuscrito)</option>
            <option value="CM">Partituras musicais - Impressas</option>
            <option value="DM">Partituras musicais - Manuscritas</option>
            <option value="EM">Material cartográfico - Impresso</option>
            <option value="FM">Material cartográfico - Manuscrito</option>
            <option value="GM">Material de projeção e vídeo</option>
            <option value="IM">Registos sonoros não musicais</option>
            <option value="JM">Registos sonoros musicais</option>
            <option value="KM">Material gráfico a duas dimensões</option>
            <option value="LM">Produtos de computador</option>
            <option value="MM">Multimédia</option>
            <option value="RM">Artefatos 3D e realia</option>
            <option value="AA">Analítico</option>
            <option value="AS">Publicação periódica</option>
          </select>
          Ano de publicação: 
          <input type="text" size="4" name="DP" id="dp" maxlength="4" onkeyup="SwapFilter()">
          </p>
          <p > Formato de visualização: 
		 
          <select  size="1" name="formato" id="formato" onchange="SwapFilter()">
            <option selected value="wiusr">Completo</option>
            <option value="wiabr">Abreviado</option>
            <option value="winp405">Norma NP405</option>
            <option value="wicmp">ISBD</option>
            <option value="witit">Títulos</option>
            <option value="wibol">Boletim</option>
          </select>

          &nbsp;&nbsp;&nbsp;Registos/página:
          <select size="1" name="limites" id="limites" onchange="SwapFilter()">
            <option value="5">5</option>
            <option value="10">10</option>
            <option selected value="25">25</option>
            <option value="50">50</option>
            <option value="100">100</option>
            <option value="250">250</option>
            
          </select>
		  &nbsp;&nbsp;&nbsp;Exata <input type="checkbox" value="$" name="truncatura" id="truncatura" onclick="SwapFilter()">
		 </p> 
         <br /> 
		</div>
		
		</div>
        <div id="caixa"> 
		  <div style="float:right"> 
          <input type="submit" value="Pesquisar" onClick="return ValidaExpress_5(this.form)" name="Submit">
          <input type="reset" value=" Limpar " name="Reset">
          </div>
		  
		  <span class="txtexp"> Palavra-chave</span>: 
          <input type="text" size="74" name="termo" maxlength="80"> 
		  
        </div>  
        
      </form>
	   <% if ucase(session("user"))="ADMIN" then
	        strHTML=getUrl(strROOT & "/cgi/www.exe/[in=gettags.in]?expr=MFN $")
	      else
	        strHTML=getUrl(strROOT & "/cgi/www.exe/[in=gettags.in]?expr=(MFN $) AND (LTR " & session("nuser") & ")")
	      end if
		  tabela=split(strHTML,",")
		  redim tmp(ubound(tabela)\2-1)
		  k=0
		  for i=0 to ubound(tabela)-1 step 2
			  tmp(k)=tabela(i)
			  k=k+1
		  next
		  alfavalores=sortArray(tmp)
		 response.write "<div style=""clear:both"">"
         response.write "<fieldset style=""padding:15px"">"
		  response.write "<legend style=""padding-bottom:10px"">Lista de palavras-chave</legend>"
          response.write GenerateTagCloud (alfavalores, true)
		  'for i=0 to ubound(alfavalores)
		'	if alfavalores(i)<>"" then 			 
		'	 response.write "<span class=""tagBox-item""><a href="""
		'	 response.write "javascript:window.location.href=""javascript:chkLinkHref(0,&quot;wiusr&quot;,&quot;"&alfavalores(i)& "&quot;)"">" & alfavalores(i) & "</a></span>" 
		'	end if 
		'  next 	 
		  response.write "</fieldset>"
		  response.write "<div>"
       end if%>
    </div>


</body>
</html>
