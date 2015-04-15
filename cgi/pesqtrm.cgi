'cipar=dbdef.cip'/
'gizmo=gizmo'/
'uctab=isisuc.tab'/
'db='(if v9000^n='base' then v9000^v fi)/
'pft=@',(if V9000^n='formato0' then v9000^v fi)'.pft'/
'k1=',  (if v9000^n='expressao' then v9000^v fi)  /
'count=',(if v9000^n='limites' then v9000^v fi)/
'user=',(if V9000^n='user' then v9000^v fi)/
