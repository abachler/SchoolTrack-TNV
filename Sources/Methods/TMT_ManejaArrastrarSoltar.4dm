//%attributes = {}
  // TMT_ManejaArrastrarSoltar()
  //
  //
  // creado por: Alberto Bachler Klein: 19-07-16, 13:55:04
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_AsignacionDesplazada)
C_LONGINT:C283($l_asignarSala;$l_campo;$l_columna;$l_columnaHorario;$l_columnaOrigen;$l_elementoArrastre;$l_fila;$l_filaHorario;$l_filaOrigen;$l_IdAsignatura)
C_LONGINT:C283($l_NumeroAlumnos;$l_numeroDia;$l_numeroDiaDestino;$l_numeroHora;$l_numeroHoraDestino;$l_numeroHoraRecNum;$l_proceso;$l_recNumAsignatura;$l_recnumCeldaDestino;$l_recnumCeldaHorario)
C_LONGINT:C283($l_recnumCeldaOrigen;$l_tabla)
C_TIME:C306($h_HoraInicio;$h_HoraTermino)
C_POINTER:C301($y_asignaturas;$y_diaDestino_al;$y_diaHorario_al;$y_diaHorario_at;$y_diaOrigen_al;$y_diaOrigen_at;$y_horario;$y_origen;$y_salas)
C_TEXT:C284($t_Nombreprofesor;$t_objetoOrigen;$t_textoError;$t_variable)

$t_objetoOrigen:=OBJECT Get name:C1087(Object current:K67:2)
$y_salas:=OBJECT Get pointer:C1124(Object named:K67:5;"lbSalas")
$y_asignaturas:=OBJECT Get pointer:C1124(Object named:K67:5;"lbasignaturas")
$y_horario:=OBJECT Get pointer:C1124(Object named:K67:5;"lbHorario")
DRAG AND DROP PROPERTIES:C607($y_origen;$l_elementoArrastre;$l_proceso)
RESOLVE POINTER:C394($y_origen;$t_variable;$l_tabla;$l_campo)

