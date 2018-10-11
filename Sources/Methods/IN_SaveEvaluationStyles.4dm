//%attributes = {}
  //IN_SaveEvaluationStyles


If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("IN_SaveEvaluationStyles";Pila_256K;"Guardando estilos de evaluación")
Else 
	
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	C_LONGINT:C283($styleID)
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"EstilosEvaluacion_"+<>vtXS_CountryCode+".txt"
	
	SET CHANNEL:C77(12;$file)
	If (ok=1)
		QUERY:C277([xxSTR_EstilosEvaluacion:44];[xxSTR_EstilosEvaluacion:44]ID:1<0)
		nbRecords:=Records in selection:C76([xxSTR_EstilosEvaluacion:44])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xxSTR_EstilosEvaluacion:44])
		While (Not:C34(End selection:C36([xxSTR_EstilosEvaluacion:44])))
			$styleID:=[xxSTR_EstilosEvaluacion:44]ID:1
			SEND VARIABLE:C80($styleID)
			SEND RECORD:C78([xxSTR_EstilosEvaluacion:44])
			NEXT RECORD:C51([xxSTR_EstilosEvaluacion:44])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 