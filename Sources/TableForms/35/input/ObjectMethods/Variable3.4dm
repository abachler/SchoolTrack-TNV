If (Records in table:C83([BU_Rutas_Inscripciones:35])>0)
	
	$line:=AL_GetLine (xalp_ListaRec)
	READ ONLY:C145([BU_Rutas_Inscripciones:35])
	QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4=alBU_IdRecorrido{$line};*)
	QUERY:C277([BU_Rutas_Inscripciones:35]; & ;[BU_Rutas_Inscripciones:35]Numero_Alumno:2#0)
	vsRecorrido:=atBU_RecNombre{$line}
	ORDER BY:C49([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Nombre_y_Apellidos:9;>)
	FORM SET OUTPUT:C54([BU_Rutas_Inscripciones:35];"Lista Impresa")
	PRINT SELECTION:C60([BU_Rutas_Inscripciones:35])
Else 
	CD_Dlog (0;__ ("No registro de inscripciones para imprimir, seleccione otro recorrido."))
End if 