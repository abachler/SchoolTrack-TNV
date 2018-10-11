//%attributes = {}
  //CFG_ADT_MetaDataDefinitions

CFG_OpenConfigPanel (->[xxADT_MetaDataDefinition:79];"Configuration")
READ WRITE:C146([xxADT_MetaDataDefinition:79])
For ($i;1;Size of array:C274(alADT_DefRecNums))
	If (asADT_DefName{$i}="")
		GOTO RECORD:C242([xxADT_MetaDataDefinition:79];alADT_DefRecNums{$i})
		DELETE RECORD:C58([xxADT_MetaDataDefinition:79])
	End if 
End for 
KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
PREF_Set (0;"ADT Permite postulaciones archivos";String:C10(cb_PermitirPostFiles))
PREF_Set (0;"ADT Permite postulaciones web";String:C10(cb_PermitirPostWeb))