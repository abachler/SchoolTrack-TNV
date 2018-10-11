C_LONGINT:C283($offset)

Case of 
	: (alproEvt=AL Single Control Click)
		$l_selectedLine:=AL_GetLine (xALP_Mensajes)
		If ($l_selectedLine>0)
			If (vt_UUIDmensaje#at_UUID_mensaje{$l_selectedLine})
				vt_UUIDmensaje:=at_UUID_mensaje{$l_selectedLine}
				$t_userIdSegment:="."+String:C10(USR_GetUserID )+"."
				NTC_ConfiguraAreaMensaje 
				If (Position:C15($t_userIdSegment;at_lectores{$l_selectedLine})=0)
					NTC_Mensaje_Leido (vt_UUIDmensaje)
					at_lectores{$l_selectedLine}:=[NTC_Notificaciones:190]Lectores:11
					Case of 
						: (Position:C15($t_userIdSegment;at_lectores{$l_selectedLine})=0)
							AL_SetRowStyle (xALP_Mensajes;$l_selectedLine;Bold:K14:2)
						Else 
							AL_SetRowStyle (xALP_Mensajes;$l_selectedLine;Plain:K14:1)
					End case 
					AL_UpdateArrays (xALP_Mensajes;-1)
				End if 
			End if 
		End if 
		
		
		If ([NTC_Notificaciones:190]Resuelto:22)
			If (USR_GetUserName (USR_GetUserID )=[NTC_Notificaciones:190]Resuelto_Por:24)
				$t_popUpItems:=__ ("(Marcar como resuelto;Marcar como no resuelto;(-;Eliminar;-;(Resuelto por: ; ")+[NTC_Notificaciones:190]Resuelto_Por:24+__ ("; el ")+[NTC_Notificaciones:190]Resuelto_fechaHora:23+__ (";(-;(Leído por: ;")
			Else 
				$t_popUpItems:=__ ("(Marcar como resuelto;Marcar como no resuelto;(-;(Eliminar;-;(Resuelto por: ; ")+[NTC_Notificaciones:190]Resuelto_Por:24+__ ("; el ")+[NTC_Notificaciones:190]Resuelto_fechaHora:23+__ (";(-;(Leído por: ;")
			End if 
		Else 
			$t_popUpItems:=__ ("Marcar como resuelto;(Marcar como no resuelto;(-;(Eliminar;(-;(Leído por: ")
		End if 
		$t_userIdSegment:="."+String:C10(USR_GetUserID )+"."
		For ($i;1;ST_countlines ([NTC_Notificaciones:190]Lectores:11))
			$t_reader:=ST_GetLine ([NTC_Notificaciones:190]Lectores:11;$i)
			If ($t_reader#"")
				$t_popUpItems:=$t_popUpItems+";  "+ST_GetWord ($t_reader;1;".")+" - "+ST_GetWord ($t_reader;3;".")
			End if 
		End for 
		$l_userChoice:=Pop up menu:C542($t_popUpItems;0)
		Case of 
			: ($l_userChoice=1)
				KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->vt_UUIDmensaje;True:C214)
				[NTC_Notificaciones:190]Resuelto:22:=True:C214
				[NTC_Notificaciones:190]Resuelto_fechaHora:23:=String:C10(Current date:C33(*);System date abbreviated:K1:2)+","+String:C10(Current time:C178(*);System time short:K7:9)
				[NTC_Notificaciones:190]Resuelto_DTS:25:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
				[NTC_Notificaciones:190]Resuelto_Por:24:=USR_GetUserName (USR_GetUserID )
				SAVE RECORD:C53([NTC_Notificaciones:190])
				KRL_ReloadAsReadOnly (->[NTC_Notificaciones:190])
				NTC_CargaMensajes (vl_displayOptions)
			: ($l_userChoice=2)
				KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->vt_UUIDmensaje;True:C214)
				[NTC_Notificaciones:190]Resuelto:22:=False:C215
				[NTC_Notificaciones:190]Resuelto_fechaHora:23:=""
				[NTC_Notificaciones:190]Resuelto_DTS:25:=""
				[NTC_Notificaciones:190]Resuelto_Por:24:=""
				SAVE RECORD:C53([NTC_Notificaciones:190])
				KRL_ReloadAsReadOnly (->[NTC_Notificaciones:190])
				NTC_CargaMensajes (vl_displayOptions)
			: ($l_userChoice=4)
				KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->vt_UUIDmensaje;True:C214)
				KRL_DeleteRecord (->[NTC_Notificaciones:190])
				NTC_CargaMensajes (vl_displayOptions)
		End case 
		
		
	: ((alproEvt=AL Single click event) | (alproEvt=AL Double click event))
		$l_selectedLine:=AL_GetLine (xALP_Mensajes)
		If ($l_selectedLine>0)
			vt_UUIDmensaje:=at_UUID_mensaje{$l_selectedLine}
			$t_userIdSegment:="."+String:C10(USR_GetUserID )+"."
			If (Position:C15($t_userIdSegment;at_lectores{$l_selectedLine})=0)
				NTC_Mensaje_Leido (vt_UUIDmensaje)
				at_lectores{$l_selectedLine}:=[NTC_Notificaciones:190]Lectores:11
				Case of 
					: (Position:C15($t_userIdSegment;at_lectores{$l_selectedLine})=0)
						AL_SetRowStyle (xALP_Mensajes;$l_selectedLine;Bold:K14:2)
					Else 
						AL_SetRowStyle (xALP_Mensajes;$l_selectedLine;Plain:K14:1)
				End case 
				AL_UpdateArrays (xALP_Mensajes;-1)
			End if 
		Else 
			vt_UUIDmensaje:=""
		End if 
		NTC_ConfiguraAreaMensaje 
		
End case 

