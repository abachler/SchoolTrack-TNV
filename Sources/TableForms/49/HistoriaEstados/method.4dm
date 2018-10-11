vs_Name:=<>tUSR_CurrentUser

Case of 
	: (Form event:C388=On Load:K2:1)
		ADT_CargaArreglosCambioEstado 
		IT_SetButtonState (False:C215;->bDelEstado;->bDelSituacionFinal)
End case 
