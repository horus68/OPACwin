<% 

Function BinaryToString(xBinary)

Dim Binary
Dim RS, LBinary

If VarType(xBinary)=8 Then Binary = MultiByteToBinary(xBinary) Else Binary = xBinary
Const adLongVarChar = 201
Set RS = CreateObject("ADODB.Recordset")
LBinary = LenB(Binary)

If LBinary>0 Then
	RS.Fields.Append "mBinary", adLongVarChar, LBinary
	RS.Open
	RS.AddNew
	RS("mBinary").AppendChunk Binary 
	RS.Update
	BinaryToString = RS("mBinary")
Else
	BinaryToString = ""
End If

Set RS=Nothing

End Function

Function MultiByteToBinary(MultiByte)

Dim RS, LMultiByte, Binary
Const adLongVarBinary = 205

Set RS = CreateObject("ADODB.Recordset")
LMultiByte = LenB(MultiByte)

If LMultiByte>0 Then
	RS.Fields.Append "mBinary", adLongVarBinary, LMultiByte
	RS.Open
	RS.AddNew
	RS("mBinary").AppendChunk MultiByte & ChrB(0)
	RS.Update
	Binary = RS("mBinary").GetChunk(LMultiByte)
End If

Set RS = Nothing
MultiByteToBinary = Binary

End Function

Function IIf(condition,value1,value2)
	If condition Then IIf = value1 Else IIf = value2
End Function
Function getUrl(surl)

	Dim objXmlHttp
    Dim strHTML
	Set objXmlHttp = Server.CreateObject("Msxml2.ServerXMLHTTP")
    objXmlHttp.open "GET", surl , False
	objXmlHttp.send
	
	On Error Resume Next  

	'Wait for up to 15 seconds to receive the data.   
	If objXmlHttp.ReadyState <> 4 Then  
	  objXmlHttp.WaitForResponse 15   
	End If  
	  
	If (objXmlHttp.ReadyState <> 4) Or (objXmlHttp.Status <> 200) Then  
	  'Abort the request.   
	  objXmlHttp.Abort   
	  strHTML = "<br /><br /><p class=""aviso"">Servidor Indisponível.<br>Não é possível continuar...</p>"
	  response.write strHTML
	  response.end   
	End if		


	strHTML = objXmlHttp.responseBody
	strHTML= BinaryToString(strHTML)

    getUrl=strHTML
	set objXmlHttp = nothing
	
end function

Sub WriteFile(sFilePathAndName,sFileContents)   
  Const ForWriting =2 
  Set oFS = Server.CreateObject("Scripting.FileSystemObject") 
  Set oFSFile = oFS.OpenTextFile(sFilePathAndName,ForWriting,True) 
  oFSFile.Write(sFileContents) 
  oFSFile.Close 
  Set oFSFile = Nothing 
  Set oFS = Nothing 

End Sub 

Function ReadFile(sFilePathAndName) 
   dim sFileContents 
   Set oFS = Server.CreateObject("Scripting.FileSystemObject") 
   If oFS.FileExists(sFilePathAndName) = True Then 
      Set oTextStream = oFS.OpenTextFile(sFilePathAndName,1) 
      sFileContents = oTextStream.ReadAll 
      oTextStream.Close 
      Set oTextStream = nothing 
   End if 
   Set oFS = nothing 
   ReadFile = sFileContents 

End Function 

Sub ReadFileLineByLine(sFilePathAndName) 
   Const ForReading = 1 
   Const ForWriting = 2 
   Const ForAppending = 8 
   Const TristateUseDefault = -2 
   Const TristateTrue = -1 
   Const TristateFalse = 0 

   Dim oFS 
   Dim oFile 
   Dim oStream 
   Set oFS = Server.CreateObject("Scripting.FileSystemObject") 
   Set oFile = oFS.GetFile(sFilePathAndName) 
   Set oStream = oFile.OpenAsTextStream(ForReading, TristateUseDefault) 
   Do While Not oStream.AtEndOfStream 
      sRecord=oStream.ReadLine 
      Response.Write  sRecord 
   Loop 
   oStream.Close 
End Sub 

Function FormatStr(strTemp)

	strTemp = Replace(strTemp, chr(13), "")
	strTemp = Replace(strTemp, chr(10), "<br>")
	strTemp = Replace(strTemp, "<br><br><br><br>", "<br><br>")
	strTemp = Replace(strTemp, "<br><br><br>", "<br><br>")
	strTemp = Replace(strTemp, chr(34), "'")
	strTemp = Replace(strTemp, "(", "[")
	strTemp = Replace(strTemp, ")", "]")
	
	FormatStr = strTemp
	
