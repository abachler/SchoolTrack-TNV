//%attributes = {}
  //ACTcfg_SortMatrixItems

$selectedMatrix:=AL_GetLine (xALP_Matrices)
If ($selectedMatrix>0)
	$idMatrix:=alACT_IdMatriz{$selectedMatrix}
Else 
	$idMatrix:=0
	BEEP:C151
End if 
READ WRITE:C146([xxACT_ItemsMatriz:180])
CREATE SELECTION FROM ARRAY:C640([xxACT_ItemsMatriz:180];alACT_RecNumItems)
START TRANSACTION:C239
DELETE SELECTION:C66([xxACT_ItemsMatriz:180])
READ ONLY:C145([xxACT_ItemsMatriz:180])
If (Records in set:C195("LockedSet")>0)
	CD_Dlog (0;__ ("Algunos items están bloqueados. No es posible realizar el cambio de orden en este momento."))
	CANCEL TRANSACTION:C241
Else 
	VALIDATE TRANSACTION:C240
	For ($i;Size of array:C274(alACT_RecNumItems);1;-1)
		CREATE RECORD:C68([xxACT_ItemsMatriz:180])
		[xxACT_ItemsMatriz:180]ID_Item:2:=alACT_IDItemMatriz{$i}
		[xxACT_ItemsMatriz:180]ID_Matriz:1:=$idMatrix
		SAVE RECORD:C53([xxACT_ItemsMatriz:180])
		UNLOAD RECORD:C212([xxACT_ItemsMatriz:180])
	End for 
	AL_UpdateArrays (xALP_ItemsMatriz;0)
	ACTcfg_loadMatrixItems ($idMatrix)
	ACTcfg_UpdateMatrixItemsArea 
	ACTcfg_CalculateMatrixAmounts 
End if 