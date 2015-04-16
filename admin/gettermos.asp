<!--#include file="config.asp"-->
<!--#include file="functions.asp"-->
<%

  arrWords= ReadTextFile (Server.MapPath(vdir & "/upload/logs/words.lst"))
  sortArray arrWords
  'response.write GerarPalavras(arrWords)
  response.write GenerateTagCloud(arrWords, false)
  
  

%>
