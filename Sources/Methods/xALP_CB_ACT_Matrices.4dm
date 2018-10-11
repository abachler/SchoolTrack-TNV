//%attributes = {}
  //xALP_CB_ACT_Matrices

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_Matrices;vCol;vRow)
	If (AL_GetCellMod (xALP_Matrices)=1)
		READ WRITE:C146([ACT_Matrices:177])
		QUERY:C277([ACT_Matrices:177];[ACT_Matrices:177]ID:1=alACT_IDMatriz{vRow})
		If (Records in selection:C76([ACT_Matrices:177])=1)
			$matrixName:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233(atACT_NombreMatriz{vRow};"(";"[");")";"]");"/";"_");"\\";"_")
			$matrixName:=ST_GetCleanString ($matrixName)
			atACT_NombreMatriz{vRow}:=$matrixName
			[ACT_Matrices:177]Nombre_matriz:2:=atACT_NombreMatriz{vRow}
			[ACT_Matrices:177]Moneda:9:=atACT_MonedaMatriz{vRow}
			SAVE RECORD:C53([ACT_Matrices:177])
			ARRAY INTEGER:C220($select;1)
			$select{1}:=vRow
			AL_SetSelect (xALP_Matrices;$select)
			ACTinit_LoadMatrixIntoArrays 
			ACTcfg_loadMatrixItems (alACT_IDMatriz{vRow})
			ACTcfg_CalculateMatrixAmounts 
			ACTcfg_UpdateMatrixItemsArea 
			ACTcfg_TestMatrixButtons 
		Else 
			BEEP:C151
		End if 
	End if 
	  //AL_SetLine (xALP_Matrices;vRow)
	  //vi_lastLine:=vRow
	  //If (vi_lastLine>0)
	  //$matrixID:=alACT_IdMatriz{vi_lastLine}
	  //ACTcfg_loadMatrixItems ($matrixID)
	  //End if 
	  //ACTcfg_CalculateMatrixAmounts 
	  //ACTcfg_UpdateMatrixItemsArea 
	  //ACTcfg_TestMatrixButtons 
End if 