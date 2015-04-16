<%
sfile= request("file")
dim fs,f
set fs=Server.CreateObject("Scripting.FileSystemObject")
set f=fs.GetFile(server.MapPath("/opac/upload/isos/" & sfile))
Response.Write(f.DateLastModified & "#" & f.size)
set f=nothing
set fs=nothing
%>
