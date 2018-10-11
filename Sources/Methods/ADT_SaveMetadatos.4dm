//%attributes = {}
  //ADT_SaveMetadatos

If (Application type:C494=4D Remote mode:K5:5)
	C_LONGINT:C283($P)
	$p:=Execute on server:C373("ADT_SaveMetadatos";Pila_256K;"Guardando metadatos del sistema")
Else 
	C_LONGINT:C283($proceso)
	$proceso:=IT_UThermometer (1;0;"Guardando metadatos del sistema")
	C_TEXT:C284($file)
	_O_C_STRING:C293(15;fileHeader)
	C_LONGINT:C283(nbRecords)
	C_PICTURE:C286($pict;theBundle)
	
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"MetaDatosADT.txt"
	SET CHANNEL:C77(12;$file)
	If (ok=1)
		READ ONLY:C145([xxADT_MetaDataDefinition:79])
		QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]ID:1<0)
		nbRecords:=Records in selection:C76([xxADT_MetaDataDefinition:79])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xxADT_MetaDataDefinition:79])
		While (Not:C34(End selection:C36([xxADT_MetaDataDefinition:79])))
			sName:=[xxADT_MetaDataDefinition:79]Name:2
			SEND VARIABLE:C80(sName)
			SEND RECORD:C78([xxADT_MetaDataDefinition:79])
			NEXT RECORD:C51([xxADT_MetaDataDefinition:79])
		End while 
		
	End if 
	SET CHANNEL:C77(11)
	IT_UThermometer (-2;$proceso)
End if 
