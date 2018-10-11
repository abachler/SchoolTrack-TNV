If ((USR_checkRights ("M";->[Alumnos_EventosPersonales:16])) | (<>lUSR_RelatedTableUserID=[Alumnos:2]Tutor_numero:36) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
	WDW_OpenFormWindow (->[Alumnos_EventosPersonales:16];"Input";-1;5)
	FORM SET INPUT:C55([Alumnos_EventosPersonales:16];"Input")
	ADD RECORD:C56([Alumnos_EventosPersonales:16];*)
	CLOSE WINDOW:C154
	If (ok=1)
		AL_CargaEventosPersonales 
	End if 
Else 
	CD_Dlog (0;__ ("Usted no dispone de los privilegios necesarios para agregar información en esta sección."))
End if 