End Function


Function ChkHTTP(strTemp)

	If Not InStr(1, strTemp, "http://") > 0 Then
		
		strTemp = "http://" & strTemp
		
	End If
	
	ChkHTTP = strTemp
	
End Function

Function FormatURL(strURL)

	If strURL = "" Or strURL = Null Then
	
		strURL = "/"
		
	End If

	If Not InStr(Len(strURL), strURL, "/") > 0 Then
		
		strURL = strURL & "/"
		
	End If
	
	FormatURL = strURL
	
End Function

Function CutSlash(strURL)

	If Not InStr(1, strURL, "/") > 1 Then
		
		strURL = Mid(strURL,2)
		
	End If
	
	CutSlash = strURL
	
End Function

Function ChkEmail(strTemp)

	ChkEmail = True
	strEmail = Trim(strTemp)	

	If Len(strEmail) > 0 Then

		intAtPos = InStr(1, strEmail, "@")

		If Not (intAtPos > 1 And (InStrRev(strEmail, ".") > intAtPos + 1)) Then
		
		    ChkEmail = False
		    
		ElseIf InStr(intAtPos + 1, strEmail, "@") > intAtPos Then
		
		    ChkEmail = False
		    
		ElseIf Mid(strEmail, intAtPos + 1, 1) = "." Then
		
		    ChkEmail = False
		    
		ElseIf InStr(1, Right(strEmail, 2), ".") > 0 Then
		
		    ChkEmail = False
		    
		End If
		
	End If

End Function

Function SendMail(Subject, Sender, Recipient, Body)

	          SendMail = False
   
              strRecipientsName = ""
		      strRecipients = Recipient
			  strFrom = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "MAIL", "mailSender")  
			  strFromName = session("user")
		      strSubject = subject 
			  strMessage= Body
		      if strFrom <> "" then 
				strSender = strFrom
			  end if

	
			   Dim iMsg 
		       Dim iConf 
		       Dim Flds 
		       Dim strHTML
		
			Const cdoSendUsingPort = 2
			
			set iMsg = CreateObject("CDO.Message")
			set iConf = CreateObject("CDO.Configuration")
	
			Set Flds = iConf.Fields
	
			' Set the CDOSYS configuration fields to use port 25 on the SMTP server.
			
			With Flds
				.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = cdoSendUsingPort
				.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")= ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "MAIL", "porta") 
				.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "MAIL", "smtp") 
				.Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "MAIL", "timeout") 
				if ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "MAIL", "perfil")=1 then
					.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")= 1
					.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "MAIL", "utilizador") 
					.Item ("http://schemas.microsoft.com/cdo/configuration/sendpassword") = ReadIniFile(Server.MapPath("/opac/cgi/cgi.ini"), "MAIL", "senha") 
				end if
				.Update
			End With
	
			on error resume next 
			
			With iMsg
				 Set .Configuration = iConf
				.To = strRecipients
				.From = strSender
				.Subject = strSubject
				.HTMLBody = strMessage
				.Send
			End With
			
			' Clean up variables.
			Set iMsg = Nothing
			Set iConf = Nothing
			Set Flds = Nothing 
		    If Err <> 0 Then 
				sendMail=false
			else
			    sendMail = true
			End if
            on error goto 0

End Function

