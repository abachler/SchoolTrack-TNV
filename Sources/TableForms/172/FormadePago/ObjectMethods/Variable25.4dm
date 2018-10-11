$Duplicados:=ACTdc_buscaDuplicados (5;vtACT_LDocumento)
If ($Duplicados>0)
	Self:C308->:="0"
	CD_Dlog (0;__ ("El número de documento ya se encuentra generado"))
End if 
Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		vbSpell_StopChecking:=True:C214
End case 