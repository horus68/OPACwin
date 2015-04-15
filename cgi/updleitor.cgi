'cipar=dbdef.cip'/
'uctab=isisuc.tab'/

'db=leitor'/
'read=x'/
'write=x'/
'proc=@updleitor.prc'/
'from=',(if v9000^n='from' then mhu,v9000^v,mhl fi)/
'pft=@report.pft'/
'count=1'/