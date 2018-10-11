If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		If (Length:C16(Self:C308->)<16)
			$ignore:=CD_Dlog (0;__ ("Al parecer el número de tarjeta no está completo."))
		End if 
	End if 
	[ACT_CuentasCorrientes:175]PAT_num_t_c:38:=Self:C308->
End if 
If ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
	ACTpp_CRYPTTC ("OnDataChange";Self:C308;->[ACT_CuentasCorrientes:175]PAT_num_t_c:38;->[ACT_CuentasCorrientes:175]x_Pass:52)
End if 