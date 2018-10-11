Case of 
	: (Form event:C388=On Data Change:K2:15)
		If (Find in array:C230(at_idsTextos;"2")=-1)
			CD_Dlog (0;__ ("No es necesario ingresar un código de aprobación para este tipo de archivo."))
		End if 
End case 
