If (Form event:C388=On Data Change:K2:15)
	If (Self:C308->#"")
		If (Length:C16(Self:C308->)<16)
			$ignore:=CD_Dlog (0;__ ("Al parecer el número de tarjeta no está completo."))
		End if 
	End if 
	[Personas:7]ACT_Numero_TD:104:=Self:C308->
End if 
If ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
	ACTpp_CRYPTTC ("OnDataChange";Self:C308;->[Personas:7]ACT_Numero_TD:104;->[Personas:7]ACT_xPass_TD:109)
End if 