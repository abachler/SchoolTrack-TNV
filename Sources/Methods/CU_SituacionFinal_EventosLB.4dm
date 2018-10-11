//%attributes = {}
  // CU_SituacionFinal_EventosLB()
  // 
  //
  // creado por: Alberto Bachler Klein: 16-11-16, 10:54:59
  // -----------------------------------------------------------


C_BOOLEAN:C305($b_calificacionValida;$b_editable;$b_Promovible;$b_reprobable)
C_LONGINT:C283($choice;$l_abajo;$l_abajoLB;$l_arriba;$l_arribaLB;$l_columna;$l_derecha;$l_derechaLB;$l_filas;$l_filaSeleccionada)
C_LONGINT:C283($l_izquierda;$l_izquierdaLB;$l_modifiers;$l_recNumAlumno;$l_registroEnSeleccion)
C_POINTER:C301($y_antesEdicion;$y_ListboxControl;$y_literalAntesEdicion;$y_reprobadas_Asignatura;$y_SitFinalAlumno;$y_SitFinalAsistencia;$y_SitFinalComentarios;$y_SitFinalObsActas;$y_SitFinalPromedio;$y_SitFinalRecNum)
C_POINTER:C301($y_SitFinalSituacionFinal)
C_REAL:C285($r_real)
C_TEXT:C284($t_accionBoton;$t_alumno;$t_atajo;$t_literal;$t_nombreColumna;$t_nombreListBox;$t_OpcionesMenu;$t_parametro;$t_refMenu;$t_refSubMenu)

