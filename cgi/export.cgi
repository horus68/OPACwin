'cipar=dbdef.cip'/
'uctab=isisuc.tab'/
'db='(if v9000^n='base' then v9000^v fi)/
'pft='/
(if v9000^n='expressao' then 'bool='mhu,v9000^v,mhl fi)/
'h1=',(if v9000^n='lim_inicio' then v9000^v fi)/
'count=',(if v9000^n='limites' then v9000^v fi)/
'user=',(if V9000^n='user' then v9000^v fi)/
'from=',(if v9000^n='from' then v9000^v fi)/
'to=',(if v9000^n='to' then v9000^v fi)/
'export='(if v9000^n='tmppath' then v9000^v fi)(if v9000^n='expfile' then v9000^v fi)/
'proc='"'D9000D9001'"N0/
