//%attributes = {}
  //ACTcfg_MarkStandardDTModels

AL_GetSort (xAL_Modelos;$sort)
For ($i;1;Size of array:C274(abACT_ModelosEsSt))
	If (abACT_ModelosEsSt{$i})
		AL_SetRowStyle (xAL_Modelos;$i;1;"")
	Else 
		AL_SetRowStyle (xAL_Modelos;$i;0;"")
	End if 
End for 
AL_SetSort (xAL_Modelos;$sort)