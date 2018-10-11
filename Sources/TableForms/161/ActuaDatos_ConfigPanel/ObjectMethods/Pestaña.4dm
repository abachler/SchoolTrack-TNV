GET LIST ITEM:C378(Self:C308->;Selected list items:C379(Self:C308->);$ref;$text)
If (vlSN3_CurrentTab#$ref)
	Case of 
		: (vlSN3_CurrentTab=1)
			SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
		: (vlSN3_CurrentTab=2)
			SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
		: (vlSN3_CurrentTab=3)
			SN3_SaveDataReceptionSettings 
		: (vlSN3_CurrentTab=4)
	End case 
	$mostrar:=True:C214
	Case of 
		: ($ref=1)
			FORM GOTO PAGE:C247(1)
			SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
		: ($ref=2)
			FORM GOTO PAGE:C247(2)
			SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
		: ($ref=3)
			$mostrar:=False:C215
			FORM GOTO PAGE:C247(3)
		: ($ref=4)
			$mostrar:=False:C215
			FORM GOTO PAGE:C247(4)
	End case 
	
	OBJECT SET SCROLL POSITION:C906(lb_CamposAlumno;1;*)
	OBJECT SET SCROLL POSITION:C906(lb_CamposRelaciones;1;*)
	OBJECT SET ENTERABLE:C238(SN3_PublicaRF;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_PublicaAlumno;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_EditaAlumno;(SN3_ActuaDatosPublica=1))
	OBJECT SET ENTERABLE:C238(SN3_EditaRF;(SN3_ActuaDatosPublica=1))
	
	vlSN3_CurrentTab:=$ref
End if 