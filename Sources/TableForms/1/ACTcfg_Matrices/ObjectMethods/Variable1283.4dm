$r:=CD_Dlog (0;__ ("Ingrese el nombre de la nueva matriz:");"";__ ("Aceptar");__ ("Cancelar");"";"";"")
$matrixName:=Substring:C12(vt_UserEntry;1;30)
$matrixName:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233($matrixName;"(";"[");")";"]");"/";"_");"\\";"_")
$matrixName:=ST_GetCleanString ($matrixName)
If (($matrixName#"") & ($r=1))
	If (Find in array:C230(atACT_NombreMatriz;$matrixName)>0)
		BEEP:C151
	Else 
		CREATE RECORD:C68([ACT_Matrices:177])
		[ACT_Matrices:177]ID:1:=SQ_SeqNumber (->[ACT_Matrices:177]ID:1)
		$newMatrixID:=[ACT_Matrices:177]ID:1
		[ACT_Matrices:177]Nombre_matriz:2:=$matrixName
		[ACT_Matrices:177]Moneda:9:=<>vsACT_MonedaColegio
		SAVE RECORD:C53([ACT_Matrices:177])
		LOG_RegisterEvt ("Creación de matriz "+[ACT_Matrices:177]Nombre_matriz:2+".")
		AL_UpdateArrays (xALP_Matrices;0)
		AT_Insert (1;1;->alACT_IdMatriz;->atACT_NombreMatriz;->atACT_MonedaMatriz)
		alACT_IdMatriz{1}:=[ACT_Matrices:177]ID:1
		atACT_NombreMatriz{1}:=[ACT_Matrices:177]Nombre_matriz:2
		atACT_MonedaMatriz{1}:=[ACT_Matrices:177]Moneda:9
		AL_UpdateArrays (xALP_Matrices;-2)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Item_Global:13=True:C214)
		While (Not:C34(End selection:C36([xxACT_Items:179])))
			CREATE RECORD:C68([xxACT_ItemsMatriz:180])
			[xxACT_ItemsMatriz:180]ID_Item:2:=[xxACT_Items:179]ID:1
			[xxACT_ItemsMatriz:180]ID_Matriz:1:=[ACT_Matrices:177]ID:1
			SAVE RECORD:C53([xxACT_ItemsMatriz:180])
			NEXT RECORD:C51([xxACT_Items:179])
		End while 
		AL_UpdateArrays (xALP_ItemsMatriz;0)
		ACTinit_LoadMatrixIntoArrays 
		ACTcfg_loadMatrixItems ($newMatrixID)
		ACTcfg_UpdateMatrixItemsArea 
		ACTcfg_CalculateMatrixAmounts 
		$nueva:=Find in array:C230(alACT_IdMatriz;$newMatrixID)
		ARRAY INTEGER:C220(abrSelectMatrices;1)
		abrSelectMatrices{1}:=$nueva
		AL_SetSelect (xALP_Matrices;abrSelectMatrices)
		ACTcfg_TestMatrixButtons 
	End if 
End if 