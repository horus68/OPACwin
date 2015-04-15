<%         
		Function writeLog (str) 
        Application.Lock 
			Dim objFSO, objTStream
			Set objFSO = Server.CreateObject("Scripting.FileSystemObject")
			Set objTStream = objFSO.openTextFile(Server.MapPath(vdir &"/upload/logs/admin.log"), 8, True)
			dia=day(now)
			mes=month(now)
			ano=year(now)
			hora=hour(now)
			minuto=minute(now)
			segundo= second(now)
			if len(segundo)=1 then segundo= "0" & segundo
			linha = dia & "-" & mes & "-" & ano & ";" & hora & ":" & minuto & ":" & segundo  & ";" & str
			objTStream.WriteLine linha & " [" & Request.ServerVariables("Remote_Addr") & "]" 
			objTStream.Close
			Set objTStream = nothing
			Set objFSO = nothing
			Application.Unlock
 		End Function 
	    'writeLog("Logout - " & ucase(session("user")))
		Session.Contents.RemoveAll()
		session.Abandon()
		
		if request.QueryString("referr")="NS" or request.querystring("sys")="admin" then 
		    strPath=request.ServerVariables("HTTP_REFERER")
			if instr(strPath,"www.exe")>0 then
			    'if instr(strPath,"catind.asp")>0 then response.Redirect("/opac/admin/admin.asp")
				posi=instr(strPath,"&ut=")
				if posi>0 then 
				    posf= instr(posi+1,strPath,"&")
					if posf=0 then posf=len(strPath)
					termo= mid(strPath,posi,posf-posi)
			        strPath=replace(strPath,termo,"&ut=guest")
				end if
				posi=instr(strPath,"nut=")
				if posi>0 then 
				    posf= instr(posi,strPath,"&")
					if posf=0 then posf=len(strPath)
					termo= mid(strPath,posi,posf-posi)
			        strPath=replace(strPath,termo,"nut=")
					
				end if
				posi=instr(strPath,"&ent=")
				if posi>0 then 
				    posf= instr(posi+1,strPath,"&")
					if posf=0 then posf=len(strPath)
					termo= mid(strPath,posi,posf-posi)
			        strPath=replace(strPath,termo,"")
				end if
			end if
			if instr(strPath,"catpesq.asp?id=3")>0 then response.redirect "default.asp" else response.redirect strPath
		end if
%>