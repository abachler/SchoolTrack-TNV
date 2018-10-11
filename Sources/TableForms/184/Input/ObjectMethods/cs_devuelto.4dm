If (Self:C308->=1)
	$vl_ok:=Num:C11(ACTcfg_OpcionesPagares ("DevuelveDocumento"))
	If ($vl_ok=0)
		Self:C308->:=0
	End if 
Else 
	ACTcfg_OpcionesPagares ("NoDevuelveDocumento")
End if 
ACTcfg_OpcionesPagares ("SetObjetosPag2")