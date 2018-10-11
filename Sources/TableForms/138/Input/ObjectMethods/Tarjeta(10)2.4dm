Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
If (Self:C308->#"")
	If (KRL_RecordExists (->[ACT_Terceros:138]PAC_Identificador:46))
		CD_Dlog (0;__ ("Este identificados de titular de cuenta corriente está siendo utilizado por otro apoderado."))
		Self:C308->:=""
	End if 
End if 