<%@ Language="VBScript" %>
<% Option Explicit %>
<%
Dim theComponent(15)
Dim theComponentName(15)

        ' Lista dos Componentes
        theComponent(0) = "ADODB.Connection"
        theComponent(1) = "SoftArtisans.FileUp"
        theComponent(2) = "AspHTTP.Conn"
        theComponent(3) = "AspImage.Image"
        theComponent(4) = "LastMod.FileObj"
        theComponent(5) = "Scripting.FileSystemObject"
        theComponent(6) = "SMTPsvg.Mailer"
        theComponent(7) = "CDONTS.NewMail"
        theComponent(8) = "Jmail.smtpmail"
        theComponent(9) = "SmtpMail.SmtpMail.1"
        theComponent(10) = "Persits.Upload.1"
        theComponent(11) = "UnitedBinary.AutoImageSize"
        theComponent(12) = "aspSmartUpload.SmartUpload"
        theComponent(13) = "DAO.DBEngine.35"
		theComponent(14) = "CDOSYS.Message"

        ' Apelido dos Componentes
        theComponentName(0) = "ADODB"
        theComponentName(1) = "SA-FileUp"
        theComponentName(2) = "AspHTTP"
        theComponentName(3) = "AspImage"
        theComponentName(4) = "LastMod"
        theComponentName(5) = "FileSystemObject"
        theComponentName(6) = "ASPMail"
        theComponentName(7) = "CDONTS"
        theComponentName(8) = "JMail"
        theComponentName(9) = "SMTP"
        theComponentName(10) = "Persits Upload"
        theComponentName(11) = "AutoImageSize"
        theComponentName(12) = "ASpSmartUpload"
        theComponentName(13) = "DBEngine"
		theComponentName(14) = "CDOSYS"

Function IsObjInstalled(strClassString)
        On Error Resume Next
                IsObjInstalled = False
        Err = 0
                Dim xTestObj
                        Set xTestObj = Server.CreateObject(strClassString)
        If 0 = Err Then IsObjInstalled = True
                Set xTestObj = Nothing
        Err = 0
End Function
%>
<html>
<head>
<title>O que tem aqui?</title>
</head>
<body>
<table width="100%" border="1" cellspacing="0" cellpadding="0">
<tr>
<td align="center"><font face="Verdana, Arial, Helvetica, sans-serif" size="2" color="#000000"><b>Componentes 
instalados:</b></font></td>
</tr>
<tr>
<td><font face="Verdana, Arial, Helvetica, sans-serif" size="2">
<table border="0" cellpadding="0" cellspacing="0" width="100%">
<% 
Dim i
        For i = 0 To UBound(theComponent)
        If Not IsObjInstalled(theComponent(i)) Then
        Else
                Response.Write "<tr>" & vbCrLf
                Response.Write "<td width=""100%"">" & vbCrLf
                Response.Write "<b>" & theComponentName(i) & "</b>" & vbCrLf
                Response.Write "</td>" & vbCrLf
                Response.Write "</tr>" & vbCrLf
        End If
Next 
%>
	</table>
	</font> 
	</td>
	</tr>
</table>
</body>
</html>

