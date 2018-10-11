$row:=AL_GetLine (xALP_MARCInputGeneral)

If (Not:C34(abBBL_EquivPrincipalGeneral{$row}))
	If (alBBL_MarcValueRecNumGeneral{$row}#-1)
		READ WRITE:C146([BBL_ItemMarcFields:205])
		GOTO RECORD:C242([BBL_ItemMarcFields:205];alBBL_MarcValueRecNumGeneral{$row})
		DELETE RECORD:C58([BBL_ItemMarcFields:205])
		KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
	End if 
	AL_UpdateArrays (xALP_MARCInputGeneral;0)
	AT_Delete ($row;1;->atBBL_MARCCodeGeneral;->atBBL_SubFieldCodeGeneral;->atBBL_SubFieldNameGeneral;->atBBL_MARCValueGeneral;->alBBL_MarcValueRecNumGeneral;->abBBL_EquivPrincipalGeneral;->atBBL_FieldSubFieldGeneral)
	AL_UpdateArrays (xALP_MARCInputGeneral;-2)
	AL_SetLine (xALP_MARCInputGeneral;0)
	_O_DISABLE BUTTON:C193(bDelMARCGeneral)
	ARRAY LONGINT:C221($aLong;2;0)
	For ($i;1;Size of array:C274(abBBL_EquivPrincipalGeneral))
		If (abBBL_EquivPrincipalGeneral{$i})
			AL_SetRowStyle (xALP_MARCInputGeneral;$i;Bold:K14:2)
		Else 
			AL_SetRowStyle (xALP_MARCInputGeneral;$i;Plain:K14:1)
		End if 
	End for 
End if 