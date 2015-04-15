<% 
   Set fs = Server.CreateObject("Scripting.FileSystemObject")
   response.write fs.FileExists(Server.MapPath(request("vdir") & "/bases/" & request("fname")& ".mst"))

%>