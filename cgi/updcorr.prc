
    ,select s((if v9000^n='campo' then v9000^v fi))
	case '10' : 'D10'
				 (
				  if v9000^n: 'v10'  and v9000^v<>'' then
				 	'A10~'replace(v9000^v,'[$]','^')'~'
				  fi	
				 ),
	case '11' : 'D11'
	             (
	              if v9000^n: 'v11'  and v9000^v<>'' then
					'A11~'replace(v9000^v,'[$]','^')'~'
				  fi
				  ),
	case '101': 'D101A101~'replace(s((if v9000^n='v101'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '102': 'D102A102~'replace(s((if v9000^n='v102'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '200': 'D200A200~'replace(s((if v9000^n='v200'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '210': 'D210A210~'replace(s((if v9000^n='v210'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '215': 'D215'
    			 (
	              if v9000^n: 'v215'  and v9000^v<>'' then
					'A215~'replace(v9000^v,'[$]','^')'~'
				 fi
				 ),	
	case '461': 'D461D463D210D215D921D922'
				'A461~'replace(s((if v9000^n='v461'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A463~'replace(s((if v9000^n='v463'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A210~'replace(s((if v9000^n='v210'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A215~'replace(s((if v9000^n='v215'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
	            'A921~'replace(s((if v9000^n='v921'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A922~'replace(s((if v9000^n='v922'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '207': 'D207D303D921D922'
	            'A207~'replace(s((if v9000^n='v207'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A303~'replace(s((if v9000^n='v303'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A921~'replace(s((if v9000^n='v921'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A922~'replace(s((if v9000^n='v922'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '326': 'D326D921D922'
				(
				 if v9000^n:'v326'  and v9000^v<>'' then	
	            	'A326~'replace(v9000^v,'[$]','^')'~'
				 fi
				),
	            'A921~'replace(s((if v9000^n='v921'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A922~'replace(s((if v9000^n='v922'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '620': 'D620D921D922'
				(
				 if v9000^n:'v620'  and v9000^v<>'' then	
	            	'A620~'replace(v9000^v,'[$]','^')'~'
				  fi
				),
	            'A921~'replace(s((if v9000^n='v921'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~'
				'A922~'replace(s((if v9000^n='v922'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',			
	case '675':  'D675'
	             (
				   if v9000^n:'v675'  and v9000^v<>'' then 
				   'A675~'replace(v9000^v,'[$]','^')'~'
				   fi
				 ),
	case '700': 'D700A700~'replace(s((if v9000^n='v700'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '701': 'D701'
	             (
				   if v9000^n:'v701' and v9000^v<>'' then 
				   'A701~'replace(v9000^v,'[$]','^')'~'
				   fi
				 ),
	case '702':  'D702'
	             (
				  
				   if v9000^n:'v702'  and v9000^v<>'' then 
				   'A702~'replace(v9000^v,'[$]','^')'~'
				   fi
				  
				 ),
	case '931': 'D931A931~'replace(s((if v9000^n='v931'  and v9000^v<>'' then v9000^v fi)),'[$]','^')'~',
	case '966': 'D966'
	             (
				   if v9000^n:'v966'  and v9000^v<>'' then 
				  'A966~'replace(v9000^v,'[$]','^')'~'
				  fi 
				  ),
	endsel, 

