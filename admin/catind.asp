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
	<script language="JavaScript" src="../js/geral.js"></script> 
    <link rel="icon" href="../favicon.ico" type="image/ico"/>
    <link rel="shortcut icon" href="../favicon.ico" type="image/x-icon"/>
</head>

<body>
    <h3><span>Catálogos</span></h3>
    <div id="principal"> 
    <div id="lblutilizador">Utilizador: <span id="utilizador">
        <% if session("user")="" then response.write "anónimo" else response.write ucase(session("user"))%><%if Session("LoggedIn") then%> &nbsp;[ <a href="admin.asp?Logout=1">Sair</a> ]<%else%> &nbsp;[ <a href="admin.asp">Entrar</a> ]<%end if%>
        </span> </div><p class="fil">» <a href="../default.asp">Início</a> » <a href="admin.asp?id=1">Administração</a> » Visualizar o meu catálogo
	    <div id="admbotoes" style="float:right"><a href="admin.asp?id=1"><img src="../imagens/close.gif" border=0 alt="Voltar à página anterior"></a><% if flag=1 then %><a href="javascript:window.print()"><img src="../imagens/imprimir.gif" border=0 alt="Imprimir esta página"></a><%end if%></div><h3>O meu catálogo</h3>  
	
	
<% if request.querystring("id")=1 then %>
<p><b>Pesquisa orientada</b>:</p>
	
	<form action="../cgi/www.exe/[in=pesqger.in]" method="get" onSubmit="return ValidaData(this)">
		
	 	<input type="hidden" name="expressao" value>
		<input type="hidden" name="lim_inicio" value="1">
		<input type="hidden" name="nomemnu" value="admin/catind.asp?du=0">
		<input type="hidden" name="id" value="1">
		<input type="hidden" name="base" value="<%=lcase(session("user"))%>">
		<input type="hidden" name="entidade" value="<%=sentidade%>">
        <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%> 
       <p>
	    Tipo de documento 
		<select  size="1" name="TDOC">
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
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Analítico</option>
		  <option value="AS">Publicação periódica</option>
		</select>
		 Ano
        <input type="text" size="4" name="DP" maxlength="4"><span class="notas"> (Ex. 2001) </span>
        </p>
		<p>
		Formato
       <select  size="1" name="formato">

				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">Títulos</option>
				  <option value="wibol">Boletim</option>
         </select>
        Registos por página 
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		 </p>
       
		<table>
		<th>Operador</th>
		<th>Campo</th>
		<th>Termo</th>
		<th>Truncatura</th>
		<tr>
			<td>
			</td>
			<td>  <select size="1" name="PRFX1">
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
              <option value="SI">SIGLA</option>
            </select>
           </td>
		   	<td><input type="text" size="40" name="Termo1" maxlength="80"> 
            </td>
		   <td><input type="checkbox" value="$" name="TR1" checked>
			</td>
		
			
		</tr>
		<tr>
			<td><select size="1" name="OP2">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">NÃO</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorrência</option>
             </select>
			</td>
			
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
              <option value="SI">SIGLA</option>
            </select>
			<td><input type="text" size="40" name="Termo2" maxlength="80">
            </td>
			</td><td><input type="checkbox" value="$" name="TR2" checked>
			</td>
		</tr>
		<tr>
			<td>  <select size="1" name="OP3">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">NÃO</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorrência</option>
                  </select>
			</td>
			
			<td>     <select size="1" name="PRFX3">
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
              <option value="SI">SIGLA</option>
            </select>
          </td>
			<td><input type="text"  size="40" name="Termo3" maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR3" checked>
			</td>
		</tr>
		<tr>
			<td><select size="1"  name="OP4">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">NÃO</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorrência</option>
                  </select>
			</td>
			
			<td>  <select size="1" name="PRFX4">
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
              <option value="SI">SIGLA</option>
            </select>
 			</td>
			<td><input type="text"  size="40" name="Termo4" maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR4" checked>
			</td>
		</tr>
		<tr>
			<td><select size="1" name="OP5">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">NÃO</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorrência</option>
                  </select>
			</td>
			
			<td>           <select size="1" name="PRFX5">
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
              <option value="SI">SIGLA</option>
            </select>
      		</td>
			<td><input type="text" size="40" name="Termo5" maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR5" checked>
		    </td>
		</tr>
		<tr>
			<td><select size="1"  name="OP6">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">NÃO</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorrência</option>
                  </select>
			</td>
			
			<td>  <select size="1" name="PRFX6">
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
              <option value="SI">SIGLA</option>
            </select>
			</td>
			<td><input type="text" size="40" name="Termo6" maxlength="80">
			</td>
			<td><input type="checkbox" value="$" name="TR6" checked>
			</td>
		</tr>
		<tr>
			<td><select size="1"  name="OP7">
                    <option value="OR">OU</option>
                    <option selected value="AND">E</option>
                    <option value="AND NOT">NÃO</option>
                    <option value="(G)">Campo</option>
                    <option value="(F)">Ocorrência</option>
                  </select>
			</td>
			
			<td>      <select size="1" name="PRFX7">
              <option value="AU">Autor</option>
              <option value="TI">Título</option>
              <option value="AS">Assunto</option>
              <option value="COL">Coleção</option>
              <option value="ISBN">ISBN</option>   
			  <option value="ISSN">ISSN</option>     
              <option value="CDU">CDU</option>
              <option value="LED">Local</option>
              <option value="PAL">Palavra</option>
              <option value="CT">Cota</option>
			  <option selected value="SI">SIGLA</option>

            </select>
          </td>
			<td><input type="text"  size="40" name="Termo7" maxlength="80">
            </td>
			<td><input type="checkbox" value="$" name="TR7" checked>
			</td>
		</tr>
		</table><br>
	
		 <div align="right"><input type="submit" value="Pesquisar" onClick="return ValidaExpress(this.form)" name="Submit">
        <input type="reset" value="Limpar" name="Reset"></div>
       </form>


