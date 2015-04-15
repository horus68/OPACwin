'cipar=dbdef.cip'/

'uctab=isisuc.tab'/
'db='(if v9000^n='base' then v9000^v fi)/
'read=x'/
'write=x'/
'proc=@updperm.prc'/
'from=',(if v9000^n='from' then mhu,v9000^v,mhl fi)/
'pft=@report.pft'/
'count=1'/