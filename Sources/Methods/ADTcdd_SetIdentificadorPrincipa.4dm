//%attributes = {}
  //ADTcdd_SetIdentificadorPrincipa

  //opciones Identificadores nacionales

  //Para candidato

AL_SetIdentificadorPrincipal 

  //Para mamá....

If (<>ai_IDNacional_LimiteEdad{1}=0)
	OBJECT SET VISIBLE:C603(*;"motherRUT@";True:C214)
	OBJECT SET VISIBLE:C603(*;"motherIDDos@";False:C215)
	OBJECT SET VISIBLE:C603(*;"motherIDTres@";False:C215)
	OBJECT SET VISIBLE:C603(*;"motherPas@";False:C215)
Else 
	$age:=Int:C8(DT_ReturnAgeInMonths (vdPST_fNacMOTHER)/12)
	Case of 
		: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			OBJECT SET VISIBLE:C603(*;"motherRUT@";True:C214)
			OBJECT SET VISIBLE:C603(*;"motherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherPas@";False:C215)
			
		: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			OBJECT SET VISIBLE:C603(*;"motherRUT@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherIDDos@";True:C214)
			OBJECT SET VISIBLE:C603(*;"motherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherPas@";False:C215)
			
		: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
			OBJECT SET VISIBLE:C603(*;"motherRUT@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherIDTres@";True:C214)
			OBJECT SET VISIBLE:C603(*;"motherPas@";False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*;"motherRUT@";True:C214)
			OBJECT SET VISIBLE:C603(*;"motherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherPas@";False:C215)
	End case 
End if 

  //opciones según pais