<% elseif request.QueryString("id")=0 then%>
			<p><b>Pesquisa simplificada</b>:</p>
	<form action="../cgi/www.exe/[in=pesqger.in]" method="GET">     
        <input type="hidden" name="base" value="<%=lcase(session("user"))%>">  
        <input type="hidden" name="expressao" value>
        <input type="hidden" name="lim_inicio" value="1">
		<input type="hidden" name="id" value="0">
        <input type="hidden" name="nomemnu" value="admin/catind.asp?du=0">
		<input type="hidden" name="entidade" value="<%=sentidade%>">
		  <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%>  
        <p>
	    Tipo de documento 
		<select  size="1" name="TDOC">
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
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Analítico</option>
		  <option value="AS">Publicação periódica</option>
		</select>
		 Ano
        <input type="text" size="4" name="DP" maxlength="4"><span class="notas"> (Ex. 2001) </span>
        </p>
		<p>
		Formato
       <select  size="1" name="formato">

				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">Títulos</option>
				  <option value="wibol">Boletim</option>
         </select>
        Registos por página 
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		 </p>
       
	    <p id="caixa">
        <span class="txtexp">Termo</span>: <input type="text" size="55" name="termo" maxlength="80">
        <input type="checkbox" value="$" name="truncatura">Exata<br>
		<div style="margin-top: 2px;text-align:center;width:350px;"> 
        <input type="radio" value="" name="PRF" checked>Palavra
		<input type="radio" value="AU" name="PRF"> Autor 
        <input type="radio" value="AS" name="PRF" >Assunto
		<input type="radio" value="TI" name="PRF" >Título
		</div>
		  
        </p><br>      
		 <div align="right"><input type="submit" value="Pesquisar" onClick="return ValidaExpress_3(this.form)" name="Submit">
		<input type="reset" value="Limpar" name="Reset"></div>
        
         </form>
	<% elseif request.QueryString("id")=2 then%>
		<p><b>Pesquisa avançada</b>:</p>
	<form action="../cgi/www.exe/[in=pesqger.in]" method="GET">     
        <input type="hidden" name="base" value="<%=lcase(session("user"))%>">  
        <input type="hidden" name="expressao" value>
        <input type="hidden" name="lim_inicio" value="1">
        <input type="hidden" name="id" value="2">
        <input type="hidden" name="nomemnu" value="admin/catind.asp?du=0">
		<input type="hidden" name="entidade" value="<%=sentidade%>">
		 <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%> 
        <p>
	    Tipo de documento 
		<select  size="1" name="TDOC">
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
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Analítico</option>
		  <option value="AS">Publicação periódica</option>
		</select>
		 Ano
        <input type="text" size="4" name="DP" maxlength="4"><span class="notas"> (Ex. 2001) </span>
        </p>
		<p>
		Formato
       <select  size="1" name="formato">

				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">Títulos</option>
				  <option value="wibol">Boletim</option>
         </select>
        Registos por página 
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		 </p>
        <p id="caixa-avan">
		  <textarea rows=3 cols="53" name="termo" tabindex="1"></textarea>
        <br><br>Aqui pode recorrer às várias técnicas e formas de criação de
      expressões de pesquisa <br>(<em>operadores booleanos, de nível e proximidade, truncatura,
      restrição por campos, etc</em>)<br>
      Caso indique mais do que um termo, separe-o por um operador
      booleano<br><strong>AND, OR, AND</strong> ou <strong>NOT</strong></p><br>
      <div align="right"><input type="submit" value="Pesquisar" onClick="return ValidaExpress_4(this.form)" name="Submit">
	  <input type="reset" value="Limpar" name="Reset"></div>
    </form>  
	<%else%>
	  <p><b>Pesquisa por termos</b>:</p>
	 <form ACTION="../cgi/www.exe/[in=pesqtrm.in]" METHOD="get" align="center">
      <input type="hidden" name="expressao" value=" ">
      <input type="hidden" name="base" value="<%=lcase(session("user"))%>">
      <input type="hidden" name="formato0" value="witrm">
	  <input type="hidden" name="id" value="3">
	  <input type="hidden" name="nomemnu" value="admin/catind.asp?du=0"> 
	  <input type="hidden" name="entidade" value="<%=sentidade%>">
	   <% if Session("LoggedIn") then %>
			<input type="hidden" name="ut" value="<%=session("user")%>"> 
		<% else %>
		      <input type="hidden" name="ut" value="guest"> 
	    <% end if%> 
 	  <p>
	    Tipo de documento 
		<select  size="1" name="TDOC">
		  <option selected value="XX">Todos os documentos</option>
		  <option value="AM">Monografia (texto impresso)</option>
		  <option value="BM">Monografia (texto manuscrito)</option>
		  <option value="CM">Partituras musicais - Impressas</option>
		  <option value="DM">Partituras musicais - Manuscritas</option>
		  <option value="EM">Material cartográfico - Impresso</option>
		  <option value="FM">Material cartográfico - Manuscrito</option>
		  <option value="GM">Material de projeção e vídeo</option>
		  <option value="IM">Registos sonoros não Musicais</option>
		  <option value="JM">Registos sonoros musicais</option>
		  <option value="KM">Material gráfico a duas dimensões</option>
		  <option value="LM">Produtos de computador</option>
		  <option value="MM">Multimédia</option>
		  <option value="RM">Artefactos 3D e realia</option>
		  <option value="AA">Analítico</option>
		  <option value="AS">Publicação periódica</option>
		</select>
		 Ano
        <input type="text" size="4" name="DP" maxlength="4"><span class="notas"> (Ex. 2001) </span>
        </p>
		<p>
		Formato
       <select  size="1" name="formato">

				  <option selected value="wiusr">Completo</option>
				  <option value="wiabr">Abreviado</option>
				  <option value="winp405">Norma NP405</option>
				  <option value="wicmp">ISBD</option>
				  <option value="witit">Títulos</option>
				  <option value="wibol">Boletim</option>
         </select>
        Registos por página 
	    <select size="1" name="limites">
			  <option value="5">5</option>
			  <option value="10">10</option>
			  <option selected value="25">25</option>
			  <option value="50">50</option>
			  <option value="100">100</option>
			  <option value="250">250</option>
			  <option value="500">500</option>
	    </select>
		 </p>
                         
         <p>Selecione o campo relativo aos termos a apresentar&nbsp;e digite o termo de pesquisa&nbsp;</p>                 
          <p><select size="1" name="PRFX" tabindex="1">
                  <option selected value="AU">Autor</option>
                  <option value="TI">Título</option>
                  <option value="AS">Assunto</option>
                  <option value="CDU">CDU</option>
                  <option value="COL">Coleção</option>
                  <option value="ISBN">ISBN</option>
				  <option value="ISSN">ISSN</option>     
                  <option value="DL">DL</option>
                  <option value="PAL">Palavra</option>
                  <option value="CT">Cota (Localização)</option>
                  <option value="DP">Data de publicação</option>
				  <option value="SI">SIGLA</option>
                </select>
			<input type="text" size="40" name="termo" tabindex="2" maxlength="80">
           </p>
           <p>Será
                apresentado o índice a partir do termo que indicou. Caso seja
                deixado em branco será apresentada a lista desde o início.
                Cada termo (à excepção das palavras soltas) aparece
                identificado por prefixos (Ex. AU, TI, etc)
            </p><br>
                    
           <div align="right"><input type="submit" value="Listar termos" name="Submit1" onClick="ChkTermo(this.form)" tabindex="4">
		  <input  type="reset" value="Limpar" name="Reset"></div>
               
       </form>
	<% end if%>
	  
  </div> 
</body>
</html>