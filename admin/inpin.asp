<%
Response.Expires = 0
Response.Expiresabsolute = Now() - 1 
Response.AddHeader "pragma","no-cache" 
Response.AddHeader "cache-control","private" 
Response.CacheControl = "no-cache" 
%>
<html>
<head>
<title>Definição/Alteração do PIN de Leitor</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</head>
<body>
<form name="detalhes" id="type-details-form"> 
<input type="hidden" value="<%=request("mfn")%>" name="mfn" id="mfn">
<fieldset style="text-align:left">
<legend>PIN do Leitor</legend><br />
<label><%=request("us")%></label><br><br />
<label for="details" style="width:120px">PIN &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:</label>
<input  type="text"  size="10" name="details" id="details" value="<%=request("pin")%>">&nbsp;&nbsp;
<label for="activo" style="width:120px">Ativo:</label>
<input type="radio" id="activo1" name="activo" <% if request("est")=1 then response.write "checked"%>>Sim<input type="radio" id="activo2" name="activo" <% if request("est")=0 then response.write "checked"%>>Não<br />
<label for="msg" style="width:120px">Mensagem:</label> 
<input  type="text" name="msg" id="msg" size="38" value="<%=request("msg")%>">
<br /> <br />
<div align="center">
<input type="button" name="update" value="Confirmar" onclick="lerdados()" class="add-button" /> 
<input type="button" name="close" value="Fechar" onclick="closeLightbox();" class="add-button" /> <br /><br />
</div>
</fieldset>
</form>
<script>document.getElementById("details").focus();</script>
</body>
<%
'DecodeUTF8
'  Decodes a UTF-8 string to the Windows character set
'  Non-convertable characters are replace by an upside
'  down question mark.
'Returns:
'  A Windows string
function DecodeUTF8(s)
  dim i
  dim c
  dim n

  i = 1
  do while i <= len(s)
    c = asc(mid(s,i,1))
    if c and &H80 then
      n = 1
      do while i + n < len(s)
        if (asc(mid(s,i+n,1)) and &HC0) <> &H80 then
          exit do
        end if
        n = n + 1
      loop
      if n = 2 and ((c and &HE0) = &HC0) then
        c = asc(mid(s,i+1,1)) + &H40 * (c and &H01)
      else
        c = 191 
      end if
      s = left(s,i-1) + chr(c) + mid(s,i+n)
    end if
    i = i + 1
  loop
  DecodeUTF8 = s 
end function



%>
</html>
