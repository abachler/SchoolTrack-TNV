If (Form event:C388#On After Keystroke:K2:26)
	If (Self:C308-><0)
		CD_Dlog (0;__ ("No puede ingresar un valor inferior a 0."))
		Self:C308->:=0
	Else 
		If (Form event:C388=On Data Change:K2:15)
			ACTcfgmyt_OpcionesGenerales ("CalculaMontoPagadoMNacional")
			vbACTpgs_Ajustar:=False:C215
			vrACTpgs_MontoAjuste:=0
			ACTcfgmyt_OpcionesGenerales ("AplicaColorAjuste")
		End if 
	End if 
End if 