// =========================================================================================
// geral.js
// =========================================================================================

var lastHeader;
var lastpopup;
var lastmfn;

function ShowExi(header,base,formato,mfn,biblio,ut,nut,bibleitor)
{
    changecont(header);
	var strMfn=mfn;
    while (strMfn.length < 6) {
        strMfn = '0' + strMfn;
    }
  var image=document.getElementById("vermais"+strMfn);
  var flag;
  
  if (lastpopup ==header) flag= document.getElementById("cotas"+lastmfn).style.display=="inline"; 
  if (image.src.indexOf('plus.gif')!=-1) {
     
     if (lastmfn) {var strLastMfn=lastmfn;while (strLastMfn.length < 6) strLastMfn = '0' + strLastMfn;document.getElementById("vermais"+strLastMfn).src="/opac/imagens/plus.gif";}
	 image.src="/opac/imagens/minus.gif";
     image.title="Esconder";
	 
  }else
  {
	if (flag)
	{
    var str1="tab"+strMfn+"1";
	changecont(str1);
	image.src="/opac/imagens/plus.gif";
    image.title="Expandir";
	}
  }
 var loc = "/opac/cgi/www.exe/[in=pesqexi.in]?base="+base+"&ut="+ut+"&nut="+nut+"&formato="+formato+"&lim_inicio=1&limites=25&from="+mfn+"&to="+mfn+"&ent="+bibleitor+"&estab="+biblio;
 
 var janela =  "cotas"+mfn;
 if ((lastpopup != null )|| (lastmfn != null)) 
 {
     if (lastpopup==header) 
	    if (document.getElementById("cotas"+lastmfn).style.display=="none") 
		    {document.getElementById("cotas"+mfn).style.height="60px";document.getElementById("cotas"+lastmfn).style.display="inline"}
		else 
			document.getElementById("cotas"+lastmfn).style.display="none";
	 else
        {document.getElementById("cotas"+lastmfn).style.height="60px";document.getElementById("cotas"+lastmfn).style.display="none";document.getElementById("cotas"+mfn).style.display="inline";}
}
 else 
    document.getElementById("cotas"+mfn).style.display="inline";
 
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,width=500,height=60,left=100,top=50");
 ndoc=popup.document;
 ndoc.location.href=loc;
 lastpopup=header;
 lastmfn=mfn;
}

function pad(number, length) {
    var str = '' + number;
    while (str.length < length) {
        str = '0' + str
    }
    return str;
}

function ShowRegs(mfn,exp,base,user,nuser,ex,count,sigla,bibleitor)
{
 var texto = "Informação detalhada acerca das existências na base local";
 var janela = "exemplares";
 var loc = "/opac/cgi/www.exe/[in=pexiloc.in]?base="+base.toLowerCase()+"&expressao="+exp+"&lim_inicio=1&limites=1000&ut="+user+"&nut="+nuser+"&mfn="+mfn+"&nex="+ex+"&pos="+count+"&sigla="+sigla+"&ent="+bibleitor;
 if (document.getElementById("exemplares").style.display=="none") 
 {
            
			window.parent.document.getElementById("cotas"+mfn).style.height="124px";
		    document.getElementById("exemplares").style.display="inline";		
 }
 else
 { 
			window.parent.document.getElementById("cotas"+mfn).style.height="60px";
			document.getElementById("exemplares").style.height="115px";
			document.getElementById("exemplares").style.display="none";
			
}			
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,width=500,height=60,left=100,top=50");
 ndoc=popup.document;
 ndoc.location.href=loc;
 //if(window.focus) popup.focus();
 }
 
 function expandir(mfn,base,sigla,user,nuser,ent)
{
  
  var intmfn=parseInt(mfn,10);
  var param="";var pos="";
  var str1="tab"+mfn;
  var pos=""; 
  if (lastHeader) {
     var str2=lastHeader.id; 
     var index = str2.lastIndexOf(str1);
	 if (index > -1) {
       pos=str2.substring(str1.length);
     }
    if (pos!=0) param=str1+pos; else param=str1+"1";  
  } else {param=str1+"1";} 
  
  changecont(param,intmfn);
  ShowExi(param,base,"showexi",intmfn.toString(),sigla,user,nuser,ent);
}
 
 
function encode_utf8(s){
return unescape( encodeURIComponent( s ) );
}    
   
function alterarPin()
{
var janela =  "altpin"; 
var loc = "/opac/admin/logleitor.asp?op=ap";
popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,width=380,height=170,left=150%,top=150%");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
}
   
function adcoment(id,mfn)
{
 var texto = "Adicionar comentário";
 var janela =  "coment"; 
 var loc = "/opac/comentarios.asp?id="+id+"&mfn="+mfn;
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,width=570,height=530,left=100,top=50");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
 } 

function ver_comm(id,mfn,nreg)
{
 
 var texto = "Ver comentários";
 var janela =  "coment"; 
 var loc = window.location.protocol+window.location.hostname+"/../../../cgi/www.exe/[in=lstcomm.in]?expr="+mfn.replace(/@@/g,'')+"&id="+id+"&mfn="+mfn+"&nreg="+nreg;
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,width=570,height=530,left=100,top=50");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
 }
 
function ShowMap(entidade,morada,concelho,lg,lt)
{
 var texto = "Localização da biblioteca";
 var janela =  "map"; 
 var loc = "/opac/mostra_mapa.asp?long="+lg+"&lat="+lt+"&entidade="+encode_utf8(entidade)+"&morada="+encode_utf8(morada)+"&concelho="+encode_utf8(concelho);
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,width=652,height=540,left=100,top=50");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
 }
 
 function build_reservas(user,nuser)
{
 var texto = "Reservas";
 var janela =  "res"; 
 if (nuser != "")
 var loc = "/opac/cgi/www.exe/[in=pesqres.in]?base=reservas&expressao=REQ "+nuser+"&lim_inicio=1&limites=99999&ut="+escape(user)+"&nut="+nuser;
 else
 var loc = "/opac/cgi/www.exe/[in=pesqres.in]?base=reservas&expressao=REQ "+user+"&lim_inicio=1&limites=9999&ut="+user;
 
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,menubar=no,width=752,height=440,left=100,top=50");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
 }
 
 function nova_reserva(titulo,autor,entidade,nut,sigla,cota,nreg,ex,user)
{

 var janela =  "novares"; 
 var nuser= nut == undefined ? "": nut;
 var loc = "/opac/cgi/www.exe/[in=newres.in]?base=reservas&titulo="+titulo+"&autor="+autor+"&entidade="+entidade+"&nut="+nuser+"&sigla="+sigla+"&cota="+cota+"&nreg="+nreg+"&ex="+ex+"&ut="+user;
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,width=652,height=200,left=200,top=100");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
 }

 
 
 function act_reserva(ex,user,mfn, sigla)
{
 var janela =  "novares"; 
 var loc = window.location.protocol+window.location.hostname+"/../cgi/www.exe/[in=updres.in]?base=reservas&from="+mfn+"&ex="+ex+"&ut="+user+"&sigla="+sigla;
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,width=652,height=200,left=200,top=100");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
 }

 function regista_reserva(nut,user)
{
 var janela =  "novares"; 
 var nuser= nut == undefined ? "": nut;
 var loc = window.location.protocol+window.location.hostname+"/../cgi/www.exe/[in=regres.in]?base=sumres&nut="+nuser+"&ut="+user;
 popup=window.open("",janela,"toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=no,width=652,height=200,left=200,top=100");
 ndoc=popup.document;
 ndoc.location.href=loc;
 if(window.focus) popup.focus();
 }

