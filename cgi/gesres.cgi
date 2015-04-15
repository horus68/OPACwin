'cipar=dbdef.cip'/

'uctab=isisuc.tab'/
'db='(if v9000^n='base' then v9000^v fi)/
'pft=@gesres.pft'/
'bool=',(if v9000^n='express' then mhu,v9000^v,mhl fi)/
'h1=',(if v9000^n='lim_inicio' then v9000^v fi)/
'count=',(if v9000^n='limites' then v9000^v fi)/