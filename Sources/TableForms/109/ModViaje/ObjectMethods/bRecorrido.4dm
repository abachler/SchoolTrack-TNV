$text:=AT_array2text (->atRecorrido)
$choice:=Pop up menu:C542($text)

If ($choice>0)
	ARRAY LONGINT:C221($al_Inscripciones;0)
	READ ONLY:C145([BU_Rutas_Inscripciones:35])
	QUERY:C277([BU_Rutas_Inscripciones:35];[BU_Rutas_Inscripciones:35]Numero_Recorrido:4;=;alIDRecorrido{$choice})
	SELECTION TO ARRAY:C260([BU_Rutas_Inscripciones:35]Numero_Inscripcion:1;$al_Inscripciones)
	If (Size of array:C274($al_Inscripciones)>0)
		AL_UpdateArrays (xALP_Viajes;0)
		vtNombreRec:=atRecorrido{$choice}
		READ ONLY:C145([BU_Viajes:109])
		QUERY:C277([BU_Viajes:109];[BU_Viajes:109]Numero_Recorrido:4;=;alIDRecorrido{$choice})
		SELECTION TO ARRAY:C260([BU_Viajes:109]Fecha:2;adBU_Fecha;[BU_Viajes:109]ID:1;alBU_NumeroViaje)
		AL_UpdateArrays (xALP_Viajes;-2)
		AL_SetLine (xALP_Viajes;0)
	Else 
		ok:=CD_Dlog (1;__ ("No existen Inscripciones para el Recorrido Seleccionado.\rDeben ser creados desde la Ficha de la Ruta.");__ ("");__ ("OK"))
		vtNombreRec:=""
		AL_UpdateArrays (xALP_Viajes;0)
	End if 
	IT_SetButtonState (False:C215;->bDelViajes)
	ARRAY LONGINT:C221($al_Inscripciones;0)
End if 