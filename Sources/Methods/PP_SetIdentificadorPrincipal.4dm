//%attributes = {}
  //PP_SetIdentificadorPrincipal

  //opciones Identificadores nacionales


If (<>ai_IDNacional_LimiteEdad{1}=0)
	OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
	OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
	OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
	OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
Else 
	$age:=Int:C8(DT_ReturnAgeInMonths ([Personas:7]Fecha_de_nacimiento:5)/12)
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
		If (([Personas:7]RUT:6="") & ([Personas:7]Nacionalidad:7#"Chilen@"))
			OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";True:C214)
		End if 
		If (Num:C11(Substring:C12([Personas:7]RUT:6;1;Length:C16([Personas:7]RUT:6)-1))>0)
			OBJECT SET FORMAT:C236([Personas:7]RUT:6;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236([Personas:7]RUT:6;"")
		End if 
		OBJECT SET FILTER:C235([Personas:7]RUT:6;"&\"0-9;k;K\"")
	Else 
		If ([Personas:7]Fecha_de_nacimiento:5=!00-00-00!)
			
			Case of 
				: ([Personas:7]RUT:6#"")
					OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
					OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
				: ([Personas:7]IDNacional_2:37#"")
					OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDb@";True:C214)
					OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
				: ([Personas:7]IDNacional_3:38#"")
					OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDc@";True:C214)
					OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
					
			End case 
			
		End if 
		
		  //: (<>vtXS_CountryCode="co")
		  //$edadAgnos:=Int(DT_ReturnAgeInMonths ([Personas]Fecha_de_nacimiento)/12)
		  //Case of 
		  //: (<>ai_IDNacional_LimiteEdad{1}=0)
		  //Case of 
		  //: (([Personas]RUT="") & ([Personas]Pasaporte="") & ([Personas]IDNacional_2="") & ([Personas]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Personas]RUT#"") & ([Personas]Pasaporte="") & ([Personas]IDNacional_2="") & ([Personas]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Personas]RUT="") & ([Personas]Pasaporte#"") & ([Personas]IDNacional_2="") & ([Personas]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //: (([Personas]RUT="") & ([Personas]Pasaporte="") & ([Personas]IDNacional_2#"") & ([Personas]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Personas]RUT="") & ([Personas]Pasaporte="") & ([Personas]IDNacional_2="") & ([Personas]IDNacional_3#""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //End case 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | ([Personas]RUT#"") & ([Personas]IDNacional_2="") & ([Personas]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | ([Personas]IDNacional_2#"") & ([Personas]RUT="") & ([Personas]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | ([Personas]IDNacional_3#"") & ([Personas]IDNacional_2="") & ([Personas]RUT=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (([Personas]RUT="") & ([Personas]Pasaporte#"") & ([Personas]IDNacional_2="") & ([Personas]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //End case 
End case 



  //
  //