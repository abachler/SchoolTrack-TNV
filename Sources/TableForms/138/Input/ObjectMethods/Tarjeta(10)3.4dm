Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
If (Self:C308->#"")
	If (KRL_RecordExists (->[ACT_Terceros:138]RC_IdentificadorTD:64))
		CD_Dlog (0;__ ("Este identificador de tarjetahabiente está siendo utilizado por otro apoderado."))
		Self:C308->:=""
	End if 
End if 