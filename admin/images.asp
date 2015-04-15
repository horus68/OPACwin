<%If Not Session("LoggedIn") = True  Then response.redirect "admin.asp" %>
<!--#include file="config.asp"-->
<%
Response.Expires = 0
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma","no-cache" 
Response.AddHeader "cache-control","private" 
Response.CacheControl = "no-cache" 
%>
<html>
<head>
<title>Selecionar imagens</title>
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
<script type="text/javascript" src="../js/prototype.js"></script>
<script>
function fixar(fpath)
{
  opener.document.getElementById("v11").value=fpath;
  opener.document.getElementById("imlt").src=fpath;
  opener.focus;
  self.close;
}

</script>
<style>
 body, td {
    background: #FFFFFF;
	font: normal 9pt/1em "Lucida Sans", Verdana, Arial, sans-serif;
	color: black;
 }
 input{
	font: normal 10pt/1em "Lucida Sans", Verdana, Arial, sans-serif;
 }
</style>
<%	If Session("LoggedIn") = True  Then %>
		<% if request.QueryString("mode")="doit" then %>	
            <!--#include file="functions.asp"-->
			<%	
		        Server.ScriptTimeout = 1200
				Dim Image()
				If Session("ImageArray") = True Then
				
					ArraySize = UBound(Session("Images"))
					ReDim Preserve Image(ArraySize + 1)
					For imgRun = 1 To ArraySize			
						Image(imgRun) = Session("Images")(imgRun)		
					Next				
				Else			
					ArraySize = 0
					ReDim Image(1)				
				End If
				
				Image(ArraySize + 1) = UploadFile("img")
				Session("ImageArray") = True
	
				If Image(ArraySize + 1) = "None" Then						
					Response.Write("<br><br><p align='center'>A imagem não pôde ser carregada! Use o botão Retroceder do Browser para tentar de novo ou clique <a href='javascript:history.go(-1)'>aqui</a>!</p>")				
				elseif Image(ArraySize + 1) = "Existe" then
					 Response.Write("<br><br><p align='center'>Já existe uma imagem com esse nome no servidor! <br><br><a  href='javascript:window.resizeTo(500,420);history.go(-1)'>Voltar</a></p>")
				Else
					 Response.Write("<br><br><p align='center'><br>A imagem foi carregada com successo. <a  href=""images.asp?expressao=""" & request.querystring("expressao") & ">Clique aqui para fechar a janela</a>!</p>")							
					 								
				End If			
				Session("Images") = Image
			 else %>	

				    <!--#INCLUDE FILE="i_img_util.asp"-->
					<!--#INCLUDE FILE="i_utility.asp"-->
								        		
					<script language="JavaScript">
                   
					
	
					function toggleImage()
					{
					    var sBox= document.getElementById("sBox");
						var i_image= document.getElementById("i_image");
						var img_props= document.getElementById("img_props");
						var factor;	
				 
							if (sBox.selectedIndex != -1)					
							{
							    	
								if (i_image.style.display=="none") i_image.style.display="";
                                var strA=sBox.options[sBox.selectedIndex].value.split("|");
								i_image.src= "<%=strWebDir%>" + strA[0];
								var x=strA[1];
								var y=strA[2];
								i_image.width=x;
								i_image.height=y;
								if (x>110 || y>110) 
								{ 
								      if (x>110) factor1= 110/x;
									  if (y>110) factor2= 100/y;
									  if (factor1<factor2) factor=factor1; else factor= factor2;
									  i_image.width= x* factor;
									  i_image.height= y * factor;
								}
								
								
								img_props.innerHTML = "Altura=" + x + " " ;
								img_props.innerHTML += "Largura=" + y + "<BR>" ;
								img_props.innerHTML += "Tamanho=" + strA[3] + " KB<BR>";
							}
						}
							
						function Upload()
						{
						var x= document.getElementById("upload").style.display;
						   if (x=='none')
						   { 
						   document.getElementById("upload").style.display='';
						   document.getElementById("lista").style.display='none';
						   window.resizeTo(500,250);
						   }
						   else
						   {
							document.getElementById("upload").style.display='none';
							document.getElementById("lista").style.display='';
							window.resizeTo(500,390);
						   }
						}
												
						function transferSelectedFile(s)
						{
							 var sBox= document.getElementById("sBox");	 
							 var imageReturnValue;
							 if (sBox.selectedIndex != -1)  
							 {								
								imageReturnValue = sBox.options[sBox.selectedIndex].value;					
								imgParams (imageReturnValue,s);							
								opener.focus;						
								self.close;
							 }else{
								alert ("Por favor, selecione o ficheiro que quer usar.");
							 }
						}	
					
						
						function DeleteFile()
						{
						    var sBox= document.getElementById("sBox");	 
							if  (sBox.selectedindex !=-1) 
							{
								var delFile = sBox.options[sBox.selectedIndex].text;
								
								var resp = confirm("Tem certeza que quer eliminar o ficheiro '" + delFile + "'?");
								
								if (resp)
								{  
								      var url="delfile.asp?strDir=<%=replace(strDir,"\","\\")%>&delFile=" + delFile;
						   		      new Ajax.Request (url, {     
							          method:"get",  
								      onSuccess: function(transport){ if (transport.responseText !="") alert(transport.responseText);window.location.href = window.location.href
;}});  
							    }
							 }	
							  else alert ("Por favor, selecione o ficheiro que quer eliminar.");
							 
						}
					   
						
						function imgParams(paramString,s)
						{
							if (paramString != "") 
					         {
							    
								var sReturn = paramString.split("|");
								<%if request("op")="novo" then %>
								opener.document.getElementById("v11").value = "../../" + s + sReturn[0];
								opener.document.getElementById("imlt").src= "../" + s +  sReturn[0];
								<%else %>
								opener.document.getElementById("v11").value = "../../" + s + sReturn[0];
								opener.document.getElementById("imlt").src= "../../" + s +  sReturn[0];			
								<%end if%>
							}	
							
						}
						function init()
						{
					   	  window.resizeTo(500,390);
						  document.getElementById("sBox").selectedIndex=0 ;
						  toggleImage();
						}
					</script>
					
			  </head>
					
			<body onload="init();window.focus();">
			<title>Imagens guardadas no servidor</title>
				 <div id="lista">
				    Escolha a imagem pretendida a partir da lista e depois pressione o botão SELECIONAR FICHEIRO (<img SRC="navImages/yes.gif" align="absbottom">) para atualizar. <br> Caso queira, poderá CARREGAR A IMAGEM PARA O SERVIDOR (<img SRC="navImages/upload.gif" align="absbottom">) a partir do seu computador. 
					<table WIDTH="100%">
					<tr>
					<td VALIGN="top" width="200">
					<input SRC="navImages/yes.gif" TYPE="image" VALUE="Selecionar ficheiro" onClick="transferSelectedFile('<%=replace(replace(lcase(strDirROOT),lcase(server.mappath(vdir)& "\") ,""),"\","/") %>')" id="button2" name="button2" TITLE="Selecionar ficheiro">
					<input SRC="navImages/delete.gif" TYPE="image" Value="Eliminar ficheiro" Onclick="DeleteFile()" name="button3" id="button3" TITLE="Eliminar ficheiro"></span>&nbsp;
					<input SRC="navImages/upload.gif" TYPE="image" Value="Carregar imagem para o servidor" Onclick="Upload()" name="button4" id="button4" TITLE="Carregar imagem para o servidor"></span>&nbsp;

						<div style="border: 2px solid green;">
						<select style="font-size:11pt;width:240px" name="sBox" id="sBox" size="9"  onClick="toggleImage()">
						<%
							For Each x in colFiles ' all the files in the current directory
								for v = 0 to ubound(validImageExtensions) 
									if lcase(Right(x.name,3)) = lcase(validImageExtensions(v)) then ' only display valid image files
									
										if gfxSpex(x.Path, w, h, c, strType) = true then ' determine width, height, and size of current image
										   iWIDTH  = w
										   iHEIGHT = h
										   iSIZE   = int(x.size/1000)
										end if		
										
										' we only want the subfolder hierarchy/filename relative to the root image directory 	
										strImagePath = replace(lcase(x.path),strDirROOT,"")
										strImagePath = replace(strImagePath,"\","/")
										strImagePath = right(strImagePath,len(strImagePath))
										
										if request("file") <> "" then
											if lcase(cstr(x.name)) = lcase(cstr(request("file"))) then
												selectMe = " SELECTED"
												didUpload = 1
											else
												selectMe = ""
											end if 
										end if
										
										' write out all the image information to a custom option tag that includes extended HTML attributes
										Response.Write "<OPTION value=""" & strImagePath  & "|" & iWIDTH & "|" & iHEIGHT & "|" & iSIZE & """" & selectMe & ">" & x.name & vbcrlf
										exit for
									end if
								next
							Next
							
							' clean up
							Set objFSObject   = nothing
							Set objFolder     = nothing
							Set colFolders    = nothing
							Set objColFiles   = nothing
							
						%>
						</select>
						</div>
					</td>
					<td VALIGN="top" WIDTH="100%" ALIGN="center"><br><br><br>
                   
					<img SRC="navImages/inviz.gif" NAME="i_image" ID="i_image" STYLE="display:none">
					<br>
					<span ID="img_props" NAME="img_props" style="font-size:7pt"><img src="..\imagens\" & slogo></span>
					</td>
					</tr>
					</table>
					                    
					<div align="right"><a href="javascript:window.self.close()" TITLE="Fechar janela">Fechar</a></div>
                    </div>
					<div id="upload" style="display:none">
					<%

					response.write "<form action=""images.asp?mode=doit&expressao=""" & request("expressao") & " method=""post"" ENCTYPE=""multipart/form-data"">"	 			
					response.write ("<table  width=90% border=0 align=center><tr><td>")
					response.write("<table border=0 width=100% cellspacing=1 cellpadding=2><tr><td  colspan=2>")
					response.write("<h4> Envio de ficheiros de imagem [Fotografia de leitor]</h4></td></tr><tr><td colspan=2 valign=top>")
					response.write("Indique o nome do ficheiro (incluindo o caminho)</td></tr><tr>")
					response.write ("<td>Imagem:</td><td>")
					response.write ("<input type=""file"" name=""FILE1"" accept=""image/gif,image/jpeg,image/x-png""  size=50>")
					response.write ("</td></tr><tr><td align=center colspan=2>")
					response.write ("<input type=""submit"" value=""Enviar""></td></tr>	<tr><td   align=""right"" colspan=2>")					    					      						        
					response.write("<a href=""javascript:Upload()"">Fechar</a>")						  
					response.write ("</td> </tr></table></td> </tr></table></form>")
				
					%>
					</div>
                    <%              
					if didUpload = "1" then
					%>
					<script>
						toggleImage();            
					</script>
					<%end if%>
					
			<% end if%>	
<%	Else %>
<body>
<center>
<%
        response.write "<script>window.resizeTo(500,250);</script>"
        response.write "<p>&nbsp;</p>"
		response.write "<br><br><b>A sua sessão expirou! Terá de voltar a iniciar a sessão.</b><br><br>"
        response.write "<a href=""javascript:window.close();"">Fechar a janela</a>"      
	
%>
</center>
<%		
	End If
%>
</body>