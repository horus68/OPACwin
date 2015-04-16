<!--#include file="config.asp"--> 
<!--#include file="functions.asp"-->
<%
   strHTML=getUrl(strROOT & "/cgi/www.exe/[in=relinst.in]") 
   uflag= instr(ucase(strHTML),ucase(request("id")))>0
   if request("id")<>"" then
	   op= request("op")
	   str=""
	   Set fso = CreateObject("Scripting.fileSystemObject")
	   Set LerTexto = fso.OpenTextFile (Server.MapPath(vdir & "/work/database.lst"), 1,-2)
	   s = LerTexto.ReadAll
	   lt= len(s)
	   
	   if op="n"  then
	      if uflag then
		   do while lt>0
			 pos=instrrev(s,"AUXDB=",lt)
			 str=mid(s,pos,lt-pos+1)
			 if instr(str,"virtual")=0 then
				lt=0
			 else
				lt=pos-1
				strv=str
			 end if
		   loop	   
			posi= instr(str,"^b")
			posf= instr(str,"^i")
			tmp= mid(str,posi+2,posf-posi-2)
			pos1= instrrev(tmp,"\")
			tmp= mid(tmp,pos1+1)
			strtmp=str
			str=replace (str,tmp,lcase(request("id")))
			texto= left(s,pos-1) & strtmp & str & strv		 
		 end if	 			
	   else
	      if not uflag then
			   pos= instr(s,lcase(request("id")))
			   if pos>0 then
				  posi=instrrev(s,"AUXDB=",pos)
				  posf=instr(pos,s,"AUXDB=")
				  if posf=0 then posf=len(s)
				  texto= left(s,posi-1) & mid(s,posf)
			   else
				  texto=s 
			   end if
			   uflag=true
		  end if	   	  
	    end if 
	  
	    if uflag then
		   set LerTexto= fso.OpenTextFile (Server.MapPath(vdir & "/work/database.lst"), 2,true)
			LerTexto.write(texto)
		   LerTexto.Close
	    end if
		 
	  Set LerTexto = fso.OpenTextFile (Server.MapPath(vdir & "/cgi/dbdef.cip"), 1)
	  if op="n" then
		  uflag=false
		  While NOT LerTexto.AtEndOfStream and not uflag 
				linha= LerTexto.ReadLine
				posi= instr(linha,"=")	
				if posi>0 then 
				   uflag=true
				end if   
		  wend
		  tmp=left(linha,instrrev(left(linha,posi-1),".")-1)
		  posf=instrrev(linha,"\")
		  linha=lcase(request("id")) & ".*" &mid(linha,posi,posf-posi+1) & lcase(request("id")) & ".*"
		  LerTexto.close
		  Set LerTexto = fso.OpenTextFile (Server.MapPath(vdir & "/cgi/dbdef.cip"), 8)
			LerTexto.write vbcrlf
			LerTexto.write linha
		  LerTexto.close
	  else
		  strTexto=""
		 While NOT LerTexto.AtEndOfStream 
			linha= LerTexto.ReadLine
				if instr(linha,lcase(request("id")))=0 and linha<>"" then	
				   strTexto = strTexto & linha & vbcrlf
				end if   
		  wend
		 LerTexto.close
		  Set LerTexto = fso.OpenTextFile (Server.MapPath(vdir & "/cgi/dbdef.cip"), 2,true)
			LerTexto.write strTexto
		  LerTexto.close	      
	  end if 	 	
	  Set fso=nothing
end if	
response.redirect "admin.asp?mnut=1"  		
%>
