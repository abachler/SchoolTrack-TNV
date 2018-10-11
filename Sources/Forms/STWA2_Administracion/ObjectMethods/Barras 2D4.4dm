Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If (lb_reemplazo>0)
			ARRAY LONGINT:C221($al_tamaño;0)
			ARRAY TEXT:C222($at_titulo;0)
			ARRAY TEXT:C222($at_usuarioTemporal;0)
			ARRAY TEXT:C222($at_usuarioTemporalID;0)
			ARRAY POINTER:C280($ay_ArregloPuntero;0)
			ARRAY LONGINT:C221($al_LineasSeleccionadas;0)
			APPEND TO ARRAY:C911($ay_ArregloPuntero;->at_login)
			APPEND TO ARRAY:C911($al_tamaño;390)
			APPEND TO ARRAY:C911($at_titulo;"Usuario")
			
			  // pàra marcar las lineas seleccionadas
			ARRAY TEXT:C222($at_usuariosListados;0)
			ARRAY LONGINT:C221($al_lineas;0)
			AT_Text2Array (->$at_usuariosListados;atSTWA2_Remplaza{lb_reemplazo};"\r")
			
			For ($i;1;Size of array:C274($at_usuariosListados))
				$l_pos:=Find in array:C230(at_login;$at_usuariosListados{$i})
				If ($l_pos#-1)
					APPEND TO ARRAY:C911($al_lineas;$l_pos)
				End if 
			End for 
			
			$ok:=SRtbl_DespliegueListaOpciones (->$ay_ArregloPuntero;->$al_tamaño;->$at_titulo;"Seleccione Usuario";True:C214;->$al_LineasSeleccionadas;->$al_lineas)
			If ($ok=1)
				If (Size of array:C274($al_LineasSeleccionadas)>0)
					For ($i;1;Size of array:C274($al_LineasSeleccionadas))
						APPEND TO ARRAY:C911($at_usuarioTemporal;at_login{$al_LineasSeleccionadas{$i}})
						APPEND TO ARRAY:C911($at_usuarioTemporalID;String:C10(al_NoUsers{$al_LineasSeleccionadas{$i}}))
					End for 
					$t_usuario:=AT_array2text (->$at_usuarioTemporal;"\r")
					$t_IDs:=AT_array2text (->$at_usuarioTemporalID;"\r")
					atSTWA2_Remplaza{lb_reemplazo}:=$t_usuario
					atSTWA2_IDReemplaza{lb_reemplazo}:=$t_IDs
					adSTWA2_fechadesde{lb_reemplazo}:=Current date:C33(*)
					adSTWA2_fechahasta{lb_reemplazo}:=Current date:C33(*)
					atSTWA2_Asignaturas{lb_reemplazo}:=""
				End if 
			End if 
		End if 
End case 