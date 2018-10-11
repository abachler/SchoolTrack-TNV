//%attributes = {}
  //IN_SaveComunas


If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("IN_SaveComunas";Pila_256K;"Guardando tabla de comunas")
Else 
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	
	$file:=Get 4D folder:C485(Database folder:K5:14)+"Config"+Folder separator:K24:12+<>vtXS_CountryCode+Folder separator:K24:12+"Comunas_"+<>vtXS_CountryCode+".txt"
	SET CHANNEL:C77(12;$file)
	If (ok=1)
		QUERY:C277([xxSTR_Comunas:94];[xxSTR_Comunas:94]AppStandard:9=True:C214)
		nbRecords:=Records in selection:C76([xxSTR_Comunas:94])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xxSTR_Comunas:94])
		While (Not:C34(End selection:C36([xxSTR_Comunas:94])))
			SEND RECORD:C78([xxSTR_Comunas:94])
			NEXT RECORD:C51([xxSTR_Comunas:94])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 