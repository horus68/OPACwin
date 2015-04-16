<!DOCTYPE html>
<head>
<title>Ver itinerário</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=8"/>
 <style type="text/css">
    body {
      font-family: Verdana, Arial, sans serif;
      margin: 2px;
    }
	table.directions td{ font-size: 8pt}
    table.directions th {

	  font-size: 8pt;
    }
    img {
      color: #000000;
    }
	a:link, a:visited {font-size: 9pt; font-weight:normal; color: magenta}
    form {font-size: 9pt;}
	</style>
<script type="text/javascript" src="http://maps.google.com/maps/api/js?sensor=false"></script>
<script type="text/javascript">

function decode_utf8(s){
return decodeURIComponent( escape( s ) );
} 
var map;
var geocoder;
var marker;
var directionsDisplay;
var directionsService = new google.maps.DirectionsService();

function showAddress(nome,address,lt,lg) {

    var address = {'address': address};
   
    if (lt!="" && lg!="") { 
	      var pos = new google.maps.LatLng(parseFloat(lt.replace(/,/,'.')), parseFloat(lg.replace(/,/,'.')));
	      createMap(pos);
          addMarker(nome,address, pos);
	}else { 
	    
		geocoder = new google.maps.Geocoder();
        geocoder.geocode(address, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            createMap (results[0].geometry.location);
			addMarker(nome,address, results[0].geometry.location);
        } else {
            alert("Endereço não encontrado: [erro - " + status+ "]");
        }
        });
    }
}	
function addMarker(nome, address, pos) {
 
  marker = new google.maps.Marker({
      map: map,
      position: pos,
      animation: google.maps.Animation.DROP,
      title: nome
  });
  
  var WinOptions = {
	content:
	'<h4>'+nome+'</h4>'+'<p>'+address.address+'</p>'
	};
  var infoWindow = new google.maps.InfoWindow(WinOptions);
  google.maps.event.addListener(marker, 'click', function() {
  infoWindow.open(map,marker);
  });
  infoWindow.open(map,marker)
} 

function createMap(pos) {
	map = new google.maps.Map(
		    document.getElementById('map'), {
			center: pos,
			zoom: 16,
			mapTypeId: google.maps.MapTypeId.ROADMAP
	});  
}   
     

function itinerario(origem, destino) {

		document.getElementById("from").value=origem;
		document.getElementById("to").value=destino;
		document.getElementById("map").style.display='none';
		document.getElementById("link").style.display='none';
		document.getElementById("itinerario").style.display='';
		var modo= document.getElementById("modo").options[document.getElementById("modo").selectedIndex].value;
		modo = (modo=='undefined' || modo=='')? google.maps.DirectionsTravelMode.DRIVING: google.maps.DirectionsTravelMode.WALKING;
		directionsDisplay = new google.maps.DirectionsRenderer();
		createMap = function (start) {
			var travel = {
					origin : (start.coords)? new google.maps.LatLng(start.lat, start.lng) : start.address,
					destination : destino,
					travelMode : modo					
				},
				mapOptions = {
					zoom: 10,
					center : marker.getPosition(),
					mapTypeId: google.maps.MapTypeId.ROADMAP
				};
				
			map = new google.maps.Map(document.getElementById("map_canvas"), mapOptions);
			directionsDisplay.setMap(map);
			directionsDisplay.setPanel(document.getElementById("directions"));
			directionsService.route(travel, function(result, status) {
				if (status === google.maps.DirectionsStatus.OK) {
					directionsDisplay.setDirections(result);
				}
			});
		};
			
		if (navigator.geolocation) {
			navigator.geolocation.getCurrentPosition(function (position) {
			        var coords = new google.maps.LatLng(position.coords.latitude, position.coords.longitude);
					geocoder = new google.maps.Geocoder();
					geocoder.geocode({'latLng': coords}, 
					function(data,status){ 
					if(status == google.maps.GeocoderStatus.OK){ 
						document.getElementById("from").value = data[0].formatted_address;  
						
					}});
					createMap({
						coords : true,
						lat : position.coords.latitude,
						lng : position.coords.longitude
					});
				}, 
				function () {
					// Gelocation fallback: Defaults to Stockholm, Sweden
					createMap({
						coords : false,
						address : origem
					});
				}
			);
		}
		else {
			// No geolocation fallback: Defaults to Lisbon, Portugal
			createMap({
				coords : false,
				address : origem
			});
		}
}

function calcRoute() {
  var modo= document.getElementById("modo").options[document.getElementById("modo").selectedIndex].value;
  modo = (modo=='undefined' || modo=='')? google.maps.DirectionsTravelMode.DRIVING: google.maps.DirectionsTravelMode.WALKING;
  var origem= document.getElementById("from").value;
  var destino= document.getElementById("to").value;
  var request = {
      origin: origem,
      destination:destino,
      travelMode: modo
  };
  directionsService.route(request, function(response, status) {
    if (status == google.maps.DirectionsStatus.OK) {
      directionsDisplay.setDirections(response);
    }
  });
}
  
function voltar() {
   document.getElementById("map").style.display='';
   document.getElementById("link").style.display='';
   document.getElementById("itinerario").style.display='none';
   document.getElementById("directions").innerHTML='';
   document.getElementById("ori_itinerario").value = document.getElementById("from").value;
   document.getElementById("dest_itinerario").value = document.getElementById("to").value;
}
</script>

</head>
<%

concelho= request("concelho")
if request("concelho")="" then concelho="Cantanhede"     
    
%>
<body onload="showAddress('<%=request("entidade")%>','<%=request("morada")%>'+', '+'<%=concelho%>','<%=request("lat")%>','<%=request("long")%>')">
<div id="map" style="width: 630px; height: 480px"></div>
<div id="link">
<form action="#" onsubmit="itinerario(this.ori_itinerario.value, this.dest_itinerario.value); return false" method="post">
<span style="margin-left:5px;font-size:.8em"><b> Origem(A): </b></span> <input style="font-size:.9em; width:160px" type="text" id="ori_itinerario" name="ori_itinerario" value="<%=concelho%>, PT">
<span style="font-size:.8em"><b> Destino(B): </b></span><input style="font-size:.9em;width:226px" type="text" name="dest_itinerario" value="<%=request("morada")%>,<%=concelho%>, PT">
<input style="font-size:.9em" type="submit"  value="Ver itinerario">
</form>
</div>

<div id="itinerario" style="display:none">
    <span style="float:right;padding-right:20px;font-size:0.8em">Modo: <select id="modo" onchange="calcRoute();"><option value="">de carro</option><option value="walking">a pé</option></select></span><h4>Como se deslocar até à biblioteca?</h4>
    <form action="#" id="frmpath" onsubmit="calcRoute(); return false">
      <table class="directions" >
        <tr>
          <td width="230">
		    Origem:
            <input style="font-size:1em;width:170px" type="text"  id="from" name="from" value=""/>
		  </td>	
          <td>
            Destino:
            <input style="font-size:1em;width:205px" type="text" id="to" name="to" value="" /> 
          </td>
		  <td><input style="font-size:1em" type="submit" name="submit" value="Atualizar" /></td>
		  <td align="right"><input style="font-size:1em" type="button" value="Voltar" onclick="voltar();" /></td>
        </tr> 
     </table>
    </form>
    <table class="directions">
      <tr>
        <td valign="top">
          <div id="directions" style="width: 230px"></div>
        </td>
        <td valign="top">
          <div id="map_canvas" style="margin-top:9px;width:390px; height: 400px"></div>
        </td>
      </tr>
    </table>   
</div>	
