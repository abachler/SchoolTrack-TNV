If (USR_checkRights ("M";->[Alumnos_EventosPersonales:16]))
	If (alProEvt=2)
		$line:=AL_GetLine (xALP_Interview)
		AL_GetCellStyle (xALP_Interview;1;$line;vl_Style;vt_Font)
		GOTO RECORD:C242([Alumnos_EventosPersonales:16];aIWId{$line})
		If (([Alumnos_EventosPersonales:16]Privada:9) & (<>lUSR_RelatedTableUserID#[Alumnos_EventosPersonales:16]ID_Autor:11))
			If (USR_IsGroupMember_by_GrpID (-15001))
				QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Alumnos_EventosPersonales:16]ID_Autor:11)
				If (Records in selection:C76([Profesores:4])=0)
					OK:=CD_Dlog (0;__ ("La persona que registró este evento privado (")+[Alumnos_EventosPersonales:16]Autor:8+__ (") ya no existe en la base de datos.\r¿Desea usted editar este registro?");__ ("");__ ("Si");__ ("No"))
					If (OK=1)
						WDW_OpenFormWindow (->[Alumnos_EventosPersonales:16];"Input";-1;5)
						KRL_ModifyRecord (->[Alumnos_EventosPersonales:16];"Input")
						AL_CargaEventosPersonales 
					End if 
				Else 
					BEEP:C151
				End if 
			Else 
				BEEP:C151
			End if 
		Else 
			WDW_OpenFormWindow (->[Alumnos_EventosPersonales:16];"Input";-1;5)
			KRL_ModifyRecord (->[Alumnos_EventosPersonales:16];"Input")
			AL_CargaEventosPersonales 
		End if 
	End if 
Else 
	BEEP:C151
End if 
