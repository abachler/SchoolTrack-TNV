If (Self:C308->#0)
	IT_SetButtonState (((vt_CharFiller#"") & (vl_LargoReg#0));->bInsertLine;->bDeleteLine)
	If (Size of array:C274(alACT_Campo)>0)
		ARRAY LONGINT:C221(alACT_FillerPositions;0)
		$j:=1
		$filler:=Find in array:C230(atACT_Descripcion;"Filler")
		While ($filler#-1)
			INSERT IN ARRAY:C227(alACT_FillerPositions;Size of array:C274(alACT_FillerPositions)+1;1)
			alACT_FillerPositions{$j}:=$filler
			$j:=$j+1
			$filler:=Find in array:C230(atACT_Descripcion;"Filler";$filler+1)
		End while 
		ACTcfg_RecalculaFillerLength 
		For ($i;1;Size of array:C274(alACT_FillerPositions))
			AL_SetRowStyle (xALP_RecepRecaud;alACT_FillerPositions{$i};1;"")
			AL_SetRowColor (xALP_RecepRecaud;alACT_FillerPositions{$i};"";7;"";0)
		End for 
	End if 
End if 
modificado:=True:C214
_O_ENABLE BUTTON:C192(bSave)