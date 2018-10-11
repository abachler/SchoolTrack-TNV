//%attributes = {}
  //Metodo: Método: BBLin_SaveMARCcodes
  //Por abachler
  //Creada el 08/10/2007, 09:38:57
  // ----------------------------------------------------
  // Descripción
  // 
  //
  // ----------------------------------------------------
  // Parámetros
  // 
  // ----------------------------------------------------

  //DECLARACIONES & INICIALIZACIONES
C_TEXT:C284($file)
_O_C_STRING:C293(15;fileHeader)
C_LONGINT:C283(nbRecords)
C_PICTURE:C286($pict)
C_LONGINT:C283(nbRecords)

  //CUERPO
If (Application type:C494=4D Remote mode:K5:5)
	$p:=Execute on server:C373("BBLin_SaveMARCcodes";Pila_256K;"Guardando lista de códigos MARC")
Else 
	
	
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"MARC_Codes.txt"
	SET CHANNEL:C77(10;$file)
	If (ok=1)
		ALL RECORDS:C47([xxBBL_MarcRecordStructure:75])
		nbRecords:=Records in selection:C76([xxBBL_MarcRecordStructure:75])
		SEND VARIABLE:C80(nbRecords)
		FIRST RECORD:C50([xxBBL_MarcRecordStructure:75])
		While (Not:C34(End selection:C36([xxBBL_MarcRecordStructure:75])))
			SEND RECORD:C78([xxBBL_MarcRecordStructure:75])
			NEXT RECORD:C51([xxBBL_MarcRecordStructure:75])
		End while 
		SET CHANNEL:C77(11)
	End if 
End if 


  //LIMPIEZA