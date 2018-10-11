If (Self:C308->=1)
	$vl_ok:=Num:C11(ACTcfg_OpcionesPagares ("ProtestaDocumento"))
	If ($vl_ok=0)
		Self:C308->:=0
	End if 
Else 
	ACTcfg_OpcionesPagares ("DesProtestaDocumento")
End if 
ACTcfg_OpcionesPagares ("SetObjetosPag2")