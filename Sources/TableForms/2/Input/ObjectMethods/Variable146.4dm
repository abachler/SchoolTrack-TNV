  //If (USR_checkRights ("M";->[Alumnos_EventosOrientación])) 20130520 ASM . no permitia abrir las observaciones aun teniendo permisos para visualizar
If (alProEvt=2)
	$line:=AL_GetLine (xALP_PsyEvents)
	GOTO SELECTED RECORD:C245([Alumnos_EventosOrientacion:21];$line)
	If ((<>lUSR_RelatedTableUserID#[Alumnos_EventosOrientacion:21]Autor_Numero:10) & ([Alumnos_EventosOrientacion:21]Publica:9=False:C215) & (<>lUSR_CurrentUserID>0))
		CD_Dlog (0;__ ("La entrevista seleccionada es privada."))
	Else 
		WDW_OpenFormWindow (->[Alumnos_EventosOrientacion:21];"Input";-1;5)
		KRL_ModifyRecord (->[Alumnos_EventosOrientacion:21];"Input")
		CLOSE WINDOW:C154
		QUERY:C277([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]Alumno_Numero:1=[Alumnos:2]numero:1)
		AL_UpdateFields (xALP_PsyEvents;2)
	End if 
End if 
  //End if 