Function UploadFile(tipo)
 
 
 ' Se nao for este o componente deve ser feita alateração respectiva
	componente="ASPSmartUpload"
	Select Case componente							'Application(ScriptName & "UploadComponent")
                                              	
		Case "ASPSmartUpload"
			Dim AllowedFilesList, SavePath
			Dim RenameFile
			Dim mySmartUpload
			Dim intI, intCount, iRun
			Dim NewFileName, SavedName
			Dim ChangedName
			Dim AutoRename
			Dim NewFileExt
			Dim ExtPos
		
			DeniedFileList = "exe,asp,php,sql,bat,pif,ocx,dll,aspx,shtml"
		
			RenameFile = False
			MaxFileSize = 100000000  ' 100MB máximo

			Set mySmartUpload = Server.CreateObject("aspSmartUpload.SmartUpload")

			select case tipo
			
            case "iso"
			       
			       AllowedFilesList = "iso"
				   savepath= "/opac/upload/isos/"
			case "img"
				   AllowedFilesList = "jpg,gif,png"
				   savepath= "/opac/upload/fotos/leitores/"
				   
			case else
			       AllowedFilesList = ""
				   UploadFile="None"
				   Exit function
			   
            end select
			
			mySmartUpload.AllowedFilesList = AllowedFilesList
			mySmartUpload.DeniedFilesList = DeniedFilesList
			mySmartUpload.MaxFileSize = MaxFileSize
			
			on error resume next
			mySmartUpload.Upload 
			If Err.Number <> 0 Then
				UploadFile = False
			Else
			    if tipo="iso" then
				      
				   if lcase(mySmartUpload.Files.Item(1).FileExt) <>"iso" then
					   UploadFile="ErroTipo"
				       Exit function
				   end if
				   fext=instrRev(mySmartUpload.Files.Item(1).FileName,".")
				   
			        If Not mySmartUpload.Files.Item(1).isMissing And mySmartUpload.Files.Item(1).Size <> 0  Then
						
						intCount = mySmartUpload.Save(Server.MapPath(SavePath))
						SavedName = mySmartUpload.Files.Item(1).FileName
						
					end if 	
				 
			   else
                  
				  If Not UploadExists(Server.MapPath(SavePath & mySmartUpload.Files.Item(1).FileName)) Then
					If Not mySmartUpload.Files.Item(1).isMissing And mySmartUpload.Files.Item(1).Size <> 0  Then
						intCount = mySmartUpload.Save(Server.MapPath(SavePath))
						SavedName = mySmartUpload.Files.Item(1).FileName
				
						
					End If
				  Else
					If Not RenameFile = True Then
						UploadFile = "Existe"
						Exit Function
					Else
						NewFileName = mySmartUpload.Files.Item(1).FileName
						iRun = 1
						ChangedName = False
						Do While Not UploadExists(Server.MapPath(SavePath & NewFileName)) = False
							If Not ChangedName = True Then
								NewFileName = Replace(NewFileName, "." & mySmartUpload.Files.Item(1).FileExt, "")
							Else
								NewFileName = Replace(NewFileName, iRun - 1 & "." & mySmartUpload.Files.Item(1).FileExt, "")
							End If
							NewFileName = NewFileName & iRun & "." & mySmartUpload.Files.Item(1).FileExt
							iRun = iRun + 1
							ChangedName = True
						Loop
						mySmartUpload.Files.Item(1).SaveAs Server.MapPath(SavePath & NewFileName)
						SavedName = NewFileName
						intCount = 1
					End If
				 End If
		       end if		
			End If
   
			If intCount = "" Or intCount = 0 Then
     			
             	UploadFile = "None"
             	     
			Else
							
				If UploadExists(Server.MapPath(SavePath &  mySmartUpload.Files.Item(1).FileName)) Then
					select case tipo		   				
			   			case "iso","img"
               				   UploadFile = SavedName & "," & Cint(mySmartUpload.Files.Item(1).size / 1000) & "," & mySmartUpload.Form.Item("chkfecho")     		
                       								
					end select
					 
				Else
					UploadFile = "None"
				End If
			End If

		Case Else		
			UploadFile = "None"
		
		End Select

End Function

Function UploadExists(FileName)

	Dim objFS
	UploadExists = False

	Set objFS = CreateObject("Scripting.FileSystemObject")

     UploadExists = objFS.FileExists(FileName)

End Function

Function GetDateTime(thisDateTime)
 
 If Application(ScriptName & "DateFormat") = "ShortDate" Then
        
  GetDateTime = FormatDateTime(thisDateTime, vbShortDate)
      
 Else
     
  GetDateTime = FormatDateTime(thisDateTime, vbLongDate)
     
 End If
 
 If Application(ScriptName & "TimeFormat") = "ShortTime" Then
        
  GetDateTime = GetDateTime & " " & FormatDateTime(thisDateTime, vbShortTime)
      
 Else
     
  GetDateTime = GetDateTime & " " & FormatDateTime(thisDateTime, vbLongTime)
     
 End If 
 
End Function 


