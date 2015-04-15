'cipar=dbdef.cip'/
'gizmo=gizmo'/
'uctab=isisuc.tab'/
'db='(if v9000^n='base' then v9000^v fi)/
'bool='(| + |+V8000)/
'h1=',(if v9000^n='lim_inicio' then v9000^v fi)/
'count=',(if v9000^n='limites' then v9000^v fi)/
'user='(if V9000^n='user' then v9000^v fi)/

/* Ordena‡Æo dos registos */
,if S((if V9000^n='sortfmt' then v9000^v fi))<='0' then
   ,"pft=@"N9999,(if V9000^n='formato' then v9000^v fi)".pft"N9999/,
,else,,@wisort.pft,
,fi/
