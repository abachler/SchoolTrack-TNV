$line:=AL_GetLine (xALP_RecepRecaud)
$eliminar:=False:C215
If ($line=0)
	$line:=vLastRow
End if 
If ($line>0)
	Case of 
		: ((atACT_Descripcion{$line}="filler") & ($line=1))
			$eliminar:=True:C214
		: ((atACT_Descripcion{$line}="filler") & ($line=Size of array:C274(atACT_Descripcion)))
			$eliminar:=True:C214
		: (atACT_Descripcion{$line}#"filler")
			$eliminar:=True:C214
		Else 
			$eliminar:=False:C215
	End case 
End if 
If ($Eliminar)
	AL_UpdateArrays (xALP_RecepRecaud;0)
	AT_Delete ($line;1;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal)
	ACTcfg_RenumberCampos 
	ACTcfg_RecalcPosRecepRecaud 
	$filler:=Find in array:C230(atACT_Descripcion;"filler";$line)
	If ($filler#-1)
		$TempFiller:=alACT_Largo{$filler}
		If ((atACT_Descripcion{$filler-1}="filler") & ($line#1))
			alACT_Largo{$filler}:=vl_LargoReg
		Else 
			alACT_Largo{$filler}:=vl_LargoReg-alACT_PosFinal{$filler-1}
		End if 
		If (alACT_Largo{$filler}>0)
			ACTcfg_RecalcPosRecepRecaud 
		Else 
			BEEP:C151
			alACT_Largo{$filler}:=$TempFiller
			alACT_Campo{vRow}:=TempCol1
			atACT_Descripcion{vRow}:=TempCol2
			alACT_Largo{vRow}:=TempCol3
			atACT_Tipo{vRow}:=TempCol4
			atACT_Posicion{vRow}:=TempCol5
			atACT_Correspondencia{vRow}:=TempCol6
			ACTcfg_RecalcPosRecepRecaud 
		End if 
	End if 
	modificado:=True:C214
	_O_ENABLE BUTTON:C192(bSave)
End if 
ARRAY LONGINT:C221(alACT_FillerPositions;0)
$j:=1
$filler:=Find in array:C230(atACT_Descripcion;"Filler")
While ($filler#-1)
	INSERT IN ARRAY:C227(alACT_FillerPositions;Size of array:C274(alACT_FillerPositions)+1;1)
	alACT_FillerPositions{$j}:=$filler
	$j:=$j+1
	$filler:=Find in array:C230(atACT_Descripcion;"Filler";$filler+1)
End while 
For ($i;1;Size of array:C274(alACT_FillerPositions))
	AL_SetRowStyle (xALP_RecepRecaud;alACT_FillerPositions{$i};1;"")
	AL_SetRowColor (xALP_RecepRecaud;alACT_FillerPositions{$i};"";7;"";0)
End for 
AL_UpdateArrays (xALP_RecepRecaud;-2)
AL_SetLine (xALP_RecepRecaud;0)
