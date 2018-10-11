Case of 
	: (Form event:C388=On Data Change:K2:15)
		If ([Alumnos_EventosEnfermeria:14]Hora_de_Salida:8<[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3)
			CD_Dlog (0;__ ("La hora de salida no puede ser inferior a la hora de ingreso."))
			[Alumnos_EventosEnfermeria:14]Hora_de_Salida:8:=?00:00:00?
			HIGHLIGHT TEXT:C210([Alumnos_EventosEnfermeria:14]Hora_de_Salida:8;1;80)
		End if 
End case 
