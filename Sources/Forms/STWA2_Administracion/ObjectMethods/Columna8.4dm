Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If (lb_reemplazo>0)
			ARRAY LONGINT:C221($al_tamaño;0)
			ARRAY TEXT:C222($at_titulo;0)
			ARRAY POINTER:C280($ay_ArregloPuntero;0)
			ARRAY LONGINT:C221($al_LineasSeleccionadas;0)
			APPEND TO ARRAY:C911($ay_ArregloPuntero;->at_login)
			APPEND TO ARRAY:C911($al_tamaño;390)
			APPEND TO ARRAY:C911($at_titulo;"Usuario")
			$ok:=SRtbl_DespliegueListaOpciones (->$ay_ArregloPuntero;->$al_tamaño;->$at_titulo;"Seleccione Usuario";False:C215;->$al_LineasSeleccionadas)
			If ($ok=1)
				If (Size of array:C274($al_LineasSeleccionadas)>0)
					atSTWA2_Usuario{lb_reemplazo}:=at_login{$al_LineasSeleccionadas{Size of array:C274($al_LineasSeleccionadas)}}
					atSTWA2_IDUsuario{lb_reemplazo}:=String:C10(al_NoUsers{$al_LineasSeleccionadas{Size of array:C274($al_LineasSeleccionadas)}})
					adSTWA2_fechadesde{lb_reemplazo}:=Current date:C33(*)
					adSTWA2_fechahasta{lb_reemplazo}:=Current date:C33(*)
					atSTWA2_Asignaturas{lb_reemplazo}:=""
					atSTWA2_Remplaza{lb_reemplazo}:=""
				End if 
			End if 
		End if 
End case 