function ShowReservas()
{
   document.getElementById('basket').style.display= document.getElementById('basket').style.display=='none'? '':'none';
 }

function ConvUp(linha_in)
{
  var i=0;
  var dim=0;
  var tmp="",car,linha_out="",tmpcar="";
  tmp=linha_in.toUpperCase();
  tmp = tmp.replace("Ø","ø");
 //var lstcar1="Á  À  Â  Ã  Ä  É  È  Ê  Ë  Í  Ì  Ï  Î  Ó  Ò  Õ  Ô  Ö  Ú  Ù  Ü  Ç  Û  ã  õ  â  ê  î  ô  û  á  é  í  ó  ú  à  è  ì  ò  ù  ä  ë  ï  ö  ü  Ä  Ë  Ö  Ü  ç  Æ  ý  Ý";
  var lstcar1="%C1%C0%C2%C3%C4%C9%C8%CA%CB%CD%CC%CF%CE%D3%D2%D5%D4%D6%DA%D9%DC%C7%DB%E3%F5%E2%EA%EE%F4%FB%E1%E9%ED%F3%FA%E0%E8%EC%F2%F9%E4%EB%EF%F6%FC%C4%CB%D6%DC%E7%C6%FD%DD";
  var lstcar2="A  A  A  A  A  E  E  E  E  I  I  I  I  O  O  O  O  O  U  U  U  C  U  A  O  A  E  I  O  U  A  E  I  O  U  A  E  I  O  U  A  E  I  O  U  A  E  O  U  C  A  Y  Y";
  dim=tmp.length;
  for(i=0;i<dim;i++)
     {
       tmpcar=tmp.charAt(i);
       car=escape(tmp.charAt(i));
       if (car.lastIndexOf("%")>=0) {p=lstcar1.lastIndexOf(car)} else {p=-1};
       car=(p>=0)?(lstcar2.charAt(p)):tmpcar;
       linha_out=unescape(linha_out + car);
     }
  return(linha_out);
}

function LTrim(VALUE){
var w_space = String.fromCharCode(32);
if(v_length < 1){
return"";
}
var v_length = VALUE.length;
var strTemp = "";

var iTemp = 0;

while(iTemp < v_length){
if(VALUE.charAt(iTemp) == w_space){
}
else{
strTemp = VALUE.substring(iTemp,v_length);
break;
}
iTemp = iTemp + 1;
} //End While
return strTemp;
} //End Function

function RTrim(VALUE){
var w_space = String.fromCharCode(32);
var v_length = VALUE.length;
var strTemp = "";
if(v_length < 0){
return"";
}
var iTemp = v_length -1;

while(iTemp > -1){
if(VALUE.charAt(iTemp) == w_space){
}
else{
strTemp = VALUE.substring(0,iTemp +1);
break;
}
iTemp = iTemp-1;

} //End While
return strTemp;

} //End Function

function validaIn(f)
{
  if (f.nk.value.lenght ==0)
  {  
	alert("O campo NOME não deve ficar vazio!");
    f.nk.focus();
    return (false);
  }
  var x='';
  
} 
 
// ----------------------------
function ValidaData(theForm)
{
  if (theForm.DP.value.length > 4)
  {
    alert("Deve digitar 4 caracteres para representar a data.");
    theForm.DP.focus();
    return (false);
  }
  var checkOK = "0123456789";
  var checkStr = theForm.DP.value;
  var allValid = true;
  var decPoints = 0;
  var allNum = "";
  for (i = 0;  i < checkStr.length;  i++)
  {
    ch = checkStr.charAt(i);
    for (j = 0;  j < checkOK.length;  j++)
      if (ch == checkOK.charAt(j))
        break;
    if (j == checkOK.length)
    {
      allValid = false;
      break;
    }
    allNum += ch;
  }
  if (!allValid)
  {
    alert("Para representar a data digite apenas números.\nEx:2001");
    theForm.DP.focus();
    return (false);
  }
  var chkVal = allNum;
  var prsVal = parseInt(allNum);
  if (chkVal != "" && !(prsVal >= "1000" && prsVal <= "2010"))
  {
    alert("A data indicada deve estar entre 1000 e 2010.");
    theForm.DP.focus();
    return (false);
  }
}

// ----------------------------
function ChkTermo(form)
{
  var i=0;
  var x="";
  for(i=0;i<12;i++)
     {
       if(form.PRFX.options[i].selected==true)
          { 
           x=form.PRFX.options[i].value+" ";
           if (x=="PAL "){x=""};
          }
     }

  form.expressao.value=ConvUp(x+form.termo.value);
}
// ----------------------------
function ChkTermo_alias(form)
{
  var i=0;
  var x="";

  for(i=0;i<12;i++)
     {
       if(form.PRFX.options[i].selected==true)
          { 
           x=form.PRFX.options[i].value+" ";
           if (x=="PAL "){x=""};
          }
     } 
  
  form.expressao.value=x+form.termo.value;
  
}
// ----------------------------
function ChkTermo_alfa(form)
{
  var i=0;
  var x="";
  for(i=0;i<8;i++)
     {
       if(form.PRFX.options[i].selected==true)
          { 
           x=form.PRFX.options[i].value+" ";
           if (x=="PAL "){x=""};
          }
     }
  form.expressao.value=ConvUp(x+form.termo.value);
}
// ----------------------------
function TrataCDU(linha_in)
{
// Limpa da CDU os auxiliares
  var i=0;
  var linha_out=linha_in;
  lista=new Array("-",":","/","(",")","#","*","%2B","+","=","\"","&#34;","&quot;","&#43;");
  for(i=0;i<14;i++)
     {
       p=linha_in.indexOf(lista[i]);
       if (p>=0) {linha_out=linha_in.substring(0,p);break;};
     }
return(linha_out);
}

// ----------------------------
function ChkMeses(form)
{
  var i,rb,data,ano,mes;
  data=new Date();
  ano=data.getYear();
  ano=(ano<2000)?"19"+ano:ano; 
  mes=data.getMonth();
  for(i=0;i<12;i++) {if(form.R1[i].checked=="1") {rb=form.R1[i].value}}
  if (rb==null) {rb=mes+1};
  var prsVal = parseInt(rb);
  rb=(prsVal<10)?"0"+rb:rb;
  form.expressao.value="DT "+ano+rb+"$";
}

// ----------------------------
function ChkDP(form)
{
  var data,ano,dp;
  data=new Date();
  ano=data.getYear();
  ano=(ano<2000)?"19"+ano:ano; 
  dp=form.DP.value;
  if (dp==""){dp=ano} else {ano=""};
  form.expressao.value="(TDOC AM)" + " AND "+"(DP "+dp+ano+")";
}

