$Duplicados:=ACTdc_buscaDuplicados (5;vtACT_LDocumento)
If ($Duplicados>0)
	Self:C308->:="0"
	CD_Dlog (0;__ ("El número de documento ya se encuentra generado"))
End if 