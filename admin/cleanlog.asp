<%  
If Not Session("LoggedIn") = True  Then response.redirect "admin.asp"
vdir = "/" & Split(Request.ServerVariables("SCRIPT_NAME"), "/")(1)  
Set ObjectoFicheiro = CreateObject("Scripting.fileSystemObject")
Set file = ObjectoFicheiro.GetFile(Server.MapPath(vdir & "/upload/logs/admin.log"))
if file.size >0 then
    ObjectoFicheiro.CopyFile Server.MapPath(vdir & "/upload/logs/admin.log"), Server.MapPath(vdir & "/upload/logs/admin-backup.log") 
end if
set file= ObjectoFicheiro.CreateTextFile(Server.MapPath(vdir & "/upload/logs/admin.log"), true) 
set file=nothing
set ObjectoFicheiro =nothing
response.redirect "admin.asp?id=1"
%>