// ----------------------------
function FindReplace(linha_in,car1,car2)
{
  var i=0;
  var dim=0;
  var car,linha_out="";
  dim=linha_in.length;
  for(i=0;i<dim;i++)
     {
       car=linha_in.charAt(i);
       if (car==car1) {car=car2};
       linha_out=linha_out + car;
     }
  return(linha_out);
}
// ----------------------------
function FindRepChar(linha_in,car1,car2)
{
  var i=0;
  var dim=0;
  var car,tmp=linha_in,linha_out="";
  dim=linha_in.length;
  for(i=0;i<dim;i++)
     {
       car=tmp.charAt(i);
       if (car==car1) {car=car2};
       linha_out=linha_out + car;
     }
  return(linha_out);
}

// ----------------------------
function FindReplace_2(linha,str1,str2)
{
   var s1,s2;
   var linha_in=linha;
   var c=linha_in.length;
   var p=0;

   while ((p>-1))
      {
       p=linha_in.substring(0,c).lastIndexOf(str1);
       if (p>=0)
           {
            s1=linha_in.substring(0,p);
            s2=linha_in.substring(p+str1.length,linha_in.length);
            linha_in=s1+str2+s2;
            c=p-1;
           };
      }
  return linha_in;    
}

// ----------------------------
function Dim_Campo(Campo)
{
 var msg01="Deve digitar no mínimo 2 caracteres para cada termo indicado.";
 var dim=Campo.length;
 if (dim<2)
    {
      alert(msg01);
      return(false);
    } else return(true);
}

// ----------------------------
function ChkChars(termo)
{
  var i=0;
  var sep="";
  termo=termo.toUpperCase();
  termo= termo.replace("Ø","ø");
//  if (termo.substring(0,4)=="CDU ") {termo=TrataCDU(termo);}
  lista=new Array("+","*","^"," AND "," OR "," NOT "," AND NOT "," (F) "," (G) ","(",")");
  for (i=0;i<11;i++)
      {
        if (termo.indexOf(lista[i])>=0)
           {
            sep="\"";
            break;
           }
      }
  return (sep+termo+sep);
}

// ----------------------------
function ChkChars_2(texto)
{
  var sep="",termo=texto;
  termo=termo.toUpperCase();
  termo= termo.replace("Ø","ø");
  lista=new Array("+","%2B","*","^"," AND "," OR "," NOT "," AND NOT ","(",")");
  for (i=0;i<12;i++)
      {
       if (termo.indexOf(lista[i])>=0)
          {
           sep="\"";
           break;
          }
       }
  return(sep+termo+sep);
}

// ----------------------------
function LimpaMais(linha_in)
{
var i=0;
var dim=linha_in.length;
var linha_out="",car="";
for (i=0;i<dim;i++)
   {
     car=linha_in.charAt(i);
     if (car=="+") car="%2B";
     if (car==" ") car="%20";
     linha_out=linha_out + car;
   }
return(linha_out);
}

