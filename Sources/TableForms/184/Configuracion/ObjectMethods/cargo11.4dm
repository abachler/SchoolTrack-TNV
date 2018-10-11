If ((ALProEvt=1) | (ALProEvt=0))
	$vl_line:=AL_GetLine (ALP_PCargos)
	$vl_column:=AL_GetColumn (ALP_PCargos)
	
	Case of 
		: ($vl_column=4)
			AL_UpdateArrays (ALP_PCargos;0)
			If (abACTp_AvisoSeparado{$vl_line})
				abACTp_AvisoSeparado{$vl_line}:=False:C215
			Else 
				abACTp_AvisoSeparado{$vl_line}:=True:C214
			End if 
			ACTat_LLenaArregloPict (->abACTp_AvisoSeparado;->apACTp_AvisoSeparado)
			AL_UpdateArrays (ALP_PCargos;-2)
	End case 
End if 