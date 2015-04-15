  
  'A100~'s('^a'(if v9000^n='titulo' then v9000^v fi),'^s'(if v9000^n='sigla' then v9000^v fi),'^c'(if v9000^n='cota' then v9000^v fi),'^r'(if v9000^n='nreg' then v9000^v fi),'^e'(if v9000^n='ex' then v9000^v fi))'~'
  'A200~^a0~'
  'A300~'s('^a'(if v9000^n='entidade' then v9000^v fi))'~'
  if getenv('nut')<>'' then
  'A999~'s('^a'(if v9000^n='nut' then v9000^v fi),'^b's(date),'^c'ref(['leitor']L(['leitor']'NR '(if v9000^n='nut' then v9000^v fi)),v20),'^dleitor')'~'
  else
  'A999~'s('^a'(if v9000^n='ut' then v9000^v fi),'^b's(date))'~'
  fi