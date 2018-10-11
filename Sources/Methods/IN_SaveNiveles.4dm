//%attributes = {}
  //IN_SaveNiveles

If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("IN_SaveNiveles";Pila_256K;"Guardando definición de niveles")
Else 
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Niveles_"+<>vtXS_CountryCode+".txt"
	SET CHANNEL:C77(12;$file)
	If (ok=1)
		ALL RECORDS:C47([xxSTR_Niveles:6])
		nbRecords:=Records in selection:C76([xxSTR_Niveles:6])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xxSTR_Niveles:6])
		While (Not:C34(End selection:C36([xxSTR_Niveles:6])))
			Case of 
				: (<>vtXS_CountryCode#"cl")
					SET BLOB SIZE:C606([xxSTR_Niveles:6]Actas_y_Certificados:43;0)
					[xxSTR_Niveles:6]CHILE_CodigoDecretoEvaluacion:38:=0
					[xxSTR_Niveles:6]CHILE_CodigoDecretoPlanEstudio:39:=0
					[xxSTR_Niveles:6]CHILE_CodigoEnseñanza:41:=0
					[xxSTR_Niveles:6]CHILE_CodigoPlanEstudio:40:=0
			End case 
			SEND RECORD:C78([xxSTR_Niveles:6])
			NEXT RECORD:C51([xxSTR_Niveles:6])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 