Function SafeHTML(ByVal pStrHTML)

	' Author: Lewis Edward Moten III
	' Email: lewis@moten.com
	' URL: http://www.lewismoten.com
	
	Dim lObjRegExp
    	
	If VarType(pStrHTML) = vbNull Then Exit Function
    	
	If pStrHTML = "" Then Exit Function
    	
	Set lObjRegExp = New RegExp
    	
		lObjRegExp.Global = True
		lObjRegExp.IgnoreCase = True
		lObjRegExp.Pattern = "<(/)?META HTTP|META NAME([^>]*)>"
		pStrHTML = lObjRegExp.Replace(pStrHTML, "<$1SCRIPT$3>")
		lObjRegExp.Pattern = "<(/)?(LINK|IFRAME|FRAMESET|FRAME|APPLET|OBJECT)([^>]*)>"
		pStrHTML = lObjRegExp.Replace(pStrHTML, "<$1LINK$3>")
		lObjRegExp.Pattern = "(<A[^>]+href\s?=\s?""?javascript:)[^""]*(""[^>]+>)"
		pStrHTML = lObjRegExp.Replace(pStrHTML, "$1//protected$2")
		lObjRegExp.Pattern = "(<IMG[^>]+src\s?=\s?""?javascript:)[^""]*(""[^>]+>)"
		pStrHTML = lObjRegExp.Replace(pStrHTML, "$1//protected$2")
		lObjRegExp.Pattern = "<([^>]*) on[^=\s]+\s?=\s?([^>]*)>"
		pStrHTML = lObjRegExp.Replace(pStrHTML, "<$1$3>")
    		
	Set lObjRegExp = Nothing

	SafeHTML = pStrHTML

End function


Function DateToStr(dtDateTime)

	DateToStr = year(dtDateTime) & doublenum(Month(dtdateTime)) & doublenum(Day(dtdateTime)) & doublenum(Hour(dtdateTime)) & doublenum(Minute(dtdateTime)) & doublenum(Second(dtdateTime)) & ""
	
End Function

Function doublenum(fNum)
	
	If fNum > 9 Then 
		
		doublenum = fNum 
		
	Else 
	
		doublenum = "0" & fNum
	
	End If
	
End function

 Function ReadIniFile(IFName, ISection, IItem)
    Const ForReading = 1, ForWriting = 2
    Dim fso, MyFile
    Dim strwork
    Dim Inner1
    Dim EQPtr
    
    Set fso = CreateObject("Scripting.FileSystemObject")
        
    Set MyFile = fso.OpenTextFile(IFName, ForReading)
    'initialize
    Inner1 = False
    strwork = ""
    
    'Send on endless loop
    Do While Not MyFile.AtEndOfStream
    strwork = MyFile.ReadLine
	Cmt = instr(1,strwork,";;",1)
	if cmt>0 then strwork= left(strwork,cmt-1)
	strwork=trim(strwork)
    'Check items after section is true
    If Inner1 = True Then
    If IsEmptyNull(strwork) = True Then
         Inner1 = False
    Else
		If CheckIniItem(strwork, IItem) = True Then
		ReadIniFile = strwork
		Exit Do
    End If
    'Somewhere check for jammed up grouping
    If InStr(1, strwork, "[", 1) > 0 Then
         Inner1 = CheckINISec(strwork, ISection)
    End If
    End If
    End If
    'Check Section first
    If Inner1 = False Then
        Inner1 = CheckINISec(strwork, ISection)
    End If
    Loop
    MyFile.Close
    End Function
	
	
    Function CheckIniItem(StrChk, QItem)
    Dim EQPtr
    'initialize
    CheckIniItem = False
    If InStr(1, StrChk, "=", 1) = 0 Then
    Exit Function
    End If
    If UCase(Left(StrChk, InStr(1, StrChk, "=", 1) - 1)) = UCase(QItem) Then
    EQPtr = InStr(1, StrChk, "=", 1)
    
    If EQPtr > 0 Then
    StrChk = Mid(StrChk, EQPtr + 1, Len(StrChk) - (EQPtr))
    CheckIniItem = True
    End If
    End If
    End Function



    Function CheckINISec(StrChk, QSec)
    If UCase(StrChk) = "[" & UCase(QSec) & "]" Then
    CheckINISec = True
    Else
    CheckINISec = False
    End If
    End Function
	
	Function IsEmptyNull(QStr)
    'initialize
    IsEmptyNull = False
    If IsNull(QStr) = True Then
    IsEmptyNull = True
    Exit Function
    End If
    If IsEmpty(QStr) = True Then
    IsEmptyNull = True
    Exit Function
    End If
    If QStr = "" Then
    IsEmptyNull = True
    Exit Function
    End If
    End Function

	
