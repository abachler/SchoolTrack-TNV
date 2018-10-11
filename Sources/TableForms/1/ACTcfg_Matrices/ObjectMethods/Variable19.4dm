
Case of 
	: (alProEvt=-1)
		AL_GetSort (Self:C308->;$col)
		AL_SetSort (Self:C308->;$col)
		ACTcfg_OpcionesArraysItemsM ("InicializaArrays")
		ACTcfg_UpdateMatrixItemsArea 
		vl_ItemsEnMatriz:=0
		UNLOAD RECORD:C212([ACT_Matrices:177])
	: (alProEvt=1)
		ARRAY INTEGER:C220(abrSelectMatrices;0)
		$err:=AL_GetSelect (xALP_Matrices;abrSelectMatrices)
		ACTcfg_TestMatrixButtons 
		Case of 
			: (Size of array:C274(abrSelectMatrices)=1)
				vi_lastLine:=abrSelectMatrices{1}
				If (vi_lastLine>0)
					$matrixID:=alACT_IdMatriz{vi_lastLine}
					ACTcfg_loadMatrixItems ($matrixID)
				End if 
				ACTcfg_CalculateMatrixAmounts 
				ACTcfg_UpdateMatrixItemsArea 
			: ((Size of array:C274(abrSelectMatrices)>1) | (Size of array:C274(abrSelectMatrices)=0))
				ACTcfg_OpcionesArraysItemsM ("InicializaArrays")
				ACTcfg_UpdateMatrixItemsArea 
				vl_ItemsEnMatriz:=0
				UNLOAD RECORD:C212([ACT_Matrices:177])
		End case 
		ACTcfg_TestMatrixButtons 
End case 