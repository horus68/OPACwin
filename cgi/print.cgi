'cipar=dbdef.cip'/
'uctab=isisuc.tab'/
'gizmo=gizmo'/
'db='(if v9000^n='base' then v9000^v fi)/
(if v9000^n='expressao' then 'bool='mhu,v9000^v,mhl fi)/
'h1=',(if v9000^n='lim_inicio' then v9000^v fi)/
'count=',(if v9000^n='limites' then v9000^v fi)/
'pft=@wiprint.pft'/,

/* Campos a excluir na importacao D9000 e D9001 s∆o obrigat¢rios */
/* Ex. D200 D225 D966 */
'proc='"'D9000D9001'"N0/
