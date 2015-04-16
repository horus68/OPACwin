<%

strImageRoot  =  lcase( server.mappath(vdir) &  "\upload\fotos\leitores\")

validImageExtensions = "jpg,gif,png"

imageArray = array(".jpg", ".gif", ".png")

maxImageFileSize = 500 * 1024

maxSubFolderInColumn = 2

strServerName = "http://" & request.servervariables("SERVER_NAME") 

strImageWebRoot  =  strServerName & vdir & "/upload/fotos/leitores/" 

%>
