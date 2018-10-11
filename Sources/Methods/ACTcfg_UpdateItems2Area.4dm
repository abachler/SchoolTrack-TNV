//%attributes = {}
  //ACTcfg_UpdateItems2Area

AL_UpdateArrays (xALP_Items2;-2)
AL_SetSort (xALP_Items2;2)
For ($i;1;Size of array:C274(alACT_IdItem))
	If (abACT_IsDiscountItem{$i})
		AL_SetRowColor (xALP_Items2;$i;"Red";0;"";0)
	Else 
		AL_SetRowColor (xALP_Items2;$i;"Blue";0;"";0)
	End if 
	If (abACT_isPercentItem{$i})
		AL_SetRowStyle (xALP_Items2;$i;2;"Tahoma")
	Else 
		AL_SetRowStyle (xALP_Items2;$i;0;"Tahoma")
	End if 
End for 
AL_UpdateArrays (xALP_Items2;-2)