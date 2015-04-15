<!--
 * FCKeditor - The text editor for Internet - http://www.fckeditor.net
 * Copyright (C) 2003-2007 Frederico Caldeira Knabben
 * 
 * == BEGIN LICENSE ==
 * 
 * Licensed under the terms of any of the following licenses at your
 * choice:
 * 
 *  - GNU General Public License Version 2 or later (the "GPL")
 *    http://www.gnu.org/licenses/gpl.html
 * 
 *  - GNU Lesser General Public License Version 2.1 or later (the "LGPL")
 *    http://www.gnu.org/licenses/lgpl.html
 * 
 *  - Mozilla Public License Version 1.1 or later (the "MPL")
 *    http://www.mozilla.org/MPL/MPL-1.1.html
 * 
 * == END LICENSE ==
 * 
 * File Name: config.asp
 * 	Configuration file for the File Manager Connector for ASP.
 * 
 * File Authors:
 * 		Frederico Caldeira Knabben (www.fckeditor.net)
-->
<%

' SECURITY: You must explicitelly enable this "uploader" (set it to "True"). 
Dim ConfigIsEnabled
ConfigIsEnabled = True

' Set if the file type must be considere in the target path. 
' Ex: /userfiles/image/ or /userfiles/file/
Dim ConfigUseFileType
ConfigUseFileType = False

' Path to user files relative to the document root.
Dim ConfigUserFilesPath
ConfigUserFilesPath = "/opac/upload/isos/"

' Allowed and Denied extensions configurations.
Dim ConfigAllowedExtensions, ConfigDeniedExtensions
Set ConfigAllowedExtensions	= CreateObject( "Scripting.Dictionary" )
Set ConfigDeniedExtensions	= CreateObject( "Scripting.Dictionary" )

ConfigAllowedExtensions.Add	"File", "iso"
ConfigDeniedExtensions.Add	"File", ""

ConfigAllowedExtensions.Add	"Image", ""
ConfigDeniedExtensions.Add	"Image", "jpg|gif|jpeg|png|bmp"

ConfigAllowedExtensions.Add	"Flash", ""
ConfigDeniedExtensions.Add	"Flash", "swf|fla"

%>