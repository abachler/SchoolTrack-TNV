//%attributes = {}
  //ADT_LoadMetadatos
ARRAY TEXT:C222($at_nombreMD;0)
C_LONGINT:C283($el)
C_BOOLEAN:C305($LicenceADT)
$LicenceADT:=LICENCIA_esModuloAutorizado (2;4)
If ($LicenceADT)
	$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cargando Metadatos..."))
	$file:=SYS_CarpetaAplicacion (CLG_Estructura)+"Config"+Folder separator:K24:12+"MetaDatosADT.txt"
	  // se eliminan registros existentes
	READ WRITE:C146([xxADT_MetaDataDefinition:79])
	QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]ID:1<0)
	If (Records in selection:C76([xxADT_MetaDataDefinition:79])>0)
		SELECTION TO ARRAY:C260([xxADT_MetaDataDefinition:79]Name:2;$at_nombreMD)
	End if 
	  // se lee archivo
	SET CHANNEL:C77(10;$file)
	RECEIVE VARIABLE:C81(nbRecords)
	For ($k;1;nbRecords)
		$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$k/nbRecords)
		RECEIVE VARIABLE:C81(sName)
		If (sName#"")
			RECEIVE RECORD:C79([xxADT_MetaDataDefinition:79])
			$el:=Find in array:C230($at_nombreMD;[xxADT_MetaDataDefinition:79]Name:2)
			If ($el=-1)
				SAVE RECORD:C53([xxADT_MetaDataDefinition:79])
			End if 
		End if 
	End for 
	$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
	SET CHANNEL:C77(11)
	KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
End if 