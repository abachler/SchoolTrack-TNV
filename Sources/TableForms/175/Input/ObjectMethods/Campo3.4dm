If ([ACT_CuentasCorrientes:175]Matriculado:29)
	[ACT_CuentasCorrientes:175]Matriculado_el:54:=Current date:C33(*)
Else 
	[ACT_CuentasCorrientes:175]Matriculado_el:54:=!00-00-00!
End if 
ACTcfg_ItemsMatricula ("SetCalendarioInputCta")