ARRAY LONGINT:C221($aSelectedMatrixIDs;0)
ARRAY INTEGER:C220(abrSelectMatrices;0)
$err:=AL_GetSelect (xALP_Matrices;abrSelectMatrices)
ARRAY LONGINT:C221($aSelectedMatrixIDs;Size of array:C274(abrSelectMatrices))
For ($i;1;Size of array:C274(abrSelectMatrices))
	$aSelectedMatrixIDs{$i}:=alACT_IdMatriz{abrSelectMatrices{$i}}
End for 
QUERY WITH ARRAY:C644([ACT_Matrices:177]ID:1;$aSelectedMatrixIDs)
FORM SET OUTPUT:C54([ACT_Matrices:177];"InformeMatrices")
PRINT SELECTION:C60([ACT_Matrices:177])