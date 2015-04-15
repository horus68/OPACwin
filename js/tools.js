// JavaScript Document
String.prototype.trim = function () {
return this.replace(/^\s*|\s*$/,"");
}

function fechar()
{
 document.getElementById("fechar").style.display='none';
  document.getElementById("frmlogin").style.display='none';
}
function getInnerText(elt) {
	var _innerText = elt.innerText;
	if (_innerText == undefined) {
  		_innerText = elt.innerHTML.replace(/<[^>]+>/g,"");
	}
	return _innerText;
}
function setInnerText(elt,str) {
	if(document.all){
		 document.getElementById(elt).innerText = str;
	} else{
		document.getElementById(elt).textContent = str;
	}
}
function submitNS()
{
       var x='<%=session("LoggedIn")%>';   
	   if (x==true) return;
	   var e=getInnerText(document.getElementById("entrada"));
	   e=e.trim();
	   if (e=='Entrar')
	   {
		   document.getElementById("frmlogin").style.display='';
		   document.getElementById("Password").value='';
		   //document.getElementById("lblutilizador").style.display='none';
		   document.getElementById("fechar").style.display='';
		}
	   else
	   {
	     document.getElementById("frmlogin").action="/opac/login.asp?Logout.asp";
	   }
}

function validar()
     {
	   //window.location.reload(true);
	  
	   var x='<%=session("LoggedIn")%>';   
	   if (x==true) return;
	   var e=getInnerText(document.getElementById("entrada"));
	   e=e.trim();
	   if (e=='Entrar')
	   {
		   document.getElementById("frmlogin").style.display='';
		   document.getElementById("Password").value='';
		   //document.getElementById("lblutilizador").style.display='none';
		   document.getElementById("fechar").style.display='';
		   //var loc = "login.asp";
		   //var popup=window.open(loc,"ID","toolbar=no,location=no,directories=no,status=no,scrollbars=no,resizable=no,width=300,height=200,left=150,top=110");
		   //if (window.focus) popup.focus(); 
	   }
	   else 
	   {   var browserName=navigator.appName;
		   if (browserName=="Microsoft Internet Explorer")
			{ 
			 getPage ("logout.asp","POST","true", null, null);
			 document.getElementById("menu").innerHTML='';
			}
			else 
			{ 
             window.location.href="/opac/logout.asp?referr=NS";
			}
			 
	   }		
}
	 
function getfields()
{

var parametros= "Login=1";
    parametros = parametros + "&" + [
    'Nickname='+document.getElementById('Nickname').value,
	'Password='+document.getElementById('Password').value ].join('&');
     
   return (parametros);
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
function goAjax(url, metodo, modo, tagRetorno, parametros) {
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
				//alert(retorno);	      
				switch (retorno)
				{
				  case "":
							{
							document.getElementById("entrada").innerText='Entrar';    
							document.getElementById("utilizador").innerText='anónimo';
							document.getElementById("lblutilizador").style.display='';
							document.getElementById("menu").innerHTML=''; 
							document.getElementById("frmlogin").style.display='none'; break;}
				
				  default:  if (retorno.indexOf("xpto")== -1 )
							{
							document.getElementById("entrada").innerText='Sair';   
							var pos= retorno.indexOf("=")+2;
							document.getElementById("utilizador").innerText=retorno.substring(pos,retorno.indexOf(";",pos)-1);
							document.getElementById("lblutilizador").style.display=''; 
							document.getElementById("menu").innerHTML='<ul><li style="list-style-type: none;margin-left:-40px;"> <a href="admin/admin.asp">Administração</a></li></ul>'; 
							document.getElementById("frmlogin").style.display='none';}break;
				}
				
                }
            }
            if(metodo == "GET") {
                xmlhttp.send(null);
            } else {      
                xmlhttp.send(parametros);
            }
}