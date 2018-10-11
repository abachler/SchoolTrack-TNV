//%attributes = {}
  //MDATA_SaveDictionnary

If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("MDATA_SaveDictionnary";Pila_256K;"Guardando diccionario de metadatos")
Else 
	
	  //DECLARATIONS
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	C_PICTURE:C286($pict)
	C_LONGINT:C283(nbRecords)
	
	  //INITIALIZATION
	
	
	  //MAIN CODE
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"metadataDictionnary.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		ALL RECORDS:C47([xxSTR_MetadatosLocales:141])
		nbRecords:=Records in selection:C76([xxSTR_MetadatosLocales:141])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xxSTR_MetadatosLocales:141])
		While (Not:C34(End selection:C36([xxSTR_MetadatosLocales:141])))
			SEND RECORD:C78([xxSTR_MetadatosLocales:141])
			NEXT RECORD:C51([xxSTR_MetadatosLocales:141])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 