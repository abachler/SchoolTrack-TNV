//%attributes = {}
  //PF_SetIdentificadorPrincipal

  //opciones Identificadores nacionales

$age:=Int:C8(DT_ReturnAgeInMonths ([Profesores:4]Fecha_de_nacimiento:6)/12)
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



  //opciones según pais
Case of 
	: (<>vtXS_CountryCode="cl")
		If (([Profesores:4]RUT:27="") & ([Profesores:4]Nacionalidad:7#"Chilen@"))
			OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";True:C214)
		End if 
		If (Num:C11(Substring:C12([Profesores:4]RUT:27;1;Length:C16([Profesores:4]RUT:27)-1))>0)
			OBJECT SET FORMAT:C236([Profesores:4]RUT:27;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236([Profesores:4]RUT:27;"")
		End if 
		OBJECT SET FILTER:C235([Profesores:4]RUT:27;"&\"0-9;k;K\"")
		  //: (<>vtXS_CountryCode="co")
		  //$edadAgnos:=Int(DT_ReturnAgeInMonths ([Profesores]Fecha_de_nacimiento)/12)
		  //Case of 
		  //: (<>ai_IDNacional_LimiteEdad{1}=0)
		  //Case of 
		  //: (([Profesores]RUT="") & ([Profesores]Pasaporte="") & ([Profesores]IDNacional_2="") & ([Profesores]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Profesores]RUT#"") & ([Profesores]Pasaporte="") & ([Profesores]IDNacional_2="") & ([Profesores]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Profesores]RUT="") & ([Profesores]Pasaporte#"") & ([Profesores]IDNacional_2="") & ([Profesores]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //: (([Profesores]RUT="") & ([Profesores]Pasaporte="") & ([Profesores]IDNacional_2#"") & ([Profesores]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Profesores]RUT="") & ([Profesores]Pasaporte="") & ([Profesores]IDNacional_2="") & ([Profesores]IDNacional_3#""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //End case 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | ([Profesores]RUT#"") & ([Profesores]IDNacional_2="") & ([Profesores]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | ([Profesores]IDNacional_2#"") & ([Profesores]RUT="") & ([Profesores]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | ([Profesores]IDNacional_3#"") & ([Profesores]IDNacional_2="") & ([Profesores]RUT=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (([Profesores]RUT="") & ([Profesores]Pasaporte#"") & ([Profesores]IDNacional_2="") & ([Profesores]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //End case 
End case 

