Case of 
	: (alProEvt=1)
		ACTcfg_TestMatrixButtons 
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
			AL_GetDrgArea (xALP_ItemsMatriz;$destinationArea)
			AL_GetDrgDstTyp (xALP_ItemsMatriz;$destinationType)
			AL_GetDrgSrcRow (xALP_ItemsMatriz;$selectedItemLine)
			AL_GetDrgDstRow (xALP_ItemsMatriz;$DestRow)
			If ($selectedItemLine>0)
				$idItem:=alACT_IDItemMatriz{$selectedItemLine}
			End if 
			If (($idItem>0) | ($idItem=-101))
				Case of 
					: ($destinationArea=xALP_Items2)
						ACTcfg_ManageMatrixModification ($idMatrix;"borrar";$idItem)
						ACTcfg_loadMatrixItems ($idMatrix)
						If (Not:C34(ACTcfg_AllowItems2Matrix ($selectedMatrix)))
							ACTcfg_ManageMatrixModification ($idMatrix;"crear";$idItem;False:C215)
							ACTcfg_loadMatrixItems ($idMatrix)
						End if 
						ACTcfg_UpdateMatrixItemsArea 
						ACTcfg_CalculateMatrixAmounts 
						AL_SetLine (xALP_ItemsMatriz;1)
						ACTcfg_TestMatrixButtons 
					: ($destinationArea=xALP_ItemsMatriz)
						ACTcfg_SortMatrixItems 
						AL_SetLine (xALP_ItemsMatriz;$DestRow)
						ACTcfg_TestMatrixButtons 
				End case 
			End if 
		End if 
End case 