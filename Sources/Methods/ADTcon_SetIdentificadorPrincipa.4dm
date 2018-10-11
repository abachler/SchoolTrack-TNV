//%attributes = {}
  //ADTcon_SetIdentificadorPrincipa

  //opciones Identificadores nacionales


If (<>ai_IDNacional_LimiteEdad{1}=0)
	OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
	OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
	OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
	OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
Else 
	$age:=Int:C8(DT_ReturnAgeInMonths ([ADT_Contactos:95]Fecha_de_Nacimiento:18)/12)
	Case of 
		: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
			
		: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDb@";True:C214)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
			
		: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
			OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";True:C214)
			OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
	End case 
End if 

  //opciones según pais
Case of 
	: (<>vtXS_CountryCode="cl")
		If (([ADT_Contactos:95]RUT:11="") & ([ADT_Contactos:95]Nacionalidad:19#"Chilen@"))
			OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";True:C214)
		End if 
		If (Num:C11(Substring:C12([ADT_Contactos:95]RUT:11;1;Length:C16([ADT_Contactos:95]RUT:11)-1))>0)
			OBJECT SET FORMAT:C236([ADT_Contactos:95]RUT:11;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236([ADT_Contactos:95]RUT:11;"")
		End if 
		OBJECT SET FILTER:C235([ADT_Contactos:95]RUT:11;"&\"0-9;k;K\"")
		  //: (<>vtXS_CountryCode="co")
		  //$edadAgnos:=Int(DT_ReturnAgeInMonths ([ADT_Contactos]Fecha_de_Nacimiento)/12)
		  //Case of 
		  //: (<>ai_IDNacional_LimiteEdad{1}=0)
		  //Case of 
		  //: (([ADT_Contactos]RUT="") & ([ADT_Contactos]Pasaporte="") & ([ADT_Contactos]IDNacional_2="") & ([ADT_Contactos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([ADT_Contactos]RUT#"") & ([ADT_Contactos]Pasaporte="") & ([ADT_Contactos]IDNacional_2="") & ([ADT_Contactos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([ADT_Contactos]RUT="") & ([ADT_Contactos]Pasaporte#"") & ([ADT_Contactos]IDNacional_2="") & ([ADT_Contactos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //: (([ADT_Contactos]RUT="") & ([ADT_Contactos]Pasaporte="") & ([ADT_Contactos]IDNacional_2#"") & ([ADT_Contactos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([ADT_Contactos]RUT="") & ([ADT_Contactos]Pasaporte="") & ([ADT_Contactos]IDNacional_2="") & ([ADT_Contactos]IDNacional_3#""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //End case 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | ([ADT_Contactos]RUT#"") & ([ADT_Contactos]IDNacional_2="") & ([ADT_Contactos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | ([ADT_Contactos]IDNacional_2#"") & ([ADT_Contactos]RUT="") & ([ADT_Contactos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | ([ADT_Contactos]IDNacional_3#"") & ([ADT_Contactos]IDNacional_2="") & ([ADT_Contactos]RUT=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (([ADT_Contactos]RUT="") & ([ADT_Contactos]Pasaporte#"") & ([ADT_Contactos]IDNacional_2="") & ([ADT_Contactos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //End case 
End case 