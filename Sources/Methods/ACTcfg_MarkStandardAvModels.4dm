//%attributes = {}
  //ACTcfg_MarkStandardAvModels

AL_GetSort (xAL_ModelosAvisos;$sort)
For ($i;1;Size of array:C274(abACT_ModelosAvEsSt))
	If (abACT_ModelosAvEsSt{$i})
		AL_SetRowStyle (xAL_ModelosAvisos;$i;1;"")
	Else 
		AL_SetRowStyle (xAL_ModelosAvisos;$i;0;"")
	End if 
End for 
AL_SetSort (xAL_ModelosAvisos;$sort)