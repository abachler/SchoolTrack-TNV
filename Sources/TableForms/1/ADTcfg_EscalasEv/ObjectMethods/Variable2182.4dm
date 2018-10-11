If (Self:C308->>=0)
	If (Self:C308-><<>vrPST_MinEvConductual)
		CD_Dlog (0;__ ("El máximo no puede ser inferior al mínimo."))
	End if 
Else 
	CD_Dlog (0;__ ("El máximo debe ser igual o superior a cero."))
End if 