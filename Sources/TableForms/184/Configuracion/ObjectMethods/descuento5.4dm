If ((ALProEvt=1) | (ALProEvt=0))
	$vl_line:=AL_GetLine (ALP_Descuentos)
	$vl_column:=AL_GetColumn (ALP_Descuentos)
	
	Case of 
		: ($vl_column=4)
			AL_UpdateArrays (ALP_Descuentos;0)
			If (abACTp_DctoNoAcum{$vl_line})
				abACTp_DctoNoAcum{$vl_line}:=False:C215
			Else 
				abACTp_DctoNoAcum{$vl_line}:=True:C214
			End if 
			ACTat_LLenaArregloPict (->abACTp_DctoNoAcum;->apACTp_DctoNoAcum)
			AL_UpdateArrays (ALP_Descuentos;-2)
	End case 
End if 