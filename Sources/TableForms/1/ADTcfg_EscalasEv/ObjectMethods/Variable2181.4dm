If (Self:C308->>=0)
	If (Self:C308->><>vrPST_MaxEvConductual)
		CD_Dlog (0;__ ("El mínimo no puede ser superior al máximo."))
	End if 
Else 
	CD_Dlog (0;__ ("El mínimo debe ser igual o superior a cero."))
End if 