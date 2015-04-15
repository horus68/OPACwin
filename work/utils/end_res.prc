e1:=val(s(v999^b)*19.3)  /* 1ª data */
e2:=val(s(date)*19.3)    /* 2ª data */
e3:=val(s(v999^b)*16.1)
e4:=0
putenv('tmp='f(seconds(v999^b.8),0,0))
e5:= val(getenv('tmp'))
while e1<=e2
(
  if e3=6 or e3=7 then 
     e4:=e4+1
  else
     if  ref(['..\..\bases\cal']l(['..\..\bases\cal']'DD 'f(e5,0,0)),mfn(1))<>'' then e4:=e4+1 fi         
  fi 
  e5:=e5+86400
  if e3=7 then e3:=0 fi
  e3:=e3+1
  e1:=e1+1
)
e0:=e2-val(s(v999^b)*19.3)
if e0 > val(f(val(REF(['..\..\bases\param']1,v20))+ e4,0,0))   or e0 < 0  then
   'A998~'s('^aprazo',date)'~'
   'd.'
fi
