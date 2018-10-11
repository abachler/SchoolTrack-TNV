Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
If (Self:C308->#"")
	If (KRL_RecordExists (->[ACT_CuentasCorrientes:175]PAT_identificador:36))
		$resp:=CD_Dlog (0;__ ("Este identificador de tarjetahabiente está siendo utilizado por otro registro.")+"\r\r"+__ ("¿Desea mantener el número?");"";"Si";"No")
		If ($resp=2)
			Self:C308->:=""
		End if 
	End if 
End if 