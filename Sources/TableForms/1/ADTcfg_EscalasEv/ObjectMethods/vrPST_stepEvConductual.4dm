Case of 
	: (Form event:C388=On Losing Focus:K2:8)
		
		If (Self:C308->>0)
			  //aqui deberia testear que no sea mayor al maximo de la escala o algo asi...
		Else 
			CD_Dlog (0;__ ("El intervalo debe ser superior a cero."))
			GOTO OBJECT:C206(*;"vrPST_stepEvConductual")
		End if 
End case 