
Case of 
	: (FORM Get current page:C276=3)
		FORM PREVIOUS PAGE:C249
		POST KEY:C465(Character code:C91("+");256)
	: (FORM Get current page:C276=2)
		If (<>al_NumeroNivelesOficiales=vl_FirstNivel)
			BLOB_Variables2Blob (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
			PREF_SetBlob (0;"Plan"+String:C10(<>al_NumeroNivelesOficiales{<>al_NumeroNivelesOficiales});xBlob)
			<>al_NumeroNivelesOficiales:=vl_FirstNivel-1
			FORM GOTO PAGE:C247(1)
		Else 
			AL_UpdateArrays (xALP_PlanNivel;0)
			BLOB_Variables2Blob (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
			PREF_SetBlob (0;"Plan"+String:C10(<>al_NumeroNivelesOficiales{<>al_NumeroNivelesOficiales});xBlob)
			<>al_NumeroNivelesOficiales:=<>al_NumeroNivelesOficiales-1
			<>at_NombreNivelesOficiales:=<>at_NombreNivelesOficiales-1
			WZD_GetGradePlan (<>al_NumeroNivelesOficiales{<>al_NumeroNivelesOficiales})
			AL_UpdateArrays (xALP_PlanNivel;-2)
		End if 
		POST KEY:C465(Character code:C91("+");256)
End case 
