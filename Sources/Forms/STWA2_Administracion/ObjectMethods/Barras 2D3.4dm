Case of 
	: (Form event:C388=On Double Clicked:K2:5)
		If (lb_reemplazo>0)
			  // puede estar reemplazando a mas de un usuario
			ARRAY TEXT:C222($at_UsuarioTemporal;0)
			ARRAY LONGINT:C221($al_profesorIDTemporal;0)
			AT_Text2Array (->$at_UsuarioTemporal;atSTWA2_Remplaza{lb_reemplazo};"\r")
			If (Size of array:C274($at_UsuarioTemporal)>0)
				
				  //cargo los usuarios (id profesor)
				For ($i;1;Size of array:C274($at_UsuarioTemporal))
					$l_pos:=Find in array:C230(at_login;$at_UsuarioTemporal{$i})
					If ($l_pos#-1)
						APPEND TO ARRAY:C911($al_profesorIDTemporal;al_NoProfesor{$l_pos})
					End if 
				End for 
				QUERY WITH ARRAY:C644([Asignaturas:18]profesor_numero:4;$al_profesorIDTemporal)
				CREATE SET:C116([Asignaturas:18];"1")
				QUERY WITH ARRAY:C644([Asignaturas:18]profesor_firmante_numero:33;$al_profesorIDTemporal)
				CREATE SET:C116([Asignaturas:18];"2")
				UNION:C120("1";"2";"3")
				USE SET:C118("3")
				SET_ClearSets ("1";"2";"3")
				
				ORDER BY:C49([Asignaturas:18];[Asignaturas:18]profesor_nombre:13;>;[Asignaturas:18]Curso:5;>;[Asignaturas:18]ordenGeneral:105;>)
				SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$at_asignaturas;[Asignaturas:18]Numero:1;$al_asignaturaID;[Asignaturas:18]Curso:5;$at_asignaturaCurso;[Asignaturas:18]profesor_nombre:13;$at_profesor)
				
				  //AT_DistinctsFieldValues (->[Asignaturas]Asignatura;->$at_asignaturas)
				ARRAY POINTER:C280($ay_ArregloPuntero;0)
				ARRAY LONGINT:C221($al_LineasSeleccionadas;0)
				ARRAY LONGINT:C221($al_Tamaño;0)
				ARRAY TEXT:C222($at_Titulo;0)
				APPEND TO ARRAY:C911($ay_ArregloPuntero;->$at_asignaturas)
				APPEND TO ARRAY:C911($ay_ArregloPuntero;->$at_asignaturaCurso)
				APPEND TO ARRAY:C911($ay_ArregloPuntero;->$at_profesor)
				APPEND TO ARRAY:C911($al_Tamaño;160)
				APPEND TO ARRAY:C911($al_Tamaño;40)
				APPEND TO ARRAY:C911($al_Tamaño;190)
				APPEND TO ARRAY:C911($at_Titulo;"Asignaturas")
				APPEND TO ARRAY:C911($at_Titulo;"Curso")
				APPEND TO ARRAY:C911($at_Titulo;"Usuario")
				
				  // pàra marcar las lineas seleccionadas
				ARRAY TEXT:C222($at_asignaturasListadasID;0)
				ARRAY LONGINT:C221($al_lineas;0)
				AT_Text2Array (->$at_asignaturasListadasID;atSTWA2_AsignaturasID{lb_reemplazo};"\r")
				
				For ($i;1;Size of array:C274($at_asignaturasListadasID))
					$l_pos:=Find in array:C230($al_asignaturaID;Num:C11($at_asignaturasListadasID{$i}))
					If ($l_pos#-1)
						APPEND TO ARRAY:C911($al_lineas;$l_pos)
					End if 
				End for 
				
				$ok:=SRtbl_DespliegueListaOpciones (->$ay_ArregloPuntero;->$al_Tamaño;->$at_Titulo;"Seleccione asignaturas";True:C214;->$al_LineasSeleccionadas;->$al_lineas)
				
				If ($ok=1)
					ARRAY TEXT:C222($at_AsigSeleccionados;0)
					ARRAY TEXT:C222($at_AsigSelecccionadosID;0)
					C_TEXT:C284($t_asignaturas)
					$t_asignaturas:=""
					For ($i;1;Size of array:C274($al_LineasSeleccionadas))
						APPEND TO ARRAY:C911($at_AsigSeleccionados;$at_asignaturas{$al_LineasSeleccionadas{$i}}+" ("+$at_asignaturaCurso{$al_LineasSeleccionadas{$i}}+")")
						APPEND TO ARRAY:C911($at_AsigSelecccionadosID;String:C10($al_asignaturaID{$al_LineasSeleccionadas{$i}}))
					End for 
					
					If (Size of array:C274($al_LineasSeleccionadas)>0)
						$t_asignaturas:=AT_array2text (->$at_AsigSeleccionados;"\r")
						$t_asignaturasID:=AT_array2text (->$at_AsigSelecccionadosID;"\r")
						If ($t_asignaturas#"")
							atSTWA2_Asignaturas{lb_reemplazo}:=$t_asignaturas
							atSTWA2_AsignaturasID{lb_reemplazo}:=$t_asignaturasID
						End if 
					Else 
						atSTWA2_Asignaturas{lb_reemplazo}:=""
						atSTWA2_AsignaturasID{lb_reemplazo}:=""
					End if 
					
				End if 
			End if 
		End if 
End case 
