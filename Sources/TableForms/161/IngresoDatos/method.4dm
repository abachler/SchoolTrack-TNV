Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY TEXT:C222(at_IDNivel;0)
		ARRAY LONGINT:C221(aiADT_NivNo;0)
		ARRAY BOOLEAN:C223(ab_NivelModificado;0)
		NIV_LoadArrays 
		COPY ARRAY:C226(<>al_NumeroNivelesSchoolNet;aiADT_NivNo)
		COPY ARRAY:C226(<>at_NombreNivelesSchoolNet;at_IDNivel)
		ARRAY BOOLEAN:C223(ab_NivelModificado;Size of array:C274(at_IDNivel))
		vtSNT_ConfigLevelRD:=at_IDNivel{1}
		vlSN3_CurrConfigLevel:=aiADT_NivNo{1}
		aiADT_NivNo:=1
		
		SN3_InitDataReceptionSettings 
		SN3_LoadDataReceptionSettings 
		SN3_LoadDataReceptionSettings (vlSN3_CurrConfigLevel)
		
		vlSN3_CurrentTab:=1
		vb_RFModificado:=False:C215
		FORM GOTO PAGE:C247(1)
		SELECT LIST ITEMS BY POSITION:C381(SN3_TabRecepcionDatos;1)
		OBJECT SET TITLE:C194(bEnviarNivel;__ ("Enviar ahora ")+vtSNT_ConfigLevelRD)
		SET TIMER:C645(30)
	: (Form event:C388=On Close Box:K2:21)
		$page:=FORM Get current page:C276
		Case of 
			: ($page=1)
				SN3_SaveDataReceptionSettings (vlSN3_CurrConfigLevel)
			: ($page=2)
				SN3_SaveDataReceptionSettings 
			: ($page=3)
				
		End case 
		SN3_SendDataReceptionConfigs (3)
		If (vb_RFModificado)
			SN3_SendDataReceptionConfigs (0)
		End if 
		CANCEL:C270
	: (Form event:C388=On Timer:K2:25)
		IT_MODIFIERS 
		Case of 
			: ((Macintosh option down:C545 | Windows Alt down:C563) & (Shift down:C543))
				OBJECT SET TITLE:C194(bEnviarNivel;__ ("Enviar sólo modificadas ahora"))
			: (Macintosh option down:C545 | Windows Alt down:C563)
				OBJECT SET TITLE:C194(bEnviarNivel;__ ("Enviar todas ahora"))
			Else 
				OBJECT SET TITLE:C194(bEnviarNivel;__ ("Enviar ahora ")+vtSNT_ConfigLevelRD)
		End case 
End case 