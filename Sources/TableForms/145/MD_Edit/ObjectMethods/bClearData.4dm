$column:=AL_GetColumn (xALP_MetaDatos)
$row:=AL_GetClickedRow (xALP_MetaDatos)

atMD_TextValues{$row}:=ST_GetWord ($menuText;$result;";")
AL_UpdateArrays (xALP_MetaDatos;-2)
If (atMD_RecNum{$row}>=0)
	KRL_GotoRecord (->[MDATA_RegistrosDatosLocales:145];atMD_RecNum{$row};True:C214)
	[MDATA_RegistrosDatosLocales:145]Llave_Tabla_and_ID:6:=""
	SAVE RECORD:C53([MDATA_RegistrosDatosLocales:145])
	KRL_UnloadReadOnly (->[MDATA_RegistrosDatosLocales:145])
	AL_SetLine (xALP_MetaDatos;$row)
End if 
