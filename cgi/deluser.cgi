'cipar=dbdef.cip'/

'uctab=isisuc.tab'/
'db='(if v9000^n='base' then v9000^v fi)/
'read=x'/
'write=x'/
'proc=@deluser.prc'/
'fst=@users.fst'/
'from=',(if v9000^n='mfn' then mhu,v9000^v,mhl fi)/
'pft=@rpt_dusr.pft'/
'count=1'/