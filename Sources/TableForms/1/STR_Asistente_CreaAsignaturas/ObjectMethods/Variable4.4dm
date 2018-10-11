C_LONGINT:C283($proc)
$choice:=CD_Dlog (0;__ ("¿Desea realmente reemplazar la malla curricular de ")+vt_Nivel+__ (" por la Malla curricular estándar?");__ ("");__ ("No");__ ("Si, Reemplazar"))
If ($choice=2)
	AL_UpdateArrays (xALP_PlanNivel;0)
	WZD_GetStandardGradePlan (<>al_NumeroNivelesOficiales{<>al_NumeroNivelesOficiales})  //se ejecuta en el servidor
	$proc:=IT_UThermometer (1;0;__ ("Cargando..."))
	DELAY PROCESS:C323(Current process:C322;6)
	While (Test semaphore:C652("WZD_GetStandardGradePlan"))
		DELAY PROCESS:C323(Current process:C322;12)
	End while 
	IT_UThermometer (-2;$proc)
	xBlob:=PREF_fGetBlob (0;"Plan"+String:C10(<>al_NumeroNivelesOficiales{<>al_NumeroNivelesOficiales});xBlob)
	BLOB_Blob2Vars (->xBlob;0;->aOrder;->aSubject;->aSubjectType;->aSex;->aNumber;->aIncide;->aStyle)
	
	AL_UpdateArrays (xALP_PlanNivel;-2)
	
End if 