ARRAY BOOLEAN:C223($ab_visibles;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY POINTER:C280($ay_Encabezados;0)
ARRAY POINTER:C280($ay_Estilos;0)
ARRAY TEXT:C222($at_nombreColumnas;0)
ARRAY TEXT:C222($at_nombreEncabezados;0)


$y_SitFinalAlumno:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Alumno")
$y_SitFinalPromedio:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Promedio")
$y_SitFinalSituacionFinal:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_SituacionFinal")
$y_SitFinalAsistencia:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Asistencia")
$y_SitFinalComentarios:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_Comentarios")
$y_SitFinalObsActas:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_ObsActas")
$y_SitFinalRecNum:=OBJECT Get pointer:C1124(Object named:K67:5;"SitFinal_RecNum")
$y_literalAntesEdicion:=OBJECT Get pointer:C1124(Object named:K67:5;"literalAntesEdicion")
$y_ListboxControl:=OBJECT Get pointer:C1124(Object named:K67:5;"listboxControl")

Case of 
		  // el usuario pulsó un botón en formulario que actúa sobre el listbox de visualización y registro de la infomación
	: (Count parameters:C259=1)
		$t_accionBoton:=$1
		
		OBJECT GET SHORTCUT:C1186(*;$t_accionBoton;$t_atajo;$l_modifiers)
		If (($t_atajo=Shortcut with Down arrow:K75:30) | ($t_atajo=Shortcut with Up arrow:K75:29) | ($t_atajo=Shortcut with Enter:K75:17))
			$t_nombreListBox:=OBJECT Get name:C1087(Object with focus:K67:3)
			
			$t_nombreColumna:=OB Get:C1224($y_ListboxControl->;"nombreColumnaActual")
			$l_columna:=OB Get:C1224($y_ListboxControl->;"celda_columna")
			
			$l_filaSeleccionada:=OB Get:C1224($y_ListboxControl->;"celda_fila")
			$l_filaSeleccionada:=Choose:C955($l_filaSeleccionada=0;1;$l_filaSeleccionada)
			
			$l_filas:=LISTBOX Get number of rows:C915(*;"lbSituacionFinal")
			$b_editable:=OBJECT Get enterable:C1067(*;$t_nombreColumna)
			
			Case of 
				: (($t_atajo=Shortcut with Down arrow:K75:30) | ($t_atajo=Shortcut with Enter:K75:17))
					$l_filaSeleccionada:=Choose:C955($l_filaSeleccionada<$l_filas;$l_filaSeleccionada+1;1)
				: ($t_atajo=Shortcut with Up arrow:K75:29)
					$l_filaSeleccionada:=Choose:C955($l_filaSeleccionada=1;$l_filas;$l_filaSeleccionada-1)
			End case 
			
			
			If ($b_editable)
				EDIT ITEM:C870(*;$t_nombreColumna;$l_filaSeleccionada)
			Else 
				LISTBOX SELECT ROW:C912(*;$t_nombreListBox;$l_filaSeleccionada;lk replace selection:K53:1)
				OBJECT SET SCROLL POSITION:C906(*;$t_nombreListBox;$l_filaSeleccionada)
			End if 
			
			OB SET:C1220($y_ListboxControl->;"celda_fila";$l_filaSeleccionada)
			OB SET:C1220($y_ListboxControl->;"celda_columna";$l_columna)
		End if 
		
		$t_alumno:=$y_SitFinalAlumno->{$l_filaSeleccionada}
		KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$y_SitFinalRecNum->{$l_filaSeleccionada};False:C215)
		RELATE ONE:C42([Alumnos_SintesisAnual:210]ID_Alumno:4)
		CU_SituacionFinal_InfoPromo 
		
		
	Else 
		  // el usuario actúa directamente sobre el el listbox de visualización y registro de la información
		LISTBOX GET CELL POSITION:C971(*;"lbSituacionFinal";$l_columna;$l_filaSeleccionada)
		  // obtengo informacion del objeto en que manejo información de la selección actual
		OB GET ARRAY:C1229($y_ListboxControl->;"columnas";$at_nombreColumnas)
		$t_nombreColumna:=Choose:C955($l_columna>0;$at_nombreColumnas{$l_columna};"")
		
		  //ABC Valido que se esta seleccionando una fila y columna  con click o las flechas de teclado
		  //192301 
		If ((Form event:C388=On Clicked:K2:4) & ($l_columna>0) & ($l_filaSeleccionada>0) & (Form event:C388=On Getting Focus:K2:7))
			OB SET:C1220($y_ListboxControl->;"nombreColumnaActual";$t_nombreColumna)
			OB SET:C1220($y_ListboxControl->;"celda_fila";$l_filaSeleccionada)
			OB SET:C1220($y_ListboxControl->;"celda_columna";$l_columna)
		End if 
		
		
		  //If ($l_filaSeleccionada>0)
		If (($l_filaSeleccionada>0) & ($l_filaSeleccionada<=Size of array:C274($y_SitFinalAlumno->)))  //20170126 RCH Cuando el curso no tenía alumnos aparecía un error
			$t_alumno:=$y_SitFinalAlumno->{$l_filaSeleccionada}
			KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$y_SitFinalRecNum->{$l_filaSeleccionada};False:C215)
			RELATE ONE:C42([Alumnos_SintesisAnual:210]ID_Alumno:4)
			CU_SituacionFinal_InfoPromo 
			OBJECT SET VISIBLE:C603(*;"lbReprobadas";True:C214)
			OBJECT SET VISIBLE:C603(*;"lbConducta";True:C214)
		Else 
			OBJECT SET TITLE:C194(*;"mensaje";"")
			OBJECT SET VISIBLE:C603(*;"lbReprobadas";False:C215)
			OBJECT SET VISIBLE:C603(*;"lbConducta";False:C215)
		End if 
		
		
		Case of 
			: (Form event:C388=On Getting Focus:K2:7)
				If ($l_columna>0)
					$t_nombreColumna:=$at_nombreColumnas{$l_columna}
					LISTBOX SELECT ROW:C912(*;"lbSituacionFinal";$l_filaSeleccionada)
					OBJECT GET COORDINATES:C663(*;"lbSituacionFinal";$l_izquierdaLB;$l_arribaLB;$l_derechaLB;$l_abajoLB)
					LISTBOX GET CELL COORDINATES:C1330(*;"lbSituacionFinal";$l_columna;$l_filaSeleccionada;$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
					OBJECT SET COORDINATES:C1248(*;"rectanguloEntrada";$l_izquierda-2;$l_arriba-2;$l_derecha+1;$l_abajo+1)
					OBJECT SET COORDINATES:C1248(*;"fondoEdicion";$l_izquierdaLB;$l_arriba-1;$l_derechaLB;$l_abajo-1)
					OBJECT SET VISIBLE:C603(*;"fondoEdicion";True:C214)
					OBJECT SET VISIBLE:C603(*;"rectanguloEntrada";True:C214)
					LISTBOX SET ROW FONT STYLE:C1268(*;"sitFinal@";$l_filaSeleccionada;Bold:K14:2)
					
					Case of 
						: ($t_nombreColumna="SitFinal_Promedio")
							$y_literalAntesEdicion->:=$y_SitFinalPromedio->{$l_filaSeleccionada}
						: ($t_nombreColumna="SitFinal_Comentarios")
							$y_literalAntesEdicion->:=$y_SitFinalComentarios->{$l_filaSeleccionada}
						: ($t_nombreColumna="SitFinal_ObsActas")
							$y_literalAntesEdicion->:=$y_SitFinalObsActas->{$l_filaSeleccionada}
					End case 
					OB SET:C1220($y_ListboxControl->;"celda_fila";$l_filaSeleccionada)
					OB SET:C1220($y_ListboxControl->;"celda_columna";$l_columna)
					OB SET:C1220($y_ListboxControl->;"nombreColumnaActual";$t_nombreColumna)
				End if 
				
				
			: (Form event:C388=On Losing Focus:K2:8)
				OBJECT SET VISIBLE:C603(*;"fondoEdicion";False:C215)
				OBJECT SET VISIBLE:C603(*;"rectanguloEntrada";False:C215)
				LISTBOX SET ROW FONT STYLE:C1268(*;"sitFinal@";$l_filaSeleccionada;Plain:K14:1)
				LISTBOX SET ROW COLOR:C1270(*;"lbSituacionFinal";$l_filaSeleccionada;lk inherited:K53:26;lk background color:K53:25)
				LISTBOX SET ROW COLOR:C1270(*;"lbSituacionFinal";$l_filaSeleccionada;lk inherited:K53:26;lk font color:K53:24)
				
				
			: (Form event:C388=On Selection Change:K2:29)
				LISTBOX SET ROW COLOR:C1270(*;"lbSituacionFinal";$l_filaSeleccionada;lk inherited:K53:26;lk font color:K53:24)
				
				
			: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Losing Focus:K2:8))
				$t_nombreColumna:=OB Get:C1224($y_ListboxControl->;"nombreColumnaActual")
				$l_columna:=OB Get:C1224($y_ListboxControl->;"celda_columna")
				$l_filaSeleccionada:=OB Get:C1224($y_ListboxControl->;"celda_fila")
				$t_alumno:=$y_SitFinalAlumno->{$l_filaSeleccionada}
				
				$r_real:=-10
				$t_literal:=""
				$l_recNumAlumno:=$y_SitFinalRecNum->{$l_filaSeleccionada}
				Case of 
					: ($t_nombreColumna="SitFinal_Promedio")
						$b_calificacionValida:=EV2_validaCalificacion ($y_SitFinalPromedio->{$l_filaSeleccionada};->$t_literal;->$r_real)
						If ($b_calificacionValida)
							KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$y_SitFinalRecNum->{$l_filaSeleccionada};True:C214)
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19:=$t_literal
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Real:15:=$r_real
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Nota:16:=EV2_Real_a_Nota ($r_real)
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Puntos:17:=EV2_Real_a_Puntos ($r_real)
							[Alumnos_SintesisAnual:210]PromedioAnualOficial_Simbolo:18:=EV2_Real_a_Simbolo ($r_real)
							[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=True:C214
							LOG_RegisterEvt ("Modificación del promedio final general de "+$t_alumno+":\r"+[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19+"\rAntes: "+Old:C35([Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19)+")")
							KRL_SaveUnLoadReadOnly (->[Alumnos_SintesisAnual:210])
						Else 
							$y_SitFinalPromedio->{$l_filaSeleccionada}:=$y_literalAntesEdicion->
							EDIT ITEM:C870(*;$t_nombreColumna;$l_filaSeleccionada)
						End if 
						
					: ($t_nombreColumna="SitFinal_Comentarios")
						KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$y_SitFinalRecNum->{$l_filaSeleccionada};True:C214)
						[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:=$y_SitFinalComentarios->{$l_filaSeleccionada}
						If ([Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62#Old:C35([Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62))
							LOG_RegisterEvt ("Modificación del comentario de situación final para "+$t_alumno+":\r"+[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62+"\rAntes: "+Old:C35([Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62)+")")
						End if 
						KRL_SaveUnLoadReadOnly (->[Alumnos_SintesisAnual:210])
						
					: ($t_nombreColumna="SitFinal_ObsActas")
						KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$y_SitFinalRecNum->{$l_filaSeleccionada};True:C214)
						[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9:=$y_SitFinalObsActas->{$l_filaSeleccionada}
						If ([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9#Old:C35([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9))
							LOG_RegisterEvt ("Modificación de observaciones en actas para "+$t_alumno+":\r"+[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9+"\rAntes: "+Old:C35([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9)+")")
						End if 
						KRL_SaveUnLoadReadOnly (->[Alumnos_SintesisAnual:210])
						LISTBOX SELECT ROW:C912(*;"lbSituacionFinal";$l_filaSeleccionada)
						
				End case 
				
				
				
				
			: (Form event:C388=On Double Clicked:K2:5)
				Case of 
					: ($t_nombreColumna="SitFinal_Promedio")
						EDIT ITEM:C870(*;"sitFinal_promedio";$l_filaSeleccionada)
					: ($t_nombreColumna="SitFinal_Comentarios")
						EDIT ITEM:C870(*;"sitFinal_comentarios";$l_filaSeleccionada)
					: ($t_nombreColumna="SitFinal_ObsActas")
						EDIT ITEM:C870(*;"SitFinal_ObsActas";$l_filaSeleccionada)
				End case 
				
			: ((Form event:C388=On Clicked:K2:4) & (Contextual click:C713))
				LISTBOX GET CELL POSITION:C971(*;"lbSituacionFinal";$l_columna;$l_filaSeleccionada)
				KRL_GotoRecord (->[Alumnos_SintesisAnual:210];$y_SitFinalRecNum->{$l_filaSeleccionada};False:C215)
				$l_recNumAlumno:=Record number:C243([Alumnos:2])
				
				$t_refMenu:=Create menu:C408
				MNU_Append ($t_refMenu;__ ("Evaluar ")+[Alumnos:2]apellidos_y_nombres:40;"evaluar")
				MNU_Append ($t_refMenu;"(-")
				$t_refSubMenu:=Create menu:C408
				
				
				Case of 
						  // opciones CHILE
					: (<>vtXS_CountryCode="cl")
						$b_Promovible:=(([Alumnos_SintesisAnual:210]SituacionFinal:8="R") & (Position:C15(__ ("Reprobado por rendimiento");[Alumnos:2]Comentario_Situacion_Final:31)=0))
						$b_reprobable:=([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
						MNU_Append ($t_refSubMenu;__ ("Promovido: P");"P";$b_promovible)
						MNU_Append ($t_refSubMenu;__ ("Reprobado: R");"R";$b_reprobable)
						
						
						  // opciones COLOMBIA
					: (<>vtXS_CountryCode="co")
						MNU_Append ($t_refSubMenu;__ ("Promovido");"P")
						MNU_Append ($t_refSubMenu;__ ("Requiere Recuperación");"RR")
						MNU_Append ($t_refSubMenu;__ ("No Promovido");"NP")
						
						
						  // opciones Otros paises
					Else 
						MNU_Append ($t_refSubMenu;__ ("Promovido");"P")
						MNU_Append ($t_refSubMenu;__ ("Reprobado");"R")
						
						
				End case 
				APPEND MENU ITEM:C411($t_refMenu;__ ("Asignar Situación Final ");$t_refSubMenu)
				$t_parametro:=Dynamic pop up menu:C1006($t_refMenu)
				
				
				If ($t_parametro#"")
					KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
					Case of 
						: ($t_parametro="evaluar")
							CU_SituacionFinal_Evaluar ($l_recNumAlumno)
							KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
							KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
							
							
						Else 
							KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno;False:C215)
							KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]ID_Alumno:4;->[Alumnos:2]numero:1;True:C214)
							
							[Alumnos_SintesisAnual:210]SituacionFinal:8:=$t_parametro
							[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=True:C214
							
							Case of 
									  // CHILE
								: (<>vtXS_CountryCode="cl")
									Case of 
										: ([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
											[Alumnos_SintesisAnual:210]SitFinal_AsignadaManualmente:61:=True:C214
											If ([Alumnos_SintesisAnual:210]PorcentajeAsistencia:33<[xxSTR_Niveles:6]Minimo_asistencia:24)
												[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:="Situación final asignada: Promovido con asistencia inferior al "+String:C10([xxSTR_Niveles:6]Minimo_asistencia:24)+"; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7)
												[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9:=Choose:C955([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9#"";[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9+"; "+vs_PromoAbs;vs_PromoAbs)
											Else 
												[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:="Situación final asignada: Promovido; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7)
											End if 
											
										: ([Alumnos_SintesisAnual:210]SituacionFinal:8="R")
											[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:="Situación final asignada: Reprobado; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7)
											If ([Alumnos:2]nivel_numero:29=12)
												[Alumnos:2]Chile_PromedioEMedia:73:=0
												[Alumnos:2]Chile_SumaNotasEMedia:74:=0
												[Alumnos:2]Chile_TotalAsignaturasEMedia:75:=0
											End if 
									End case 
									[Alumnos_SintesisAnual:210]Promovido:91:=([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
									
									  // COLOMBIA
								: (<>vtXS_CountryCode="co")
									Case of 
										: ([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
											[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:="Situación final asignada: Promovido; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7)
											
										: ([Alumnos_SintesisAnual:210]SituacionFinal:8="RR")
											[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:="Situación final asignada: Requiere Recuperación; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7)
											
										: ([Alumnos_SintesisAnual:210]SituacionFinal:8="NP")
											[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:="Situación final asignada: No Promovido; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7)
											
									End case 
									[Alumnos_SintesisAnual:210]Promovido:91:=(([Alumnos_SintesisAnual:210]SituacionFinal:8="P") | ([Alumnos_SintesisAnual:210]SituacionFinal:8="RR"))
									
								Else 
									[Alumnos_SintesisAnual:210]Promovido:91:=([Alumnos_SintesisAnual:210]SituacionFinal:8="P")
									[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62:=Choose:C955($t_parametro="R";"Situación final asignada: Reprobado; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7);"Situación final asignada: Promovido; por "+USR_GetUserName (USR_GetUserID )+", el "+String:C10(Current date:C33(*);7))
							End case 
					End case 
					
					$y_SitFinalComentarios->{$l_filaSeleccionada}:=[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62
					$y_SitFinalObsActas->{$l_filaSeleccionada}:=[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9
					$y_SitFinalSituacionFinal->{$l_filaSeleccionada}:=[Alumnos_SintesisAnual:210]SituacionFinal:8
					$y_SitFinalPromedio->{$l_filaSeleccionada}:=[Alumnos_SintesisAnual:210]PromedioAnualOficial_Literal:19
					
					If ([Alumnos_SintesisAnual:210]SituacionFinal:8#Old:C35([Alumnos_SintesisAnual:210]SituacionFinal:8))
						LOG_RegisterEvt ("Modificación de situación final para "+$t_alumno+":\r"+[Alumnos_SintesisAnual:210]SituacionFinal:8+"\rAntes: "+Old:C35([Alumnos_SintesisAnual:210]SituacionFinal:8))
					End if 
					If ([Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62#Old:C35([Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62))
						LOG_RegisterEvt ("Modificación del comentario de situación final para "+$t_alumno+":\r"+[Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62+"\rAntes: "+Old:C35([Alumnos_SintesisAnual:210]Comentario_SituacionFinal:62))
					End if 
					If ([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9#Old:C35([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9))
						LOG_RegisterEvt ("Modificación de observaciones en actas para "+$t_alumno+":\r"+[Alumnos_SintesisAnual:210]ObservacionesActas_cl:9+"\rAntes: "+Old:C35([Alumnos_SintesisAnual:210]ObservacionesActas_cl:9))
					End if 
					
					SAVE RECORD:C53([Alumnos_SintesisAnual:210])
					KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
					
				End if 
				
			: (Form event:C388=On Clicked:K2:4)
				
		End case 
		
End case 






