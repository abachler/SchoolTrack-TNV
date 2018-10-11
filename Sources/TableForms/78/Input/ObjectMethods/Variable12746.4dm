If (alProEvt=2)
	If (USR_checkRights ("M";->[Familia_RegistroEventos:140]))
		$line:=AL_GetLine (xALP_EventosFamiliares)
		AL_GetCellStyle (xALP_EventosFamiliares;1;$line;vl_Style;vt_Font)
		GOTO RECORD:C242([Familia_RegistroEventos:140];al_Long1{$line})
		If (([Familia_RegistroEventos:140]Privada:8) & (<>lUSR_RelatedTableUserID#[Familia_RegistroEventos:140]ID_Autor:9))
			If (USR_IsGroupMember_by_GrpID (-15001))
				If (USR_GetUserID <0)
					WDW_OpenFormWindow (->[Familia_RegistroEventos:140];"Input";-1;5)
					KRL_ModifyRecord (->[Familia_RegistroEventos:140];"Input")
					FM_LoadEvents 
				Else 
					QUERY:C277([Profesores:4];[Profesores:4]Numero:1=[Familia_RegistroEventos:140]ID_Autor:9)
					If (Records in selection:C76([Profesores:4])=0)
						OK:=CD_Dlog (0;__ ("La persona que registr este evento privado (")+[Familia_RegistroEventos:140]Registrado_por:5+__ (") ya no existe en la base de datos.\rDesea usted editar este registro?");__ ("");__ ("Si");__ ("No"))
						If (OK=1)
							WDW_OpenFormWindow (->[Familia_RegistroEventos:140];"Input";-1;5)
							KRL_ModifyRecord (->[Familia_RegistroEventos:140];"Input")
							FM_LoadEvents 
						End if 
					Else 
						BEEP:C151
					End if 
				End if 
			Else 
				BEEP:C151
			End if 
		Else 
			WDW_OpenFormWindow (->[Familia_RegistroEventos:140];"Input";-1;5)
			KRL_ModifyRecord (->[Familia_RegistroEventos:140];"Input")
			FM_LoadEvents 
		End if 
	Else 
		BEEP:C151
	End if 
End if 