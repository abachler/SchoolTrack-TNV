//%attributes = {}
  //ACTcfg_UpdateMatrixItemsArea

  //JVP 167599 20160907
  //AL_UpdateArrays (xALP_ItemsMatriz;-2)
For ($i;1;Size of array:C274(alACT_IdItemMatriz))
	  //JVP 167599 20160907
	AL_UpdateArrays (xALP_ItemsMatriz;-2)
	If (abACT_IsDiscountItemMatriz{$i})
		AL_SetRowColor (xALP_ItemsMatriz;$i;"Red";0;"";0)
	Else 
		AL_SetRowColor (xALP_ItemsMatriz;$i;"Blue";0;"";0)
	End if 
	If (abACT_isPercentItemMatriz{$i})
		AL_SetRowStyle (xALP_ItemsMatriz;$i;2;"Tahoma")
	Else 
		AL_SetRowStyle (xALP_ItemsMatriz;$i;0;"Tahoma")
	End if 
	  //JVP 167599 20160907
	AL_UpdateArrays (xALP_ItemsMatriz;-2)
End for 
  //JVP 167599 20160907
  //AL_UpdateArrays (xALP_ItemsMatriz;-2)
