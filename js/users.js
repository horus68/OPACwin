function getAction()
  {
	 var pos=document.getElementById("susers").selectedIndex;
	 var x=document.getElementById("susers").options[pos].value;
	 document.getElementById("expressao").value="SIGLA "+x;
	 document.getElementById("frmseluser").submit();
	
}


function getActionRes()
  {
	 var pos=document.getElementById("estado").selectedIndex;
	 var x=document.getElementById("estado").options[pos].value;	   
	 if (x!='X') 
	 document.getElementById("express").value += " AND EST "+x;
	 document.getElementById("frmgesres").submit();
	
}

function getOp(){
   var pos=document.getElementById("criterio").selectedIndex;
   var x=document.getElementById("criterio").options[pos].value;
   switch(x){
   case 'X': document.getElementById("frmgescol").action="../admin/colselop.asp";break;
   case 'i': document.getElementById("frmgescol").action="../cgi/www.exe/[in=mnucol.in]"; document.getElementById("mnu").value="2";break;
   case 'c': document.getElementById("frmgescol").action="../cgi/www.exe/[in=mnucol.in]"; document.getElementById("mnu").value="3";break;	 
   }
   document.getElementById("frmgescol").submit();
}


function getOpCol(){
   var pos=document.getElementById("opges").selectedIndex;
   var x=document.getElementById("opges").options[pos].value;
   if (x!="" && document.getElementById("termo").value=="") {alert("ATENÇÃO! O termo não pode ficar vazio.");return false}
   var ss= x + " " +  document.getElementById("termo").value;
   var flag=false;
   if(document.getElementById("op").value.toUpperCase()==document.getElementById("base").value.toUpperCase()) flag=true;
   document.getElementById("op").value=document.getElementById("op").value.toUpperCase();
   document.getElementById("expressao").value =(document.getElementById("op").value=='X' || flag==true? ss : "SI " + document.getElementById("op").value+ " AND " + ss);
   if(document.getElementById("PFX").checked==false) document.getElementById("expressao").value += "$";
   if(document.getElementById("limites").value =="" || parseInt(document.getElementById("limites").value)<=0 || parseInt(document.getElementById("limites").value)>1000 ) document.getElementById("limites").value="25";
   document.getElementById("frmselcri").submit();
}

function getOpsel(){
	 var pos=document.getElementById("susers").selectedIndex;
	 if (pos==-1) {alert("ATENÇÃO! É necessário selecionar um utilizador.");return false}
	 var x=document.getElementById("susers").options[pos].value;
	 var tags=x.split("~~");
	 document.getElementById("base").value=tags[1]; 
	 document.getElementById("users").value=tags[0];

	 if (FileExists("../admin/chkfile.asp?vdir=/opac&fname="+tags[1].toLowerCase()+"&d="+new Date().getTime())=='False') {alert("ATENÇÃO! Biblioteca sem base de dados carregada no sistema.");return};
//	 if (tags[0]==tags[1]) 
//		document.getElementById("expressao").value="";
//	 else
//	     document.getElementById("expressao").value="SI "+tags[0];
	 if (document.getElementById("mnu").value=='2')
	    document.getElementById("frmselcri").action="../../admin/colselop.asp";
	 else
	 {
	   document.getElementById("base").value=document.getElementById("base").value.toLowerCase();
	   document.getElementById("frmselcri").action="../../admin/graficos.asp";
	 }  
	 document.getElementById("frmselcri").submit();
}

function validadados(flag){
       
	 
       var status=true;var stat_gps=true;
       var msgconf="";var msgID="";
       var msg="";
       //if (!ValidateSigla(document.getElementById("v21"))) return false;
	   if (!ValidateEmail(document.getElementById("v11"))) return false; 
	   if (flag!=-1)
	   {
       var senha=document.getElementById("v7").value;
       var confirma=document.getElementById("confirma").value;
	    if (senha!=confirma)
        { msgconf= "As senhas não conferem.\n";status=false; }
		if (document.getElementById("v1").value=="")
        {msg = "ID"; status=false; }
        else {
		    var valor = parseInt(document.getElementById("v1").value);
            if (isNaN(valor)) 
            {msgID = "O campo ID tem de ser numérico!\n";status=false;}
		}	
        if (document.getElementById("v2").value=="")
        {msg= (msg != "") ? msg+ ",SIGLA": msg+"SIGLA"; status=false; }
		
		}
        if (document.getElementById("v3").value=="")
        {msg=  (msg != "") ? msg +",NOME": msg+ "NOME"; status=false; }
        
		if (flag!=-1)
	    {
		if (document.getElementById("v7").value=="")
        {msg= (msg != "") ? msg +",SENHA": msg+ "SENHA" ; status=false; }
        }
		if (msg != "")  msg= "Os campos " + msg + " são obrigatórios.";
		if (document.getElementById("v22").value!=""){
 		 	   var valor1 = document.getElementById("v22").value;
			   if (!ValidateGPS(valor1)) stat_gps=false;
             
        }
        if (document.getElementById("v23").value!=""){
		       var valor2 = document.getElementById("v23").value;
			   if (!ValidateGPS(valor2)) stat_gps=false;
        }      
		if (!stat_gps) { msgID += "As coordenadas GPS devem ser valores numéricos [ex: -3,02345].\n";status=false;}
        if (!status) alert ("ATENÇÂO! Existem erros no preenchimento do formulário.\n\n" + msgID+msgconf + msg)
		return status;
    }

	
