<% 
function findMatch(inpStr)
  Dim oRe, oMatches
  Set oRe = New RegExp
  oRe.Pattern = "/µ|‡|¡|¢|„|##/"
  
  Set oMatches = oRe.Execute(inpStr)
  ' Get the first item in the Matches collection
  on error resume next
  findMatch=oMatches(0)
  Set oRe = nothing
end function


strFile=request("file")

set FSO = server.createObject("Scripting.FileSystemObject")
Filepath = server.MapPath("/opac/upload/isos/"+strFile)
if not FSO.FileExists(Filepath) Then
    response.write "Erro"  
    response.end
else	 
	Set TextStream = FSO.OpenTextFile(Filepath, 1, False)
	Dim Contents
	Contents = TextStream.ReadAll
	TextStream.Close
	Set TextStream = nothing
	
	if findMatch(Contents)<>"" then
	   response.write "ascii"
	else
	   response.write "ansi"
	end if   
End If
Set FSO = nothing
%>
