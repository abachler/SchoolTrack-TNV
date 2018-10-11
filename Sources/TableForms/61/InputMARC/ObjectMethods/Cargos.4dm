$row:=AL_GetLine (xALP_MARCInput)

If (Not:C34(abBBL_EquivPrincipal{$row}))
	If (alBBL_MarcValueRecNum{$row}#-1)
		READ WRITE:C146([BBL_ItemMarcFields:205])
		GOTO RECORD:C242([BBL_ItemMarcFields:205];alBBL_MarcValueRecNum{$row})
		DELETE RECORD:C58([BBL_ItemMarcFields:205])
		KRL_UnloadReadOnly (->[BBL_ItemMarcFields:205])
	End if 
	AL_UpdateArrays (xALP_MARCInput;0)
	AT_Delete ($row;1;->atBBL_MARCCode;->atBBL_SubFieldCode;->atBBL_SubFieldName;->atBBL_MARCValue;->alBBL_MarcValueRecNum;->abBBL_EquivPrincipal)
	AL_UpdateArrays (xALP_MARCInput;-2)
	AL_SetLine (xALP_MARCInput;0)
	_O_DISABLE BUTTON:C193(bDelMARC)
	ARRAY LONGINT:C221($aLong;2;0)
	For ($i;1;Size of array:C274(abBBL_EquivPrincipal))
		If (abBBL_EquivPrincipal{$i})
			AL_SetRowStyle (xALP_MARCInput;$i;Bold:K14:2)
		Else 
			AL_SetRowStyle (xALP_MARCInput;$i;Plain:K14:1)
		End if 
	End for 
End if 