'       function validadados() {'
'       var status=true; var stat_gps=true;'
'       var msg="";' 
'       var msgID="";'
'        //if (!ValidateSigla(document.getElementById("v21"))) return false;'	
'		 if (!ValidateEmail(document.getElementById("v11"))) return false;'
'        if (document.getElementById("v3").value=="")'
'        {msg=  (msg != "") ? msg +",NOME": msg+ "NOME"; status=false; }'
'        if (msg != "")  msg= "Os campos " + msg + " são obrigatórios.";'
'        if (document.getElementById("v22").value!=""){'
'				var valor1 = document.getElementById("v22").value;'
'			    if (!ValidateGPS(valor1)) stat_gps=false;'
'        }'
'        if (document.getElementById("v23").value!=""){'
'		       var valor2 = document.getElementById("v23").value;'
'			   if (!ValidateGPS(valor2)) stat_gps=false;'
'        }'
'		 if (!stat_gps) { msgID += "As coordenadas GPS têm de ser valores numéricos [ex: -3,02345].\n";status=false;}'
'        if (!status) alert ("ATENÇÂO! Existem erros no preenchimento do formulário.\n\n" + msgID +"\n" + msg);'
'        return status;'
'       }'	
	
function validadadosLeitor(){
       
	     
       var status=true;
       var msg="";var msgID="";
	    if (!ValidateData(document.getElementById("v3"))) return false;	
		if (!ValidateEmail(document.getElementById("v9"))) return false;
       	if (document.getElementById("v20").options[document.getElementById("v20").selectedIndex].value=="")
		{msg = "BIBLIOTECA"; status=false; }
		if (document.getElementById("v1").value=="")
        {msg= (msg != "") ? msg+ ",Nº de LEITOR": msg+"Nº de LEITOR"; status=false; }
        else {
		    var valor = parseInt(document.getElementById("v1").value);
            if (isNaN(valor)) 
            {msgID = "O campo Nº Leitor tem de ser numérico!\n";status=false;}
		}	
        if (document.getElementById("v2").value=="")
        {msg= (msg != "") ? msg+ ",NOME": msg+"NOME"; status=false; }
        if (document.getElementById("v4").value=="")
        {msg=  (msg != "") ? msg +",MORADA": msg+ "MORADA"; status=false; }
        if (document.getElementById("v5").value=="")
        {msg= (msg != "") ? msg +",CONCELHO": msg+ "CONCELHO" ; status=false; }
        if (msg != "")  msg= "O(s) campo(s) " + msg + " é(são) obrigatório(s).\n";
		if (!status) alert ("ATENÇÂO! Existem erros no preenchimento do formulário.\n\n" + msg+msgID)
		return status;
    }
		   
   function chkuser()
   {
            
		   var flag=false; var now=new Date();
		   new Ajax.Request('../cgi/www.exe/[in=veruser.in]?sigla='+document.getElementById("v2").value.toLowerCase()+'&r='+ now.getTime(), {     
           method:'get',     
		   onSuccess: function(transport){       
		   var response = transport.responseText || "nao";  
      	   
		   if (response.indexOf('sim')!=-1) {alert("ATENÇÃO! Já existe um utilizador com esta SIGLA ["+document.getElementById("v2").value.toUpperCase()+"]");} 
		   else 
		     {
			   document.getElementById("v7").value=check(document.getElementById("v7"));
			   document.getElementById("confirma").value=check(document.getElementById("confirma"));
			   flag=validadados(); 
			   if (flag) {document.getElementById("frminuser").action ="/opac/cgi/www.exe/[in=newuser.in]?r="+now.getTime(); document.getElementById("frminuser").submit();}
			 }},     
		   onFailure: function(){ alert('Ocorreu um erro. Contacte o administrador.') }}); 
		   return false;
   }
   
    function chkleitor()
   {
          
		   var flag=false;var now=new Date();

		   new Ajax.Request('../cgi/www.exe/[in=verleitor.in]?nome='+ConvUp(document.getElementById("v2").value)+'&r='+now.getTime(), {     
           method:'get',     
		   onSuccess: function(transport){       
		   var response = transport.responseText || "nao";      	
		   if (response.indexOf('sim')!=-1) {alert("ATENÇÃO! Já existe um utilizador com este nome ["+document.getElementById("v2").value.toUpperCase()+"]");} 
		   else 
		     {
			   flag=validadadosLeitor(); 
			   if (flag) {document.getElementById("frminleitor").action ="/opac/cgi/www.exe/[in=newleitor.in]?r="+now.getTime(); document.getElementById("frminleitor").submit();}}},     
		   onFailure: function(){ alert('Ocorreu um erro. Contacte o administrador.') }   }); 
		   return false;
   }
	    
  function pwdRob(pwd){
	        var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
			var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
            var enoughRegex = new RegExp("(?=.{6,}).*", "g");
			var strength = document.getElementById('pwd');
			if (pwd.value.length==0) {
			strength.innerHTML = "";
			} else if (false == enoughRegex.test(pwd.value)) {
			strength.innerHTML = "<img src='/opac/imagens/pwd0.gif' border='0'>";   //muito fraca
			} else if (strongRegex.test(pwd.value)) {
			strength.innerHTML = "<img src='/opac/imagens/pwd4.gif' border='0'>";  // muito boa
			} else if (mediumRegex.test(pwd.value)) {
			strength.innerHTML = "<img src='/opac/imagens/pwd3.gif' border='0'>";  //razoável
			} else { 
			strength.innerHTML = "<img src='/opac/imagens/pwd1.gif' border='0'>";  //fraca
			}
		  } 

  function chgColor(ob,status){
	    switch (status){
		  case true:ob.style.backgroundColor="#99ff66";break;
		  case false:ob.style.backgroundColor="#fff";break;
		  default:
		}
		//document.getElementById("pwd").innerHTML="";
	}
	
  function alpha(s)
  {
	
	for(var j=0; j<s.length; j++)
	{
		  var alphaa = s.charAt(j);
		  var hh = alphaa.charCodeAt(0);
		  if( (hh > 64 && hh<91) || (hh > 96 && hh<123))
		  {
		  }
		    else return false;
		  
 	}
 return true;
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
String.prototype.soundex = function(p){ //v1.0
	var i, j, r, p = isNaN(p) ? 4 : p > 10 ? 10 : p < 4 ? 4 : p,
	m = {BFPV: 1, CGJKQSXZ: 2, DT: 3, L: 4, MN: 5, R: 6},
	r = (s = this.toUpperCase().replace(/[^A-Z]/g, "").split("")).splice(0, 1);
	for(i in s)
		for(j in m)
			if(j.indexOf(s[i]) + 1 && r[r.length-1] != m[j] && r.push(m[j]))
				break;
	return r.length > p && (r.length = p), r.join("") + (new Array(p - r.length + 1)).join("0");
};
Array.prototype.max = function() {
var max = this[0];
var len = this.length;
for (var i = 1; i < len; i++) if (this[i] > max) max = this[i];
return max;
}
Array.prototype.min = function() {
var min = this[0];
var len = this.length;
for (var i = 1; i < len; i++) if (this[i] < min) min = this[i];
return min;
}

function trim(stringToTrim) {
	return stringToTrim.replace(/^\s+|\s+$/g,"");
}
function ltrim(stringToTrim) {
	return stringToTrim.replace(/^\s+/,"");
}
function rtrim(stringToTrim) {
	return stringToTrim.replace(/\s+$/,"");
}

var dtCh= "-";
var minYear=1900;
var maxYear=2100;

function isInteger(s){
	var i;
    for (i = 0; i < s.length; i++){   
        // Check that current character is number.
        var c = s.charAt(i);
        if (((c < "0") || (c > "9"))) return false;
    }
    // All characters are numbers.
    return true;
}

function stripCharsInBag(s, bag){
	var i;
    var returnString = "";
    // Search through string's characters one by one.
    // If character is not in bag, append to returnString.
    for (i = 0; i < s.length; i++){   
        var c = s.charAt(i);
        if (bag.indexOf(c) == -1) returnString += c;
    }
    return returnString;
}

function daysInFebruary (year){
	// February has 29 days in any year evenly divisible by four,
    // EXCEPT for centurial years which are not also divisible by 400.
    return (((year % 4 == 0) && ( (!(year % 100 == 0)) || (year % 400 == 0))) ? 29 : 28 );
}
function DaysArray(n) {
	for (var i = 1; i <= n; i++) {
		this[i] = 31
		if (i==4 || i==6 || i==9 || i==11) {this[i] = 30}
		if (i==2) {this[i] = 29}
   } 
   return this
}

function isDate(dtStr){
	var daysInMonth = DaysArray(12)
	var pos1=dtStr.indexOf(dtCh)
	var pos2=dtStr.indexOf(dtCh,pos1+1)
	var strDay=dtStr.substring(0,pos1)
	var strMonth=dtStr.substring(pos1+1,pos2)
	var strYear=dtStr.substring(pos2+1)
	strYr=strYear
	if (strDay.charAt(0)=="0" && strDay.length>1) strDay=strDay.substring(1)
	if (strMonth.charAt(0)=="0" && strMonth.length>1) strMonth=strMonth.substring(1)
	for (var i = 1; i <= 3; i++) {
		if (strYr.charAt(0)=="0" && strYr.length>1) strYr=strYr.substring(1)
	}
	month=parseInt(strMonth)
	day=parseInt(strDay)
	year=parseInt(strYr)
	if (pos1==-1 || pos2==-1){
		alert("O formato da data deve ser: dd-mm-yyyy .")
		return false
	}
	if (strMonth.length<1 || month<1 || month>12){
		alert("Por favor indique um mês válido.")
		return false
	}
	if (strDay.length<1 || day<1 || day>31 || (month==2 && day>daysInFebruary(year)) || day > daysInMonth[month]){
		alert("Por favor indique um dia do mês válido.")
		return false
	}
	if (strYear.length != 4 || year==0 || year<minYear || year>maxYear){
		alert("Por favor indique um ano entre "+minYear+" e "+maxYear+".")
		return false
	}
	if (dtStr.indexOf(dtCh,pos2+1)!=-1 || isInteger(stripCharsInBag(dtStr, dtCh))==false){
		alert("Por favor indique uma data válida.")
		return false
	}
return true
}

function ValidateEmail(ctrl) {               
var strMail = ctrl.value;   
if (strMail=="") return true;    
var regMail =/^\w+([-.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/;        
if (regMail.test(strMail)) {            
	return true;}        
else {
	ctrl.value = "";            
	ctrl.focus();            
	alert("Email inválido.\nPor favor indique um email válido no formato nome@servidor.dominio");            
	return false;        
	}
}

function ValidateData(ctrl) {
   
	    if (ctrl.value !="" && !isDate(ctrl.value)) 
		{
		    ctrl.value="";
			ctrl.focus();    
			return false;
		}else return true;
		
}		
function ValidateSigla(ctrl) {
   
	       var sigla=ctrl.value; 
		   switch (sigla.toLowerCase())
		   {
		    case 'admin':
		    	ctrl.value="";
				ctrl.focus(); 
				alert('O nome de agrupamento não é válido.');   
				return false;
				break;
			case '': 
			    return true;
			    break;     	
		    default:
			   var flag=false;
			   new Ajax.Request('../cgi/www.exe/[in=veragr.in]?agr='+sigla.toLowerCase(), {     
			   method:'get', 		   
			   onSuccess: function(transport){       
			   var response = transport.responseText || "nao";      
			   if (response.indexOf('sim')!=-1) 
				  flag= true;				  
			   else 
				 {	   
				ctrl.value="";
				ctrl.focus();    
				alert('A entidade não existe ou o nome de agrupamento não é válido.'); 
				}},
				onFailure: function(){ alert('Ocorreu um erro. Contacte o administrador.') }   });
				return flag;
				break;
			}	
}		

function ValidateGPS(str) {
        str=rtrim(str);
		if (isNaN(parseInt(str))) return false;
		var regStr =/^[+-]?\d+([,]\d+)*$/;        
		if (regStr.test(str)) {            
			return true;
		}else{ 
		    return false;        
		}		
}

function check(f){ 
   return hex_md5(f.value);	
}

function FileExists(strURL)
{
    oHttp = window.ActiveXObject ? new ActiveXObject("Microsoft.XMLHTTP") : new XMLHttpRequest(); 
	oHttp.open("GET", strURL, false);
	oHttp.send();
	return (oHttp.responseText);
}
	