//%attributes = {}
  //ACTcfg_RenumberCampos

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
	
	Case of 
		: (Size of array:C274(alACT_FillerPositions)=0)
			For ($p;1;Size of array:C274(alACT_Campo))
				alACT_Campo{$p}:=$p
			End for 
		: (Size of array:C274(alACT_FillerPositions)=1)
			For ($p;1;alACT_FillerPositions{1})
				alACT_Campo{$p}:=$p
			End for 
			If (Size of array:C274(alACT_Campo)>alACT_FillerPositions{1})
				$campo:=1
				For ($p;alACT_FillerPositions{1}+1;Size of array:C274(alACT_Campo))
					alACT_Campo{$p}:=$campo
					$campo:=$campo+1
				End for 
			End if 
		: (Size of array:C274(alACT_FillerPositions)>1)
			For ($p;1;alACT_FillerPositions{1})
				alACT_Campo{$p}:=$p
			End for 
			For ($i;1;Size of array:C274(alACT_FillerPositions)-1)
				$campo:=1
				For ($k;alACT_FillerPositions{$i}+1;alACT_FillerPositions{$i+1})
					alACT_Campo{$k}:=$campo
					$campo:=$campo+1
				End for 
			End for 
	End case 
	_O_ENABLE BUTTON:C192(bDeleteModelo)
Else 
	_O_DISABLE BUTTON:C193(bDeleteModelo)
End if 