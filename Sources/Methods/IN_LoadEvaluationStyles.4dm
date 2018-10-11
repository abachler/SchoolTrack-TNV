//%attributes = {}
  //IN_LoadEvaluationStyles

If (Application type:C494=4D Remote mode:K5:5)
	$pId:=Execute on server:C373(Current method name:C684;Pila_256K;Current method name:C684)
Else 
	$semaphore:=Semaphore:C143("CargandoEstilosEvaluacion")
	C_LONGINT:C283($styleNumber)
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"EstilosEvaluacion_"+<>vtXS_CountryCode+".txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		EVS_LoadStyles 
		$Process:=IT_UThermometer (1;0;__ ("Cargando estilos de evaluación por defecto…"))
		RECEIVE VARIABLE:C81(nbRecords)
		
		For ($k;1;nbrecords)
			RECEIVE VARIABLE:C81($styleNumber)
			QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1=$styleNumber)
			If (Records in selection:C76([xxSTR_EstilosEvaluacion:44])=1)
				vlEVS_CurrentEvStyleID:=0
				EVS_ReadStyleData 
				$vi_gTrEXNF:=vi_gTrEXNF
				$vi_RoundCPpresent:=vi_RoundCPpresent
				$vi_gTrPAvg:=vi_gTrPAvg
				$vi_gTrFAvg:=vi_gTrFAvg
				$vi_gTroncarNotaFinal:=vi_gTroncarNotaFinal
				READ WRITE:C146([xxSTR_EstilosEvaluacion:44])
				LOAD RECORD:C52([xxSTR_EstilosEvaluacion:44])
				DELETE RECORD:C58([xxSTR_EstilosEvaluacion:44])
				RECEIVE RECORD:C79([xxSTR_EstilosEvaluacion:44])
				[xxSTR_EstilosEvaluacion:44]Auto_UUID:23:=Generate UUID:C1066  //20140123 RCH
				SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
				vlEVS_CurrentEvStyleID:=0
				EVS_ReadStyleData 
				vi_gTrEXNF:=$vi_gTrEXNF
				vi_RoundCPpresent:=$vi_RoundCPpresent
				vi_gTrPAvg:=$vi_gTrPAvg
				vi_gTrFAvg:=$vi_gTrFAvg
				vi_gTroncarNotaFinal:=$vi_gTroncarNotaFinal
				EVS_WriteStyleData 
				SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
			Else 
				RECEIVE RECORD:C79([xxSTR_EstilosEvaluacion:44])
				[xxSTR_EstilosEvaluacion:44]Auto_UUID:23:=Generate UUID:C1066  //20140123 RCH
				SAVE RECORD:C53([xxSTR_EstilosEvaluacion:44])
			End if 
		End for 
		SET CHANNEL:C77(11)
		UNLOAD RECORD:C212([xxSTR_EstilosEvaluacion:44])
		READ ONLY:C145([xxSTR_EstilosEvaluacion:44])
		IT_UThermometer (-2;$Process)
	Else 
		$r:=CD_Dlog (1;__ ("El archivo que contiene los niveles no pudo ser cargado."))
	End if 
	
	
	CLEAR SEMAPHORE:C144("CargandoEstilosEvaluacion")
End if 
