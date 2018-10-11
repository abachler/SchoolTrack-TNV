If (Self:C308->=1)
	If ((Size of array:C274(adSTR_Periodos_InicioCiclos)=0) | (IT_AltKeyIsDown ))
		COPY ARRAY:C226(adSTR_Periodos_Desde;adSTR_Periodos_InicioCiclos)
	End if 
Else 
	ARRAY DATE:C224(adSTR_Periodos_InicioCiclos;0)
End if 
