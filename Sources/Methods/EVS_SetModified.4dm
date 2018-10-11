//%attributes = {}
  //EVS_SetModified

If (Find in array:C230(alEVS_ModifiedStyles;[xxSTR_EstilosEvaluacion:44]ID:1)=-1)
	APPEND TO ARRAY:C911(alEVS_ModifiedStyles;[xxSTR_EstilosEvaluacion:44]ID:1)
End if 