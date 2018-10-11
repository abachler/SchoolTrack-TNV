//%attributes = {}
  //AS_validaIngresoEventoCalendari
  //157386
C_BOOLEAN:C305($b_continuar;$asig_seleccion;$b_horaOK)
C_DATE:C307($d_fecha;$d_fechaInicio;$fechaFin;$2)
C_LONGINT:C283($id_evt;$l_ID_asig;$l_numeroDia;$l_cantidadDia;$l_cantidadSemana;$3;$4;$fia;$l_nivel;$i_horas;$l_idAlu;$l_opc)
C_TEXT:C284($t_accion;$1;$5;$curso;vt_textoError;$curso_nombre;$tipo_evento;$t_alumnos;vt_alumnosConflicto)
C_BLOB:C604($vx_Calendario_DiasBloq)

$t_accion:=$1
$d_fecha:=$2
$l_ID_asig:=$3
$b_continuar:=False:C215

If (Count parameters:C259>=4)
	$l_modulo:=$4
Else 
	$l_modulo:=SchoolTrack
End if 

If (Count parameters:C259>=5)
	$tipo_evento:=$5
End if 

READ ONLY:C145([Cursos:3])
READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos:2])

Case of 
	: ($t_accion="validaCalendarioAsig")
		  //MONO Ticket 171875
		If ((<>d_FechaLimiteParaEventosAsig=!00-00-00!) | ($d_fecha<=<>d_FechaLimiteParaEventosAsig) | (USR_IsGroupMember_by_GrpID (-15001)))
			
			ARRAY DATE:C224($ad_fechasBloqueadas;0)
			ARRAY DATE:C224($ad_fechasBloqueadasTEMP;0)
			ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
			ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
			ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)
			ARRAY LONGINT:C221($al_HoraDesde;0)
			ARRAY LONGINT:C221($al_HoraHasta;0)
			
			ARRAY TEXT:C222($at_cursos_alu_asig;0)
			ARRAY TEXT:C222($at_cursos_dia_bloqueado;0)
			
			$asig_seleccion:=KRL_GetBooleanFieldData (->[Asignaturas:18]Numero:1;->$l_ID_asig;->[Asignaturas:18]Seleccion:17)
			
			If ($asig_seleccion)
				  //Si es grupal debemos buscar todos los cursos de los alumnos inscritos para hacer la validación
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_ID_asig)
				KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@")
				KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
				AT_DistinctsFieldValues (->[Alumnos:2]curso:20;->$at_cursos_alu_asig)
				For ($n_cursos;1;Size of array:C274($at_cursos_alu_asig))
					$curso_nombre:=$at_cursos_alu_asig{$n_cursos}
					SET BLOB SIZE:C606($vx_Calendario_DiasBloq;0)
					$vx_Calendario_DiasBloq:=KRL_GetBlobFieldData (->[Cursos:3]Curso:1;->$curso_nombre;->[Cursos:3]xCalendario_DiasBloq:48)
					BLOB_Blob2Vars (->$vx_Calendario_DiasBloq;0;->$ad_fechasBloqueadasTEMP)
					For ($n_dias;1;Size of array:C274($ad_fechasBloqueadasTEMP))
						$fia:=Find in array:C230($ad_fechasBloqueadas;$ad_fechasBloqueadasTEMP{$n_dias})
						If ($fia=-1)
							APPEND TO ARRAY:C911($ad_fechasBloqueadas;$ad_fechasBloqueadasTEMP{$n_dias})
							APPEND TO ARRAY:C911($at_cursos_dia_bloqueado;$curso_nombre)
						Else 
							$at_cursos_dia_bloqueado{$fia}:=$at_cursos_dia_bloqueado{$fia}+";"+$curso_nombre
						End if 
					End for 
					
				End for 
				
			Else 
				
				$curso:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_ID_asig;->[Asignaturas:18]Curso:5)
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
				BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
				
			End if 
			
			$l_pos:=Find in array:C230($ad_fechasBloqueadas;$d_fecha)
			If ($l_pos=-1)
				$b_continuar:=True:C214
			Else 
				$b_continuar:=False:C215
				If ($l_modulo#SchoolTrack Web Access)
					CD_Dlog (0;"Este día se encuentra bloqueado para el ingreso de eventos.")
				Else 
					vt_textoError:="bloqueado"
				End if 
			End if 
			
		Else 
			
			If ($l_modulo#SchoolTrack Web Access)
				CD_Dlog (0;__ ("El ingreso de Eventos fue bloqueado para después del ^0 en la sección Otras Preferencias.";String:C10(<>d_FechaLimiteParaEventosAsig)))
			Else 
				vt_textoError:="FechaLimiteParaEventosAsig"
			End if 
			$b_continuar:=False:C215
		End if 
		
	: ($t_accion="validaCantidadTipoEvento")  //157382
		
		ARRAY LONGINT:C221($al_idAlumno;0)  //166658
		ARRAY LONGINT:C221($al_evtdia;0)
		ARRAY LONGINT:C221($al_evtsemana;0)
		
		ARRAY TEXT:C222($at_EvtCalTipo;0)
		ARRAY LONGINT:C221($al_EvtCalMaxDay;0)
		ARRAY LONGINT:C221($al_EvtCalMaxWeek;0)
		
		$b_continuar:=True:C214
		
		$l_nivel:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$l_ID_asig;->[Asignaturas:18]Numero_del_Nivel:6)
		
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=$l_nivel)
		BLOB_Blob2Vars (->[xxSTR_Niveles:6]xEventoCalendario:53;0;->$at_EvtCalTipo;->$al_EvtCalMaxDay;->$al_EvtCalMaxWeek)
		
		$fia:=Find in array:C230($at_EvtCalTipo;$tipo_evento)
		
		If ($fia>0)
			
			If (($al_EvtCalMaxDay{$fia}>0) | ($al_EvtCalMaxWeek{$fia}>0))
				  //busco rango de fechas para la semana
				$l_numeroDia:=Day number:C114($d_fecha)
				Case of 
					: ($l_numeroDia=2)
						$d_fechaInicio:=$d_fecha
					: ($l_numeroDia=3)
						$d_fechaInicio:=$d_fecha-1
					: ($l_numeroDia=4)
						$d_fechaInicio:=$d_fecha-2
					: ($l_numeroDia=5)
						$d_fechaInicio:=$d_fecha-3
					: ($l_numeroDia=6)
						$d_fechaInicio:=$d_fecha-4
				End case 
				$fechaFin:=$d_fechaInicio+4
				
				$tipo_evento:=[Asignaturas_Eventos:170]Tipo Evento:7
				$id_evt:=[Asignaturas_Eventos:170]ID_Event:11
				
				PUSH RECORD:C176([Asignaturas_Eventos:170])
				
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_ID_asig)
				ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]NoDeLista:10;>)
				SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$al_idAlumno)
				
				For ($i;1;Size of array:C274($al_idAlumno))
					QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=$al_idAlumno{$i})
					KRL_RelateSelection (->[Asignaturas_Eventos:170]ID_asignatura:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
					QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2>=$d_fechaInicio;*)
					QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Fecha:2<=$fechaFin)
					QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Tipo Evento:7=$tipo_evento)
					If ($id_evt>0)  //validación para evento creado que se está editando
						QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]ID_Event:11#$id_evt)
					End if 
					
					$l_cantidadSemana:=Records in selection:C76([Asignaturas_Eventos:170])
					APPEND TO ARRAY:C911($al_evtsemana;$l_cantidadSemana)
					QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2=$d_fecha)
					$l_cantidadDia:=Records in selection:C76([Asignaturas_Eventos:170])
					APPEND TO ARRAY:C911($al_evtdia;$l_cantidadDia)
					
				End for 
				
				ARRAY LONGINT:C221($al_foundvalues;0)
				  //Validación cantidad díaria
				If ($al_EvtCalMaxDay{$fia}>0)
					$al_evtdia{0}:=$al_EvtCalMaxDay{$fia}
					AT_SearchArray (->$al_evtdia;">=";->$al_foundvalues)
					
					If (Size of array:C274($al_foundvalues)>0)
						
						For ($i;1;Size of array:C274($al_foundvalues))
							$l_idAlu:=$al_idAlumno{$al_foundvalues{$i}}
							$t_alumnos:=$t_alumnos+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlu;->[Alumnos:2]apellidos_y_nombres:40)+" - "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlu;->[Alumnos:2]curso:20)+"\r"
						End for 
						
						
						If ($l_modulo#SchoolTrack Web Access)
							$l_opc:=CD_Dlog (0;"No es posible ingresar el evento."+"\r"+"La cantidad de eventos es superior al máximo autorizado para el ingreso diario.";"";"Continuar";"Detalle Alumnos")
							If ($l_opc=2)
								IT_ShowScrollableText ($t_alumnos;"Alumnos con máximo diario de "+$tipo_evento)
							End if 
						Else 
							vt_textoError:="notienedia"
							vt_alumnosConflicto:=Replace string:C233($t_alumnos;"\r";";")
						End if 
						
						$b_continuar:=False:C215
						
					End if 
					
				End if 
				
				  //Validación de cantidad semanal
				If (($al_EvtCalMaxWeek{$fia}>0) & ($b_continuar))
					$al_evtsemana{0}:=$al_EvtCalMaxWeek{$fia}
					AT_SearchArray (->$al_evtsemana;">=";->$al_foundvalues)
					
					If (Size of array:C274($al_foundvalues)>0)
						
						For ($i;1;Size of array:C274($al_foundvalues))
							$l_idAlu:=$al_idAlumno{$al_foundvalues{$i}}
							$t_alumnos:=$t_alumnos+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlu;->[Alumnos:2]apellidos_y_nombres:40)+" - "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAlu;->[Alumnos:2]curso:20)+"\r"
						End for 
						
						If ($l_modulo#SchoolTrack Web Access)
							$l_opc:=CD_Dlog (0;"No es posible ingresar el evento."+"\r"+"La cantidad de eventos es superior al máximo autorizado para el ingreso semanal.";"";"Continuar";"Detalle Alumnos")
							If ($l_opc=2)
								IT_ShowScrollableText ($t_alumnos;"Alumnos con máximo semanal de "+$tipo_evento)
							End if 
						Else 
							vt_textoError:="notienesemana"
							vt_alumnosConflicto:=Replace string:C233($t_alumnos;"\r";";")
						End if 
						
						$b_continuar:=False:C215
						
					End if 
					
				End if 
				
				REDUCE SELECTION:C351([Asignaturas_Eventos:170];0)
				REDUCE SELECTION:C351([Alumnos:2];0)
				REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)
				POP RECORD:C177([Asignaturas_Eventos:170])
				
			End if 
			
		Else 
			$b_continuar:=True:C214
		End if 
		
		
	: ($t_accion="validaHoraEvento")
		
		ARRAY DATE:C224($ad_fechasBloqueadas;0)
		ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
		
		ARRAY DATE:C224($ad_HorasBloqueadasFechasTemp;0)
		ARRAY TEXT:C222($at_HorasBloqueadasMotivoTemp;0)
		ARRAY LONGINT:C221($al_HoraDesdeTemp;0)
		ARRAY LONGINT:C221($al_HoraHastaTemp;0)
		
		ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
		ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)
		ARRAY LONGINT:C221($al_HoraDesde;0)
		ARRAY LONGINT:C221($al_HoraHasta;0)
		
		ARRAY TEXT:C222($at_cursos_alu_asig;0)
		ARRAY TEXT:C222($at_cursos_dia_bloqueado;0)
		
		$asig_seleccion:=KRL_GetBooleanFieldData (->[Asignaturas:18]Numero:1;->$l_ID_asig;->[Asignaturas:18]Seleccion:17)
		
		If ($asig_seleccion)  //157386
			  //Si es grupal debemos buscar todos los cursos de los alumnos inscritos para hacer la validación
			QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$l_ID_asig)
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@")
			KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
			AT_DistinctsFieldValues (->[Alumnos:2]curso:20;->$at_cursos_alu_asig)
			For ($n_cursos;1;Size of array:C274($at_cursos_alu_asig))
				$curso_nombre:=$at_cursos_alu_asig{$n_cursos}
				SET BLOB SIZE:C606($vx_Calendario_DiasBloq;0)
				$vx_Calendario_DiasBloq:=KRL_GetBlobFieldData (->[Cursos:3]Curso:1;->$curso_nombre;->[Cursos:3]xCalendario_DiasBloq:48)
				BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechasTemp;->$at_HorasBloqueadasMotivoTemp;->$al_HoraDesdeTemp;->$al_HoraHastaTemp)
				
				AT_MergeArrays (->$ad_HorasBloqueadasFechasTemp;->$ad_HorasBloqueadasFechas)
				AT_MergeArrays (->$at_HorasBloqueadasMotivoTemp;->$at_HorasBloqueadasMotivo)
				AT_MergeArrays (->$al_HoraDesdeTemp;->$al_HoraDesde)
				AT_MergeArrays (->$al_HoraHastaTemp;->$al_HoraHasta)
				
			End for 
			
		Else 
			
			$curso:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->$l_ID_asig;->[Asignaturas:18]Curso:5)
			QUERY:C277([Cursos:3];[Cursos:3]Curso:1=$curso)
			BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
			
		End if 
		
		ARRAY LONGINT:C221($DA_Return;0)
		$ad_HorasBloqueadasFechas{0}:=$d_fecha
		AT_SearchArray (->$ad_HorasBloqueadasFechas;"=";->$DA_Return)
		$b_continuar:=True:C214
		
		If (Size of array:C274($DA_Return)>0)
			  //MONO: ticket 165257
			$b_horaOK:=(([Asignaturas_Eventos:170]Hora_Inicio:13#?00:00:00?) & ([Asignaturas_Eventos:170]Hora_Termino:14#?00:00:00?) & ([Asignaturas_Eventos:170]Hora_Inicio:13<[Asignaturas_Eventos:170]Hora_Termino:14))
			
			If ($b_horaOK)
				
				For ($i_horas;1;Size of array:C274($DA_Return))
					If ((([Asignaturas_Eventos:170]Hora_Inicio:13>=$al_HoraDesde{$DA_Return{$i_horas}}) & ([Asignaturas_Eventos:170]Hora_Inicio:13<=$al_HoraHasta{$DA_Return{$i_horas}})) | (([Asignaturas_Eventos:170]Hora_Termino:14>=$al_HoraDesde{$DA_Return{$i_horas}}) & ([Asignaturas_Eventos:170]Hora_Termino:14<=$al_HoraHasta{$DA_Return{$i_horas}})))
						$b_continuar:=False:C215
						$i_horas:=Size of array:C274($DA_Return)
						If ($l_modulo#SchoolTrack Web Access)
							CD_Dlog (0;__ ("El evento está en el rango de una hora bloqueada, cambie la hora del evento e intente nuevamente."))
						Else 
							vt_textoError:="horaBloqueada"
						End if 
					End if 
				End for 
				
			Else 
				$b_continuar:=False:C215
				If ($l_modulo#SchoolTrack Web Access)
					CD_Dlog (0;__ ("Por favor llene las horas del evento, el inicio no puede ser mayor al termino."))
				Else 
					vt_textoError:="horasIngresadasNoValidas"
				End if 
				
			End if 
		Else 
			$b_continuar:=True:C214
		End if 
		
	: ($t_accion="verificaDiaDeClases")
		$l_nivelNumero:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$l_ID_asig;->[Asignaturas:18]Numero_del_Nivel:6)
		PERIODOS_LoadData ($l_nivelNumero)
		$l_posFeriado:=Find in array:C230(adSTR_Calendario_Feriados;$d_fecha)
		If ($l_posFeriado#-1)
			$b_continuar:=False:C215
			If ($l_modulo#SchoolTrack Web Access)
				CD_Dlog (0;__ ("Por favor llene las horas del evento, el inicio no puede ser mayor al termino."))
			Else 
				vt_textoError:="feriado"
			End if 
		Else 
			$b_continuar:=True:C214
		End if 
	: ($t_accion="validaPeriodoNivel")
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=$l_ID_asig)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		$inicio:=adSTR_Periodos_Desde{1}
		$final:=adSTR_Periodos_Hasta{Size of array:C274(adSTR_Periodos_Hasta)}
		If ($inicio<=$d_fecha) & ($final>=$d_fecha)
			$b_continuar:=True:C214
		Else 
			$b_continuar:=False:C215
			If ($l_modulo#SchoolTrack Web Access)
				
			Else 
				vt_textoError:="noClases"
			End if 
		End if 
End case 

$0:=$b_continuar