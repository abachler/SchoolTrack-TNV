//%attributes = {}
C_TEXT:C284($t_afeccion)
$t_afeccion:=$1
[Alumnos_EventosEnfermeria:14]Afeccion:6:=$t_afeccion
Case of 
	: (Position:C15("[T]";$t_afeccion)#0)
		[Alumnos_EventosEnfermeria:14]TipoConsulta:5:="Traumatológica"
	: (Position:C15("[M]";$t_afeccion)#0)
		[Alumnos_EventosEnfermeria:14]TipoConsulta:5:="Médica"
	: (Position:C15("[D]";$t_afeccion)#0)
		[Alumnos_EventosEnfermeria:14]TipoConsulta:5:="Dental"
End case 

