'cipar=dbdef.cip'/
'gizmo=gizmo'/
'uctab=isisuc.tab'/
'db='(if v9000^n='base' then v9000^v fi)/
'pft=@',(if V9000^n='formato' then v9000^v fi)'.pft'/
'from=',(if v9000^n='from' then mhu,v9000^v,mhl fi)/
'to=',(if v9000^n='to' then mhu,v9000^v,mhl fi)/
'h1=',(if v9000^n='lim_inicio' then v9000^v fi)/
'count=',(if v9000^n='limites' then v9000^v fi)/
