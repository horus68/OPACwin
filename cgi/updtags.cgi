'cipar=dbdef.cip'/

'uctab=isisuc.tab'/
'db=tags'/
'read=x'/
'write=x'/
'proc=@updtags.prc'/
'from=',(if v9000^n='from' then mhu,v9000^v,mhl fi)/
'pft=@report.pft'/
'count=1'/