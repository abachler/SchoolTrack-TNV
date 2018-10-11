Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
If (Self:C308->#"")
	If (KRL_RecordExists (->[ACT_CuentasCorrientes:175]PAC_identificador:49))
		CD_Dlog (0;__ ("Este identificados de titular de cuenta corriente está siendo utilizado por otro registro."))
		Self:C308->:=""
	End if 
End if 