// ----------------------------
function ValidaExpress(form)
{
  _NTermos=11;  // termos
  _LTermos=7;   // linhas com termos
  _OP = new Array(_LTermos);
  _PRFX = new Array(_LTermos);
  _Termo = new Array(_LTermos);
  var cont=0,i=0,t=0,_tdoc="",_dp="",part1="",part2="";tmp="";
  if (form.Termo1.value!="")
     {
       form.Termo1.focus();
       if (Dim_Campo(form.Termo1.value)==false) return(false);
       t=0;
       for(i=0;i<_NTermos;i++){if(form.PRFX1.options[i].selected==true){ _PRFX[t]=form.PRFX1.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR1.value=(form.TR1.checked==true)?form.TR1.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo1.value+form.TR1.value);
     }
  if (form.Termo2.value!="")
     {
       form.Termo2.focus();
       if (Dim_Campo(form.Termo2.value)==false) return(false);
       t=1;
       for(i=0;i<3;i++){if(form.OP2.options[i].selected==true)  { _OP[t]=form.OP2.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX2.options[i].selected==true){ _PRFX[t]=form.PRFX2.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR2.value=(form.TR2.checked==true)?form.TR2.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo2.value+form.TR2.value);
     }
  if (form.Termo3.value!="")
     {
       form.Termo3.focus();
       if (Dim_Campo(form.Termo3.value)==false) return(false);
       t=2;
       for(i=0;i<3;i++){if(form.OP3.options[i].selected==true)  { _OP[t]=form.OP3.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX3.options[i].selected==true){ _PRFX[t]=form.PRFX3.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR3.value=(form.TR3.checked==true)?form.TR3.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo3.value+form.TR3.value);
     }
  if (form.Termo4.value!="")
     {
       form.Termo4.focus();
       if (Dim_Campo(form.Termo4.value)==false) return(false);
       t=3;
       for(i=0;i<3;i++){if(form.OP4.options[i].selected==true)  { _OP[t]=form.OP4.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX4.options[i].selected==true){ _PRFX[t]=form.PRFX4.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR4.value=(form.TR4.checked==true)?form.TR4.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo4.value+form.TR4.value);
     }
  if (form.Termo5.value!="")
     {
       form.Termo5.focus();
       if (Dim_Campo(form.Termo5.value)==false) return(false);
       t=4;
       for(i=0;i<3;i++){if(form.OP5.options[i].selected==true)  { _OP[t]=form.OP5.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX5.options[i].selected==true){ _PRFX[t]=form.PRFX5.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR5.value=(form.TR5.checked==true)?form.TR5.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo5.value+form.TR5.value);
     }
  if (form.Termo6.value!="")
     {
       form.Termo6.focus();
       if (Dim_Campo(form.Termo6.value)==false) return(false);
       t=5;
       for(i=0;i<3;i++){if(form.OP6.options[i].selected==true)  { _OP[t]=form.OP6.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX6.options[i].selected==true){ _PRFX[t]=form.PRFX6.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR6.value=(form.TR6.checked==true)?form.TR6.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo6.value+form.TR6.value);
     }
  if (form.Termo7.value!="")
     {
       form.Termo7.focus();
       if (Dim_Campo(form.Termo7.value)==false) return(false);
       t=6;
       for(i=0;i<3;i++){if(form.OP7.options[i].selected==true)  { _OP[t]=form.OP7.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX7.options[i].selected==true){ _PRFX[t]=form.PRFX7.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR7.value=(form.TR7.checked==true)?form.TR7.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo7.value+form.TR7.value);
     }
  part1="";
  for (i=0;i<_NTermos-1;i++)
    {
     if (_Termo[i]!=null)
        {
         cont++;
         part1=(part1!="")?(part1+" "+_OP[i]+" "+_Termo[i]):_Termo[i];
        }
    }
  part2="";
  for(i=0;i<16;i++)
     {
       if(form.TDOC.options[i].selected==true)
          { 
           _tdoc=form.TDOC.options[i].value;    // Tipo de documento
           _tdoc=(_tdoc=="XX")?"":("TDOC " + _tdoc + " ");
          }
     }
  _dp=(form.DP.value!="")?("DP " + form.DP.value):"";  // Data de publicação
  part2=(_tdoc!="" && _dp!="")?(_tdoc + " AND " + _dp):(_tdoc+_dp);
  tmp=ConvUp((part1!="" && part2!="")?("(" + part1 + ") AND " + "("+part2+")"):part1+part2);
  if (tmp=="")
     {  
       alert("ATENÇÃO! Não existem termos para pesquisa!\n\nDeve preencher pelo menos um dos campos indicados\n");  
       return(false);
     } else 
     {
    
      form.expressao.value=tmp;
      return(true);
     }
}
// ----------------------------
function ValidaExpress_alias(form)
{
  _NTermos=10;  // termos
  _LTermos=7;   // linhas com termos
  _OP = new Array(_LTermos);
  _PRFX = new Array(_LTermos);
  _Termo = new Array(_LTermos);
  var cont=0,i=0,t=0,_tdoc="",_dp="",part1="",part2="";tmp="";
  if (form.Termo1.value!="")
     {
       form.Termo1.focus();
       if (Dim_Campo(form.Termo1.value)==false) return(false);
       t=0;
       for(i=0;i<_NTermos;i++){if(form.PRFX1.options[i].selected==true){ _PRFX[t]=form.PRFX1.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR1.value=(form.TR1.checked==true)?form.TR1.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo1.value+form.TR1.value);
     }
  if (form.Termo2.value!="")
     {
       form.Termo2.focus();
       if (Dim_Campo(form.Termo2.value)==false) return(false);
       t=1;
       for(i=0;i<3;i++){if(form.OP2.options[i].selected==true)  { _OP[t]=form.OP2.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX2.options[i].selected==true){ _PRFX[t]=form.PRFX2.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR2.value=(form.TR2.checked==true)?form.TR2.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo2.value+form.TR2.value);
     }
  if (form.Termo3.value!="")
     {
       form.Termo3.focus();
       if (Dim_Campo(form.Termo3.value)==false) return(false);
       t=2;
       for(i=0;i<3;i++){if(form.OP3.options[i].selected==true)  { _OP[t]=form.OP3.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX3.options[i].selected==true){ _PRFX[t]=form.PRFX3.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR3.value=(form.TR3.checked==true)?form.TR3.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo3.value+form.TR3.value);
     }
  if (form.Termo4.value!="")
     {
       form.Termo4.focus();
       if (Dim_Campo(form.Termo4.value)==false) return(false);
       t=3;
       for(i=0;i<3;i++){if(form.OP4.options[i].selected==true)  { _OP[t]=form.OP4.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX4.options[i].selected==true){ _PRFX[t]=form.PRFX4.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR4.value=(form.TR4.checked==true)?form.TR4.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo4.value+form.TR4.value);
     }
  if (form.Termo5.value!="")
     {
       form.Termo5.focus();
       if (Dim_Campo(form.Termo5.value)==false) return(false);
       t=4;
       for(i=0;i<3;i++){if(form.OP5.options[i].selected==true)  { _OP[t]=form.OP5.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX5.options[i].selected==true){ _PRFX[t]=form.PRFX5.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR5.value=(form.TR5.checked==true)?form.TR5.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo5.value+form.TR5.value);
     }
  if (form.Termo6.value!="")
     {
       form.Termo6.focus();
       if (Dim_Campo(form.Termo6.value)==false) return(false);
       t=5;
       for(i=0;i<3;i++){if(form.OP6.options[i].selected==true)  { _OP[t]=form.OP6.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX6.options[i].selected==true){ _PRFX[t]=form.PRFX6.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR6.value=(form.TR6.checked==true)?form.TR6.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo6.value+form.TR6.value);
     }
  if (form.Termo7.value!="")
     {
       form.Termo7.focus();
       if (Dim_Campo(form.Termo7.value)==false) return(false);
       t=6;
       for(i=0;i<3;i++){if(form.OP7.options[i].selected==true)  { _OP[t]=form.OP7.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX7.options[i].selected==true){ _PRFX[t]=form.PRFX7.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR7.value=(form.TR7.checked==true)?form.TR7.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo7.value+form.TR7.value);
     }
  part1="";
  for (i=0;i<_NTermos-1;i++)
    {
     if (_Termo[i]!=null)
        {
         cont++;
         part1=(part1!="")?(part1+" "+_OP[i]+" "+_Termo[i]):_Termo[i];
        }
    }
  part2="";
  for(i=0;i<16;i++)
     {
       if(form.TDOC.options[i].selected==true)
          { 
           _tdoc=form.TDOC.options[i].value;    // Tipo de documento
           _tdoc=(_tdoc=="XX")?"":("TDOC " + _tdoc + " ");
          }
     }
  _dp=(form.DP.value!="")?("DP " + form.DP.value):"";  // Data de publicação
  part2=(_tdoc!="" && _dp!="")?(_tdoc + "AND " + _dp):(_tdoc+_dp);
  tmp=ConvUp((part1!="" && part2!="")?("(" + part1 + ") AND " + "("+part2+")"):part1+part2);
  if (tmp=="")
     {  
       alert("ATENÇÃO! Não existem termos para pesquisa!\n\nDeve preencher pelo menos um dos campos indicados\n");  
       return(false);
     } else 
     {
        
      form.expressao.value=tmp;
	  
      return(true);
     }
}

// validaExpress_thes(form)
function ValidaExpress_thes(form)
{
  _NTermos=8;  // termos
  _LTermos=7;   // linhas com termos
  _OP = new Array(_LTermos);
  _PRFX = new Array(_LTermos);
  _Termo = new Array(_LTermos);
  var cont=0,i=0,t=0,_tdoc="",_dp="",part1="",part2="";tmp="";
  if (form.Termo1.value!="")
     {
       form.Termo1.focus();
       if (Dim_Campo(form.Termo1.value)==false) return(false);
       t=0;
       for(i=0;i<_NTermos;i++){if(form.PRFX1.options[i].selected==true){ _PRFX[t]=form.PRFX1.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR1.value=(form.TR1.checked==true)?form.TR1.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo1.value+form.TR1.value);
     }
  if (form.Termo2.value!="")
     {
       form.Termo2.focus();
       if (Dim_Campo(form.Termo2.value)==false) return(false);
       t=1;
       for(i=0;i<3;i++){if(form.OP2.options[i].selected==true)  { _OP[t]=form.OP2.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX2.options[i].selected==true){ _PRFX[t]=form.PRFX2.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR2.value=(form.TR2.checked==true)?form.TR2.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo2.value+form.TR2.value);
     }
  if (form.Termo3.value!="")
     {
       form.Termo3.focus();
       if (Dim_Campo(form.Termo3.value)==false) return(false);
       t=2;
       for(i=0;i<3;i++){if(form.OP3.options[i].selected==true)  { _OP[t]=form.OP3.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX3.options[i].selected==true){ _PRFX[t]=form.PRFX3.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR3.value=(form.TR3.checked==true)?form.TR3.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo3.value+form.TR3.value);
     }
  if (form.Termo4.value!="")
     {
       form.Termo4.focus();
       if (Dim_Campo(form.Termo4.value)==false) return(false);
       t=3;
       for(i=0;i<3;i++){if(form.OP4.options[i].selected==true)  { _OP[t]=form.OP4.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX4.options[i].selected==true){ _PRFX[t]=form.PRFX4.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR4.value=(form.TR4.checked==true)?form.TR4.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo4.value+form.TR4.value);
     }
  if (form.Termo5.value!="")
     {
       form.Termo5.focus();
       if (Dim_Campo(form.Termo5.value)==false) return(false);
       t=4;
       for(i=0;i<3;i++){if(form.OP5.options[i].selected==true)  { _OP[t]=form.OP5.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX5.options[i].selected==true){ _PRFX[t]=form.PRFX5.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR5.value=(form.TR5.checked==true)?form.TR5.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo5.value+form.TR5.value);
     }
  if (form.Termo6.value!="")
     {
       form.Termo6.focus();
       if (Dim_Campo(form.Termo6.value)==false) return(false);
       t=5;
       for(i=0;i<3;i++){if(form.OP6.options[i].selected==true)  { _OP[t]=form.OP6.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX6.options[i].selected==true){ _PRFX[t]=form.PRFX6.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR6.value=(form.TR6.checked==true)?form.TR6.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo6.value+form.TR6.value);
     }
  if (form.Termo7.value!="")
     {
       form.Termo7.focus();
       if (Dim_Campo(form.Termo7.value)==false) return(false);
       t=6;
       for(i=0;i<3;i++){if(form.OP7.options[i].selected==true)  { _OP[t]=form.OP7.options[i].value;}}
       for(i=0;i<_NTermos;i++){if(form.PRFX7.options[i].selected==true){ _PRFX[t]=form.PRFX7.options[i].value;_PRFX[t]=(_PRFX[t]=="PAL")?"":(_PRFX[t]+" ");}}
       form.TR7.value=(form.TR7.checked==true)?form.TR7.value:"";
       _Termo[t]=ChkChars(_PRFX[t]+form.Termo7.value+form.TR7.value);
     }
  part1="";
  for (i=0;i<_NTermos-1;i++)
    {
     if (_Termo[i]!=null)
        {
         cont++;
         part1=(part1!="")?(part1+" "+_OP[i]+" "+_Termo[i]):_Termo[i];
        }
    }
  part2="";
  
  _tdoc="";
 
  tmp=ConvUp((part1!="" && part2!="")?("(" + part1 + ") AND " + "("+part2+")"):part1+part2);
  if (tmp=="")
     {  
       alert("ATENÇÃO! Não existem termos para pesquisa!\n\nDeve preencher pelo menos um dos campos indicados\n");  
       return(false);
     } else 
     {
      
      form.expressao.value=tmp;
      return(true);
     }
}
// ----------------------------
function ValidaExpress_3(form)
{
// 
  

  var cont=0,i=0,t=0,_tdoc="",_dp="",part1="",part2="";tmp="";temp="";

  for(i=0;i<16;i++)
     {
       if(form.TDOC.options[i].selected==true)
          { 
           _tdoc=form.TDOC.options[i].value;    // Tipo de documento
           _tdoc=(_tdoc=="XX")?"":("TDOC " + _tdoc + " ");
          }
     }

  _dp=(form.DP.value!="")?("DP " + form.DP.value):"";  // Data de publicação
  temp=(_tdoc!="" && _dp!="")?(_tdoc + "AND " + _dp):(_tdoc+_dp);

  part1=LTrim(RTrim(form.termo.value));
  part1=ConvUp(FindReplace_2(part1,'  ',' '));
  tmp=ConvUp("("+part1+")" + (temp==""? "":" AND " + "("+temp+")"));
  if (tmp=="")
  {  
       alert("ATENÇÃO! Não existem termos para pesquisa!\n\nDeve definir uma expressão de pesquisa.\nPara mais informações consulte o guia do utilizador.");  
       return(false);
  }else{
         
	      if (part1!='')
		  {
		  part1 = part1.replace(/ +(?= )/g,''); part1 = part1.replace(/ AND NOT /g,'-');part1 = part1.replace(/ AND /g,'+');part1 = part1.replace(/ OR /g,' ');
		  part1 = part1.replace(/\s\+\s/g,'(*)');part1 = part1.replace(/\+\s/g,'(*)');part1 = part1.replace(/\s\+/g,'(*)'); part1 = part1.replace(/\+/g,'(*)');
          part1 = part1.replace(/\s\-\s/g,'(^)');part1 = part1.replace(/\s\-/g,'(^)'); part1 = part1.replace(/\-\s/g,'(^)'); part1 = part1.replace(/\-/g,'(^)');  
		  //var par= part1.split(/\W/).length;
		  var par= part1.match(/\b(\w+)\b/g).length;
		  if (par>1) {
		     var opr= part1.match(/\^|\s|\*/g).length   
		     if (par!=(opr+1)) { alert('Erro na expressão de pesquisa!');return false;}
		  } 
		  dblq=part1.match(/"(.*?)"/g);
		  		 		  
		  //if (part1.indexOf('"')!=-1 && dblq==null) { alert('Erro na expressão de pesquisa!');return false;}
		  if (dblq)
		  {

			  for (i=0;i<dblq.length;i++)
			  {
		         if (dblq[i].match(/\$/g)) { alert('Erro na expressão de pesquisa!');return false;}
				 eval("part1=part1.replace(/("+dblq[i]+")/, '"+dblq[i].replace(/\s/g,'~$~')+"')"); 
				 eval("part1=part1.replace(/\-"+dblq[i]+"/, '-"+dblq[i]+"')"); 
			  }
		  }	  

		  var p1= part1.match(/\s|\(\^\)|\(\*\)/g);
		  var tb= part1.split(/\s|\(\^\)|\(\*\)/g);
		  part1=(tb[0].match(/"(.*?)"/g) ? tb[0]: tb[0]+'$');
		  for(i=1;i<tb.length;i++)
		  {
		      if (p1[i-1]==' ') part1='('+part1+ ') or ('+ (tb[i].match(/"(.*?)"/g) ? tb[i]: tb[i]+'$')+')';
			  else if (p1[i-1]=='(*)') part1='('+part1+')'+ p1[i-1]+'('+(tb[i].match(/"(.*?)"/g) ? tb[i]: tb[i]+'$')+')';
			       else if (p1[i-1]=='(^)') part1=part1+ p1[i-1]+'('+(tb[i].match(/"(.*?)"/g) ? tb[i]: tb[i]+'$')+')';   
		  }
		  part1= part1.replace(/~/g,' ');
		  part1=part1.replace(/\(\^\)/g,' and not ');
		  part1=part1.replace(/\(\*\)/g,' and ');
		  
		  part1= part1.replace(/"/g,'');
		  var pa=part1.match(/\(/g);if (pa) var l=pa.length; else var l=0;
		  var pf=part1.match(/\)/g);if (pf) var r=pa.length; else var r=0;
		  //if (l>r) part1 +=')';
		  //if (!dblq && part1.match(/ or /))
		  //    part1= part1.replace ('$) or ','$) and ') + ') or ' + part1; 
          }
		  tmp=ConvUp(part1+ (part1==''?'$':'')+ (temp==""? "":" AND " + "("+temp+")"));	 		    
		  
		  //var flag=false;
		  //tarr= tmp.split(" ");
		  //for (var i = 0;  i < tarr.length; i++)		  
		  //  if (tarr[i].length<=3 && tarr[i]!="$") {flag=true; break; }   
		  //if (flag && dblq) tmp=tmp.replace(/\$/g,'*');
		  //alert(tmp);
	      
		  form.expressao.value=tmp;
         return(true);
     }
}
// ----------------------------
function ValidaExpress_4(form)
{
  var i=0;
  var trm="";
  var _tdoc="";
  var _dp="";
  var temp="",tmp="";
  for(i=0;i<16;i++)
     {
       if(form.TDOC.options[i].selected==true)
          { 
           _tdoc=form.TDOC.options[i].value;    // Tipo de documento
           _tdoc=(_tdoc=="XX")?"":("TDOC " + _tdoc + " ");
          }
     }
  _dp=(form.DP.value!="")?("DP " + form.DP.value):"";  // Data de publicação
  temp=(_tdoc!="" && _dp!="")?(_tdoc + " AND " + _dp):(_tdoc+_dp);if (temp!="") temp="(" + temp +")";
  trm=form.termo.value;if (trm!="") trm="(" + trm +")";
  tmp=ConvUp((trm!="" && temp!="")?(temp + " AND " + trm):temp+trm);
  if (tmp=="")
     {  
       alert("ATENÇÃO! Não existem termos para pesquisa!\n\nDeve definir uma expressão de pesquisa.\nPara mais informações consulte o guia do utilizador.");  
       return(false);
     } else 
     { 
       form.expressao.value=tmp;
       return(true);
     }
}

// ----------------------------
function ValidaExpress_5(form)
{
// 
  
  _OP = new Array(1);
  _Termo = new Array(1);
  var cont=0,i=0,t=0,_tdoc="",_dp="",part1="",part2="";tmp="";temp="";

  for(i=0;i<16;i++)
     {
       if(form.TDOC.options[i].selected==true)
          { 
           _tdoc=form.TDOC.options[i].value;    // Tipo de documento
           _tdoc=(_tdoc=="XX")?"":("TDOC " + _tdoc + " ");
          }
     }

  _dp=(form.DP.value!="")?("DP " + form.DP.value):"";  // Data de publicação
  temp=(_tdoc!="" && _dp!="")?(_tdoc + "AND " + _dp):(_tdoc+_dp);

  part1=LTrim(RTrim(form.termo.value));
//--------------------------------------
// trata o termo (espaços e operadores)
//--------------------------------------
  part1=FindReplace_2(part1,'  ',' ');
  
  
//--------------------------------------

  //tmp=ConvUp(part1+ (temp==""? "":" AND " + "("+temp+")"));

  if (part1=="")
     {  
       alert("ATENÇÃO! Não foi indicada uma palavra-chave para pesquisa!\n\nPara mais informações consulte o guia do utilizador.");  
       return(false);
     } else 
     { 

		  part1 = part1.replace(/ +(?= )/g,''); part1 = part1.replace(/ OR /g,' ');

		  dblq=part1.match(/"(.*?)"/g);
		 
		  if (dblq)
		  {
			  for (i=0;i<dblq.length;i++)
			  {
		         if (dblq[i].match(/\$/g)) { alert('Erro na expressão de pesquisa!');return false;}
				 eval("part1=part1.replace(/("+dblq[i]+")/, '"+dblq[i].replace(/\s/g,'~')+"')"); 
			  }
		  }	  
		  	      
		   
		  var tb= part1.split(/\s/g);
		  part1='PCH '+(tb[0].match(/"(.*?)"/g) ? tb[0]: tb[0]+'$');
		  for(i=1;i<tb.length;i++)
		  {
		      part1='('+part1+ ') or (PCH '+ (tb[i].match(/"(.*?)"/g) ? tb[i]: tb[i]+'$')+')';
			  
		  }
		  part1= part1.replace(/~/g,' ');	  
		  part1= part1.replace(/"/g,'');
	 
	      tmp=ConvUp(part1 +(temp==""? "":" AND " + "(\""+temp+"\")"));
	 
	//   part2= px==""? "":" ";
    //   if (form.truncatura.checked==false) 
	//             tmp=ConvUp(LTrim(px)+part2+part1+"$" + (temp==""? "":" AND " + "("+temp+")"));
	//   else   tmp=ConvUp("\""+LTrim(px)+part2+part1 +"\"" + (temp==""? "":" AND " + "(\""+temp+"\")"));	
	   form.expressao.value=tmp;
       return(true);
     }


  
}


// ----------------------------
function findInPage(str)
{
   var NS4 = (document.layers);
   var IE4 = (document.all);
   var win = this;
   var n   = 0;
   var txt, i, found;

   if (str == "") return false;
   if (NS4) 
      {if (!win.find(str))
          while(win.find(str, false, true)) n++;
       else
          n++;
       if (n == 0) lert("Não foi encontrado o texto "+str+" nesta página");
      }
   if (IE4) 
      {
       txt = win.document.body.createTextRange();
       for (i = 0; i <= n && (found = txt.findText(str)) != false; i++) 
           {
            txt.moveStart("character", 1);
            txt.moveEnd("textedit");
           }
   if (found)  
      {
       txt.moveStart("character", -1);
       txt.findText(str);
       txt.select();
       txt.scrollIntoView();
       n++;
      }
      else  
      { 
       if (n > 0) {n = 0; findInPage(str);
          }
          else alert("Não foi encontrado o texto "+str+" nesta página");
          }
      }
   return false;
}
// ----------------------------
function ChkVer()
{
  if (((navigator.appName == "Netscape") && (navigator.appVersion.substring(0,4) < "5.00")) ||
     ((navigator.appName == "Microsoft Internet Explorer") && (navigator.appVersion.substring(0,1) < "4")))
     {
      return(false);
     } else return(true);
} 
// -----------------------------
function MailIt(base,formato,express,mfn1,limites)
{
 var texto = "Envio do resultado de uma pesquisa por Email";
 var infile="mailit.in";
 express=FindRepChar(express,'+','OR');

 var loc = "/opac/cgi/www.exe/[in="+infile+"]?base="+base+"&formato="+formato+"&expressao="+express+"&lim_inicio="+mfn1+"&limites="+limites;
      eval('window.showModalDialog(loc,"","help:0;resizable:1;dialogWidth:535px;dialogHeight:400px;status:0;")')
 
}
// -----------------------------

function Imprimir(base,formato,express,mfn1,limites,entidade)
{
 var texto = "Imprimir registos";
 var infile;
 express=LimpaMais(express);
 infile="print.in";
 var loc = window.location.protocol+window.location.hostname+"/../cgi/www.exe/[in="+infile+"]?base="+base+"&formato="+formato+"&expressao="+express+"&lim_inicio="+mfn1+"&limites="+limites+"&entidade="+entidade;
 popup=window.open("","ID","toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,width=670,height=450,left=50,top=100");
 ndoc=popup.document;
 ndoc.location.href=loc;

 
}


  var NS4 = (document.layers) ? 1 : 0;
   var IE = (document.all) ? 1 : 0;
   var DOM = 0; 
   if (parseInt(navigator.appVersion) >=5) {DOM=1};


function changecont(header,ob) {    
                
                if (DOM) {
                    if ( lastHeader ) { 
                       lastHeader.style.background = "#f2f2f2"; 
                       lastHeader.style.fontWeight="normal"; 
                    }           
      
                    var thisTab = document.getElementById(header);			
                    thisTab.style.background = "silver";
                    thisTab.style.fontWeight = "bold";                   
                    lastHeader = document.getElementById(header);
                    return false;
                }else if (IE) {   
			        
                    if (lastHeader) { 
                        
                        lastHeader.style.background = "#f2f2f2"; 
                        lastHeader.style.fontWeight="normal";
						
                    }   
				
 						document.all[header].style.background = "silver";
						document.all[header].style.fontWeight = "bold";                  
						lastHeader=document.all[header]; 
					
                    return false;
                }else if (NS4) {
                    if (lastHeader) { lastHeader.bgColor = "white"; }                  
                    document.layers[header].bgColor  = "silver";
                    lastHeader=document.layers[header];
                    return false;
                }else {
                    window.location=("#A" +target);
                    return true;
                }
       }

// -----------------------------
function popitup()
{
   var loc = window.location.protocol+window.location.hostname+"/../cgi/www.exe/[in=pedemp.in]?base="+base+"&formato="+formato+"&expressao="+express+"&lim_inicio=1&limites=25&from="+mfn1+"&to="+mfn1;
   popup=window.open(loc,"ID","toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,width=450,height=260,left=150,top=110"); 
   if (window.focus) {popup.focus()}
   return false;
}
//var win2;

function popunimarc(base,express,formato,mfn1,op)
{
   var loc = window.location.protocol+window.location.hostname+"/../cgi/www.exe/[in=pesquni.in]?base="+base+"&formato="+formato+"&expressao="+express+"&lim_inicio=1&limites=25&from="+mfn1+"&to="+mfn1+"&op="+op;
   popup=window.open(loc,"ID","toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,width=550,height=280,left=200,top=110"); 

}


function Pedido_Empr(sigla,descri,email,nome,origem,mailori,morada,express,titulo,nreg,p)
{
   var texto = "Envio de pedido de empréstimo por Email";
   if (!p) {alert("Operação não permitida a utilizadores anónimos!!!"); return}
   //var loc = window.location.protocol+window.location.hostname+"/../cgi/www.exe/[in=pedemp.in]?base="+base+"&formato="+formato+"&expressao="+express+"&lim_inicio=1&limites=25&from="+mfn1+"&to="+mfn1;
	var loc = window.location.protocol+window.location.hostname+"/../pedidoemp.php?sigla="+sigla+"&descri="+unescape(descri)+"&email="+unescape(email)+"&titulo="+unescape(titulo)+"&expressao="+express+"&nome="+nome+"&origem="+unescape(origem)+"&mailori="+unescape(mailori)+"&morada="+unescape(morada)+"&nreg="+nreg;  
   //popup=window.open(loc,"","toolbar=no,location=no,directories=no,status=yes,scrollbars=no,resizable=yes,width=450,height=350,left=200,top=110");
     if (document.all)
        window.showModalDialog(loc,'','help:0;resizable:1;dialogWidth:580px;dialogHeight:590px;status:1;');
	 //eval("window.showModalDialog(loc,'','help:0;resizable:1;dialogWidth:480px;dialogHeight:420px;status:1;')")
     else
     eval("window.open(loc,'','Width:580px;Height:590px')");
    //if (window.focus) {popup.focus()}
}

var loadImage = function(w, h, isbn, target) {

var code= stripEAN(isbn); 
var ean= code + mod10CheckDigit(code);
var img = new Image(w,h);
url ="http://www.biblioteca.cm-feira.pt:8080/hipres/Imagens/livros/p"+LTrim(RTrim(isbn.substring(0,13)))+".jpg";
img.onerror = function (evt) {
  this.style.height="120px";
  this.style.width="160px";  
  this.src="http://ec2.images-amazon.com/images/P/"+LTrim(RTrim(isbn.substring(0,13)))+".01._AA240_SCLZZZZZZZ_.jpg"
  }
img.src = url;
img.style.visibility = "hidden";
var molde = document.createElement("div");
molde.setAttribute("id", "molde");
var style = molde.style;
style.width = img.width+"px";
style.height = img.height+"px";
document.getElementById(target).appendChild(molde);
molde.appendChild(img);
img.onload = function() {
    
    if (this && this.src != "")  { 
		 this.style.visibility = "visible";
     } 
  
}
}


function mod10CheckDigit(code) {

   var sum = 0;
	var digit = 0;

	/* Calculate the checksum digit here. */
	for (var i = code.length; i >= 1; --i)
	{
		digit = parseInt(code.substring( i - 1, i ) );

		/* This appears to be backwards but the EAN-13 checksum must be calculated
		this way to be compatible with UPC-A. */
		if ( i % 2 == 0 )
		{   /* odd */
			sum += digit * 3;
		}  
		else 
		{   /* even */
			sum += digit * 1; 
		}
	}
	
	var modDigit = ( 10 - ( sum % 10 ) )  % 10; 
	return modDigit;
}
function stripEAN(code)
{
  var s=code.substring(0,9);
  return s;
}

function ImageLoadFailed(ob)
{
	  var NS4 = (document.layers) ? 1 : 0;
      var IE = (document.all) ? 1 : 0;
      var DOM = 0; 
      if (parseInt(navigator.appVersion) >=5) {DOM=1};
	  if (DOM)
	    { 		  
		  ob.style.visibility = "hidden";
		}
	 else
        {       
         window.event.srcElement.style.display = "none";}

}

var version4 = (navigator.appVersion.charAt(0) == "4");
var popupHandle;
function closePopup() {
if(popupHandle != null && !popupHandle.closed) popupHandle.close()
}


function displayPopup(position,url,name,height,width,evnt)
{
// Nannette Thacker http://www.shiningstar.net
// position=1 POPUP: makes screen display up and/or left,
//    down and/or right
// depending on where cursor falls and size of window to open
// position=2 CENTER: makes screen fall in center

var properties = "toolbar=0,location=0, resizable=yes,height="+height;
properties = properties+",width="+width;

var leftprop, topprop, screenX, screenY, cursorX, cursorY, padAmt;

if(navigator.appName == "Microsoft Internet Explorer")
{
	screenY = document.body.offsetHeight;
	screenX = window.screen.availWidth;
}
else
{ // Navigator coordinates
//		screenY = window.outerHeight
//		screenX = window.outerWidth
	// change made 3/16/01 to work with Netscape:
		screenY = screen.height;
		screenX = screen.width;
}

if(position == 1)	// if POPUP not CENTER
{
	cursorX = evnt.screenX;
	cursorY = evnt.screenY;
	padAmtX = 10;
	padAmtY = 10;
	
	if((cursorY + height + padAmtY) > screenY)	
	// make sizes a negative number to move left/up
	{
		padAmtY = (-30) + (height*-1);	
		// if up or to left, make 30 as padding amount
	}
	if((cursorX + width + padAmtX) > screenX)
	{
		padAmtX = (-30) + (width*-1);	
		// if up or to left, make 30 as padding amount
	}

	if(navigator.appName == "Microsoft Internet Explorer")
	{
		leftprop = cursorX + padAmtX;
		topprop = cursorY + padAmtY;
	}
	else
	{ // adjust Netscape coordinates for scrolling
		leftprop = (cursorX - pageXOffset + padAmtX);
		topprop = (cursorY - pageYOffset + padAmtY);
	}
}
else	// CENTER
{
	leftvar = (screenX - width) / 2;
	rightvar = (screenY - height) / 2;
		
	if(navigator.appName == "Microsoft Internet Explorer")
	{
		leftprop = leftvar;
		topprop = rightvar;
	}
	else
	{ // adjust Netscape coordinates for scrolling
		leftprop = (leftvar - pageXOffset);
		topprop = (rightvar - pageYOffset);
	}
}

if(evnt != null)
{
properties = properties+",left="+leftprop;
properties = properties+",top="+topprop;
}
closePopup();
popupHandle = open(url,name,properties);
}


 
function show_popup(top,left,width,height,text)
{
var p=window.createPopup();
var pbody=p.document.body;
pbody.style.backgroundColor="#99cc00";
pbody.style.border="solid black 1px";
pbody.innerHTML=text;
p.show(top,left,width,height,document.body);
}

function gravarnodisco()
{
var fso = new ActiveXObject("Scripting.FileSystemObject");
var a = fso.CreateTextFile("c:\\testfile.txt", true);
a.WriteLine("This is a test.");
a.Close();
}


function chgAction( action_name )
    {
        if( action_name=="s" ) {
            document.pori.action = "cgi/multibase.exe";     
        }else{ 
            document.pori.action = "cgi/www.exe/[in=pesqger.in]";
        }
    }
	

function doHighlight(bodyText, searchTerm, highlightStartTag, highlightEndTag) 
{

  if ((!highlightStartTag) || (!highlightEndTag)) {
    highlightStartTag = "<font style=\"color:blue; background-color:yellow;\">";
    highlightEndTag = "</font>";
  }

  var newText = "";
  var i = -1;
  var lcSearchTerm = searchTerm.toLowerCase();
  var lcBodyText = bodyText.toLowerCase();
  
  while (bodyText.length > 0) {
    i = lcBodyText.indexOf(lcSearchTerm, i+1);
    if (i < 0) {
      newText += bodyText;
      bodyText = "";
    } else {
     
		  if (bodyText.lastIndexOf(">", i) >= bodyText.lastIndexOf("<", i)) {
			
			if (lcBodyText.lastIndexOf("/script>", i) >= lcBodyText.lastIndexOf("<script", i)) {
			  newText += bodyText.substring(0, i) + highlightStartTag + bodyText.substr(i, searchTerm.length) + highlightEndTag;
			  bodyText = bodyText.substr(i + searchTerm.length);
			  lcBodyText = bodyText.toLowerCase();
			  i = -1;
			}
		  }
    }
  }
   
  return newText;
}	
	
function Localizar(str)
{  
   document.body.innerHTML=doHighlight(document.body.innerHTML, str);
   return false;
}
	
function postToURL(url, values){ 
   values = values || {};    
   var form = createElement("form", {action: url,
                                         method: "POST",
										 style: "display: none"});    
	 for (var property in values)    {        
		 if (values.hasOwnProperty(property))        
		 	{ var value = values[property];            
		 	if (value instanceof Array)            
		 		{for (var i = 0, l = value.length; i < l; i++)                
				{                  
				form.appendChild(createElement("input", {type: "hidden",
				                                         name: property,
														 value: value[i]}));                
				}            
			}            
			else            
			{                
			    form.appendChild(createElement("input", {type: "hidden",
				                                         name: property,
														 value: value}));            
			}        
		}    
		}    
		document.body.appendChild(form);    
		form.submit();    
		document.body.removeChild(form);
}

 
	 
function createRequestObject() {        
    if (window.XMLHttpRequest)         
	{                
           return xmlhttprequest = new XMLHttpRequest();         
    }       
    else if (window.ActiveXObject)       
	{              
       return xmlhttprequest = new ActiveXObject("Microsoft.XMLHTTP");       
	} 
}

function getPage(url, metodo, modo, tagId, parametros)
{  
	   goAjax( url+"?"+parametros+"&rnd"+ Math.random() , metodo, modo , tagId); 
	   return false;
}
function goAjax(url, metodo, modo, parametros) {
             xmlhttp = createRequestObject();
            if(metodo == "GET") {
                xmlhttp.open("GET", url, modo);
            } else {        
                xmlhttp.open("POST", url, modo);
                xmlhttp.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=iso-8859-1");
                xmlhttp.setRequestHeader("Cache-Control", "no-store, no-cache, must-revalidate");
                xmlhttp.setRequestHeader("Cache-Control", "post-check=0, pre-check=0");
                xmlhttp.setRequestHeader("Pragma", "no-cache");
            }    
           
            xmlhttp.onreadystatechange = function() {
                if(xmlhttp.readyState == 4) {
                retorno=xmlhttp.responseText;
				return retorno
                }
            }
            if(metodo == "GET") {
                xmlhttp.send(null);
            } else {      
                xmlhttp.send(parametros);
            }
}

String.prototype.trim = function () {
return this.replace(/^\s*|\s*$/,"");
}

function ver_his()
{
  
 var loc = window.location.protocol+window.location.hostname+"/../../../admin/verhis.asp";
 popup=window.open("","historico","toolbar=no,location=no,directories=no,status=no,scrollbars=yes,resizable=yes,width=670,height=350,left=50,top=100");
 ndoc=popup.document;
 ndoc.location.href=loc;

}
/**
*
*  UTF-8 data encode / decode
*  http://www.webtoolkit.info/
*
**/
 
var Utf8 = {
 
	// public method for url encoding
	encode : function (string) {
		string = string.replace(/\r\n/g,"\n");
		var utftext = "";
 
		for (var n = 0; n < string.length; n++) {
 
			var c = string.charCodeAt(n);
 
			if (c < 128) {
				utftext += String.fromCharCode(c);
			}
			else if((c > 127) && (c < 2048)) {
				utftext += String.fromCharCode((c >> 6) | 192);
				utftext += String.fromCharCode((c & 63) | 128);
			}
			else {
				utftext += String.fromCharCode((c >> 12) | 224);
				utftext += String.fromCharCode(((c >> 6) & 63) | 128);
				utftext += String.fromCharCode((c & 63) | 128);
			}
 
		}
 
		return utftext;
	},
 
	// public method for url decoding
	decode : function (utftext) {
		var string = "";
		var i = 0;
		var c = c1 = c2 = 0;
 
		while ( i < utftext.length ) {
 
			c = utftext.charCodeAt(i);
 
			if (c < 128) {
				string += String.fromCharCode(c);
				i++;
			}
			else if((c > 191) && (c < 224)) {
				c2 = utftext.charCodeAt(i+1);
				string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
				i += 2;
			}
			else {
				c2 = utftext.charCodeAt(i+1);
				c3 = utftext.charCodeAt(i+2);
				string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
				i += 3;
			}
 
		}
 
		return string;
	}
 
}