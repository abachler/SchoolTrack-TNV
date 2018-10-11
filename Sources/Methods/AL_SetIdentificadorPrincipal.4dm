//%attributes = {}
  //AL_SetIdentificadorPrincipal

  //opciones Identificadores nacionales


If (<>ai_IDNacional_LimiteEdad{1}=0)
	OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
	OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
	OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
	OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
Else 
	$age:=Int:C8(DT_ReturnAgeInMonths ([Alumnos:2]Fecha_de_nacimiento:7)/12)
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
		If (([Alumnos:2]RUT:5="") & ([Alumnos:2]Nacionalidad:8#"Chilen@"))
			OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
			OBJECT SET VISIBLE:C603(*;"IDd@";True:C214)
		End if 
		If (Num:C11(Substring:C12([Alumnos:2]RUT:5;1;Length:C16([Alumnos:2]RUT:5)-1))>0)
			OBJECT SET FORMAT:C236([Alumnos:2]RUT:5;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236([Alumnos:2]RUT:5;"")
		End if 
		OBJECT SET FILTER:C235([Alumnos:2]RUT:5;"&\"0-9;k;K\"")
	Else 
		
		If ([Alumnos:2]Fecha_de_nacimiento:7=!00-00-00!)
			
			Case of 
				: ([Alumnos:2]RUT:5#"")
					OBJECT SET VISIBLE:C603(*;"IDa@";True:C214)
					OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
				: ([Alumnos:2]IDNacional_2:71#"")
					OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDb@";True:C214)
					OBJECT SET VISIBLE:C603(*;"IDc@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
				: ([Alumnos:2]IDNacional_3:70#"")
					OBJECT SET VISIBLE:C603(*;"IDa@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDb@";False:C215)
					OBJECT SET VISIBLE:C603(*;"IDc@";True:C214)
					OBJECT SET VISIBLE:C603(*;"IDd@";False:C215)
					
			End case 
			
		End if 
		  //: (<>vtXS_CountryCode="co")
		  //$edadAgnos:=Int(DT_ReturnAgeInMonths ([Alumnos]Fecha_de_nacimiento)/12)
		  //Case of 
		  //: (<>ai_IDNacional_LimiteEdad{1}=0)
		  //Case of 
		  //: (([Alumnos]RUT="") & ([Alumnos]NoPasaporte="") & ([Alumnos]IDNacional_2="") & ([Alumnos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Alumnos]RUT#"") & ([Alumnos]NoPasaporte="") & ([Alumnos]IDNacional_2="") & ([Alumnos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Alumnos]RUT="") & ([Alumnos]NoPasaporte#"") & ([Alumnos]IDNacional_2="") & ([Alumnos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //: (([Alumnos]RUT="") & ([Alumnos]NoPasaporte="") & ([Alumnos]IDNacional_2#"") & ([Alumnos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //: (([Alumnos]RUT="") & ([Alumnos]NoPasaporte="") & ([Alumnos]IDNacional_2="") & ([Alumnos]IDNacional_3#""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //End case 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | ([Alumnos]RUT#"") & ([Alumnos]IDNacional_2="") & ([Alumnos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";True)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | ([Alumnos]IDNacional_2#"") & ([Alumnos]RUT="") & ([Alumnos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";True)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | ([Alumnos]IDNacional_3#"") & ([Alumnos]IDNacional_2="") & ([Alumnos]RUT=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";True)
		  //OBJECT SET VISIBLE(*;"IDd@";False)
		  //
		  //: (([Alumnos]RUT="") & ([Alumnos]NoPasaporte#"") & ([Alumnos]IDNacional_2="") & ([Alumnos]IDNacional_3=""))
		  //OBJECT SET VISIBLE(*;"IDa@";False)
		  //OBJECT SET VISIBLE(*;"IDb@";False)
		  //OBJECT SET VISIBLE(*;"IDc@";False)
		  //OBJECT SET VISIBLE(*;"IDd@";True)
		  //End case 
		
End case 
  //






