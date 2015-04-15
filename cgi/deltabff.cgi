'cipar=dbdef.cip'/

'uctab=isisuc.tab'/
'db=cal'/
'read=x'/
'write=x'/
'proc=@deluser.prc'/
'fst=@cal.fst'/
'from=',(if v9000^n='mfn' then mhu,v9000^v,mhl fi)/
'pft=@report.pft'/
'count=1'/