'EncodeUTF8
'  Encodes a Windows string in UTF-8
'Returns:
'  A UTF-8 encoded string
function EncodeUTF8(s)
  dim i
  dim c

  i = 1
  do while i <= len(s)
    c = asc(mid(s,i,1))
    if c >= &H80 then
      s = left(s,i-1) + chr(&HC2 + ((c and &H40) / &H40)) + chr(c and &HBF) + mid(s,i+1)
      i = i + 1
    end if
    i = i + 1
  loop
  EncodeUTF8 = s 
end function

Sub DualSorter( byRef arrArray, DimensionToSort )
    Dim row, j, StartingKeyValue, StartingOtherValue, _
        NewStartingKey, NewStartingOther, _
        swap_pos, OtherDimension
    Const column = 1
    
    ' Ensure that the user has picked a valid DimensionToSort
    If DimensionToSort = 1 then
		OtherDimension = 0
	ElseIf DimensionToSort = 0 then
		OtherDimension = 1
	Else
	    'Shoot, invalid value of DimensionToSort
	    Response.Write "Invalid dimension for DimensionToSort: " & _
	                   "must be value of 1 or 0."
	    Response.End
	End If
    
    For row = 0 To UBound( arrArray, column ) - 1
    'Start outer loop.
        
        'Take a snapshot of the first element
        'in the array because if there is a 
        'smaller value elsewhere in the array 
        'we'll need to do a swap.
        StartingKeyValue = arrArray ( row, DimensionToSort )
        StartingOtherValue = arrArray ( row, OtherDimension )
        
        ' Default the Starting values to the First Record
        NewStartingKey = arrArray ( row, DimensionToSort )
        NewStartingOther = arrArray ( row, OtherDimension )

        swap_pos = row
		
        For j = row + 1 to UBound( arrArray, column )
        'Start inner loop.
            If arrArray ( j, DimensionToSort ) < NewStartingKey Then
			   
            'This is now the lowest number - 
            'remember it's position.
                swap_pos = j
                NewStartingKey = arrArray ( j, DimensionToSort )
                NewStartingOther = arrArray ( j, OtherDimension )
            End If
        Next
		
        If swap_pos <> row Then
        'If we get here then we are about to do a swap
        'within the array.
            arrArray ( swap_pos, DimensionToSort ) = StartingKeyValue
            arrArray ( swap_pos, OtherDimension ) = StartingOtherValue
            
            arrArray ( row, DimensionToSort ) = NewStartingKey
            arrArray ( row, OtherDimension ) = NewStartingOther
            
        End If	
	
    Next
	
End Sub

Function Min(aNumberArray)
	Dim I               ' Standard loop counter
	Dim dblLowestSoFar  ' Numeric variable for current lowest item
	
	' Init it to Null so I know it's empty
	dblLowestSoFar = Null

	' Loop through the array
	For I = LBound(aNumberArray) to UBound(aNumberArray)
		' Testing line left in for debugging if needed
		'Response.Write aNumberArray(I) & "<BR>"
		
		' Check to be sure the item is numeric so we don't bomb out by trying to
		' compare a number to a string.
		If IsNumeric(aNumberArray(I)) Then
			' Convert it to a Double for comparison and compare it to previous lowest #.
			' If it's lower than the current lowest or the value of dblLowestSoFar is
			' still NULL then set dblLowestSoFar to it's new value.
			If CDbl(aNumberArray(I)) < dblLowestSoFar Or IsNull(dblLowestSoFar) Then
				dblLowestSoFar = CDbl(aNumberArray(I))
			End If
		End If
	Next 'I

	' Set our return value and "Get the Hell Outta Dodge."
	' http://www.asp101.com/samples/download/get_the_hell_outta_dodge.wav
	' FYI: That's Kristen Cloke as Shane Vansen from "Space: Above and Beyond"
	
	Min = dblLowestSoFar
End Function


'* Max ******************************************************
'Finds and returns the highest value in an array of numbers.
'Ignores non-numeric and Null data contained in the array.
'Returns Null if no numeric items are found in the array.
'************************************************************
Function Max(aNumberArray)
	Dim I
	Dim dblHighestSoFar

	' Y'all really don't want comments on this one too, do you?  It's exactly the
	' same as above except for the > instead of <.  I also changed the variable name
	' from dblLowestSoFar to dblHighestSoFar so it made more sense.
	
	' Notice about the "Y'all"...
	'             we've just moved to Georgia and I'm practicing my accent!  ;)

	dblHighestSoFar = Null

	For I = LBound(aNumberArray) to UBound(aNumberArray)
		' Testing line left in for debugging if needed
		'Response.Write aNumberArray(I) & "<BR>"
		If IsNumeric(aNumberArray(I)) Then
			If CDbl(aNumberArray(I)) > dblHighestSoFar Or IsNull(dblHighestSoFar) Then
				dblHighestSoFar = CDbl(aNumberArray(I))
			End If
		End If
	Next 'I
	
	Max = dblHighestSoFar
