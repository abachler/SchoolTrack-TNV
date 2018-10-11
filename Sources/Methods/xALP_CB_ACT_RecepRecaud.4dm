//%attributes = {}
  //xALP_CB_ACT_RecepRecaud

C_BOOLEAN:C305($0)
C_LONGINT:C283($ALArea;$exitMethod;$1;$2;$3)
$ALArea:=$1
$exitMethod:=$2

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	modificado:=True:C214
	_O_ENABLE BUTTON:C192(bSave)
	AL_GetCurrCell (xALP_RecepRecaud;vCol;vRow)
	vLastRow:=vRow
	vLastCol:=vCol
	Case of 
		: (vCol=2)
			If (atACT_Descripcion{vRow}="Filler")
				Case of 
					: (vRow=Size of array:C274(atACT_Descripcion))
						If (atACT_Descripcion{vRow-1}#"filler")
							alACT_Largo{vRow}:=vl_LargoReg-alACT_PosFinal{vRow-1}
						Else 
							alACT_Largo{vRow}:=vl_LargoReg
						End if 
						atACT_Tipo{vRow}:="AN"
						AL_SetRowStyle (xALP_RecepRecaud;vRow;1;"")
						AL_SetRowColor (xALP_RecepRecaud;vRow;"";7;"";0)
						AL_UpdateArrays (xALP_RecepRecaud;-2)
					: (vRow<Size of array:C274(atACT_Descripcion))
						If ((atACT_Descripcion{vRow-1}#"Filler") & (atACT_Descripcion{vRow+1}#"Filler"))
							alACT_Largo{vRow}:=vl_LargoReg-alACT_PosFinal{vRow-1}
							AL_SetRowStyle (xALP_RecepRecaud;vRow;1;"")
							AL_SetRowColor (xALP_RecepRecaud;vRow;"";7;"";0)
							AL_UpdateArrays (xALP_RecepRecaud;-2)
						Else 
							BEEP:C151
							alACT_Campo{vRow}:=TempCol1
							atACT_Descripcion{vRow}:=TempCol2
							alACT_Largo{vRow}:=TempCol3
							atACT_Tipo{vRow}:=TempCol4
							atACT_Posicion{vRow}:=TempCol5
							atACT_Correspondencia{vRow}:=TempCol6
							alACT_PosIni{vRow}:=TempCol7
							alACT_PosFinal{vRow}:=TempCol8
							AL_GotoCell (xALP_RecepRecaud;vCol;vRow)
						End if 
				End case 
			Else 
				If (TempCol2="filler")
					alACT_Largo{vRow}:=0
				End if 
				AL_SetRowStyle (xALP_RecepRecaud;vRow;0;"")
				AL_SetRowColor (xALP_RecepRecaud;vRow;"Black";0;"White";0)
				AL_SetEnterable (xALP_RecepRecaud;4;2;atACT_Tipos)
				AL_UpdateArrays (xALP_RecepRecaud;-2)
			End if 
			ACTcfg_RenumberCampos 
			ACTcfg_RecalcPosRecepRecaud 
		: (vCol=3)
			ACTcfg_RecalcPosRecepRecaud 
			$filler:=Find in array:C230(atACT_Descripcion;"filler";vRow)
			If ($filler#-1)
				$TempFiller:=alACT_Largo{$filler}
				If (atACT_Descripcion{$filler-1}#"filler")
					alACT_Largo{$filler}:=vl_LargoReg-alACT_PosFinal{$filler-1}
				Else 
					alACT_Largo{$filler}:=vl_LargoReg
				End if 
				If (alACT_Largo{$filler}<0)
					BEEP:C151
					alACT_Largo{$filler}:=$TempFiller
					alACT_Campo{vRow}:=TempCol1
					atACT_Descripcion{vRow}:=TempCol2
					alACT_Largo{vRow}:=TempCol3
					atACT_Tipo{vRow}:=TempCol4
					atACT_Posicion{vRow}:=TempCol5
					atACT_Correspondencia{vRow}:=TempCol6
					alACT_PosIni{vRow}:=TempCol7
					alACT_PosFinal{vRow}:=TempCol8
					AL_GotoCell (xALP_RecepRecaud;vCol;vRow)
				End if 
				ACTcfg_RecalcPosRecepRecaud 
			Else 
				If (alACT_PosFinal{Size of array:C274(alACT_PosFinal)}>vl_LargoReg)
					BEEP:C151
					alACT_Largo{$filler}:=$TempFiller
					alACT_Campo{vRow}:=TempCol1
					atACT_Descripcion{vRow}:=TempCol2
					alACT_Largo{vRow}:=TempCol3
					atACT_Tipo{vRow}:=TempCol4
					atACT_Posicion{vRow}:=TempCol5
					atACT_Correspondencia{vRow}:=TempCol6
					alACT_PosIni{vRow}:=TempCol7
					alACT_PosFinal{vRow}:=TempCol8
					alACT_PosIni{vRow}:=TempCol7
					alACT_PosFinal{vRow}:=TempCol8
					AL_GotoCell (xALP_RecepRecaud;vCol;vRow)
					ACTcfg_RecalcPosRecepRecaud 
				End if 
			End if 
	End case 
End if 