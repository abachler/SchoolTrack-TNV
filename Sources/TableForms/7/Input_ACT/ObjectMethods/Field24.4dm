If ([Personas:7]Fecha_de_nacimiento:5>Current date:C33)
	BEEP:C151
	CD_Dlog (0;__ ("La fecha de nacimiento no puede ser superior a la fecha actual."))
	[Personas:7]Fecha_de_nacimiento:5:=Old:C35([Personas:7]Fecha_de_nacimiento:5)
Else 
	PP_SetIdentificadorPrincipal 
	$age:=Int:C8(DT_ReturnAgeInMonths ([Personas:7]Fecha_de_nacimiento:5)/12)
	Case of 
		: ((<>ai_IDNacional_LimiteEdad{1}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			vIdentPAC:=<>at_IDNacional_Names{1}
			vIdentPAT:=<>at_IDNacional_Names{1}
		: ((<>ai_IDNacional_LimiteEdad{2}>=$age) | (<>ai_IDNacional_LimiteEdad{2}=0))
			vIdentPAC:=<>at_IDNacional_Names{2}
			vIdentPAT:=<>at_IDNacional_Names{2}
		: ((<>ai_IDNacional_LimiteEdad{3}>=$age) | (<>ai_IDNacional_LimiteEdad{3}=0))
			vIdentPAC:=<>at_IDNacional_Names{3}
			vIdentPAT:=<>at_IDNacional_Names{3}
		Else 
			vIdentPAC:=<>at_IDNacional_Names{1}
			vIdentPAT:=<>at_IDNacional_Names{1}
	End case 
	vIdentPAC:=vIdentPAC+":"
	vIdentPAT:=vIdentPAT+":"
	Case of 
		: (<>vtXS_CountryCode="cl")
			OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitutal_Cta:50;"###.###.###-#")
			OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitular_TC:56;"###.###.###-#")
		: (<>vtXS_CountryCode="co")
			OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitutal_Cta:50;"")
			OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitular_TC:56;"")
		Else 
			OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitutal_Cta:50;"")
			OBJECT SET FORMAT:C236([Personas:7]ACT_RUTTitular_TC:56;"")
	End case 
End if 