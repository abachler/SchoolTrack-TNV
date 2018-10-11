$mes:=Num:C11([ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39)
$agno:=Num:C11([ACT_CuentasCorrientes:175]PAT_year_venc:40)
If (($mes<1) | ($mes>12))
	CD_Dlog (0;__ ("El mes de vencimiento debe estar entre 1 y 12."))
	[ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39:=Old:C35([ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39)
Else 
	If (([ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39#"") & ([ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39#""))
		If ($agno<Year of:C25(Current date:C33(*)))
			CD_Dlog (0;__ ("El año de vencimiento no puede ser inferior al año actual."))
			[ACT_CuentasCorrientes:175]PAT_year_venc:40:=Old:C35([ACT_CuentasCorrientes:175]PAT_year_venc:40)
		Else 
			If ($agno=Year of:C25(Current date:C33(*)))
				If ($mes<Month of:C24(Current date:C33(*)))
					CD_Dlog (0;__ ("El mes de vencimiento no puede ser inferior al mes actual."))
					[ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39:=Old:C35([ACT_CuentasCorrientes:175]PAT_mes_vencimiento:39)
				End if 
			End if 
		End if 
	End if 
End if 