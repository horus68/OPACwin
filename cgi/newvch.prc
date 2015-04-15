  'A1~'(if v9000^n='mfn' then v9000^v fi)'~'
  'A10~'(if v9000^n='titulo' then v9000^v fi)'~'
  'A20~'(if v9000^n='autor' then v9000^v fi)'~'
  'A30~'(if v9000^n='nreg' then v9000^v fi)'~'
  'A40~'(if v9000^n='sigla' then v9000^v fi)'~'
  'A45~'(if v9000^n='siglaext' then v9000^v fi)'~'
  'A50~'(if v9000^n='siglamor' then v9000^v fi)'~'
  'A60~'s(date)'~'
  'A999~'s('^a'(if v9000^n='user' then v9000^v fi),'^b'(if v9000^n='biblt' then v9000^v fi))'~'
  
  