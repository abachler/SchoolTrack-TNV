If (Form event:C388=On Load:K2:1)
	XS_SetInterface 
	LIST TO ARRAY:C288("STR_InformesNotas_Modelos";popInformes)
	popInformes:=2
	atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;viSTR_PeriodoActual_Numero)
End if 
