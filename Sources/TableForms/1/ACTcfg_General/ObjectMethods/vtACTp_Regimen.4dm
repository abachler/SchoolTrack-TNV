If ((Form event:C388=On Losing Focus:K2:8) | (Form event:C388=On Data Change:K2:15))
	If ((Find in array:C230(atACT_RegimenPagares;vtACTp_Regimen)=-1) & (vtACTp_Regimen#""))
		vtACTp_Regimen:=""
		BEEP:C151
	End if 
End if 