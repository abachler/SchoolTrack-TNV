//%attributes = {}
  //ACTcfg_CalculateMatrixAmounts

ARRAY LONGINT:C221($alines;1)
$err:=AL_GetSelect (xALP_Matrices;$alines)
If (Size of array:C274($alines)>0)
	$selectedMatrix:=$alines{1}
	$selectedMatrix:=alACT_IdMatriz{$selectedMatrix}
Else 
	$selectedMatrix:=0
	
End if 
  //If ($selectedMatrix>0)
  //$idMatrix:=alACT_IdMatriz{$selectedMatrix}
  //$moneda:=atACT_MonedaMatriz{$selectedMatrix}
  //Else 
  //If (Size of array(alACT_IdMatriz)>0)
  //$idMatrix:=alACT_IdMatriz{1}
  //$moneda:=atACT_MonedaMatriz{1}
  //Else 
  //$idMatrix:=0
  //End if 
  //End if 

ACTcfg_CalculateMatrixAmount ($selectedMatrix)