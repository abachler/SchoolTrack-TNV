$line:=AL_GetLine (xALP_RecepRecaud)
If ($line=0)
	$line:=Find in array:C230(atACT_Descripcion;"filler";vLastRow)-1
	If ($line<0)
		$line:=Size of array:C274(alACT_Campo)
	End if 
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

If ((Size of array:C274(alACT_FillerPositions)<vl_TiposReg) | ((Size of array:C274(alACT_FillerPositions)=vl_TiposReg) & ($line#Size of array:C274(atACT_Descripcion))))
	AL_UpdateArrays (xALP_RecepRecaud;0)
	AT_Insert ($line+1;1;->alACT_Campo;->atACT_Descripcion;->alACT_Largo;->atACT_Tipo;->atACT_Posicion;->atACT_Correspondencia;->alACT_PosIni;->alACT_PosFinal)
	If (atACT_Descripcion{$line}="filler")
		alACT_Campo{$line+1}:=1
	Else 
		alACT_Campo{$line+1}:=alACT_Campo{$line}+1
	End if 
	
	ACTcfg_RenumberCampos 
	AL_UpdateArrays (xALP_RecepRecaud;-2)
	GOTO OBJECT:C206(xALP_RecepRecaud)
	AL_GotoCell (xALP_RecepRecaud;2;$line+1)
	AL_SetCellHigh (xALP_RecepRecaud;1;80)
	
	If ((Macintosh option down:C545) | (Windows Alt down:C563))
		NewFiller:=True:C214
	Else 
		NewFiller:=False:C215
	End if 
	modificado:=True:C214
	_O_ENABLE BUTTON:C192(bSave)
Else 
	BEEP:C151
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