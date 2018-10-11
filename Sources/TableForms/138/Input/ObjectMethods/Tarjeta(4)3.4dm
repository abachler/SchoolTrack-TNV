If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		If (Length:C16(Self:C308->)<16)
			$ignore:=CD_Dlog (0;__ ("Al parecer el numero de tarjeta no esta completo."))
		End if 
	End if 
	[ACT_Terceros:138]PAT_NumTC:36:=Self:C308->
End if 
If ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
	ACTpp_CRYPTTC ("OnDataChange";Self:C308;->[ACT_Terceros:138]PAT_NumTC:36;->[ACT_Terceros:138]xPass:58)
End if 