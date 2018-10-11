If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		If (Length:C16(Self:C308->)<16)
			$ignore:=CD_Dlog (0;__ ("Al parecer el numero de tarjeta no esta completo."))
		End if 
	End if 
	[ACT_Terceros:138]RC_NumTD:66:=Self:C308->
End if 
If ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
	ACTpp_CRYPTTC ("OnDataChange";Self:C308;->[ACT_Terceros:138]RC_NumTD:66;->[ACT_Terceros:138]RC_xPass:72)
End if 