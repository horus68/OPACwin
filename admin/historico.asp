<%
Dim histArray 
Dim histMaxUsed
histArray = Session("histArray")
histMaxUsed = Session("histMaxUsed")
Function addHistElement( )
    If histMaxUsed >= UBound(histArray,2) Then
        ' add 10 elements!
        ReDim Preserve histArray( HIST_COLUMNS, histMaxUsed + 10 )
    End If
    histMaxUsed = histMaxUsed + 1
    addHistElement = histMaxUsed
End Function
str =request("exp")& request("tipodoc")& request("lim_ini") & request("limites") & request("formato")
flag=false
for i=0 to histMaxUsed
    if request("tipodoc")="" then tipodoc="" else tipodoc= histArray(1,i) 
    temp= histArray(0,i) & tipodoc & histArray(2,i) & histArray(3,i)& histArray(4,i)
	if temp=str then flag=true
next
if not flag and request("exp") <>"" then
	histItem = addHistElement( )
	histArray(0,histItem) = request("exp")
	histArray(1,histItem) = request("tipodoc")
	histArray(2,histItem) = request("lim_ini")
	histArray(3,histItem) = request("limites")
	histArray(4,histItem) = request("formato")
	Session("histArray") = histArray 
	Session("histMaxUsed") = histMaxUsed

end if
'response.write  histMaxUsed+1 
%>