End Function

Function RC4(ByRef pStrMessage)

	Dim lBytAsciiAry(255)
	Dim lBytKeyAry(255)
	Dim lLngIndex
	Dim lBytJump
	Dim lBytTemp
	Dim lBytY
	Dim lLngT
	Dim lLngX
	Dim lLngKeyLength
	
	pStrKey="PCCRBE"
	' Validate data
	If Len(pStrKey) = 0 Then Exit Function
	If Len(pStrMessage) = 0 Then Exit Function

	' transfer repeated key to array
	lLngKeyLength = Len(pStrKey)
	For lLngIndex = 0 To 255
	    lBytKeyAry(lLngIndex) = Asc(Mid(pStrKey, ((lLngIndex) Mod (lLngKeyLength)) + 1, 1))
	Next

	' Initialize S
	For lLngIndex = 0 To 255
	    lBytAsciiAry(lLngIndex) = lLngIndex
	Next

	' Switch values of S arround based off of index and Key value
	lBytJump = 0
	For lLngIndex = 0 To 255
	
		' Figure index to switch
	    lBytJump = (lBytJump + lBytAsciiAry(lLngIndex) + lBytKeyAry(lLngIndex)) Mod 256
	    
	    ' Do the switch
	    lBytTemp				= lBytAsciiAry(lLngIndex)
	    lBytAsciiAry(lLngIndex)	= lBytAsciiAry(lBytJump)
	    lBytAsciiAry(lBytJump)	= lBytTemp
	    
	Next

	
	lLngIndex = 0
	lBytJump = 0
	For lLngX = 1 To Len(pStrMessage)
	    lLngIndex = (lLngIndex + 1) Mod 256 ' wrap index
	    lBytJump = (lBytJump + lBytAsciiAry(lLngIndex)) Mod 256 ' wrap J+S()
	    
		' Add/Wrap those two	    
	    lLngT = (lBytAsciiAry(lLngIndex) + lBytAsciiAry(lBytJump)) Mod 256
	    
	    ' Switcheroo
	    lBytTemp				= lBytAsciiAry(lLngIndex)
	    lBytAsciiAry(lLngIndex)	= lBytAsciiAry(lBytJump)
	    lBytAsciiAry(lBytJump)	= lBytTemp

	    lBytY = lBytAsciiAry(lLngT)
	
		' Character Encryption ...    
	    RC4 = RC4 & Chr(Asc(Mid(pStrMessage, lLngX, 1)) Xor lBytY)
	Next
	
End Function

Function stripALPHA(str)
	Set RegularExpressionObject = New RegExp
	With RegularExpressionObject
	.Pattern = "[a-zA-Z]"
	.IgnoreCase = True
	.Global = True
	End With
	stripALPHA = RegularExpressionObject.Replace(str, "")
	Set RegularExpressionObject = nothing
 End Function

 Function stripNUM(str)
	Set RegularExpressionObject = New RegExp
	With RegularExpressionObject
	.Pattern = "[0-9]"
	.IgnoreCase = True
	.Global = True
	End With
	stripNUM = RegularExpressionObject.Replace(str, "")
	Set RegularExpressionObject = nothing
 End Function
 
  'IsValidUTF8
'  Tells if the string is valid UTF-8 encoded
'Returns:
'  true (valid UTF-8)
'  false (invalid UTF-8 or not UTF-8 encoded string)
function IsValidUTF8(s)
  dim i
  dim c
  dim n

  IsValidUTF8 = false
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
      select case n
      case 1
        exit function
      case 2
        if (c and &HE0) <> &HC0 then
          exit function
        end if
      case 3
        if (c and &HF0) <> &HE0 then
          exit function
        end if
      case 4
        if (c and &HF8) <> &HF0 then
          exit function
        end if
      case else
        exit function
      end select
      i = i + n
    else
      i = i + 1
    end if
  loop
  IsValidUTF8 = true 
end function

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

