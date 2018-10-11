If (USR_checkRights ("M";->[Alumnos:2]))
	If (alProEvt=2)
		$line:=AL_GetLine (xALP_EventosPostEgreso)
		GOTO RECORD:C242([Alumnos_EventosPostEgreso:135];al_EventosEgreso_RecNum{$line})
		WDW_OpenFormWindow (->[Alumnos_EventosPostEgreso:135];"Input";-1;Movable form dialog box:K39:8;__ ("Eventos post egreso"))
		KRL_ModifyRecord (->[Alumnos_EventosPostEgreso:135];"Input")
		CLOSE WINDOW:C154
		QUERY:C277([Alumnos_EventosPostEgreso:135];[Alumnos_EventosPostEgreso:135]ID_Alumno:1=[Alumnos:2]numero:1)
		SELECTION TO ARRAY:C260([Alumnos_EventosPostEgreso:135]Fecha:2;ad_EventosEgreso_Fecha;[Alumnos_EventosPostEgreso:135]Tipo_Evento:3;at_EventosEgreso_Tipo;[Alumnos_EventosPostEgreso:135]Titulo_o_Cargo:6;at_EventosEgreso_Carrera;[Alumnos_EventosPostEgreso:135];al_EventosEgreso_RecNum)
		AL_UpdateArrays (xALP_EventosPostEgreso;-2)
		AL_SetSort (xALP_EventosPostEgreso;-1)
	End if 
End if 