Case of 
		
	: (Form event:C388=On Drag Over:K2:13)
		
	: (Form event:C388=On Drop:K2:12)
		Case of 
			: (($y_origen=$y_horario) & (OBJECT Get name:C1087="lbsalas"))
				  //LISTBOX GET CELL POSITION(*;"lbSalas";$l_columna;$l_fila)
				QUERY:C277([TMT_Salas:167];[TMT_Salas:167]ID_Sala:1=alTMT_Salas_ID{Drop position:C608})
				LISTBOX GET CELL POSITION:C971(*;"lbHorario";$l_columna;$l_fila)
				
				$l_numeroDia:=$l_Columna-4  //MONO TICKET 202510
				$y_diaOrigen_al:=Get pointer:C304("alSTK_Day"+String:C10($l_numeroDia))
				$y_diaOrigen_at:=Get pointer:C304("atSTK_Day"+String:C10($l_numeroDia))
				$l_recnumCeldaOrigen:=$y_diaOrigen_al->{$l_fila}
				
				If ($l_recnumCeldaOrigen>=0)
					KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaOrigen;False:C215)
					$l_asignarSala:=1
					QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=[TMT_Horario:166]NumeroDia:1;*)
					QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]NumeroHora:2=[TMT_Horario:166]NumeroHora:2;*)
					QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID:15#[TMT_Horario:166]ID:15;*)
					QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Sala:6=[TMT_Salas:167]ID_Sala:1)
					
					If (Records in selection:C76([TMT_Horario:166])>0)
						$l_asignarSala:=CD_Dlog (0;__ ("Esta sala ya está asignada en este horario. ¿Desea asignarla de todas formas?.");"";__ ("Si");__ ("No"))
					End if 
					
					If ($l_asignarSala=1)
						KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaOrigen;True:C214)
						SET QUERY DESTINATION:C396(Into variable:K19:4;$l_NumeroAlumnos)
						EV2_RegistrosDeLaAsignatura ([TMT_Horario:166]ID_Asignatura:5)
						SET QUERY DESTINATION:C396(Into current selection:K19:1)
						If (($l_NumeroAlumnos>[TMT_Salas:167]Capacidad:3) & ([TMT_Salas:167]Capacidad:3>0))
							CD_Dlog (0;__ ("El número de alumnos de la asignatura(^0) sobrepasa la capacidad de la sala (^1) ";String:C10($l_NumeroAlumnos);String:C10([TMT_Salas:167]Capacidad:3)))
						Else 
							[TMT_Horario:166]ID_Sala:6:=[TMT_Salas:167]ID_Sala:1
							[TMT_Horario:166]Sala:8:=[TMT_Salas:167]NombreSala:2
							SAVE RECORD:C53([TMT_Horario:166])
							KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5)
							$t_Nombreprofesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4;->[Profesores:4]Nombre_comun:21)
							$y_diaOrigen_at->{$l_fila}:=TMT_textoBloqueHorario ([Asignaturas:18]Abreviación:26;[Asignaturas:18]Curso:5;[TMT_Horario:166]Sala:8;$t_Nombreprofesor;[TMT_Horario:166]SesionesDesde:12;[TMT_Horario:166]SesionesHasta:13;[TMT_Horario:166]NumeroDia:1)
							KRL_UnloadReadOnly (->[TMT_Horario:166])
						End if 
					End if 
				End if 
				
				
			: (($y_origen=$y_horario) & (OBJECT Get name:C1087="lbHorario"))
				$l_filaHorario:=Drop position:C608($l_columnaHorario)
				LISTBOX GET CELL POSITION:C971(*;"lbHorario";$l_columnaOrigen;$l_filaOrigen)
				$y_diaOrigen_al:=Get pointer:C304("alSTK_Day"+String:C10($l_columnaOrigen-4))  //MONO TICKET 202510
				$l_recnumCeldaOrigen:=$y_diaOrigen_al->{$l_filaOrigen}
				
				$y_diaDestino_al:=Get pointer:C304("alSTK_Day"+String:C10($l_columnaHorario-4))  //MONO TICKET 202510
				$l_recnumCeldaDestino:=$y_diaDestino_al->{$l_filaHorario}
				
				$l_numeroDiaDestino:=$l_columnaHorario-4  //MONO TICKET 202510
				$l_numeroHoraDestino:=aiSTK_Hora{$l_filaHorario}
				
				If ($l_recnumCeldaOrigen#$l_recnumCeldaDestino)
					If ($l_recnumCeldaOrigen>No current record:K29:2)
						$b_AsignacionDesplazada:=TMT_DesplazaAsignacion ($l_recnumCeldaOrigen;$l_recnumCeldaDestino;$l_numeroDiaDestino;$l_numeroHoraDestino;vlSTR_Horario_CicloNumero)
						If ($b_AsignacionDesplazada)
							TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
						End if 
					End if 
				End if 
				
			: ($y_origen=$y_asignaturas)
				$l_filaHorario:=Drop position:C608($l_columnaHorario)
				If ($l_filaHorario>0)
					If (alSTK_RefTipoHora{$l_FilaHorario}=1)
						$l_numeroDia:=$l_ColumnaHorario-4  //MONO TICKET 202510
						$l_numeroHora:=aiSTK_Hora{$l_FilaHorario}
						If (($l_numeroDia>=1) & ($l_numeroHora>=1))
							$l_IdAsignatura:=alSTK_IDSubsectores{$l_elementoArrastre}
							$l_recNumAsignatura:=Find in field:C653([Asignaturas:18]Numero:1;$l_IdAsignatura)
							$h_HoraInicio:=alSTK_Desde{$l_FilaHorario}
							$h_HoraTermino:=alSTK_hasta{$l_FilaHorario}
							PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
							$t_textoError:=TMT_ValidaAsignacion (0;$l_recNumAsignatura;$l_numeroDia;$l_numeroHora;vlSTR_Horario_CicloNumero)
							If ($t_textoError="")
								KRL_GotoRecord (->[TMT_Horario:166];$l_numeroHoraRecNum;False:C215)
								KRL_GotoRecord (->[Asignaturas:18];$l_recNumAsignatura)
								TMT_CargaHorario (vs_SelectedClass;vlSTR_Horario_CicloNumero;b_soloBloquesVigentes)  //MONO TICKET 216065
							Else 
								CD_Dlog (0;$t_textoError)
							End if 
						End if 
					End if 
				End if 
				OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
				
			: ($y_origen=$y_salas)
				$l_filaHorario:=Drop position:C608($l_columnaHorario)
				
				If ((USR_checkRights ("M";->[TMT_Horario:166])) & ($l_columnaHorario>4))  //MONO TICKET 202510
					QUERY:C277([TMT_Salas:167];[TMT_Salas:167]ID_Sala:1=alTMT_Salas_ID{$l_elementoArrastre})
					$l_numeroDia:=$l_columnaHorario-4  //MONO TICKET 202510
					$y_diaHorario_at:=Get pointer:C304("atSTK_Day"+String:C10($l_numeroDia))
					$y_diaHorario_al:=Get pointer:C304("alSTK_Day"+String:C10($l_numeroDia))
					$l_recnumCeldaHorario:=$y_diaHorario_al->{$l_filaHorario}
					
					KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaHorario)
					If ($l_recnumCeldaHorario>No current record:K29:2)
						$l_asignarSala:=1
						QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=[TMT_Horario:166]NumeroDia:1;*)
						QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]NumeroHora:2=[TMT_Horario:166]NumeroHora:2;*)
						QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID:15#[TMT_Horario:166]ID:15;*)
						QUERY:C277([TMT_Horario:166]; & [TMT_Horario:166]ID_Sala:6=[TMT_Salas:167]ID_Sala:1)
						
						If (Records in selection:C76([TMT_Horario:166])>0)
							$l_asignarSala:=CD_Dlog (0;__ ("Esta sala ya está asignada en este horario.\r¿Desea asignarla de todas formas?");"";__ ("Si");__ ("No"))
						End if 
						
						If ($l_asignarSala=1)
							KRL_GotoRecord (->[TMT_Horario:166];$l_recnumCeldaHorario;True:C214)
							SET QUERY DESTINATION:C396(Into variable:K19:4;$l_NumeroAlumnos)
							EV2_RegistrosDeLaAsignatura ([TMT_Horario:166]ID_Asignatura:5)
							SET QUERY DESTINATION:C396(Into current selection:K19:1)
							If (($l_NumeroAlumnos>[TMT_Salas:167]Capacidad:3) & ([TMT_Salas:167]Capacidad:3>0))
								CD_Dlog (0;__ ("El número de alumnos de la asignatura(^0) sobrepasa la capacidad de la sala (^1) ";String:C10($l_NumeroAlumnos);String:C10([TMT_Salas:167]Capacidad:3)))
							Else 
								[TMT_Horario:166]ID_Sala:6:=[TMT_Salas:167]ID_Sala:1
								[TMT_Horario:166]Sala:8:=[TMT_Salas:167]NombreSala:2
								SAVE RECORD:C53([TMT_Horario:166])
								QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[TMT_Horario:166]ID_Asignatura:5)
								$t_Nombreprofesor:=KRL_GetTextFieldData (->[Profesores:4]Numero:1;->[Asignaturas:18]profesor_numero:4;->[Profesores:4]Nombre_comun:21)
								$y_diaHorario_at->{$l_filaHorario}:=TMT_textoBloqueHorario ([Asignaturas:18]Abreviación:26;[Asignaturas:18]Curso:5;[TMT_Horario:166]Sala:8;$t_Nombreprofesor;[TMT_Horario:166]SesionesDesde:12;[TMT_Horario:166]SesionesHasta:13;[TMT_Horario:166]NumeroDia:1)
								KRL_UnloadReadOnly (->[TMT_Horario:166])
							End if 
						End if 
					End if 
				End if 
		End case 
		OBJECT SET VISIBLE:C603(*;"rectanguloSeleccion";False:C215)
		
End case 