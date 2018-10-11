Self:C308->:=CTRY_CL_VerifRUT (Self:C308->)
If (Self:C308->#"")
	If (KRL_RecordExists (->[Personas:7]ACT_RUTTitular_TC:56))
		Self:C308->:=PP_AsignaRutInfoPagos (->[Personas:7];->[Personas:7]ACT_RUTTitular_TC:56;1)
	End if 
End if 
