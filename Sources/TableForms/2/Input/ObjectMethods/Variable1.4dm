If (USR_checkRights ("M";->[Alumnos:2]))
	If ([Alumnos:2]nivel_numero:29=12)
		$go:=CD_Dlog (0;__ ("Este alumno aún no ha egresado.\r¿Desea realmente registrar un evento post-egreso aún cuando el alumno no haya egresado?");__ ("");__ ("Si");__ ("No"))
	Else 
		$go:=1
	End if 
	If ($go=1)
		AL_UpdateArrays (xALP_EventosPostEgreso;0)
		WDW_OpenFormWindow (->[Alumnos_EventosPostEgreso:135];"Input";-1;Movable form dialog box:K39:8;__ ("Eventos post egreso"))
		FORM SET INPUT:C55([Alumnos_EventosPostEgreso:135];"Input")
		ADD RECORD:C56([Alumnos_EventosPostEgreso:135];*)
		CLOSE WINDOW:C154
		If (ok=1)
			QUERY:C277([Alumnos_EventosPostEgreso:135];[Alumnos_EventosPostEgreso:135]ID_Alumno:1=[Alumnos:2]numero:1)
			SELECTION TO ARRAY:C260([Alumnos_EventosPostEgreso:135]Fecha:2;ad_EventosEgreso_Fecha;[Alumnos_EventosPostEgreso:135]Tipo_Evento:3;at_EventosEgreso_Tipo;[Alumnos_EventosPostEgreso:135]Titulo_o_Cargo:6;at_EventosEgreso_Carrera;[Alumnos_EventosPostEgreso:135];al_EventosEgreso_RecNum)
		End if 
		AL_UpdateArrays (xALP_EventosPostEgreso;-2)
		AL_SetLine (xALP_EventosPostEgreso;0)
		AL_SetSort (xALP_EventosPostEgreso;-1)
	End if 
End if 
