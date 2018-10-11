If ([ADT_Contactos:95]Fecha_de_Nacimiento:18>Current date:C33)
	BEEP:C151
	CD_Dlog (0;__ ("La fecha de nacimiento no puede ser superior a la fecha actual."))
	[ADT_Contactos:95]Fecha_de_Nacimiento:18:=!00-00-00!
End if 