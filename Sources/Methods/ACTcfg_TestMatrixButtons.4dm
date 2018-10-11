//%attributes = {}
  //ACTcfg_TestMatrixButtons

line:=AL_GetLine (xALP_ItemsMatriz)
ARRAY INTEGER:C220(abrSelectMatrices;0)
$err:=AL_GetSelect (xALP_Matrices;abrSelectMatrices)
If (Size of array:C274(abrSelectMatrices)=1)
	$selectedMatrix:=abrSelectMatrices{1}
Else 
	$selectedMatrix:=0
End if 
IT_SetButtonState ((Not:C34((line=0) | (line=1)));->bSubir)
IT_SetButtonState ((Not:C34((line=0) | (line=Size of array:C274(alACT_IDItemMatriz))));->bBajar)
IT_SetButtonState (($selectedMatrix#0);->bDelMatrix)
IT_SetButtonState ((Size of array:C274(abrSelectMatrices)>0);->bPrintMatrices)