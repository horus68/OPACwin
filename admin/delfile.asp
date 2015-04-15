<%  
   
   filespec = request("strDir") & request("delFile")
   on error resume next
   Dim fso
   Set fso = CreateObject("Scripting.FileSystemObject")
   fso.DeleteFile(filespec)
   if Err<>0 then response.write Err.description 
%>   
 