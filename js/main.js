function getAction()
  {
     var pos=document.getElementById("susers").selectedIndex;
	 var x=document.getElementById("susers").options[pos].value;
	 document.getElementById("expressao").value="SIGLA "+x;
	 document.getElementById("frmseluser").submit();
  }
  function validadados(){
       var status=true;var count=0;
       var msgconf="";var msgID="";
       var msg="";
       var senha=document.getElementById("v7");
       var confirma=document.getElementById("confirma");
	   document.getElementById("v1").style.backgroundColor="#fff";
	   document.getElementById("v2").style.backgroundColor="#fff";
	   document.getElementById("v3").style.backgroundColor="#fff";
	   senha.style.backgroundColor="#fff"; confirma.style.backgroundColor="#fff";
        if (senha.value!=confirma.value)
        { msgconf= "As senhas não conferem.\n";status=false; 
		senha.style.backgroundColor="#ff9797";confirma.style.backgroundColor="#ff9797" }
   		if (document.getElementById("v1").value=="")
        {msg = "ID"; status=false; count++;document.getElementById("v1").style.backgroundColor="#ff9797"}
        else {
		    var valor = parseInt(document.getElementById("v1").value);
            if (isNaN(valor))  
            {msgID = "O campo ID tem de ser numérico!\n";status=false;
			document.getElementById("v1").style.backgroundColor="#ff9797"}
		}	
        if (document.getElementById("v2").value=="")
        {msg= (msg != "") ? msg+ ",SIGLA": msg+"SIGLA"; status=false; count++;document.getElementById("v2").style.backgroundColor="#ff9797"}
        if (document.getElementById("v3").value=="")
        {msg=  (msg != "") ? msg +",NOME": msg+ "NOME"; status=false; count++;document.getElementById("v3").style.backgroundColor="#ff9797"}
        if (document.getElementById("v7").value=="")
        {msg= (msg != "") ? msg +",SENHA": msg+ "SENHA" ; status=false; count++;document.getElementById("v7").style.backgroundColor="#ff9797"}
        if (msg != "")  msg= "O" + (count>1 ? "s":"") + " campo" + (count >1 ? "s ":" ")  + msg + (count >1? " são" : " é") + " obrigatório" +(count >1? "s" : "") + ".";
        if (!status) alert ("ATENÇÂO! Existem erros no preenchimento do formulário.\n\n" +msgID+ msgconf + msg);
        return status;
       }
       function getDados(){
	     document.getElementById("c1").value=document.getElementById("v1").value;
         document.getElementById("c2").value=document.getElementById("v2").value; 
         document.getElementById("c3").value=document.getElementById("v3").value;
         document.getElementById("c4").value=document.getElementById("v4").value; 
         document.getElementById("c5").value=document.getElementById("v5").value; 
         document.getElementById("c6").value=document.getElementById("v6").value;
         document.getElementById("c7").value=document.getElementById("v7").value; 
         document.getElementById("c9").value=document.getElementById("v9").value; 
         document.getElementById("c10").value=document.getElementById("v10").value;
         document.getElementById("c11").value=document.getElementById("v11").value; 
         document.getElementById("c12").value=document.getElementById("v12").value; 
         document.getElementById("c16").value=document.getElementById("v16").value;
         document.getElementById("c17").value=document.getElementById("v17").value; 
         document.getElementById("c18").value=document.getElementById("v18").value;  
         document.getElementById("c21").value=document.getElementById("v21").value;        
       }	   
	   function pwdRob(pwd){
	        var strongRegex = new RegExp("^(?=.{8,})(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*\\W).*$", "g");
			var mediumRegex = new RegExp("^(?=.{7,})(((?=.*[A-Z])(?=.*[a-z]))|((?=.*[A-Z])(?=.*[0-9]))|((?=.*[a-z])(?=.*[0-9]))).*$", "g");
            var enoughRegex = new RegExp("(?=.{6,}).*", "g");
			var strength = document.getElementById('pwd');
			var barra='';var i;
			if (pwd.value.length==0) {
			strength.innerHTML = "";
			} else if (false == enoughRegex.test(pwd.value)) {
		
			strength.innerHTML = "&nbsp;Má!";
			} else if (strongRegex.test(pwd.value)) {
			strength.innerHTML = "<span style='color:green'>&nbsp;Forte!</span>";
			} else if (mediumRegex.test(pwd.value)) {
			strength.innerHTML = "<span style='color:orange'>&nbsp;Boa!</span>";
			} else { 
			strength.innerHTML = "<span style='color:red'>&nbsp;Fraca!</span>";
			}
		  }
    function chgColor(ob,status){
	    switch (status){
		  case true:ob.style.backgroundColor="#ccc";break;
		  case false:ob.style.backgroundColor="#fff";break;
		  default:break;
		}
	}
	function trim(str, chars) {
	return ltrim(rtrim(str, chars), chars);
	}
 
	function ltrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("^[" + chars + "]+", "g"), "");
	}
 
	function rtrim(str, chars) {
	chars = chars || "\\s";
	return str.replace(new RegExp("[" + chars + "]+$", "g"), "");
	}
	function validar_login(f){
	  if(f.nickname.value=="" && f.password.value=="")  
	   {f.nickname.focus();return false;}
	  else return true;
	}
	var cwin;
    function uploadISO2709() {
	    var texto = "Envio de ficheiro ISO 2709";
        var param = "new Window({className: \"mac_os_x\", title:\""+texto+"\", url:\"admin/admin_iso_upload.php\", top:150, left:150, width:500, height:200, zIndex: 10000,maximizable:false,minimizable:false,resizable:false,  showEffectOptions: {duration:3}});";
  		if (cwin==null) {
			cwin =eval(param);
       		cwin.show();
       		cwin.setDestroyOnClose();
       		myObserver = {
         		onDestroy: function(eventName, xwin) {
         		if (xwin == cwin) {
         				cwin = null;
         				Windows.removeObserver(this);
      					}
    			}
  			};
  			Windows.addObserver(myObserver);
  		}
	}
	
	