'EncodeUTF8
'  Encodes a Windows string in UTF-8
'Returns:
'  A UTF-8 encoded string
function EncodeUTF8(s)
  dim i
  dim c

  i = 1
  do while i <= len(s)
    c = asc(mid(s,i,1))
    if c >= &H80 then
      s = left(s,i-1) + chr(&HC2 + ((c and &H40) / &H40)) + chr(c and &HBF) + mid(s,i+1)
      i = i + 1
    end if
    i = i + 1
  loop
  EncodeUTF8 = s 
end function

function sortArray(arrShort)

    for i = UBound(arrShort) - 1 To 0 Step -1
        for j= 0 to i
            if arrShort(j)>arrShort(j+1) then
                temp=arrShort(j+1)
                arrShort(j+1)=arrShort(j)
                arrShort(j)=temp
            end if
        next
    next
    sortArray = arrShort

end function

Function GenerateTagCloud(arrAllTags, flag)
  Dim strReturn
  Dim strUrlPrefix
  Dim intLoop
  Dim objDictionary
  Dim strTag
  Dim colKeys
  Dim strKey
  Dim strStyleSize1
  Dim strStyleSize2
  Dim strStyleSize3
  Dim strStyleSize4
  Dim strStyleSize5
  Dim strStyleSize6
  Dim strStyleSize7
  Dim lngHighestTagCount
  Dim lngLowestTagCount
  Dim dblDiff
  Dim dblStep
  Dim dblOffset
  Dim dblBorder1
  Dim dblBorder2
  Dim dblBorder3
  Dim dblBorder4
  Dim dblBorder5
  Dim dblBorder6
  if session("user")<>"" then us= session("user") else us="guest"
  strUrlPrefix = strROOT & "/cgi/www.exe/[in=pesqger.in]?base=opac&formato=wiusr&nut="+session("nuser")+"&ut="+us+"&id=3&nomemnu=catpesq.asp&bd=col&lim_inicio=1&limites=25&expressao=PCH "
  strStyleSize1 = "font-size: 9px;"
  strStyleSize2 = "font-size: 10px;"
  strStyleSize3 = "font-size: 12px;"
  strStyleSize4 = "font-size: 14px;"
  strStyleSize5 = "font-size: 14px; font-weight: bold;"
  strStyleSize6 = "font-size: 16px; font-weight: bold;"
  strStyleSize7 = "font-size: 18px; font-weight: bold;"
  Set objDictionary = Server.CreateObject("Scripting.Dictionary")
  
  For intLoop = 0 to Ubound(arrAllTags)
    strTag = arrAllTags(intLoop)
    If objDictionary.Exists(strTag) = True Then
      objDictionary.Item(strTag) = objDictionary.Item(strTag) + 1
    Else
      objDictionary.Add strTag, 1
    End If
  Next
  lngHighestTagCount = 1
  lngLowestTagCount = 2147483647
  colKeys = objDictionary.Keys
  For Each strKey in colKeys
    If objDictionary.Item(strKey) > lngHighestTagCount Then
      lngHighestTagCount = objDictionary.Item(strKey)
    End If
    If objDictionary.Item(strKey) < lngLowestTagCount Then
      lngLowestTagCount = objDictionary.Item(strKey)
    End If
  Next
  dblDiff = (lngHighestTagCount-lngLowestTagCount)
  dblStep = (dblDiff-(dblDiff/7))/5
  dblOffset = dblDiff/14
  dblBorder1 = lngLowestTagCount+(dblstep*0)+dblOffset
  dblBorder2 = lngLowestTagCount+(dblstep*1)+dblOffset
  dblBorder3 = lngLowestTagCount+(dblstep*2)+dblOffset
  dblBorder4 = lngHighestTagCount-(dblstep*2)-dblOffset
  dblBorder5 = lngHighestTagCount-(dblstep*1)-dblOffset
  dblBorder6 = lngHighestTagCount-(dblstep*0)-dblOffset
  For Each strKey in colKeys
    If objDictionary.Item(strKey) < dblBorder1 Then
      objDictionary.Item(strKey) = strStyleSize1
    ElseIf objDictionary.Item(strKey) > dblBorder1 And _
        objDictionary.Item(strKey) < dblBorder2 Then
      objDictionary.Item(strKey) = strStyleSize2
    ElseIf objDictionary.Item(strKey) > dblBorder2 And _
        objDictionary.Item(strKey) < dblBorder3 Then
      objDictionary.Item(strKey) = strStyleSize3
    ElseIf objDictionary.Item(strKey) > dblBorder3 And _
        objDictionary.Item(strKey) < dblBorder4 Then
      objDictionary.Item(strKey) = strStyleSize4
    ElseIf objDictionary.Item(strKey) > dblBorder4 And _
        objDictionary.Item(strKey) < dblBorder5 Then
      objDictionary.Item(strKey) = strStyleSize5
    ElseIf objDictionary.Item(strKey) > dblBorder5 And _
        objDictionary.Item(strKey) < dblBorder6 Then
      objDictionary.Item(strKey) = strStyleSize6
    ElseIf objDictionary.Item(strKey) > dblBorder6 Then
      objDictionary.Item(strKey) = strStyleSize7
    End If
  Next
  
  For Each strKey in colKeys
    if not flag then
	  strReturn = strReturn& "<span style=""" & objDictionary.Item(strKey) &";color:#a0e"" >" & strKey & "</span> " & vbcrlf
	else
      strReturn = strReturn & "<a href=""" & strUrlPrefix & _
      server.urlencode(strKey) & """ style=""" & objDictionary.Item(strKey) & _
      """>" & strKey & "</a> " & vbcrlf
	end if  
  Next
  Set objDictionary = Nothing
  GenerateTagCloud = strReturn
End Function

Function ReadTextFile(strFilePath)
	Dim objFSO, objFile, strAllFile
	Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
	Set objFile = objFSO.OpenTextFile(strFilePath)
	strAllFile = ""
	If Not(objFile.AtEndOfStream) Then
		strAllFile = objFile.ReadAll
	End If
	objFile.Close
	Set objFile = Nothing
	Set objFSO = Nothing
	
	strAllFile = Replace(strAllFile, Chr(13)&Chr(10), Chr(13))
	strAllFile = Replace(strAllFile, Chr(10)&Chr(13), Chr(13))
	ReadTextFile = Split(strAllFile, Chr(13))
End Function

function GerarPalavras (arrWords)
  Set objDictionary = Server.CreateObject("Scripting.Dictionary")
  For intLoop = 0 to Ubound(arrWords)
    strTag = arrwords(intLoop)
    If objDictionary.Exists(strTag) = True Then
      objDictionary.Item(strTag) = objDictionary.Item(strTag) + 1
    Else
      objDictionary.Add strTag, 1
    End If
  Next
  colKeys = objDictionary.Keys
  strWords="<ul>"
  For Each strKey in colKeys
    if strKey<>"" then strWords= strWords & "<li>" & strKey & "," & objDictionary.Item(strKey) & "</li>" & vbcrlf
  Next
  strWords=strWords & "</ul>"
  Set objDictionary = Nothing
  GerarPalavras= strWords   
end function

function ereg_replace(strOriginalString, strPattern, strReplacement, varIgnoreCase)
' Function replaces pattern with replacement
' varIgnoreCase must be TRUE (match is case insensitive) or FALSE (match is case sensitive)
dim objRegExp : set objRegExp = new RegExp
with objRegExp
.Pattern = strPattern
.IgnoreCase = varIgnoreCase
.Global = True
.Multiline = True
end with
ereg_replace = objRegExp.replace(strOriginalString, strReplacement)
set objRegExp = nothing
end function

Function SortDictionary(objDict,intSort)
    Dim strDict()
    Dim objKey
    Dim strKey,strItem
    Dim X,Y,Z
    Z = objDict.Count
    If Z > 1 Then
      ReDim strDict(Z,2)
      X = 0
      For Each objKey In objDict
          strDict(X,dictKey)  = CStr(objKey)
          strDict(X,dictItem) = CStr(objDict(objKey))
          X = X + 1
      Next
      For X = 0 to (Z - 2)
        For Y = X to (Z - 1)
          If StrComp(strDict(X,intSort),strDict(Y,intSort),vbTextCompare) > 0 Then
              strKey  = strDict(X,dictKey)
              strItem = strDict(X,dictItem)
              strDict(X,dictKey)  = strDict(Y,dictKey)
              strDict(X,dictItem) = strDict(Y,dictItem)
              strDict(Y,dictKey)  = strKey
              strDict(Y,dictItem) = strItem
          End If
        Next
      Next
      objDict.RemoveAll
      For X = 0 to (Z - 1)
        objDict.Add strDict(X,dictKey), strDict(X,dictItem)
      Next
    End If
  End Function
  
Sub Pause(intSeconds)
 startTime = Time()
 Do Until DateDiff("s", startTime, Time(), 0, 0) > intSeconds
 Loop
 End Sub
%>	 
