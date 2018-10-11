C_LONGINT:C283($el;$i;$l_areaWidth;$l_bottom;$l_left;$l_numberOfColumns;$l_pixelsToReasign;$l_right;$l_rows;$l_spareWidth)
C_LONGINT:C283($l_top;$l_totalWidth)
C_POINTER:C301($y_array)
C_TEXT:C284($t_userIdSegment)

ARRAY BOOLEAN:C223($arrVisibles;0)
ARRAY DATE:C224($ad_fechaMensajes;0)
ARRAY LONGINT:C221($al_HoraCreacion;0)
ARRAY POINTER:C280($arrHeaderVars;0)
ARRAY POINTER:C280($arrStyles;0)
ARRAY POINTER:C280($arrVarsCol;0)
ARRAY TEXT:C222($arrNomsCol;0)
ARRAY TEXT:C222($arrNomsTitulos;0)
ARRAY TEXT:C222($at_Encabezados;0)
C_TEXT:C284(vt_UUIDmensaje)

Case of 
	: (Form event:C388=On Load:K2:1)
		vl_displayOptions:=0
		NTC_CargaMensajes (0)
		
		
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
		
		
	: (Form event:C388=On Close Box:K2:21)
		CANCEL:C270
		
		
	: (Form event:C388=On Unload:K2:2)
		
		
		
		
	: (Form event:C388=On Outside Call:K2:11)
		
		
		If (<>vt_CloseSesion)
			CANCEL:C270
		Else 
			
			ARRAY TEXT:C222($at_IPmsg_UUID;0)
			ARRAY TEXT:C222($at_IPmsg_Message;0)
			
			$l_Messages:=IP_GetMessageQueue (->$at_IPmsg_UUID;->$at_IPmsg_Message)
			For ($i;1;$l_Messages)
				$t_IPmsg_uuid:=$at_IPmsg_UUID{$i}
				
				Case of 
					: ($at_IPmsg_Message{$i}="NTC_NuevoMensaje")
						$t_mensajeActual_UUID:=vt_UUIDmensaje
						NTC_CargaMensajes (vl_displayOptions)
						If ($t_mensajeActual_UUID#"")
							$l_elementoActual:=Find in array:C230(at_UUID_mensaje;$t_mensajeActual_UUID)
							If ($l_elementoActual>0)
								vt_UUIDmensaje:=$t_mensajeActual_UUID
								AL_SetLine (xALP_Mensajes;$l_elementoActual)
								NTC_ConfiguraAreaMensaje 
							End if 
						End if 
						
						
						
						
					: ($at_IPmsg_Message{$i}="NTC_CodigoEjecutado")
						$t_notificacionUUID:=ST_GetWord (IP_GetTextParameter ($t_IPmsg_uuid);1;";")
						$l_executionResult:=Num:C11(ST_GetWord (IP_GetTextParameter ($t_IPmsg_uuid);2;";"))
						
						KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_notificacionUUID)
						Case of 
							: (($l_ExecutionResult<0) & ([NTC_Notificaciones:190]Ejecucion_MensajeFalla:19#""))
								CD_Dlog (0;[NTC_Notificaciones:190]Ejecucion_MensajeFalla:19)
								NTC_CargaMensajes (vl_displayOptions)
								
							: (($l_ExecutionResult>=0) & ([NTC_Notificaciones:190]Ejecucion_MensajeExito:18#""))
								CD_Dlog (0;[NTC_Notificaciones:190]Ejecucion_MensajeExito:18+"\r\rEsta notificación será conservada en el registro pero dejará de visualizarse en la lista.")
								KRL_FindAndLoadRecordByIndex (->[NTC_Notificaciones:190]Auto_UUID:1;->$t_notificacionUUID;True:C214)
								[NTC_Notificaciones:190]Resuelto:22:=True:C214
								[NTC_Notificaciones:190]Resuelto_fechaHora:23:=String:C10(Current date:C33(*);System date abbreviated:K1:2)+","+String:C10(Current time:C178(*);System time short:K7:9)
								[NTC_Notificaciones:190]Resuelto_DTS:25:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
								[NTC_Notificaciones:190]Resuelto_Por:24:=USR_GetUserName (USR_GetUserID )
								SAVE RECORD:C53([NTC_Notificaciones:190])
								KRL_UnloadReadOnly (->[NTC_Notificaciones:190])
								NTC_CargaMensajes (vl_displayOptions)
						End case 
						IP_DeleteFromQueue ($t_IPmsg_uuid)
						
						
				End case 
			End for 
		End if 
		
		
		
		
		
		
	: (Form event:C388=On Resize:K2:27)
		IT_HCenterObjects_onResize ("P0_MsgArea_draw";"P0_NoSelection@")
		
		
		  // determino el ancho óptimo de las columnas
		If (vt_UUIDmensaje#"")
			OBJECT GET COORDINATES:C663(xALP_MsgWarnings;$l_left;$l_top;$l_right;$l_bottom)
			$l_areaWidth:=$l_right-$l_left-16
			$l_totalWidth:=AT_GetSumArray (->al_columnWidhts)
			If ($l_totalWidth<$l_areaWidth)
				$l_spareWidth:=$l_areaWidth-$l_totalWidth
			End if 
			
			If ($l_spareWidth>0)
				$l_numberOfColumns:=Size of array:C274(at_ArreglosErrores)
				$l_pixelsToReasign:=Int:C8($l_spareWidth/$l_numberOfColumns)
				If ($l_pixelsToReasign>0)
					For ($i;1;Size of array:C274(at_ArreglosErrores))
						$y_array:=Get pointer:C304(at_ArreglosErrores{$i})
						  //al_maxColumnWidhts{$i}:=hmFree_GetArrayWidth ($y_array->;"Tahoma";11;0)+20
						If (al_maxColumnWidhts{$i}>al_columnWidhts{$i})
							al_columnWidhts{$i}:=al_columnWidhts{$i}+$l_pixelsToReasign
						End if 
						If (al_maxColumnWidhts{$i}>al_columnWidhts{$i})
							$l_rows:=(al_maxColumnWidhts{$i}/al_columnWidhts{$i})+(1-Dec:C9(al_maxColumnWidhts{$i}/al_columnWidhts{$i}))
							al_RowsInColumn{$i}:=$l_Rows
						Else 
							al_columnWidhts{$i}:=al_maxColumnWidhts{$i}
						End if 
						$l_numberOfColumns:=Size of array:C274(at_ArreglosErrores)-$i
						$l_pixelsToReasign:=Int:C8($l_spareWidth/$l_numberOfColumns)
					End for 
				End if 
			End if 
		End if 
		
		
		
		
		
End case 
