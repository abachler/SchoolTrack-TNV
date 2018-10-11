//%attributes = {}
  // ----------------------------------------------------
  // Usuario (SO): Patricio Aliaga
  // Fecha y hora: 05-07-18, 17:13:04
  // ----------------------------------------------------
  // Método: UD_v20180705_UpdateConfPrInfJef
  // Descripción
  // Ticket N° 209201: Se actrualiza variable de preferencia vi_SelectedStyle para guarda el id del estilo de evaluación en vez del indice al que corresponde dentro del array aEvStyleID  
  // Modificacón Fecha y hora: 09-07-18, 14:43:54, Ejecución solo para Chile y se setea preferencua default en el caso de que no exista.
  // Ninguno
  // ----------------------------------------------------


If (<>gCountryCode="cl")
	  // Carga de arryas con información desde las configuraciónes de SchoolTrack
	EVS_LoadStyles 
	  // Carga de arryas con información desde las configuraciónes de SchoolTrack
	
	  // Carga de las preferencias para el informe de jefatura de curso
	C_BLOB:C604($xBlob)
	$xBlob:=PREF_fGetBlob (0;"DispersionNotasEnInformeJefatura";$xBlob)
	If (BLOB size:C605($xBlob)=0)
		CU_DefaultJefaturaRepSettings 
		SET BLOB SIZE:C606($xBlob;0)
		$xBlob:=PREF_fGetBlob (0;"DispersionNotasEnInformeJefatura";$xBlob)
	End if 
	BLOB_Blob2Vars (->$xBlob;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres;->vl_sinprofesor)
	  // Carga de las preferencias para el informe de jefatura de curso
	
	  // Verificacion de la existencia del indice guardado del estilo de evaluación en la preferencia
	If (vi_SelectedStyle>Size of array:C274(aEvStyleID))  // Cuando estilo ya no existe en la BD se dejan los valores por default
		
		  //CU_DefaultJefaturaRepSettings
		
		ARRAY INTEGER:C220(aiCU_DispersionRango;0)
		ARRAY INTEGER:C220(aiCU_DispersionRango;8)
		ARRAY TEXT:C222(atCU_DispersionFrom;0)
		ARRAY TEXT:C222(atCU_DispersionTo;0)
		ARRAY REAL:C219(arCU_DispersionFrom;0)
		ARRAY REAL:C219(arCU_DispersionTo;0)
		ARRAY TEXT:C222(atCU_DispersionFrom;8)
		ARRAY TEXT:C222(atCU_DispersionTo;8)
		ARRAY REAL:C219(arCU_DispersionFrom;8)
		ARRAY REAL:C219(arCU_DispersionTo;8)
		
		READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
		ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
		ORDER BY:C49([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1;>)
		vlEVS_DefaultStyleID:=[xxSTR_EstilosEvaluacion:44]ID:1
		REDUCE SELECTION:C351([xxSTR_EstilosEvaluacion:44];0)
		
		EVS_ReadStyleData (vlEVS_DefaultStyleID)
		For ($i;1;Size of array:C274(aiCU_DispersionRango))
			aiCU_DispersionRango{$i}:=$i
		End for 
		arCU_DispersionFrom{1}:=Round:C94(1/7*100;11)
		arCU_DispersionTo{1}:=Round:C94(3.9/7*100;11)
		arCU_DispersionFrom{2}:=Round:C94(4/7*100;11)
		arCU_DispersionTo{2}:=Round:C94(4.9/7*100;11)
		arCU_DispersionFrom{3}:=Round:C94(5/7*100;11)
		arCU_DispersionTo{3}:=Round:C94(5.9/7*100;11)
		arCU_DispersionFrom{4}:=Round:C94(6/7*100;11)
		arCU_DispersionTo{4}:=Round:C94(7/7*100;11)
		
		For ($i;1;8)
			atCU_DispersionFrom{$i}:=NTA_PercentValue2StringValue (arCU_DispersionFrom{$i};iEvaluationMode)
			atCU_DispersionTo{$i}:=NTA_PercentValue2StringValue (arCU_DispersionTo{$i};iEvaluationMode)
		End for 
		
		iPosAnot:=3
		iNegAnot:=3
		iDet:=3
		iSusp:=1
		bNoPbl:=1
		r0_Todas:=0
		r1_EnPromedioInterno:=1
		r1_EnPromedioOficial:=0
		r3_madres:=0
		rAvgMinAsignaturaPercent:=Round:C94(4/7*100;11)
		rAvgSupPercent:=Round:C94(6/7*100;11)
		rAvgInfPercent:=Round:C94(4/7*100;11)
		rAvgMinPercent:=rPctMinimum
		vl_sinprofesor:=0
		
		  //ARRAY TEXT(aEvStyleType;2)
		  //$el:=Find in array(aEvStyleID;vlEVS_DefaultStyleID)
		  //If ($el>0)
		vi_SelectedStyle:=vlEVS_DefaultStyleID
		  //End if 
		vi_StyleType:=1
		
	Else 
		vi_SelectedStyle:=aEvStyleID{vi_SelectedStyle}
	End if 
	  // Verificacion de la existencia del indice guardado del estilo de evaluación en la preferencia
	
	  // Guardado de la informacion actualizada
	BLOB_Variables2Blob (->$xBlob;0;->vlEVS_DefaultStyleID;->vi_SelectedStyle;->vi_StyleType;->aiCU_DispersionRango;->arCU_DispersionFrom;->arCU_DispersionTo;->iPosAnot;->iNegAnot;->iDet;->iSusp;->bNoPbl;->rAvgMinAsignaturaPercent;->rAvgSupPercent;->rAvgInfPercent;->rAvgMinPercent;->r0_Todas;->r1_EnPromedioInterno;->r2_EnPromedioOficial;->r3_Madres;->vl_sinprofesor)
	PREF_SetBlob (0;"DispersionNotasEnInformeJefatura";$xBlob)
	SET BLOB SIZE:C606($xBlob;0)
	  // Guardado de la informacion actualizada
End if 
