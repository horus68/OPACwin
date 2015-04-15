<!--#INCLUDE FILE="i_settings.asp"-->

<%

	Dim objFSObject, objFolder, colFiles, x, strFName, strDate
	    
	'Application root folders
	
    strScript = request.serverVariables("SCRIPT_NAME")
    strScript = split(strScript,"/")
    sIndex=ubound(strScript)
	
	strCurrentScript = strScript(sIndex) 

	'check current script before setting strDirRoot
	if strCurrentScript = "images.asp"  then
		strDirRoot = strImageRoot
		strWebDir = strImageWebRoot
	end if
	
	
	' get the current navigated folder	
	if request("strDir") = "" then
		strDir = strDirRoot
	else
		strDir = lcase(request("strDir"))
	end if


	'split strings into arrays
	validImageExtensions = split(validImageExtensions,",")
		
	
    'initialize the filesystem stuff
	Set objFSObject   = CreateObject("Scripting.FileSystemObject")
	Set objFolder     = objFSObject.GetFolder(strDir)
	Set colFolders    = objFolder.subFolders
	Set colFiles      = objFolder.Files	
		
%>