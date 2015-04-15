<%
    temp=request("ids")
	
	tabela=split(temp,",")
	'for i=0 to ubound(tabela)
	'    response.write i & "#" & tabela(i) & "<br>"
	'next
	Dim histMaxUsed
	histArray = Session("histArray")
	histMaxUsed = Session("histMaxUsed")
	
	for i=0 to ubound(tabela)
		histItem=tabela(i)-1
		histArray(0,histItem) = ""
		histArray(1,histItem) = ""
		histArray(2,histItem) = ""
		histArray(3,histItem) = ""
		histArray(4,histItem) = ""
	next
	redim a(ubound(histArray),5)
	K=-1
    for i=0 to ubound(histArray)
		if histArray(0,i)<>"" then
		  k=k+1
		  a(0,k) = histArray(0,i) 
		  a(1,k) = histArray(1,i)
          a(2,k) = histArray(2,i)
		  a(3,k)=  histArray(3,i)
		  a(4,k)=  histArray(4,i)
		end if
      		
	next
    'for i=0 to ubound(a,2)
	'   for j=0 to 4
	'    response.write i & "#" & a(j,i) & "<br>"
	'   next	
	'next
    '  response.write k	
	Session("histArray") = a 
	Session("histMaxUsed") = k

%>