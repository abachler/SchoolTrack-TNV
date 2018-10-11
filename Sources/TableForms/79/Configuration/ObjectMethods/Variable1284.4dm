AL_GetCurrCell (xALP_MetaDef;$col;$row)
If ($row#0)
	AL_ExitCell (xALP_MetaDef)
	AL_SetLine (xALP_MetaDef;$row)
Else 
	$row:=AL_GetLine (xALP_MetaDef)
End if 
If ($row#0)
	READ WRITE:C146([xxADT_MetaDataDefinition:79])
	GOTO RECORD:C242([xxADT_MetaDataDefinition:79];alADT_DefRecNums{$row})
	SET QUERY DESTINATION:C396(Into variable:K19:4;$recs)
	QUERY:C277([xxADT_MetaDataValues:80];[xxADT_MetaDataValues:80]ID_Definition:1=[xxADT_MetaDataDefinition:79]ID:1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	If ($recs=0)
		DELETE RECORD:C58([xxADT_MetaDataDefinition:79])
		ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
		READ WRITE:C146([xxADT_MetaDataDefinition:79])
		For ($i;1;Size of array:C274(alADT_DefRecNums))
			GOTO RECORD:C242([xxADT_MetaDataDefinition:79];alADT_DefRecNums{$i})
			[xxADT_MetaDataDefinition:79]Posicion:8:=$i
			SAVE RECORD:C53([xxADT_MetaDataDefinition:79])
		End for 
		KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
		ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
	Else 
		$r:=CD_Dlog (0;__ ("Existen datos almacenados para este campo. Si elimina el campo esos datos también serán eliminados.\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
		If ($r=2)
			READ WRITE:C146([xxADT_MetaDataValues:80])
			QUERY:C277([xxADT_MetaDataValues:80];[xxADT_MetaDataValues:80]ID_Definition:1=[xxADT_MetaDataDefinition:79]ID:1)
			DELETE SELECTION:C66([xxADT_MetaDataValues:80])
			DELETE RECORD:C58([xxADT_MetaDataDefinition:79])
			ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
			READ WRITE:C146([xxADT_MetaDataDefinition:79])
			For ($i;1;Size of array:C274(alADT_DefRecNums))
				GOTO RECORD:C242([xxADT_MetaDataDefinition:79];alADT_DefRecNums{$i})
				[xxADT_MetaDataDefinition:79]Posicion:8:=$i
				SAVE RECORD:C53([xxADT_MetaDataDefinition:79])
			End for 
			KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
			ADTcfg_LoadMetaDataDef (Selected list items:C379(vl_TabMetaDatos))
		End if 
	End if 
	KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
	KRL_UnloadReadOnly (->[xxADT_MetaDataValues:80])
End if 