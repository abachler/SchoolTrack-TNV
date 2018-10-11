Case of 
	: (alProEvt=-5)
		ARRAY INTEGER:C220(abrSelectMatrices;0)
		$err:=AL_GetSelect (xALP_Matrices;abrSelectMatrices)
		If (Size of array:C274(abrSelectMatrices)=1)
			$selectedMatrix:=abrSelectMatrices{1}
		Else 
			$selectedMatrix:=0
		End if 
		If ($selectedMatrix>0)
			$idMatrix:=alACT_IdMatriz{$selectedMatrix}
		Else 
			$idMatrix:=0
			BEEP:C151
		End if 
		
		If ($idMatrix>0)
			AL_GetDrgArea (xALP_Items2;$destinationArea)
			AL_GetDrgDstTyp (xALP_Items2;$destinationType)
			Case of 
				: ($destinationArea=xALP_ItemsMatriz)
					AL_GetDrgSrcRow (xALP_Items2;$sourcerow)
					AL_GetDrgDstCol (xALP_ItemsMatriz;$col)
					AL_GetDrgDstRow (xALP_ItemsMatriz;$row)
					$idItem:=alACT_IDItem{$sourcerow}
					If (Find in array:C230(alACT_IdItemMatriz;$idItem)>0)
						BEEP:C151
					Else 
						ACTcfg_ManageMatrixModification ($idMatrix;"crear")
						ACTcfg_loadMatrixItems ($idMatrix)
						If (Not:C34(ACTcfg_AllowItems2Matrix ($selectedMatrix)))
							ACTcfg_ManageMatrixModification ($idMatrix;"borrar";$idItem;False:C215)
							ACTcfg_loadMatrixItems ($idMatrix)
						End if 
						ACTcfg_UpdateMatrixItemsArea 
						ACTcfg_CalculateMatrixAmounts 
						AL_SetLine (xALP_ItemsMatriz;Size of array:C274(alACT_ItemRecNum))
						ACTcfg_TestMatrixButtons 
					End if 
			End case 
		End if 
End case 