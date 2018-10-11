If (Form event:C388=On Double Clicked:K2:5)
	If (atXS_AssistantsItems>0)
		ACCEPT:C269
	End if 
End if 
IT_SetButtonState ((atXS_AssistantsItems>0);->bIniciar)