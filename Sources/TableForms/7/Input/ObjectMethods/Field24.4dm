If ([Personas:7]Fecha_de_nacimiento:5>Current date:C33)
	BEEP:C151
	CD_Dlog (0;__ ("La fecha de nacimiento no puede ser superior a la fecha actual."))
	[Personas:7]Fecha_de_nacimiento:5:=!00-00-00!
End if 