Case of 
	: (<>vtXS_CountryCode="cl")
		If ((vsPST_RUTMOTHER="") & (vtPST_MotherNacionalidad#"Chilen@"))
			OBJECT SET VISIBLE:C603(*;"motherRUT@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"motherPas@";True:C214)
		End if 
		If (Num:C11(Substring:C12(vsPST_RUTMOTHER;1;Length:C16(vsPST_RUTMOTHER)-1))>0)
			OBJECT SET FORMAT:C236(vsPST_RUTMOTHER;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236(vsPST_RUTMOTHER;"")
		End if 
		OBJECT SET FILTER:C235(vsPST_RUTMOTHER;"&\"0-9;k;K\"")
		  //: (<>vtXS_CountryCode="co")
		  //$edadAgnos:=Int(DT_ReturnAgeInMonths (vdPST_fNacMOTHER)/12)
		  //Case of 
		  //: (<>ai_IDNacional_LimiteEdad{1}=0)
		  //Case of 
		  //: ((vsPST_RUTMOTHER="") & (vsPST_PasMOTHER="") & (vsPST_IDN2MOTHER="") & (vsPST_IDN3MOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";True)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";False)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";False)
		  //OBJECT SET VISIBLE(*;"motherPas@";False)
		  //: ((vsPST_RUTMOTHER#"") & (vsPST_PasMOTHER="") & (vsPST_IDN2MOTHER="") & (vsPST_IDN3MOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";True)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";False)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";False)
		  //OBJECT SET VISIBLE(*;"motherPas@";False)
		  //: ((vsPST_RUTMOTHER="") & (vsPST_PasMOTHER#"") & (vsPST_IDN2MOTHER="") & (vsPST_IDN3MOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";False)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";False)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";False)
		  //OBJECT SET VISIBLE(*;"motherPas@";True)
		  //: ((vsPST_RUTMOTHER="") & (vsPST_PasMOTHER="") & (vsPST_IDN2MOTHER#"") & (vsPST_IDN3MOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";False)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";True)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";False)
		  //OBJECT SET VISIBLE(*;"motherPas@";False)
		  //: ((vsPST_RUTMOTHER="") & (vsPST_PasMOTHER="") & (vsPST_IDN2MOTHER="") & (vsPST_IDN3MOTHER#""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";False)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";False)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";True)
		  //OBJECT SET VISIBLE(*;"motherPas@";False)
		  //End case 
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | (vsPST_RUTMOTHER#"") & (vsPST_IDN2MOTHER="") & (vsPST_IDN3MOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";True)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";False)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";False)
		  //OBJECT SET VISIBLE(*;"motherPas@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | (vsPST_IDN2MOTHER#"") & (vsPST_RUTMOTHER="") & (vsPST_IDN3MOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";False)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";True)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";False)
		  //OBJECT SET VISIBLE(*;"motherPas@";False)
		  //
		  //: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | (vsPST_IDN3MOTHER#"") & (vsPST_IDN2MOTHER="") & (vsPST_RUTMOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";False)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";False)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";True)
		  //OBJECT SET VISIBLE(*;"motherPas@";False)
		  //
		  //: ((vsPST_RUTMOTHER="") & (vsPST_PasMOTHER#"") & (vsPST_IDN2MOTHER="") & (vsPST_IDN3MOTHER=""))
		  //OBJECT SET VISIBLE(*;"motherRUT@";False)
		  //OBJECT SET VISIBLE(*;"motherIDDos@";False)
		  //OBJECT SET VISIBLE(*;"motherIDTres@";False)
		  //OBJECT SET VISIBLE(*;"motherPas@";True)
		  //End case 
End case 

  //Para Papá....

If (<>ai_IDNacional_LimiteEdad{1}=0)
	OBJECT SET VISIBLE:C603(*;"fatherRUT@";True:C214)
	OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
	OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
	OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
Else 
	$age:=Int:C8(DT_ReturnAgeInMonths (vdPST_fNacFATHER)/12)
	Case of 
		: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			OBJECT SET VISIBLE:C603(*;"fatherRUT@";True:C214)
			OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
			
		: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherIDDos@";True:C214)
			OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
			
		: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
			OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherIDTres@";True:C214)
			OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*;"fatherRUT@";True:C214)
			OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
	End case 
End if 

  //opciones según pais
Case of 
	: (<>vtXS_CountryCode="cl")
		If ((vsPST_RUTfather="") & (vtPST_fatherNacionalidad#"Chilen@"))
			OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
			OBJECT SET VISIBLE:C603(*;"fatherPas@";True:C214)
		End if 
		If (Num:C11(Substring:C12(vsPST_RUTfather;1;Length:C16(vsPST_RUTfather)-1))>0)
			OBJECT SET FORMAT:C236(vsPST_RUTfather;"###.###.###-#")
		Else 
			OBJECT SET FORMAT:C236(vsPST_RUTfather;"")
		End if 
		OBJECT SET FILTER:C235(vsPST_RUTfather;"&\"0-9;k;K\"")
	: (<>vtXS_CountryCode="co")
		$edadAgnos:=Int:C8(DT_ReturnAgeInMonths (vdPST_fNacFATHER)/12)
		Case of 
			: (<>ai_IDNacional_LimiteEdad{1}=0)
				Case of 
					: ((vsPST_RUTfather="") & (vsPST_Pasfather="") & (vsPST_IDN2father="") & (vsPST_IDN3father=""))
						OBJECT SET VISIBLE:C603(*;"fatherRUT@";True:C214)
						OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
					: ((vsPST_RUTfather#"") & (vsPST_Pasfather="") & (vsPST_IDN2father="") & (vsPST_IDN3father=""))
						OBJECT SET VISIBLE:C603(*;"fatherRUT@";True:C214)
						OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
					: ((vsPST_RUTfather="") & (vsPST_Pasfather#"") & (vsPST_IDN2father="") & (vsPST_IDN3father=""))
						OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherPas@";True:C214)
					: ((vsPST_RUTfather="") & (vsPST_Pasfather="") & (vsPST_IDN2father#"") & (vsPST_IDN3father=""))
						OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherIDDos@";True:C214)
						OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
					: ((vsPST_RUTfather="") & (vsPST_Pasfather="") & (vsPST_IDN2father="") & (vsPST_IDN3father#""))
						OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
						OBJECT SET VISIBLE:C603(*;"fatherIDTres@";True:C214)
						OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
				End case 
				
			: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{1}) | (vsPST_RUTfather#"") & (vsPST_IDN2father="") & (vsPST_IDN3father=""))
				OBJECT SET VISIBLE:C603(*;"fatherRUT@";True:C214)
				OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
				
			: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{2}) | (vsPST_IDN2father#"") & (vsPST_RUTfather="") & (vsPST_IDN3father=""))
				OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherIDDos@";True:C214)
				OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
				
			: (($edadAgnos<=<>ai_IDNacional_LimiteEdad{3}) | (vsPST_IDN3father#"") & (vsPST_IDN2father="") & (vsPST_RUTfather=""))
				OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherIDTres@";True:C214)
				OBJECT SET VISIBLE:C603(*;"fatherPas@";False:C215)
				
			: ((vsPST_RUTfather="") & (vsPST_Pasfather#"") & (vsPST_IDN2father="") & (vsPST_IDN3father=""))
				OBJECT SET VISIBLE:C603(*;"fatherRUT@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherIDDos@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherIDTres@";False:C215)
				OBJECT SET VISIBLE:C603(*;"fatherPas@";True:C214)
		End case 
End case 