//%attributes = {}
C_POINTER:C301($1;$2;$3;$y_refJson)
C_POINTER:C301($field_literal_Ptr;$field_real_Ptr;$field_nota_Ptr;$field_puntos_Ptr;$field_simbolo_Ptr;$ppPtr;$arrPtr)
C_BOOLEAN:C305($0)
C_REAL:C285($real)
C_TEXT:C284($t_refJson)

$y_Names:=$1
$y_data:=$2

$y_refJson:=$3
  //$t_refJson:=$y_refJson->

$0:=True:C214
$dataType:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipo")
EVS_initialize 
PERIODOS_Init 
$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
$userID:=STWA2_Session_GetUserSTID ($uuid)
$profID:=STWA2_Session_GetProfID ($uuid)
$userName:=USR_GetUserName ($userID)
Case of 
	: ($dataType="cambiofechaevento")
		$id:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idevent"))
		$d:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"d"))
		$m:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"m"))
		$a:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"a"))
		$fecha:=DT_GetDateFromDayMonthYear ($d;$m;$a)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas_Eventos:170]ID_Event:11;->$id;True:C214)
		KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_Eventos:170]ID_asignatura:1;False:C215)
		
		$tipoEvento:=[Asignaturas_Eventos:170]Tipo Evento:7
		$permisocrear:=(USR_checkRights ("M";->[Asignaturas:18];$userID)) | ([Asignaturas:18]profesor_numero:4=$profID) | ([Asignaturas:18]profesor_firmante_numero:33=$profID)  //20150824 ASM Ticket 149033  Realizo validaciones
		
		  //ASM Ticket 214980 
		If ($permisocrear)
			$b_continuar:=AS_validaIngresoEventoCalendari ("validaCalendarioAsig";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
			If ($b_continuar)
				$b_continuar:=AS_validaIngresoEventoCalendari ("validaCantidadTipoEvento";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access;$tipoEvento)
				If ($b_continuar)
					AS_validaIngresoEventoCalendari ("verificaDiaDeClases";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
					If ($b_continuar)
						AS_validaIngresoEventoCalendari ("validaHoraEvento";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
						If ($b_continuar)
							AS_validaIngresoEventoCalendari ("validaPeriodoNivel";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
						End if 
					End if 
				End if 
				If ($b_continuar)
					[Asignaturas_Eventos:170]Fecha:2:=$fecha
					SAVE RECORD:C53([Asignaturas_Eventos:170])
					Log_RegisterEvtSTW ("Edición de evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";$userID)
					OB_SET_Text ($y_refjson->;String:C10([Asignaturas_Eventos:170]ID_Event:11);"idevento")
				Else 
					OB_SET_Text ($y_refjson->;vt_textoError;"permiso")
				End if 
			Else 
				  //validaCalendarioAsig=false // dia bloqueado o fecha limite de evento activada.
				OB_SET ($y_refjson->;->vt_textoError;"permiso")
				If (vt_textoError="FechaLimiteParaEventosAsig")
					$t_msjerror:=__ ("El ingreso de Eventos fue bloqueado para después del ^0 en la sección Otras Preferencias.")
					$t_msjerror:=Replace string:C233($t_msjerror;"^0";String:C10(<>d_FechaLimiteParaEventosAsig))
				Else 
					$t_msjerror:=""
				End if 
				OB_SET ($y_refjson->;->$t_msjerror;"mensaje_error")
			End if 
			
		Else 
			OB_SET_Text ($y_refjson->;"notiene";"permiso")
		End if 
		KRL_UnloadReadOnly (->[Asignaturas_Eventos:170])
		
	: ($dataType="eventocalendario")
		$rn_Asignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAsig"))
		$id:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idevent"))
		$d:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"d"))
		$m:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"m"))
		$a:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"a"))
		$fecha:=DT_GetDateFromDayMonthYear ($d;$m;$a)
		
		$publicar:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"publicar")="true")
		$privado:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"privado")="true")
		$tipoEvento:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipoevento")
		$evento:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"evento")
		$descripcion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"descripcion")
		$hora_desde:=Time:C179(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"hora_desde"))
		$hora_hasta:=Time:C179(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"hora_hasta"))
		
		  //20150824 ASM Ticket 149033  Realizo validaciones
		KRL_GotoRecord (->[Asignaturas:18];$rn_Asignatura;False:C215)
		C_LONGINT:C283($pos)
		PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
		$pos:=Find in array:C230(adSTR_Calendario_Feriados;$fecha)
		$permisocrear:=(USR_checkRights ("M";->[Asignaturas:18];$userID)) | ([Asignaturas:18]profesor_numero:4=$profID) | ([Asignaturas:18]profesor_firmante_numero:33=$profID)
		If ($pos=-1)
			If (DateIsValid ($fecha;0))  // 20180712 ASM Ticket 211957
				If ($permisocrear)
					If (KRL_GotoRecord (->[Asignaturas:18];$rn_Asignatura;False:C215))
						C_TEXT:C284(vt_textoError)
						vt_textoError:=""
						$b_continuar:=AS_validaIngresoEventoCalendari ("validaCalendarioAsig";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
						If (($b_continuar) | ($id#-1))
							If ($id=-1)
								CREATE RECORD:C68([Asignaturas_Eventos:170])
								  //20160425 ASM Ticket 159796
								[Asignaturas_Eventos:170]ID_asignatura:1:=[Asignaturas:18]Numero:1
								[Asignaturas_Eventos:170]ID_Profesor:8:=[Asignaturas:18]profesor_numero:4
							Else 
								KRL_FindAndLoadRecordByIndex (->[Asignaturas_Eventos:170]ID_Event:11;->$id;True:C214)
							End if 
							[Asignaturas_Eventos:170]UserID:10:=$userID
							[Asignaturas_Eventos:170]Fecha:2:=$fecha
							[Asignaturas_Eventos:170]Publicar:5:=$publicar
							[Asignaturas_Eventos:170]Privado:9:=$privado
							[Asignaturas_Eventos:170]Tipo Evento:7:=$tipoEvento
							[Asignaturas_Eventos:170]Evento:3:=$evento
							[Asignaturas_Eventos:170]Descripción:4:=$descripcion
							[Asignaturas_Eventos:170]Hora_Inicio:13:=$hora_desde
							[Asignaturas_Eventos:170]Hora_Termino:14:=$hora_hasta
							
							
							  //MONO 157386 - 157382
							  //$continuar:=AS_validaIngresoEventoCalendari ("validaCantidadTipoEvento";$fecha;[Asignaturas]Numero;SchoolTrack Web Access;$tipoEvento)
							  //$continuar:=($continuar & AS_validaIngresoEventoCalendari ("verificaDiaDeClases";$fecha;[Asignaturas]Numero;SchoolTrack Web Access))
							  //$continuar:=($continuar & AS_validaIngresoEventoCalendari ("validaHoraEvento";$fecha;[Asignaturas]Numero;SchoolTrack Web Access))
							  //$continuar:=($continuar & AS_validaIngresoEventoCalendari ("validaPeriodoNivel";$fecha;[Asignaturas]Numero;SchoolTrack Web Access))
							
							  //ASM ticket 214980
							$continuar:=AS_validaIngresoEventoCalendari ("validaCalendarioAsig";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
							If ($continuar)
								$continuar:=AS_validaIngresoEventoCalendari ("validaCantidadTipoEvento";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access;$tipoEvento)
								If ($continuar)
									AS_validaIngresoEventoCalendari ("verificaDiaDeClases";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
									If ($continuar)
										AS_validaIngresoEventoCalendari ("validaHoraEvento";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
										If ($continuar)
											AS_validaIngresoEventoCalendari ("validaPeriodoNivel";$fecha;[Asignaturas:18]Numero:1;SchoolTrack Web Access)
										End if 
									End if 
								End if 
								
								If ($continuar)
									SAVE RECORD:C53([Asignaturas_Eventos:170])
									If ($id=-1)
										Log_RegisterEvtSTW ("Nuevo evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";$userID)
									Else 
										Log_RegisterEvtSTW ("Edición de evento en calendario para "+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+": ["+String:C10([Asignaturas_Eventos:170]Fecha:2;7)+", "+[Asignaturas_Eventos:170]Evento:3+"]";$userID)
									End if 
									OB_SET_Text ($y_refjson->;String:C10([Asignaturas_Eventos:170]ID_Event:11);"idevento")
									KRL_UnloadReadOnly (->[Asignaturas_Eventos:170])
								Else 
									OB_SET ($y_refjson->;->vt_textoError;"permiso")
									OB_SET ($y_refjson->;->vt_alumnosConflicto;"alumnosConflicto")
								End if 
								
							Else 
								  //validaCalendarioAsig=false // dia bloqueado o fecha limite de evento activada.
								OB_SET ($y_refjson->;->vt_textoError;"permiso")
								If (vt_textoError="FechaLimiteParaEventosAsig")
									$t_msjerror:=__ ("El ingreso de Eventos fue bloqueado para después del ^0 en la sección Otras Preferencias.")
									$t_msjerror:=Replace string:C233($t_msjerror;"^0";String:C10(<>d_FechaLimiteParaEventosAsig))
								Else 
									$t_msjerror:=""
								End if 
								OB_SET ($y_refjson->;->$t_msjerror;"mensaje_error")
							End if 
						Else 
							$0:=False:C215
						End if 
					Else 
						OB_SET_Text ($y_refjson->;"notiene";"permiso")
					End if 
				Else 
					OB SET:C1220($y_refjson->;"permiso";"noClases")
				End if 
			Else 
				OB_SET_Text ($y_refjson->;"noClases";"permiso")
			End if 
			
		Else 
			vt_textoError:="feriado"
			OB SET:C1220($y_refjson->;"permiso";"feriado")
		End if 
	: ($dataType="visitaenfermeria")
		C_OBJECT:C1216($ob_afeccion)
		$ob_afeccion:=OB_Create 
		
		$id:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"id"))
		$idAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idAlumno"))
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$horavisita:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"horavisita")
		$procedencia:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"procedencia")
		$fueradehorario:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fueradehorario")="true")
		$autorizador:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"autorizador"))
		$afeccion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"afeccion")
		$ob_afeccion:=OB_JsonToObject (NV_GetValueFromPairedArrays ($y_Names;$y_Data;"afeccionOB"))
		$tratamiento:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tratamiento")
		$obs_interna:=ST_ClearExtraCR (NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obsinterna"))
		$obs:=ST_ClearExtraCR (NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs"))
		$horasalida:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"horasalida")
		$destino:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"destino")
		$recomendaciones:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"recomendaciones")
		$evolucion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"evolucion")
		$medicamentos:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"medicamentos")
		$derivacion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"derivacion")
		
		C_LONGINT:C283($l_userID)  //20180122 RCH Ticket 197769
		$l_userID:=STWA2_Session_GetUserSTID ($uuid)
		If ($l_userID>0)  //si es usuario de la base, se busca prof id
			$l_userID:=STWA2_Session_GetProfID ($uuid)
		End if 
		
		ARRAY TEXT:C222($recs;0)
		JSON PARSE ARRAY:C1219($recomendaciones;$recs)
		
		  // Modificado por: Alexis Bustamante (10-06-2017)
		  //TICKET 179869
		
		  //JSON GET CHILD NODES ($root;$nodes;$types;$names)
		  //For ($i;1;Size of array($nodes))
		  //$node:=JSON Get child by position ($root;$i)
		  //$recom:=JSON Get text ($node)
		  //APPEND TO ARRAY($recs;$recom)
		  //End for 
		  //JSON CLOSE ($root)  //20150421 RCH Se agrega cierre
		
		
		$recomendaciones:=AT_array2text (->$recs)
		$fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		
		
		
		
		If (KRL_GotoRecord (->[Alumnos:2];$idAlumno;False:C215))
			$fueraAutomatico:=True:C214
			READ ONLY:C145([Profesores:4])
			READ ONLY:C145([TMT_Horario:166])
			READ ONLY:C145([Asignaturas:18])
			EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
			If (Records in selection:C76([Alumnos_Calificaciones:208])>0)
				KRL_RelateSelection (->[TMT_Horario:166]ID_Asignatura:5;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			End if 
			$idProfAutoriza:=0
			If (Records in selection:C76([TMT_Horario:166])>0)
				  //busqueda de los registros de horario para la fecha de la visita e enfermeria
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]SesionesDesde:12<=$fecha;*)
				QUERY SELECTION:C341([TMT_Horario:166]; & ;[TMT_Horario:166]SesionesHasta:13>=$fecha)
				  //ABK en las tres lineas que siguen se busca el horario para el día y la hora
				QUERY SELECTION:C341([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=(Day number:C114($fecha)-1);*)
				QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Desde:3<=Time:C179($horavisita);*)
				QUERY SELECTION:C341([TMT_Horario:166]; & [TMT_Horario:166]Hasta:4>=Time:C179($horavisita))
				  //ABK: recuperación de la información de asignatura y profesor
				If (Records in selection:C76([TMT_Horario:166])>0)
					$asignatura:=KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]denominacion_interna:16)
					$idProfAsig:=KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[TMT_Horario:166]ID_Asignatura:5;->[Asignaturas:18]profesor_numero:4)
					$idProfAutoriza:=$idProfAsig
					$fuera:=False:C215
				Else 
					$fuera:=True:C214
				End if 
			Else 
				$fuera:=True:C214
				$fueraAutomatico:=False:C215
			End if 
			If ($autorizador>-1)
				KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->$autorizador)
				$idProfAutoriza:=[Profesores:4]Numero:1
			End if 
			If ($id=-1)
				CREATE RECORD:C68([Alumnos_EventosEnfermeria:14])
				[Alumnos_EventosEnfermeria:14]Alumno_Numero:1:=[Alumnos:2]numero:1
				[Alumnos_EventosEnfermeria:14]Fecha:2:=$fecha
				[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3:=Time:C179($horavisita)
				[Alumnos_EventosEnfermeria:14]Procedencia:4:=$procedencia
				[Alumnos_EventosEnfermeria:14]OB_evolucion:21:=OB_Create 
				[Alumnos_EventosEnfermeria:14]OB_evolucion:21:=OB_JsonToObject ($evolucion;"evolucion")
				[Alumnos_EventosEnfermeria:14]OB_medicamentos:22:=OB_Create 
				[Alumnos_EventosEnfermeria:14]OB_medicamentos:22:=OB_JsonToObject ($medicamentos;"medicamentos")
				[Alumnos_EventosEnfermeria:14]OB_derivacion:23:=OB_Create 
				[Alumnos_EventosEnfermeria:14]OB_derivacion:23:=OB_JsonToObject ($derivacion;"derivacion")
				If ($fueraAutomatico)
					[Alumnos_EventosEnfermeria:14]Fuera_de_horario:14:=$fuera
					If ($fuera)
						[Alumnos_EventosEnfermeria:14]Asignatura:11:=""
						[Alumnos_EventosEnfermeria:14]ID_Profesor:12:=0
					Else 
						[Alumnos_EventosEnfermeria:14]Asignatura:11:=$asignatura
						[Alumnos_EventosEnfermeria:14]ID_Profesor:12:=$idProfAsig
					End if 
				Else 
					[Alumnos_EventosEnfermeria:14]Fuera_de_horario:14:=($fueradehorario=1)
					[Alumnos_EventosEnfermeria:14]Asignatura:11:=""
					[Alumnos_EventosEnfermeria:14]ID_Profesor:12:=0
				End if 
				[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13:=$idProfAutoriza
				  //[Alumnos_EventosEnfermeria]ID_ProfesorIngresa:=$profID
				[Alumnos_EventosEnfermeria:14]ID_ProfesorIngresa:16:=$l_userID  //20180122 RCH Ticket 197769
				[Alumnos_EventosEnfermeria:14]Afeccion:6:=$afeccion
				[Alumnos_EventosEnfermeria:14]OB_Afeccion:20:=$ob_afeccion
				[Alumnos_EventosEnfermeria:14]Tratamiento:7:=$tratamiento
				[Alumnos_EventosEnfermeria:14]obs_privada:18:=$obs_interna
				[Alumnos_EventosEnfermeria:14]Observaciones:10:=$obs
				[Alumnos_EventosEnfermeria:14]Hora_de_Salida:8:=Time:C179($horasalida)
				[Alumnos_EventosEnfermeria:14]Destino:9:=$destino
				[Alumnos_EventosEnfermeria:14]Recomendaciones:17:=$recomendaciones
				SAVE RECORD:C53([Alumnos_EventosEnfermeria:14])
				Log_RegisterEvtSTW ("Se crea evento de enfermería para el alumno:  "+[Alumnos:2]Apellido_materno:4;$userID)
				If (Application version:C493<"15@")
					  //json_AddText($y_refjson;ST_Qte (String(Record number([Alumnos_EventosEnfermeria])));ST_Qte ("idvisita"))
				Else 
					OB_SET_Text ($y_refjson->;String:C10(Record number:C243([Alumnos_EventosEnfermeria:14]));"idvisita")
				End if 
				KRL_UnloadReadOnly (->[Alumnos_EventosEnfermeria:14])
			Else 
				If (KRL_GotoRecord (->[Alumnos_EventosEnfermeria:14];$id;True:C214))
					[Alumnos_EventosEnfermeria:14]Fecha:2:=$fecha
					[Alumnos_EventosEnfermeria:14]Hora_de_Ingreso:3:=Time:C179($horavisita)
					[Alumnos_EventosEnfermeria:14]Procedencia:4:=$procedencia
					[Alumnos_EventosEnfermeria:14]OB_evolucion:21:=OB_Create 
					[Alumnos_EventosEnfermeria:14]OB_evolucion:21:=OB_JsonToObject ($evolucion;"evolucion")
					[Alumnos_EventosEnfermeria:14]OB_medicamentos:22:=OB_Create 
					[Alumnos_EventosEnfermeria:14]OB_medicamentos:22:=OB_JsonToObject ($medicamentos;"medicamentos")
					[Alumnos_EventosEnfermeria:14]OB_derivacion:23:=OB_Create 
					[Alumnos_EventosEnfermeria:14]OB_derivacion:23:=OB_JsonToObject ($derivacion;"derivacion")
					If ($fueraAutomatico)
						[Alumnos_EventosEnfermeria:14]Fuera_de_horario:14:=$fuera
						If ($fuera)
							[Alumnos_EventosEnfermeria:14]Asignatura:11:=""
							[Alumnos_EventosEnfermeria:14]ID_Profesor:12:=0
						Else 
							[Alumnos_EventosEnfermeria:14]Asignatura:11:=$asignatura
							[Alumnos_EventosEnfermeria:14]ID_Profesor:12:=$idProfAsig
						End if 
					Else 
						[Alumnos_EventosEnfermeria:14]Fuera_de_horario:14:=($fueradehorario=1)
						[Alumnos_EventosEnfermeria:14]Asignatura:11:=""
						[Alumnos_EventosEnfermeria:14]ID_Profesor:12:=0
					End if 
					[Alumnos_EventosEnfermeria:14]OB_Afeccion:20:=$ob_afeccion
					[Alumnos_EventosEnfermeria:14]ID_Profesor_Autoriza:13:=$idProfAutoriza
					  //[Alumnos_EventosEnfermeria]ID_ProfesorIngresa:=$profID
					  //20180502 ASM Ticket 205641 se debe ingresar el profesor solo cuando se crea, no al editar. 
					  //[Alumnos_EventosEnfermeria]ID_ProfesorIngresa:=$l_userID  //20180122 RCH Ticket 197769
					[Alumnos_EventosEnfermeria:14]Afeccion:6:=$afeccion
					[Alumnos_EventosEnfermeria:14]Tratamiento:7:=$tratamiento
					[Alumnos_EventosEnfermeria:14]obs_privada:18:=$obs_interna
					[Alumnos_EventosEnfermeria:14]Observaciones:10:=$obs
					[Alumnos_EventosEnfermeria:14]Hora_de_Salida:8:=Time:C179($horasalida)
					[Alumnos_EventosEnfermeria:14]Destino:9:=$destino
					[Alumnos_EventosEnfermeria:14]Recomendaciones:17:=$recomendaciones
					SAVE RECORD:C53([Alumnos_EventosEnfermeria:14])
					Log_RegisterEvtSTW ("edición de evento de enfermería para el alumno:  "+[Alumnos:2]Apellido_materno:4;$userID)
					If (Application version:C493<"15@")
						  //json_AddText($y_refjson;ST_Qte (String(Record number([Alumnos_EventosEnfermeria])));ST_Qte ("idvisita"))
					Else 
						OB_SET_Text ($y_refjson->;String:C10(Record number:C243([Alumnos_EventosEnfermeria:14]));"idvisita")
					End if 
					KRL_UnloadReadOnly (->[Alumnos_EventosEnfermeria:14])
				Else 
					  //ERROR
				End if 
			End if 
		Else 
			  //ERROR
		End if 
		
	: ($dataType="profsesiones")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$sel:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"sel")
		$nuevoprof:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"nuevoprof"))
		If (KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$rn;False:C215))
			$go:=True:C214
			If ($nuevoprof=-1)
				$nuevoprof:=0
				$profNombre:=""
			Else 
				If (KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->$nuevoprof;False:C215)>-1)
					$profNombre:=[Profesores:4]Nombre_comun:21
				Else 
					$go:=False:C215
				End if 
			End if 
			If ($go)
				$d_fechaSesion:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
				KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;False:C215)
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				Case of 
					: ($sel="hoy")
						QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9)
						APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=$profNombre)
						APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=$nuevoprof)
						Log_RegisterEvtSTW ("Profesor "+ST_Qte ($profNombre)+" asignado a la sesión del día: "+String:C10($d_fechaSesion)+", para la asignatura: "+[Asignaturas:18]denominacion_interna:16+", del curso "+[Asignaturas:18]Curso:5+", asignatura id: "+String:C10([Asignaturas:18]Numero:1)+".";$userID)
					: ($sel="anteriores")
						QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=vdSTR_Periodos_InicioEjercicio;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9)
						APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=$profNombre)
						APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=$nuevoprof)
						Log_RegisterEvtSTW ("Profesor "+ST_Qte ($profNombre)+" asignado a la sesión del día "+String:C10($d_fechaSesion)+" o anterior, para la asignatura: "+[Asignaturas:18]denominacion_interna:16+", del curso "+[Asignaturas:18]Curso:5+", asignatura id: "+String:C10([Asignaturas:18]Numero:1)+".";$userID)
					: ($sel="posteriores")
						QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<=vdSTR_Periodos_FinEjercicio;*)
						QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9=[Asignaturas_RegistroSesiones:168]Ciclo_Numero:9)
						APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_Nombre:11:=$profNombre)
						APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10:=$nuevoprof)
						Log_RegisterEvtSTW ("Profesor "+ST_Qte ($profNombre)+" asignado a la sesión del día "+String:C10($d_fechaSesion)+" o posterior, para la asignatura: "+[Asignaturas:18]denominacion_interna:16+", del curso "+[Asignaturas:18]Curso:5+", asignatura id: "+String:C10([Asignaturas:18]Numero:1)+".";$userID)
				End case 
				ARRAY LONGINT:C221($arnsAfectadas;0)
				LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$arnsAfectadas;"")
				If (Application version:C493<"15@")
					  //STWA2_json_array2json($json;->$arnsAfectadas;"afectadas";"#########")
				Else 
					OB_SET ($y_refjson->;->$arnsAfectadas;"afectadas")
				End if 
			Else 
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
		End if 
		  //
	: ($dataType="guardarjustificacion")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs")
		$just:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"justificacion")
		$todas:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"todas")="true")
		If (KRL_GotoRecord (->[Asignaturas_Inasistencias:125];$rn;True:C214))
			[Asignaturas_Inasistencias:125]Justificacion:3:=$just
			[Asignaturas_Inasistencias:125]Observaciones:5:=$obs
			$idalumno:=[Asignaturas_Inasistencias:125]ID_Alumno:2
			$fecha:=[Asignaturas_Inasistencias:125]dateSesion:4
			SAVE RECORD:C53([Asignaturas_Inasistencias:125])
			KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
			If ($todas=1)
				READ WRITE:C146([Asignaturas_Inasistencias:125])
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=$idalumno;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$fecha)
				APPLY TO SELECTION:C70([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Justificacion:3:=$just)
				APPLY TO SELECTION:C70([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]Observaciones:5:=$obs)
				KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
			End if 
			Log_RegisterEvtSTW ("Se realiza justifición de inasistencias por hora";$userID)
		Else 
			$0:=False:C215
		End if 
	: ($dataType="grabarobservacionsesion")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$profID:=STWA2_Session_GetProfID ($uuid)
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs")
		$idsesion:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idsesion"))
		$estado:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"estado")="true")
		If (KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$idsesion;True:C214)>-1)
			[Asignaturas_RegistroSesiones:168]Impartida:5:=$estado
			[Asignaturas_RegistroSesiones:168]Observacion:12:=$obs
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			Log_RegisterEvtSTW ("Se modifica la sesión: "+String:C10($idsesion);$userID)
			KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
		Else 
			$0:=False:C215
		End if 
	: ($dataType="grabarinasistenciahora")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$profID:=STWA2_Session_GetProfID ($uuid)
		$idalumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idalumno"))
		$idsesion:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idsesion"))
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		READ ONLY:C145([Asignaturas_Inasistencias:125])
		READ ONLY:C145([Asignaturas_RegistroSesiones:168])
		READ ONLY:C145([Asignaturas:18])
		C_TEXT:C284($t_justificacion)
		C_LONGINT:C283($l_idLicencia)
		$fSesion:=KRL_FindAndLoadRecordByIndex (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->$idsesion)
		If ($fSesion>-1)
			$fAsignatura:=KRL_FindAndLoadRecordByIndex (->[Asignaturas:18]Numero:1;->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			If ($fAsignatura>-1)
				$permisocrear:=(USR_checkRights ("M";->[Asignaturas_Inasistencias:125];$userID)) | ([Asignaturas:18]profesor_numero:4=$profID)
				If ($permisocrear)
					  //verifico si existe licencia para el día que se registra la inasistencia
					QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=$idalumno)
					QUERY SELECTION:C341([Alumnos_Licencias:73];[Alumnos_Licencias:73]Desde:2<=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;*)
					QUERY SELECTION:C341([Alumnos_Licencias:73]; & ;[Alumnos_Licencias:73]Hasta:3>=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
					
					If (Records in selection:C76([Alumnos_Licencias:73])>0)
						$t_justificacion:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
						$l_idLicencia:=[Alumnos_Licencias:73]ID:6
						OB_SET_Text ($y_refjson->;"true";"justificada")
					End if 
					
					QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$idsesion;*)
					QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]ID_Alumno:2=$idalumno)
					If (Records in selection:C76([Asignaturas_Inasistencias:125])=0)
						CREATE RECORD:C68([Asignaturas_Inasistencias:125])
						[Asignaturas_Inasistencias:125]ID_Sesión:1:=$idsesion
						[Asignaturas_Inasistencias:125]ID_Alumno:2:=$idalumno
						[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
						[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
						[Asignaturas_Inasistencias:125]Dia:7:=Day number:C114([Asignaturas_Inasistencias:125]dateSesion:4)-1
						[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
						[Asignaturas_Inasistencias:125]Año:11:=<>gYear
						[Asignaturas_Inasistencias:125]Justificacion:3:=$t_justificacion
						[Asignaturas_Inasistencias:125]ID_Licencia:9:=$l_idLicencia
						SAVE RECORD:C53([Asignaturas_Inasistencias:125])
						Log_RegisterEvtSTW ("Asistencia por hora detallada: "+String:C10([Asignaturas_Inasistencias:125]dateSesion:4)+" Inasistencia en la hora "+String:C10([Asignaturas_Inasistencias:125]Hora:8)+" de "+[Asignaturas:18]denominacion_interna:16+" "+[Asignaturas:18]Curso:5+", para "+[Alumnos:2]apellidos_y_nombres:40;$userID)  //20170415 RCH Se cambia de posicion y se deja antes del llamado al siguiente metodo
						AL_InasistenciaDiariaPorHoras ($idalumno;$fecha)
						  //Log_RegisterEvtSTW ("Asistencia por hora detallada: "+String([Asignaturas_Inasistencias]dateSesion)+" Inasistencia en la hora "+String([Asignaturas_Inasistencias]Hora)+" de "+[Asignaturas]Denominación_interna+" "+[Asignaturas]Curso+", para "+[Alumnos]Apellidos_y_Nombres;$userID)
					End if 
				Else 
					$0:=False:C215
				End if 
			Else 
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="eliminarinasistenciahora")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$profID:=STWA2_Session_GetProfID ($uuid)
		$idalumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idalumno"))
		$idsesion:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idsesion"))
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$idsesion)
		QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=[Asignaturas_Inasistencias:125]ID_Sesión:1)
		
		$permisocrear:=(USR_checkRights ("M";->[Asignaturas_Inasistencias:125];$userID)) | ([Asignaturas:18]profesor_numero:4=$profID)
		  //$permisoeliminar:=$permisocrear & STWA2_Priv_GetMethodAccess ("AL_EliminaInasistencia";$userID)
		  //20150804 ASM Para validar los permisos de eliminar inasistencias
		  //$permisoeliminar:=(USR_checkRights ("D";->[Asignaturas_Inasistencias];$userID)) | (([Asignaturas]Profesor_Numero=$profID) & (<>viSTR_NoModificarNotas=0))
		$permisoeliminar:=(USR_checkRights ("D";->[Asignaturas_Inasistencias:125];$userID)) | (([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=$profID) & (<>viSTR_NoModificarNotas=0))  //ASM 20151102 Ticket  151341 
		If ($permisoeliminar)
			
			  //READ WRITE([Asignaturas_Inasistencias])
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$idsesion;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]ID_Alumno:2=$idalumno)
			$isReadWrite:=KRL_LoadRecordLoop (->[Asignaturas_Inasistencias:125];5)
			If ($isReadWrite)
				$d_fechaSesion:=[Asignaturas_Inasistencias:125]dateSesion:4
				$idAlumno:=[Asignaturas_Inasistencias:125]ID_Alumno:2
				$l_numeroDia:=[Asignaturas_Inasistencias:125]Dia:7
				$l_numeroHora:=[Asignaturas_Inasistencias:125]Hora:8
				DELETE RECORD:C58([Asignaturas_Inasistencias:125])
				READ ONLY:C145([Asignaturas_Inasistencias:125])
				AL_InasistenciaDiariaPorHoras ($idalumno;$fecha)
				Log_RegisterEvtSTW ("Inasistencia Eliminada para: "+[Alumnos:2]apellidos_y_nombres:40+" "+[Alumnos:2]curso:20+" Asignatura: "+[Asignaturas:18]denominacion_interna:16+" Día: "+String:C10($l_numeroDia)+" Hora:"+String:C10($l_numeroHora)+" Fecha: "+String:C10($d_fechaSesion);$userID)
			Else 
				Log_RegisterEvtSTW ("La inasistencia no pudo ser eliminadas";$userID)
			End if 
		Else 
			If (Application version:C493<"15@")
				  //json_AddText($y_refjson;ST_Qte ("notiene");ST_Qte ("permiso"))
			Else 
				OB_SET_Text ($y_refjson->;"notiene";"permiso")
			End if 
		End if 
		
		
	: ($dataType="suspension")
		$alus:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alus")
		$motivo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"motivo")
		$obs:=ST_ClearExtraCR (NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs"))
		$prof:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"prof"))
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$dh:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dh"))
		$mh:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"mh"))
		$ah:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ah"))
		$reginasist:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"reginasist")="true")
		$reginasistfutura:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"reginasistfutura")="true")  //MONO Ticket 179808
		
		$fechaDesde:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		$fechaHasta:=DT_GetDateFromDayMonthYear ($dh;$mh;$ah)
		$alus:=Replace string:C233($alus;"null";"-1")
		
		PREF_Set ($userID;"SuspencionCreaInasistencia";String:C10($reginasist))
		PREF_Set ($userID;"SuspencionCreaInasistenciaFutura";String:C10($reginasistfutura))
		
		C_LONGINT:C283($feriados)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$feriados)
		QUERY:C277([xShell_Feriados:71];[xShell_Feriados:71]Fecha:1>=$fechaDesde;*)
		QUERY:C277([xShell_Feriados:71]; & [xShell_Feriados:71]Fecha:1<=$fechaHasta)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		$iDays:=$fechaHasta-$fechaDesde+1-$feriados
		ARRAY LONGINT:C221($al_recNumAlumnos;0)
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		$ob_raiz:=OB_JsonToObject ($alus;"rnAlumnos")
		OB GET ARRAY:C1229($ob_raiz;"rnAlumnos";$al_recNumAlumnos)
		READ ONLY:C145([Alumnos_Suspensiones:12])
		READ ONLY:C145([Alumnos_Inasistencias:10])
		PERIODOS_Init 
		For ($i;1;Size of array:C274($al_recNumAlumnos))
			$rnAlumno:=$al_recNumAlumnos{$i}
			If (KRL_GotoRecord (->[Alumnos:2];$rnAlumno;False:C215))
				
				PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
				KRL_GotoRecord (->[Profesores:4];$prof;False:C215)
				$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Alumnos:2]nivel_numero:29;->[xxSTR_Niveles:6]AttendanceMode:3)
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1)
				QUERY SELECTION:C341([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Fecha:1=$fechaDesde)
				
				If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
					
					If ([Alumnos:2]Fecha_de_Ingreso:41<=$fechaDesde)
						
						CREATE RECORD:C68([Alumnos_Suspensiones:12])
						[Alumnos_Suspensiones:12]Desde:5:=$fechaDesde
						[Alumnos_Suspensiones:12]Hasta:6:=$fechaHasta
						[Alumnos_Suspensiones:12]Alumno_Numero:7:=[Alumnos:2]numero:1
						[Alumnos_Suspensiones:12]Nivel_Numero:10:=[Alumnos:2]nivel_numero:29
						[Alumnos_Suspensiones:12]Motivo:2:=$motivo
						[Alumnos_Suspensiones:12]Días_de_suspensión:3:=$iDays
						[Alumnos_Suspensiones:12]Profesor_Numero:4:=[Profesores:4]Numero:1
						[Alumnos_Suspensiones:12]Observaciones:8:=$obs
						SAVE RECORD:C53([Alumnos_Suspensiones:12])
						Log_RegisterEvtSTW ("Conducta - Registro de Suspensión: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20;$userID)
						
						  //MONO Ticket 179808
						If ((($reginasist=1) | ($reginasistfutura=1)) & ($modoRegistroAsistencia=1))
							$date:=$fechaDesde
							Repeat 
								READ WRITE:C146([Alumnos_Inasistencias:10])
								QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_Suspensiones:12]Alumno_Numero:7;*)
								QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$date)
								If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
									If ((Find in array:C230(adSTR_Calendario_Feriados;$date)=-1) & (DateIsValid ($date;0)))
										If (($date>Current date:C33(*)) & ($reginasistfutura=0))
											$date:=$fechaHasta+1
										Else 
											If (($date<=Current date:C33(*)) | ($reginasistfutura=1))
												CREATE RECORD:C68([Alumnos_Inasistencias:10])
												[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
												[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29
												[Alumnos_Inasistencias:10]Fecha:1:=$date
												[Alumnos_Inasistencias:10]Observaciones:3:="Suspendido por "+$motivo
												SAVE RECORD:C53([Alumnos_Inasistencias:10])
												UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
											End if 
										End if 
									End if 
								End if 
								$date:=$date+1
							Until ($date>$fechaHasta)
							
						End if 
						
					End if 
					
					  //20160725 Ticket 164838
					  //MONO Ticket 179808
					If (($reginasist=1) & ($modoRegistroAsistencia=2))
						KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Suspensiones:12]Alumno_Numero:7)
						CREATE SET:C116([Alumnos_Calificaciones:208];"calificaciones")
						SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IDAsignatura)
						$d_FechaDesde:=[Alumnos_Suspensiones:12]Desde:5
						$d_fechaFinal:=[Alumnos_Suspensiones:12]Hasta:6
						While ($d_FechaDesde<=$d_fechaFinal)
							$dayNumber:=DT_GetDayNumber_ISO8601 ($d_FechaDesde)
							QUERY:C277([TMT_Horario:166];[TMT_Horario:166]NumeroDia:1=$dayNumber)
							QRY_QueryWithArray (->[TMT_Horario:166]ID_Asignatura:5;->$al_IDAsignatura;True:C214)
							SELECTION TO ARRAY:C260([TMT_Horario:166]ID_Asignatura:5;$aIdAsignatura;[TMT_Horario:166]NumeroHora:2;$aNumeroHora;[TMT_Horario:166]SesionesHasta:13;$aDateTo;[TMT_Horario:166]No_Ciclo:14;$aNumeroCiclo)
							For ($i;1;Size of array:C274($aIdAsignatura))
								QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Asignatura:2=$aIdAsignatura{$i};*)
								QUERY:C277([Asignaturas_RegistroSesiones:168]; & ;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$d_FechaDesde)
								If ((Records in selection:C76([Asignaturas_RegistroSesiones:168])=0) & (DateIsValid ($d_FechaDesde;0)))
									ASrs_CreaRegistro ($aIdAsignatura{$i};$aNumeroHora{$i};$aNumeroCiclo{$i};$d_FechaDesde)
								End if 
							End for 
							$d_FechaDesde:=$d_FechaDesde+1
						End while 
						
						USE SET:C118("calificaciones")
						KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
						QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=[Alumnos_Suspensiones:12]Desde:5)
						QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;[Alumnos_Suspensiones:12]Hasta:6)
						
						ARRAY LONGINT:C221($al_RecNums;0)
						LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNums;"")
						For ($i_registros;1;Size of array:C274($al_RecNums))
							GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_RecNums{$i_registros})
							QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos_Suspensiones:12]Alumno_Numero:7;*)
							QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
							If (Records in selection:C76([Asignaturas_Inasistencias:125])=0)
								CREATE RECORD:C68([Asignaturas_Inasistencias:125])
								[Asignaturas_Inasistencias:125]Año:11:=<>gYear
								[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
								[Asignaturas_Inasistencias:125]Dia:7:=[Asignaturas_RegistroSesiones:168]NumeroDia:15
								[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
								[Asignaturas_Inasistencias:125]ID:10:=SQ_SeqNumber (->[Asignaturas_Inasistencias:125]ID:10)
								[Asignaturas_Inasistencias:125]ID_Alumno:2:=[Alumnos_Suspensiones:12]Alumno_Numero:7
								[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
								[Asignaturas_Inasistencias:125]ID_Sesión:1:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
								[Asignaturas_Inasistencias:125]Observaciones:5:="Suspendido por "+$motivo
								SAVE RECORD:C53([Asignaturas_Inasistencias:125])
								UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
							End if 
							AL_InasistenciaDiariaPorHoras ([Alumnos_Suspensiones:12]Alumno_Numero:7;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
						End for 
						$success:=AL_TotalizaInasistencias ([Alumnos_Suspensiones:12]Alumno_Numero:7;[Alumnos:2]nivel_numero:29)
						SET_ClearSets ("calificaciones")
						
					End if 
					
				End if 
				
			End if 
		End for 
		
	: ($dataType="castigo")
		C_OBJECT:C1216($ob_raiz)
		$alus:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alus")
		$motivo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"motivo")
		$obs:=ST_ClearExtraCR (NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs"))
		$prof:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"prof"))
		$horas:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"horas"))
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$fechaDesde:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		$alus:=Replace string:C233($alus;"null";"-1")
		
		ARRAY LONGINT:C221($al_recNumAlumnos;0)
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		$ob_raiz:=OB_JsonToObject ($alus;"rnAlumnos")
		OB GET ARRAY:C1229($ob_raiz;"rnAlumnos";$al_recNumAlumnos)
		
		
		For ($i;1;Size of array:C274($al_recNumAlumnos))
			$rnAlumno:=$al_recNumAlumnos{$i}
			If (KRL_GotoRecord (->[Alumnos:2];$rnAlumno;False:C215))
				KRL_GotoRecord (->[Profesores:4];$prof;False:C215)
				CREATE RECORD:C68([Alumnos_Castigos:9])
				[Alumnos_Castigos:9]Fecha:9:=$fechaDesde
				[Alumnos_Castigos:9]Alumno_Numero:8:=[Alumnos:2]numero:1
				[Alumnos_Castigos:9]Motivo:2:=$motivo
				[Alumnos_Castigos:9]Horas_de_castigo:7:=$horas
				[Alumnos_Castigos:9]Profesor_Numero:6:=[Profesores:4]Numero:1
				[Alumnos_Castigos:9]Observaciones:3:=$obs
				[Alumnos_Castigos:9]Nivel_Numero:11:=[Alumnos:2]nivel_numero:29  // MONO Cambio en el Trigger necesita el numero de nivel del alumno
				SAVE RECORD:C53([Alumnos_Castigos:9])
				Log_RegisterEvtSTW ("Conducta - Registro de Castigo: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20;$userID)
			End if 
		End for 
		
	: ($dataType="anotacion")
		$alus:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alus")
		$motivo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"motivo")
		$obs:=ST_ClearExtraCR (NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs"))
		$prof:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"prof"))
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$asignatura:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"asignatura")
		$fechaDesde:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		$alus:=Replace string:C233($alus;"null";"-1")
		ARRAY LONGINT:C221($al_recNumAlumnos;0)
		C_OBJECT:C1216($ob_raiz)
		$ob_raiz:=OB_Create 
		$ob_raiz:=OB_JsonToObject ($alus;"rnAlumnos")
		OB GET ARRAY:C1229($ob_raiz;"rnAlumnos";$al_recNumAlumnos)
		
		STR_LeePreferenciasConducta 
		For ($i;1;Size of array:C274($al_recNumAlumnos))
			$rnAlumno:=$al_recNumAlumnos{$i}
			If (KRL_GotoRecord (->[Alumnos:2];$rnAlumno;False:C215))
				If ($motivo#"")
					$el:=Find in array:C230(<>atSTR_Anotaciones_motivo;$motivo)
					If ($el>0)
						$el2:=Find in array:C230(aiSTR_IDCategoria;<>aiID_Matriz{$el})
						If ($el2>0)
							Case of 
								: (ai_TipoAnotacion{$el2}>0)
									$tipo:="+"
									$puntaje:=<>aiSTR_Anotaciones_motivo_puntaj{$el}
								: (ai_TipoAnotacion{$el2}=0)
									$tipo:="="
									$puntaje:=0
								: (ai_TipoAnotacion{$el2}<0)
									$tipo:="-"
									$puntaje:=<>aiSTR_Anotaciones_motivo_puntaj{$el}*-1
							End case 
							$categoria:=<>atSTR_Anotaciones_categorias{$el}
							KRL_GotoRecord (->[Profesores:4];$prof;False:C215)
							CREATE RECORD:C68([Alumnos_Anotaciones:11])
							[Alumnos_Anotaciones:11]Fecha:1:=$fechaDesde
							[Alumnos_Anotaciones:11]Alumno_Numero:6:=[Alumnos:2]numero:1
							[Alumnos_Anotaciones:11]Nivel_Numero:13:=[Alumnos:2]nivel_numero:29
							[Alumnos_Anotaciones:11]Motivo:3:=$motivo
							[Alumnos_Anotaciones:11]Profesor_Numero:5:=[Profesores:4]Numero:1
							[Alumnos_Anotaciones:11]Observaciones:4:=$obs
							[Alumnos_Anotaciones:11]Categoria:8:=$categoria
							[Alumnos_Anotaciones:11]Signo:7:=$tipo
							[Alumnos_Anotaciones:11]Puntos:9:=$puntaje
							If ($asignatura#"")
								[Alumnos_Anotaciones:11]Observaciones:4:=$obs+" ("+$asignatura+")"
								[Alumnos_Anotaciones:11]Asignatura:10:=$asignatura
							End if 
							SAVE RECORD:C53([Alumnos_Anotaciones:11])
							Log_RegisterEvtSTW ("Conducta - Registro de anotaciones: "+[Alumnos:2]apellidos_y_nombres:40+" , "+[Alumnos:2]curso:20;$userID)
						End if 
					End if 
				End if 
			End if 
		End for 
		
	: ($dataType="licencia")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAlumno"))
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$dh:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dh"))
		$mh:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"mh"))
		$ah:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ah"))
		$obs:=ST_ClearExtraCR (NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs"))
		$reginasist:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"reginasist")="true")
		$reginasistfuturas:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"reginasistfuturas")="true")  //ASM 20140707 Ticket 134211
		$tipoL:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipoL"))
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$userName:=USR_GetUserName ($userID)
		$fechaDesde:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		$fechaHasta:=DT_GetDateFromDayMonthYear ($dh;$mh;$ah)
		If (KRL_GotoRecord (->[Alumnos:2];$rnAlumno;False:C215))
			$nivelAlumno:=[Alumnos:2]nivel_numero:29
			PERIODOS_Init 
			PERIODOS_LoadData ($nivelAlumno)
			$modoRegistroInasistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivelAlumno;->[xxSTR_Niveles:6]AttendanceMode:3)
			CREATE RECORD:C68([Alumnos_Licencias:73])
			[Alumnos_Licencias:73]ID:6:=SQ_SeqNumber (->[Alumnos_Licencias:73]ID:6)
			[Alumnos_Licencias:73]Tipo_licencia:4:=<>aLicencias{$tipoL}
			[Alumnos_Licencias:73]Fecha_registro:8:=Current date:C33(*)
			[Alumnos_Licencias:73]Desde:2:=$fechaDesde
			[Alumnos_Licencias:73]Hasta:3:=$fechaHasta
			[Alumnos_Licencias:73]Observaciones:5:=$obs
			[Alumnos_Licencias:73]RegistradaPor_Numero:7:=$userID
			[Alumnos_Licencias:73]Alumno_numero:1:=[Alumnos:2]numero:1
			[Alumnos_Licencias:73]Nivel_Numero:10:=$nivelAlumno
			Log_RegisterEvtSTW ("Conducta - Registro de Licencia: "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
			SAVE RECORD:C53([Alumnos_Licencias:73])
			  //If (($reginasist) & ($modoRegistroInasistencia=1))
			If ((($reginasist=1) | ($reginasistfuturas=1)) & ($modoRegistroInasistencia=1))
				Repeat 
					READ ONLY:C145([Alumnos_Inasistencias:10])
					QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_Licencias:73]Alumno_numero:1;*)
					QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$fechaDesde)
					If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
						If ((Find in array:C230(adSTR_Calendario_Feriados;$fechaDesde)=-1) & (DateIsValid ($fechaDesde;0)))
							If (($fechaDesde>Current date:C33(*)) & ($reginasistfuturas#1))
								$fechaDesde:=$fechaHasta+1
							Else 
								If (($fechaDesde<=Current date:C33(*)) | ($reginasistfuturas=1))
									CREATE RECORD:C68([Alumnos_Inasistencias:10])
									[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
									[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29
									[Alumnos_Inasistencias:10]Fecha:1:=$fechaDesde
									[Alumnos_Inasistencias:10]Licencia:5:=[Alumnos_Licencias:73]ID:6
									[Alumnos_Inasistencias:10]Justificación:2:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
									SAVE RECORD:C53([Alumnos_Inasistencias:10])
									UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
								End if 
							End if 
						End if 
					End if 
					$fechaDesde:=$fechaDesde+1
				Until ($fechaDesde>$fechaHasta)
			End if 
			READ WRITE:C146([Alumnos_Inasistencias:10])
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_Licencias:73]Alumno_numero:1;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=[Alumnos_Licencias:73]Desde:2;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=[Alumnos_Licencias:73]Hasta:3)
			If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
				For ($i;1;Records in selection:C76([Alumnos_Inasistencias:10]))
					$isReadWrite:=KRL_LoadRecordLoop (->[Alumnos_Inasistencias:10];5)
					If ($isReadWrite)
						$j:=[Alumnos_Inasistencias:10]Justificación:2
						[Alumnos_Inasistencias:10]Licencia:5:=[Alumnos_Licencias:73]ID:6
						[Alumnos_Inasistencias:10]Justificación:2:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
						If ([Alumnos_Inasistencias:10]Observaciones:3#"")
							[Alumnos_Inasistencias:10]Observaciones:3:=[Alumnos_Inasistencias:10]Observaciones:3+"\r"+[Alumnos_Licencias:73]Observaciones:5
						Else 
							[Alumnos_Inasistencias:10]Observaciones:3:=[Alumnos_Licencias:73]Observaciones:5
						End if 
						SAVE RECORD:C53([Alumnos_Inasistencias:10])
						NEXT RECORD:C51([Alumnos_Inasistencias:10])
					Else 
						BM_CreateRequest ("Justifica Inasistencias";String:C10([Alumnos_Licencias:73]ID:6))
					End if 
				End for 
				KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
			End if 
			READ ONLY:C145([Alumnos:2])
			QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Licencias:73]Alumno_numero:1)
			If ($modoRegistroInasistencia=2)
				READ WRITE:C146([Alumnos_Inasistencias:10])
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos_Licencias:73]Alumno_numero:1;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=[Alumnos_Licencias:73]Desde:2;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4<=[Alumnos_Licencias:73]Hasta:3)
				If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
					For ($i;1;Records in selection:C76([Asignaturas_Inasistencias:125]))
						$isReadWrite:=KRL_LoadRecordLoop (->[Asignaturas_Inasistencias:125];5)
						If ($isReadWrite)
							$j:=[Alumnos_Inasistencias:10]Justificación:2
							[Asignaturas_Inasistencias:125]ID_Licencia:9:=[Alumnos_Licencias:73]ID:6
							[Asignaturas_Inasistencias:125]Justificacion:3:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
							If ([Asignaturas_Inasistencias:125]Observaciones:5#"")
								[Asignaturas_Inasistencias:125]Observaciones:5:=[Alumnos_Inasistencias:10]Observaciones:3+"\r"+[Alumnos_Licencias:73]Observaciones:5
							Else 
								[Alumnos_Inasistencias:10]Observaciones:3:=[Alumnos_Licencias:73]Observaciones:5
							End if 
							SAVE RECORD:C53([Asignaturas_Inasistencias:125])
							NEXT RECORD:C51([Asignaturas_Inasistencias:125])
						Else 
							BM_CreateRequest ("Justifica Inasistencias";String:C10([Alumnos_Licencias:73]ID:6))
						End if 
					End for 
				End if 
				KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
			End if 
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="inasistenciaIndividual")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
		$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
		$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$state:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"state")
		$fecha:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$userName:=USR_GetUserName ($userID)
		If ($state="ausente")
			If (KRL_GotoRecord (->[Alumnos:2];$rn;False:C215))
				READ ONLY:C145([Alumnos_Licencias:73])
				QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
				SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$desde;[Alumnos_Licencias:73]Hasta:3;$hasta;[Alumnos_Licencias:73]ID:6;$lic)
				READ ONLY:C145([Alumnos_Inasistencias:10])
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$fecha)
				If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
					CREATE RECORD:C68([Alumnos_Inasistencias:10])
					[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
					[Alumnos_Inasistencias:10]Nivel_Numero:9:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]nivel_numero:29)
					[Alumnos_Inasistencias:10]Fecha:1:=$fecha
					[Alumnos_Inasistencias:10]RegistradaEl:11:=Current date:C33(*)
					[Alumnos_Inasistencias:10]RegistradaPor:10:=$userName
					For ($jj;1;Size of array:C274($desde))
						If (($fecha>=$desde{$jj}) & ($fecha<=$hasta{$jj}))
							[Alumnos_Inasistencias:10]Licencia:5:=$lic{$jj}
							[Alumnos_Inasistencias:10]Justificación:2:="Licencia Nº "+String:C10($lic{$jj})
							If (Application version:C493<"15@")
								  //json_AddText($y_refjson;ST_Qte (String([Alumnos_Inasistencias]Licencia));ST_Qte ("licencia"))
							Else 
								OB_SET_Text ($y_refjson->;String:C10([Alumnos_Inasistencias:10]Licencia:5);"licencia")
							End if 
							$jj:=Size of array:C274($desde)
						End if 
					End for 
					SAVE RECORD:C53([Alumnos_Inasistencias:10])
					UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
					vb_AsignaSituacionfinal:=True:C214
					AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
					vb_AsignaSituacionfinal:=False:C215
					Log_RegisterEvtSTW ("Conducta - Registro de inasistencia diaria: "+String:C10($fecha;7)+" - "+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20;$userID)
				End if 
			Else 
				$0:=False:C215
			End if 
		Else 
			If (KRL_GotoRecord (->[Alumnos:2];$rn;False:C215))
				READ WRITE:C146([Alumnos_Inasistencias:10])
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$fecha)
				If (KRL_DeleteRecord (->[Alumnos_Inasistencias:10])=0)
					$0:=False:C215
				Else 
					Log_RegisterEvtSTW ("Eliminación de Inasistencia ("+String:C10($fecha;Internal date short special:K1:4)+") para "+[Alumnos:2]apellidos_y_nombres:40;$userID)
					vb_AsignaSituacionfinal:=True:C214
					AL_CalculaSituacionFinal ([Alumnos:2]numero:1)
					vb_AsignaSituacionfinal:=False:C215
				End if 
				KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
			Else 
				$0:=False:C215
			End if 
		End if 
		
	: ($dataType="fechasplan")
		$rnPlan:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnPlan"))
		If (KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$rnPlan;True:C214))
			$dd:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dd"))
			$md:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"md"))
			$ad:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ad"))
			$dh:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"dh"))
			$mh:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"mh"))
			$ah:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ah"))
			$fechaDesde:=DT_GetDateFromDayMonthYear ($dd;$md;$ad)
			$fechaHasta:=DT_GetDateFromDayMonthYear ($dh;$mh;$ah)
			[Asignaturas_PlanesDeClases:169]Desde:3:=$fechaDesde
			[Asignaturas_PlanesDeClases:169]Hasta:4:=$fechaHasta
			SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
			  //MONO 193174
			$t_logmsj:="Planes de Clases: Modificación de fechas plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
			$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
			$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
			Log_RegisterEvtSTW ($t_logmsj;$userID)
			KRL_UnloadReadOnly (->[Asignaturas_PlanesDeClases:169])
		Else 
			$0:=False:C215
		End if 
		  //
		
	: ($dataType="propiedadesURL")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$url:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"url")
		$nombre:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"nombre")
		$descripcion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"descripcion")
		If ($rn=-1)
			$rnPlan:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnPlan"))
			If (KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$rnPlan;False:C215))
				READ ONLY:C145([xShell_Documents:91])
				CREATE RECORD:C68([xShell_Documents:91])
				[xShell_Documents:91]RelatedTable:1:=Table:C252(->[Asignaturas_PlanesDeClases:169])
				[xShell_Documents:91]RelatedID:2:=[Asignaturas_PlanesDeClases:169]ID_Plan:1
				[xShell_Documents:91]RefType:10:="URL"
				[xShell_Documents:91]DocumentType:5:="URL"
				[xShell_Documents:91]URL:11:=$url
				[xShell_Documents:91]DocumentName:3:=$nombre
				[xShell_Documents:91]OriginalPath:12:=""
				[xShell_Documents:91]DocSize:13:=0
				[xShell_Documents:91]DocumentDescription:4:=$descripcion
				[xShell_Documents:91]ApplicationName:6:=""
				SAVE RECORD:C53([xShell_Documents:91])
				Log_RegisterEvtSTW ("Asignaturas PLanes de clases: Se agrea URL :"+$url+" al plan de clase número: "+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1);$userID)
			Else 
				$0:=False:C215
			End if 
		Else 
			If (KRL_GotoRecord (->[xShell_Documents:91];$rn;True:C214))
				[xShell_Documents:91]URL:11:=$url
				[xShell_Documents:91]DocumentName:3:=$nombre
				[xShell_Documents:91]DocumentDescription:4:=$descripcion
				SAVE RECORD:C53([xShell_Documents:91])
				Log_RegisterEvtSTW ("Asignaturas PLanes de clases: Se agrea URL :"+$url+" al plan de clase número: "+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1);$userID)
				KRL_UnloadReadOnly (->[xShell_Documents:91])
			Else 
				$0:=False:C215
			End if 
		End if 
		  //
		
	: ($dataType="propiedadesDOC")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$vinculo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"vinculo")
		$descripcion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"descripcion")
		If (KRL_GotoRecord (->[xShell_Documents:91];$rn;True:C214))
			[xShell_Documents:91]DocumentName:3:=$vinculo
			[xShell_Documents:91]DocumentDescription:4:=$descripcion
			SAVE RECORD:C53([xShell_Documents:91])
			Log_RegisterEvtSTW ("Asignaturas PLanes de clases: Se agrea el documento :"+$vinculo;$userID)
			KRL_UnloadReadOnly (->[xShell_Documents:91])
		Else 
			$0:=False:C215
		End if 
		  //
		
	: ($dataType="contenidosplan")
		$subtipo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"subtipo")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$contenidos:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"contenidos")
		If (KRL_GotoRecord (->[Asignaturas_PlanesDeClases:169];$rn;True:C214))
			Case of 
				: ($subtipo="nombreplan")
					[Asignaturas_PlanesDeClases:169]Nombre:14:=$contenidos
				: ($subtipo="nota")
					[Asignaturas_PlanesDeClases:169]Nota_al_Alumno:6:=$contenidos
				: ($subtipo="objetivo")
					[Asignaturas_PlanesDeClases:169]Objetivos:7:=$contenidos
				: ($subtipo="contenido")
					[Asignaturas_PlanesDeClases:169]Contenidos:8:=$contenidos
				: ($subtipo="actividades")
					[Asignaturas_PlanesDeClases:169]Actividades:9:=$contenidos
				: ($subtipo="otrasreferencias")
					[Asignaturas_PlanesDeClases:169]Referencias:10:=$contenidos
				: ($subtipo="tareas")
					[Asignaturas_PlanesDeClases:169]Tareas:12:=$contenidos
				: ($subtipo="evaluacion")
					[Asignaturas_PlanesDeClases:169]Intrumentos_evaluacion:11:=$contenidos
			End case 
			SAVE RECORD:C53([Asignaturas_PlanesDeClases:169])
			  //MONO 193174
			$t_logmsj:="Planes de Clases: Modificación del plan id :"+String:C10([Asignaturas_PlanesDeClases:169]ID_Plan:1)
			$t_logmsj:=$t_logmsj+" en la asignatura"+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]denominacion_interna:16)+"("+String:C10([Asignaturas_PlanesDeClases:169]ID_Asignatura:2)+") - "
			$t_logmsj:=$t_logmsj+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Asignaturas_PlanesDeClases:169]ID_Asignatura:2;->[Asignaturas:18]Curso:5)
			Log_RegisterEvtSTW ($t_logmsj;$userID)
			KRL_UnloadReadOnly (->[Asignaturas_PlanesDeClases:169])
		Else 
			$0:=False:C215
		End if 
		  //
		
	: ($dataType="contenidossession")
		C_TEXT:C284($t_msglog;$t_cambioContenidos)
		
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$contenidos:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"contenidos")
		$actividades:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"actividades")
		  //ASM 20140611 
		$observaciones:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"observaciones")
		If (KRL_GotoRecord (->[Asignaturas_RegistroSesiones:168];$rn;True:C214))
			[Asignaturas_RegistroSesiones:168]Contenidos:6:=$contenidos
			[Asignaturas_RegistroSesiones:168]Actividades:7:=$actividades
			[Asignaturas_RegistroSesiones:168]Observacion:12:=$observaciones
			
			Case of 
				: (Old:C35([Asignaturas_RegistroSesiones:168]Contenidos:6)#$contenidos)
					$t_cambioContenidos:=__ ("Modificación en el texto de Contenidos")
				: (Old:C35([Asignaturas_RegistroSesiones:168]Actividades:7)#$actividades)
					$t_cambioContenidos:=__ ("Modificación en el texto de Actividades")
				: (Old:C35([Asignaturas_RegistroSesiones:168]Observacion:12)#$observaciones)
					$t_cambioContenidos:=__ ("Modificación en el texto de Observaciones")
					
			End case 
			
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			
			  //20170725 ASM ticket 182804
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			$t_msglog:=__ ("Sesiones de clases: Modificación de contenidos en Sesión de clases  :")+String:C10([Asignaturas_RegistroSesiones:168]ID_Sesion:1)+"\r"+$t_cambioContenidos+"\r"
			$t_msglog:=$t_msglog+__ ("Asignatura: ")+[Asignaturas:18]Asignatura:3+", Asignatura id: "+String:C10([Asignaturas:18]Numero:1)+", "+__ ("Curso: ")+[Asignaturas:18]Curso:5
			Log_RegisterEvtSTW ($t_msglog;$userID)
			KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
		Else 
			$0:=False:C215
		End if 
		  //
		
	: ($dataType="tipoobj")
		$rn_Asignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAsig"))
		$especificos:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"especificos")="true")
		GOTO RECORD:C242([Asignaturas:18];$rn_Asignatura)
		If (KRL_LoadRecordLoop (->[Asignaturas:18];2))
			  //If (KRL_GotoRecord (->[Asignaturas];$rn_Asignatura;True))
			If ([Asignaturas:18]ConObjetivosEspecificos:62#$especificos)
				$prevEspecificos:=[Asignaturas:18]ConObjetivosEspecificos:62
				[Asignaturas:18]ConObjetivosEspecificos:62:=$especificos
				Case of 
					: (([Asignaturas:18]ConObjetivosEspecificos:62) & (Old:C35([Asignaturas:18]ConObjetivosEspecificos:62)))
						[Asignaturas:18]ID_Objetivos:43:=Old:C35([Asignaturas:18]ID_Objetivos:43)
					: (([Asignaturas:18]ConObjetivosEspecificos:62=False:C215) & (Old:C35([Asignaturas:18]ConObjetivosEspecificos:62)=True:C214))
						READ ONLY:C145([Asignaturas_Objetivos:104])
						QUERY:C277([Asignaturas_Objetivos:104];[Asignaturas_Objetivos:104]Nivel_numero:4=[Asignaturas:18]Numero_del_Nivel:6;*)
						QUERY:C277([Asignaturas_Objetivos:104]; & ;[Asignaturas_Objetivos:104]Subsector:2=[Asignaturas:18]Asignatura:3)
						If (Records in selection:C76([Asignaturas_Objetivos:104])>0)
							[Asignaturas:18]ID_Objetivos:43:=[Asignaturas_Objetivos:104]ID:1
						End if 
					: (([Asignaturas:18]ConObjetivosEspecificos:62) & (Not:C34(Old:C35([Asignaturas:18]ConObjetivosEspecificos:62))))
						[Asignaturas:18]ID_Objetivos:43:=0
					: (([Asignaturas:18]ConObjetivosEspecificos:62) & (Old:C35([Asignaturas:18]ConObjetivosEspecificos:62)))
						[Asignaturas:18]ID_Objetivos:43:=Old:C35([Asignaturas:18]ID_Objetivos:43)
				End case 
				SAVE RECORD:C53([Asignaturas:18])
				Log_RegisterEvtSTW ("Asignaturas: Modificación de objetivos, asignatura  :"+String:C10([Asignaturas:18]Asignatura:3);$userID)
			End if 
			$idObjetivos:=[Asignaturas:18]ID_Objetivos:43
			If ($idObjetivos#0)
				$vObj_P1:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P1:6)
				$vObj_P2:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P2:7)
				$vObj_P3:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P3:8)
				$vObj_P4:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P4:9)
				$vObj_P5:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P5:10)
			Else 
				$vObj_P1:=""
				$vObj_P2:=""
				$vObj_P3:=""
				$vObj_P4:=""
				$vObj_P5:=""
			End if 
			If (Application version:C493<"15@")
				  //json_AddText($y_refjson;ST_Qte ($vObj_P1);ST_Qte ("objP1"))
				  //json_AddText($y_refjson;ST_Qte ($vObj_P2);ST_Qte ("objP2"))
				  //json_AddText($y_refjson;ST_Qte ($vObj_P3);ST_Qte ("objP3"))
				  //json_AddText($y_refjson;ST_Qte ($vObj_P4);ST_Qte ("objP4"))
				  //json_AddText($y_refjson;ST_Qte ($vObj_P5);ST_Qte ("objP5"))
			Else 
				OB_SET ($y_refjson->;->$vObj_P1;"objP1")
				OB_SET ($y_refjson->;->$vObj_P2;"objP2")
				OB_SET ($y_refjson->;->$vObj_P3;"objP3")
				OB_SET ($y_refjson->;->$vObj_P4;"objP4")
				OB_SET ($y_refjson->;->$vObj_P5;"objP5")
			End if 
			KRL_UnloadReadOnly (->[Asignaturas:18])
			KRL_UnloadReadOnly (->[Asignaturas_Objetivos:104])
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="objetivoAsig")
		$rn_Asignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAsig"))
		$especificos:=(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"especificos")="true")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$objetivo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"objetivo")
		GOTO RECORD:C242([Asignaturas:18];$rn_Asignatura)
		If (KRL_LoadRecordLoop (->[Asignaturas:18];2))
			  //If (KRL_GotoRecord (->[Asignaturas];$rn_Asignatura;True))
			[Asignaturas:18]ConObjetivosEspecificos:62:=$especificos
			$fieldPtr:=KRL_GetFieldPointerByName ("[Asignaturas_Objetivos]Objetivos_P"+String:C10($periodo))
			$varObjPtr:=Get pointer:C304("vObj_P"+String:C10($periodo))
			$idObjetivos:=[Asignaturas:18]ID_Objetivos:43
			vObj_P1:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P1:6)
			vObj_P2:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P2:7)
			vObj_P3:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P3:8)
			vObj_P4:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P4:9)
			vObj_P5:=KRL_GetTextFieldData (->[Asignaturas_Objetivos:104]ID:1;->$idObjetivos;->[Asignaturas_Objetivos:104]Objetivos_P5:10)
			$varObjPtr->:=$objetivo
			modObjetivos:=True:C214
			AS_GuardaObjetivos 
		Else 
			$0:=False:C215
		End if 
		KRL_UnloadReadOnly (->[Asignaturas:18])
		  //
		
	: ($dataType="infocalificacion")
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$info1:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"info1")
		$info2:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"info2")
		$info3:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"info3")
		If (KRL_GotoRecord (->[xxSTR_InfoCalificaciones:142];$rn;True:C214))
			[xxSTR_InfoCalificaciones:142]Info1:5:=$info1
			[xxSTR_InfoCalificaciones:142]Info2:6:=$info2
			[xxSTR_InfoCalificaciones:142]Info3:7:=$info3
			SAVE RECORD:C53([xxSTR_InfoCalificaciones:142])
		Else 
			$0:=False:C215
		End if 
		KRL_UnloadReadOnly (->[xxSTR_InfoCalificaciones:142])
	: ($dataType="obscat")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$valor:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rn;False:C215))
			$idAsignatura:=[Alumnos_Calificaciones:208]ID_Asignatura:5
			$idAlumno:=[Alumnos_Calificaciones:208]ID_Alumno:6
			ARRAY TEXT:C222($atSTR_ObsEval_Categoria;0)
			ARRAY TEXT:C222($atSTR_ObsEval_Observacion;0)
			ARRAY LONGINT:C221($alSTR_ObsEval_RefObs;0)
			
			ARRAY OBJECT:C1221(ao_obscat;0)
			
			ARRAY TEXT:C222($nodes;0)
			ARRAY LONGINT:C221($types;0)
			ARRAY TEXT:C222($names;0)
			
			
			
			
			C_OBJECT:C1216($ob_objeto;$ob_objetoObs)
			C_TEXT:C284($textoCat;$obs)
			C_LONGINT:C283($idobs)
			If (Valida_json ($valor))
				$ob_objeto:=JSON Parse:C1218($valor)
				ARRAY TEXT:C222($at_Names;0)
				ARRAY LONGINT:C221($al_Types;0)
				OB GET PROPERTY NAMES:C1232($ob_objeto;$at_Names;$al_Types)
				For ($l_indice;1;Size of array:C274($at_Names))
					$ob_objetoObs:=OB Get:C1224($ob_objeto;$at_Names{$l_indice})
					$textoCat:=OB Get:C1224($ob_objetoObs;"textocat")
					$idobs:=Num:C11(OB Get:C1224($ob_objetoObs;"idobs"))  //20180718 ASM Ticket 211873
					$obs:=OB Get:C1224($ob_objetoObs;"obs")
					APPEND TO ARRAY:C911($atSTR_ObsEval_Categoria;$textoCat)
					APPEND TO ARRAY:C911($alSTR_ObsEval_RefObs;$idobs)
					APPEND TO ARRAY:C911($atSTR_ObsEval_Observacion;$obs)
				End for 
			End if 
			
			AT_MultiLevelSort (">>";->$atSTR_ObsEval_Categoria;->$atSTR_ObsEval_Observacion;->$alSTR_ObsEval_RefObs)
			READ WRITE:C146([Alumnos_ObservacionesEvaluacion:30])
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;=;$idAsignatura;*)
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;=;$idAlumno;*)
			QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Periodo:3;=;$periodo)
			DELETE SELECTION:C66([Alumnos_ObservacionesEvaluacion:30])
			For ($i;1;Size of array:C274($atSTR_ObsEval_Categoria))
				CREATE RECORD:C68([Alumnos_ObservacionesEvaluacion:30])
				[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2:=$idAsignatura
				[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1:=$idAlumno
				[Alumnos_ObservacionesEvaluacion:30]Periodo:3:=$periodo
				[Alumnos_ObservacionesEvaluacion:30]Ref_Observacion:10:=$alSTR_ObsEval_RefObs{$i}
				[Alumnos_ObservacionesEvaluacion:30]RegistradaPor:8:=USR_GetUserName ($userID)
				[Alumnos_ObservacionesEvaluacion:30]Categoría:4:=$atSTR_ObsEval_Categoria{$i}
				[Alumnos_ObservacionesEvaluacion:30]Observacion:5:=$atSTR_ObsEval_Observacion{$i}
				SAVE RECORD:C53([Alumnos_ObservacionesEvaluacion:30])
			End for 
			KRL_UnloadReadOnly (->[Alumnos_ObservacionesEvaluacion:30])  //MONO 213584
			AS_SaveObsxCatEnCompEva ($idAlumno;$idAsignatura;$periodo;False:C215)  //MONO 213584
			
		Else 
			$0:=False:C215
		End if 
	: ($dataType="observacionMapas")
		$rnEval:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnEval"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$valor:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		If (KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$rnEval;True:C214))
			Case of 
				: ($periodo=1)
					$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Observaciones:79
				: ($periodo=2)
					$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Observaciones:80
				: ($periodo=3)
					$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Observaciones:81
				: ($periodo=4)
					$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Observaciones:82
				: ($periodo=5)
					$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Observaciones:83
				: ($periodo=-1)
					$y_evaluacionObservaciones:=->[Alumnos_EvaluacionAprendizajes:203]Final_Observaciones:84
			End case 
			$y_evaluacionObservaciones->:=$valor
			SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
			Log_RegisterEvtSTW ("Modificación de observación en Aprendizajes";$userID)
			KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
		Else 
			$0:=False:C215
		End if 
	: ($dataType="indicadorMapas")
		$rnEval:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnEval"))
		$rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))  //esta
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))  //esta
		$tipoEval:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipoeval"))
		$estilo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"estilo"))
		$valor:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")  //LOG
		$userID:=STWA2_Session_GetUserSTID ($uuid)  //LOG
		If (KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$rnEval;True:C214))
			If (KRL_GotoRecord (->[Asignaturas:18];$rnAsig;False:C215))
				PERIODOS_Init 
				PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
				  //MONO CAMBIO AS_PropEval_Lectura
				If ([Asignaturas:18]Consolidacion_PorPeriodo:58)
					AS_PropEval_Lectura ("P"+String:C10($periodo))
				Else 
					AS_PropEval_Lectura ("Anual")
				End if 
				
				$l_recNumMatriz:=Find in field:C653([MPA_AsignaturasMatrices:189]ID_Matriz:1;[Asignaturas:18]EVAPR_IdMatriz:91)
				If (KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatriz;False:C215))
					Case of 
						: ($periodo=1)
							$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoLiteral:13
							$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Real:11
							$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_NativoNumerico:12
							$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo1_Indicador:14
							$y_promedioPeriodoLiteral:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
							$y_promedioPeriodoReal:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
						: ($periodo=2)
							$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoLiteral:25
							$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Real:23
							$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_NativoNumerico:24
							$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo2_Indicador:26
							$y_promedioPeriodoLiteral:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
							$y_promedioPeriodoReal:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
						: ($periodo=3)
							$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoLiteral:37
							$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Real:35
							$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_NativoNumerico:36
							$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo3_Indicador:38
							$y_promedioPeriodoLiteral:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
							$y_promedioPeriodoReal:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
						: ($periodo=4)
							$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoLiteral:49
							$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Real:47
							$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_NativoNumerico:48
							$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo4_Indicador:50
							$y_promedioPeriodoLiteral:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
							$y_promedioPeriodoReal:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
						: ($periodo=5)
							$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoLiteral:66
							$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Real:64
							$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_NativoNumerico:65
							$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Periodo5_Indicador:67
							$y_promedioPeriodoLiteral:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
							$y_promedioPeriodoReal:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
						: ($periodo=-1)
							$y_evaluacionLiteral:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoLiteral:61
							$y_evaluacionReal:=->[Alumnos_EvaluacionAprendizajes:203]Final_Real:59
							$y_evaluacionNumerico:=->[Alumnos_EvaluacionAprendizajes:203]Final_NativoNumerico:60
							$y_evaluacionIndicador:=->[Alumnos_EvaluacionAprendizajes:203]Final_Indicador:62
							
							  //20180131 RCH Ticket 198390
							C_LONGINT:C283($l_nota)
							$l_nota:=-1
							$y_promedioPeriodoLiteral:=->$l_nota
							$y_promedioPeriodoReal:=->$l_nota
							
					End case 
					$y_promedioFinalInternoLiteral:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
					$y_promedioFinalInternoReal:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
					$y_promedioFinalOficialLiteral:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
					$y_promedioFinalOficialReal:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
					
					$b_guardarRegistro:=False:C215
					$b_ejesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10=Eje_Aprendizaje)
					$b_dimensionesIngresables:=([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Dimension_Aprendizaje)
					
					C_OBJECT:C1216($ob_refNodoCompetencias;$ob_refNodoDimension;$ob_refNodoEje)
					$ob_refNodoCompetencias:=OB_Create 
					$ob_refNodoDimension:=OB_Create 
					$ob_refNodoEje:=OB_Create 
					
					
					  //verifico que la "P" no sea de pendiente
					C_POINTER:C301($y_punteroCampoaprend)
					Case of 
						: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
							$y_punteroCampoaprend:=->[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7
						: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
							$y_punteroCampoaprend:=->[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
						: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
							$y_punteroCampoaprend:=->[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
					End case 
					
					ARRAY TEXT:C222($atEVLG_Indicadores_Descripcion;0)
					ARRAY INTEGER:C220($aiEVLG_Indicadores_Valor;0)
					ARRAY TEXT:C222($atEVLG_Indicadores_Concepto;0)
					$l_recNum:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;$y_punteroCampoaprend->)
					KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNum;False:C215)
					BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->$atEVLG_Indicadores_Descripcion;->$aiEVLG_Indicadores_Valor;->$atEVLG_Indicadores_Concepto)
					$index:=Find in array:C230($atEVLG_Indicadores_Concepto;$valor)
					
					
					
					Case of 
							  //: ($valor="*")
							  //$y_evaluacionLiteral->:="*"
							  //$y_evaluacionIndicador->:="No Evaluado"
							  //$y_evaluacionReal->:=-4
							  //$y_evaluacionNumerico->:=0
							  //$b_guardarRegistro:=True
							  //: ($valor="P")
							  //$y_evaluacionLiteral->:="P"
							  //$y_evaluacionIndicador->:="Pendiente"
							  //$y_evaluacionReal->:=-2
							  //$y_evaluacionNumerico->:=0
							  //$b_guardarRegistro:=True
						: ($valor="*") & ($index=-1)
							$y_evaluacionLiteral->:="*"
							$y_evaluacionIndicador->:="No Evaluado"
							$y_evaluacionReal->:=-4
							$y_evaluacionNumerico->:=0
							$b_guardarRegistro:=True:C214
						: ($valor="P") & ($index=-1)
							$y_evaluacionLiteral->:="P"
							$y_evaluacionIndicador->:="Pendiente"
							$y_evaluacionReal->:=-2
							$y_evaluacionNumerico->:=0
							$b_guardarRegistro:=True:C214
						: ($valor="")
							$y_evaluacionLiteral->:=""
							$y_evaluacionIndicador->:=""
							$y_evaluacionReal->:=-10
							$y_evaluacionNumerico->:=-10
							$b_guardarRegistro:=True:C214
						Else 
							
							Case of 
								: ($tipoEval=1)
									Case of 
										: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
											ARRAY TEXT:C222($atEVLG_Indicadores_Descripcion;0)
											ARRAY INTEGER:C220($aiEVLG_Indicadores_Valor;0)
											ARRAY TEXT:C222($atEVLG_Indicadores_Concepto;0)
											$l_recNum:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
											KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNum;False:C215)
											BLOB_Blob2Vars (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->$atEVLG_Indicadores_Descripcion;->$aiEVLG_Indicadores_Valor;->$atEVLG_Indicadores_Concepto)
											$index:=Find in array:C230($atEVLG_Indicadores_Concepto;$valor)
											If ($index#-1)
												$y_evaluacionLiteral->:=$atEVLG_Indicadores_Concepto{$index}
												$y_evaluacionIndicador->:=$atEVLG_Indicadores_Descripcion{$index}
												$y_evaluacionReal->:=Round:C94($aiEVLG_Indicadores_Valor{$index}/[MPA_DefinicionCompetencias:187]Maximo_Indicadores:9*100;11)
												$y_evaluacionNumerico->:=$aiEVLG_Indicadores_Valor{$index}
												$b_guardarRegistro:=True:C214
											End if 
											
											
										: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje) & ($b_dimensionesIngresables))
											If ($valor#"")
												EVS_ReadStyleData ($estilo)
												Case of 
													: (iEvaluationMode=Notas)
														$l_valorNumerico:=EV2_Nota_a_Real (Num:C11($valor))
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Notas;iGradesDec)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text (EV2_Real_a_Nota ($l_valorNumerico;Notas;iGradesDec);True:C214)+" sobre "+ST_Num2Text (rGradesTo;False:C215)
													: (iEvaluationMode=Puntos)
														$l_valorNumerico:=EV2_Puntos_a_Real (Num:C11($valor))
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Puntos;iPointsDec)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text (EV2_Real_a_Puntos ($l_valorNumerico;Puntos;iPointsDec);True:C214)+" sobre "+ST_Num2Text (rPuntosTo;False:C215)
													: (iEvaluationMode=Porcentaje)
														$l_valorNumerico:=Round:C94(Num:C11($valor);1)
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Porcentaje;1)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text ($l_valorNumerico;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
													: (iEvaluationMode=Simbolos)
														$index:=Find in array:C230(aSymbol;$valor)
														If ($index#-1)
															$y_evaluacionLiteral->:=$valor
															$y_evaluacionIndicador->:=aSymbDesc{$index}
															$y_evaluacionReal->:=aSymbPctEqu{$index}
															$y_evaluacionNumerico->:=aSymbGradesEqu{$index}
														End if 
												End case 
											Else 
												$y_evaluacionLiteral->:=""
												$y_evaluacionIndicador->:=""
												$y_evaluacionReal->:=-10
												$y_evaluacionNumerico->:=-10
											End if 
											OB_SET ($ob_refNodoCompetencias;$y_evaluacionIndicador;"descindicador")
											
											$b_guardarRegistro:=True:C214
										: (([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje) & ($b_ejesIngresables))
											If ($valor#"")
												EVS_ReadStyleData ($estilo)
												Case of 
													: (iEvaluationMode=Notas)
														$l_valorNumerico:=EV2_Nota_a_Real (Num:C11($valor))
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Notas;iGradesDec)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text (EV2_Real_a_Nota ($l_valorNumerico;Notas;iGradesDec);True:C214)+" sobre "+ST_Num2Text (rGradesTo;False:C215)
													: (iEvaluationMode=Puntos)
														$l_valorNumerico:=EV2_Puntos_a_Real (Num:C11($valor))
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Puntos;iPointsDec)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text (EV2_Real_a_Puntos ($l_valorNumerico;Puntos;iPointsDec);True:C214)+" sobre "+ST_Num2Text (rPuntosTo;False:C215)
													: (iEvaluationMode=Porcentaje)
														$l_valorNumerico:=Round:C94(Num:C11($valor);1)
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Porcentaje;1)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text ($l_valorNumerico;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
													: (iEvaluationMode=Simbolos)
														$index:=Find in array:C230(aSymbol;$valor)
														If ($index#-1)
															$y_evaluacionLiteral->:=$valor
															$y_evaluacionIndicador->:=aSymbDesc{$index}
															$y_evaluacionReal->:=aSymbPctEqu{$index}
															$y_evaluacionNumerico->:=aSymbGradesEqu{$index}
														End if 
												End case 
											Else 
												$y_evaluacionLiteral->:=""
												$y_evaluacionIndicador->:=""
												$y_evaluacionReal->:=-10
												$y_evaluacionNumerico->:=-10
											End if 
											OB_SET ($ob_refNodoCompetencias;y_evaluacionIndicador;"descindicador")
											$b_guardarRegistro:=True:C214
									End case 
									  //
									
								: ($tipoEval=2)
									$index:=-1
									ARRAY TEXT:C222($at_simbolos;0)
									ARRAY TEXT:C222($at_descriptores;0)
									Case of 
										: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
											$l_recNum:=Find in field:C653([MPA_DefinicionCompetencias:187]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Competencia:7)
											KRL_GotoRecord (->[MPA_DefinicionCompetencias:187];$l_recNum)
											AT_Text2Array (->$at_simbolos;[MPA_DefinicionCompetencias:187]SimbolosBinarios_Simbolos:17)
											AT_Text2Array (->$at_descriptores;[MPA_DefinicionCompetencias:187]SimbolosBinarios_Descripcion:18)
											$index:=Find in array:C230($at_simbolos;$valor)
										: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
											$l_recNum:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
											KRL_GotoRecord (->[MPA_DefinicionEjes:185];$l_recNum)
											AT_Text2Array (->$at_simbolos;[MPA_DefinicionEjes:185]SimbolosBinarios_Simbolos:14)
											AT_Text2Array (->$at_descriptores;[MPA_DefinicionEjes:185]SimbolosBinarios_Descripcion:15)
											$index:=Find in array:C230($at_simbolos;$valor)
										: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
											$l_recNum:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
											KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$l_recNum)
											AT_Text2Array (->$at_simbolos;[MPA_DefinicionDimensiones:188]SimbolosBinarios_Simbolos:17)
											AT_Text2Array (->$at_descriptores;[MPA_DefinicionDimensiones:188]SimbolosBinarios_Descripcion:16)
											$index:=Find in array:C230($at_simbolos;$valor)
									End case 
									If ($index#-1)
										$y_evaluacionLiteral->:=$valor
										$y_evaluacionIndicador->:=$at_descriptores{$index}
										If ($index=1)
											$y_evaluacionReal->:=1
											$y_evaluacionNumerico->:=1
										Else 
											$y_evaluacionReal->:=0
											$y_evaluacionNumerico->:=0
										End if 
										$b_guardarRegistro:=True:C214
									End if 
									  //
									
								: ($tipoEval=3)
									Case of 
										: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje)
											If ($valor#"")
												EVS_ReadStyleData ($estilo)
												Case of 
													: (iEvaluationMode=Notas)
														$l_valorNumerico:=EV2_Nota_a_Real (Num:C11($valor))
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Notas;iGradesDec)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text (EV2_Real_a_Nota ($l_valorNumerico;Notas;iGradesDec);True:C214)+" sobre "+ST_Num2Text (rGradesTo;False:C215)
													: (iEvaluationMode=Puntos)
														$l_valorNumerico:=EV2_Puntos_a_Real (Num:C11($valor))
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Puntos;iPointsDec)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text (EV2_Real_a_Puntos ($l_valorNumerico;Puntos;iPointsDec);True:C214)+" sobre "+ST_Num2Text (rPuntosTo;False:C215)
													: (iEvaluationMode=Porcentaje)
														$l_valorNumerico:=Round:C94(Num:C11($valor);1)
														$y_evaluacionReal->:=$l_valorNumerico
														$y_evaluacionLiteral->:=EV2_Real_a_Literal ($l_valorNumerico;Porcentaje;1)
														$y_evaluacionNumerico->:=$l_valorNumerico
														$y_evaluacionIndicador->:=ST_Num2Text ($l_valorNumerico;True:C214)+" sobre "+ST_Num2Text (100;False:C215)
													: (iEvaluationMode=Simbolos)
														$index:=Find in array:C230(aSymbol;$valor)
														If ($index#-1)
															$y_evaluacionLiteral->:=$valor
															$y_evaluacionIndicador->:=aSymbDesc{$index}
															$y_evaluacionReal->:=aSymbPctEqu{$index}
															$y_evaluacionNumerico->:=aSymbGradesEqu{$index}
														End if 
												End case 
											Else 
												$y_evaluacionLiteral->:=""
												$y_evaluacionIndicador->:=""
												$y_evaluacionReal->:=-10
												$y_evaluacionNumerico->:=-10
											End if 
											OB_SET ($ob_refNodoCompetencias;$y_evaluacionIndicador;"descindicador")
											
											$b_guardarRegistro:=True:C214
											
										: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Dimension_Aprendizaje)
											If ($valor#"")
												$rnDim:=Find in field:C653([MPA_DefinicionDimensiones:188]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6)
												KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$rnDim;False:C215)
												$l_valorNumerico:=Num:C11($valor)
												$y_evaluacionReal->:=Round:C94($l_valorNumerico/[MPA_DefinicionDimensiones:188]Escala_Maximo:13*100;11)
												$y_evaluacionLiteral->:=$valor
												$y_evaluacionNumerico->:=$l_valorNumerico
												$y_evaluacionIndicador->:=ST_Num2Text ($l_valorNumerico;True:C214)+" sobre "+ST_Num2Text ([MPA_DefinicionDimensiones:188]Escala_Maximo:13;False:C215)
											Else 
												$y_evaluacionLiteral->:=""
												$y_evaluacionIndicador->:=""
												$y_evaluacionReal->:=-10
												$y_evaluacionNumerico->:=-10
											End if 
											OB_SET ($ob_refNodoDimension;$y_evaluacionIndicador;"descindicador")
											$b_guardarRegistro:=True:C214
											
										: ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Eje_Aprendizaje)
											If ($valor#"")
												$rnEje:=Find in field:C653([MPA_DefinicionEjes:185]ID:1;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5)
												KRL_GotoRecord (->[MPA_DefinicionDimensiones:188];$rnDim;False:C215)
												$y_evaluacionReal->:=Round:C94($l_valorNumerico/[MPA_DefinicionDimensiones:188]Escala_Maximo:13*100;11)
												$y_evaluacionLiteral->:=$valor
												$y_evaluacionNumerico->:=$l_valorNumerico
												$y_evaluacionIndicador->:=ST_Num2Text ($l_valorNumerico;True:C214)+" sobre "+ST_Num2Text ([MPA_DefinicionEjes:185]Escala_Maximo:18;False:C215)
											Else 
												$y_evaluacionLiteral->:=""
												$y_evaluacionIndicador->:=""
												$y_evaluacionReal->:=-10
												$y_evaluacionNumerico->:=-10
											End if 
											OB_SET ($ob_refNodoDimension;$y_evaluacionIndicador;"descindicador")
											
											$b_guardarRegistro:=True:C214
											
									End case 
							End case 
					End case 
					If ($b_guardarRegistro)
						  //MONO - ticket 165579
						C_TEXT:C284($t_MPA_detalleCambio;$t_logTipoObj;$t_logEnunciado;$t_MPA_oldValue)  //log MPA
						$t_MPA_oldValue:=Old:C35($y_evaluacionLiteral->)
						SAVE RECORD:C53([Alumnos_EvaluacionAprendizajes:203])
						QR_AluEvAprendizaje_GetData ([Alumnos_EvaluacionAprendizajes:203]Auto_UUID:94;->$t_logEnunciado;->$t_logTipoObj)
						$t_MPA_detalleCambio:="Periodo "+String:C10($periodo)+" "+$t_logTipoObj+": "+$t_logEnunciado+" - Evaluación "+$t_MPA_oldValue+" >> "+$y_evaluacionLiteral->
						Log_RegisterEvtSTW ("Modificación en evaluación de aprendizajes STWA para "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;->[Alumnos:2]apellidos_y_nombres:40)+" en "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;->[Asignaturas:18]denominacion_interna:16)+" - "+$t_MPA_detalleCambio;$userID)
						
						$idAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
						MPA_Calculos (Record number:C243([Alumnos_EvaluacionAprendizajes:203]);$periodo)
						If (([MPA_AsignaturasMatrices:189]Convertir_a_Notas:9) & ($periodo>0))
							KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$rnEval;False:C215)
							$t_key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Asignaturas:18]Numero_del_Nivel:6)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1)+"."+String:C10([Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3)
							$b_promediosModificados:=MPA_Aprendizajes_a_Notas ([Asignaturas:18]EVAPR_IdMatriz:91;$t_key)
							If ($b_promediosModificados)
								ARRAY LONGINT:C221(aIdAlumnos_a_Recalcular;0)
								APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;$idAlumno)
								modNotas:=True:C214
								AS_TareasPostEdicionNotas ($userID;"SchoolTrack Web Access")
							End if 
						End if 
						KRL_GotoRecord (->[Alumnos_EvaluacionAprendizajes:203];$rnEval;False:C215)
						$l_recNumMatrizEvaluacion:=Find in field:C653([MPA_AsignaturasMatrices:189]ID_Matriz:1;[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
						READ ONLY:C145([MPA_AsignaturasMatrices:189])
						READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
						KRL_GotoRecord (->[MPA_AsignaturasMatrices:189];$l_recNumMatrizEvaluacion)
						If (([MPA_AsignaturasMatrices:189]ModoCalculoDimensiones:6=Logro_Aprendizaje) & ([Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6#0) & ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4=Logro_Aprendizaje))
							$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
							$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
							$l_IdDimension:=[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_IdAlumno;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Dimension:6;=;$l_IdDimension;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Dimension_Aprendizaje)
							
							OB_SET ($ob_refNodoDimension;$y_evaluacionLiteral;"indicadorDimension")
							OB_SET ($ob_refNodoDimension;$y_evaluacionIndicador;"descDimension")
							
						End if 
						
						If (([MPA_AsignaturasMatrices:189]ModoCalculoEjes:10>=2) & ([Alumnos_EvaluacionAprendizajes:203]ID_Eje:5#0) & ([Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4>=Dimension_Aprendizaje))
							$l_IdAsignatura:=[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1
							$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
							$l_IdEje:=[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Asignatura:1;=;$l_IdAsignatura;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3;=;$l_IdAlumno;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]ID_Eje:5;=;$l_IdEje;*)
							QUERY:C277([Alumnos_EvaluacionAprendizajes:203]; & ;[Alumnos_EvaluacionAprendizajes:203]Tipo_Objeto:4;=;Eje_Aprendizaje)
							OB_SET ($ob_refNodoEje;$y_evaluacionLiteral;"indicadorEje")
							OB_SET ($ob_refNodoEje;$y_evaluacionIndicador;"descEje")
						End if 
						
						If ([MPA_AsignaturasMatrices:189]ResultadoFinalCalculado:7)
							$l_IdAlumno:=[Alumnos_EvaluacionAprendizajes:203]ID_Alumno:3
							EV2_CargaRegistro ([Asignaturas:18]Numero:1;$l_IdAlumno)
							
							C_OBJECT:C1216($ob_promedios)
							$ob_promedios:=OB_Create 
							  //$t_refNodoPromedios:=JSON Append node ($t_refJson;"promedios")
							OB_SET ($ob_promedios;$y_promedioPeriodoLiteral;"pp")
							OB_SET ($ob_promedios;$y_promedioFinalInternoLiteral;"f")
							OB_SET ($ob_promedios;$y_promedioFinalOficialLiteral;"of")
							OB_SET_Text ($ob_promedios;String:C10($y_promedioPeriodoReal->);"ppREAL")
							OB_SET_Text ($ob_promedios;String:C10($y_promedioFinalInternoReal->);"fREAL")
							OB_SET_Text ($ob_promedios;String:C10($y_promedioFinalOficialReal->);"ofREAL")
							EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
							OB_SET_Text ($ob_promedios;String:C10(rPctMinimum);"minREAL")
							
							C_OBJECT:C1216($ob_asignatura)
							$ob_asignatura:=OB_Create 
							  //$t_refNodoAsignatura:=JSON Append node ($t_refJson;"asignatura")
							OB_SET ($ob_asignatura;->[Asignaturas:18]PromedioFinal_texto:53;"f")
							OB_SET ($ob_asignatura;->[Asignaturas:18]PromedioFinalOficial_texto:67;"of")
							OB_SET_Text ($ob_asignatura;String:C10(Record number:C243([Asignaturas:18]));"rn")
							OB_SET_Text ($ob_asignatura;String:C10([Asignaturas:18]PorcentajeAprobados:103;"|Pct_2Dec");"porcAprob")
							OB_SET ($y_refjson->;->$ob_promedios;"promedios")
							OB_SET ($y_refjson->;->$ob_asignatura;"asignatura")
							
						End if 
						KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
					End if 
					
					If (Not:C34(OB Is empty:C1297($ob_refNodoCompetencias)))
						OB_SET ($y_refjson->;->$ob_refNodoCompetencias;"datoscompetencia")
					End if 
					If (Not:C34(OB Is empty:C1297($ob_refNodoDimension)))
						OB_SET ($y_refjson->;->$ob_refNodoDimension;"datosdimension")
					End if 
					If (Not:C34(OB Is empty:C1297($ob_refNodoEje)))
						OB_SET ($y_refjson->;->$ob_refNodoEje;"datoseje")
					End if 
					
					$0:=True:C214
				Else 
					$0:=False:C215
				End if 
			Else 
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="subcalificacion")
		$idAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idalumno"))
		$colSA:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"colSA")
		$colA:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"ColA"))
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$rnAsig:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$valor:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		$rnCal:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnCal"))
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")  //LOG
		$userID:=STWA2_Session_GetUserSTID ($uuid)  //LOG
		$userName:=USR_GetUserName ($userID)+" (STWA)"  //LOG
		If ($colSA="control")
			$arrPtr:=->aRealSubEvalControles
		Else 
			$arrPtr:=Get pointer:C304("aRealSubEval"+$colSA)
		End if 
		If (KRL_GotoRecord (->[Asignaturas:18];$rnAsig;False:C215))
			PERIODOS_Init 
			PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
			
			If ($periodo=0)
				$periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
			End if 
			
			EVS_initialize 
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			
			EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$periodo)
			
			$sem:="subasignatura_"+String:C10([Asignaturas:18]Numero:1)+"."+String:C10($periodo)+"."+String:C10($colA)
			While (Semaphore:C143($sem))
				DELAY PROCESS:C323(Current process:C322;5)
			End while 
			
			$subEvalRecNum:=ASsev_LeeDatosSubasignatura ([Asignaturas:18]Numero:1;$periodo;$colA)
			ASsev_UpdateList ($subEvalRecNum)
			
			$el:=Find in array:C230(aSubEvalID;$idAlumno)
			If ($el#-1)
				Case of 
					: ($valor="-10")
						$literal:=""
					: ($valor="-4")
						$literal:="*"
					: ($valor="-3")
						$literal:="X"
					: ($valor="-2")
						$literal:="P"
					Else 
						If (iEvaluationMode=Simbolos)
							EVS_ReadStyleData ($estilo)
							$literal:=aSymbol{Num:C11($valor)}
						Else 
							$literal:=$valor
						End if 
				End case 
				$prevProm:=aSubEvalP1{$el}
				$notaReal:=NTA_StringValue2Percent ($literal)
				$arrPtr->{$el}:=$notaReal
				ASsev_Average ($el)
				
				[xxSTR_Subasignaturas:83]DTS_UltimoRegistro_GMT:3:=DTS_Get_GMT_TimeStamp 
				ASsev_GuardaNomina (Record number:C243([xxSTR_Subasignaturas:83]))
				$notaRET:=aSubEvalP1{$el}
				
				If ($prevProm#$notaRET)
					$field_literal_Ptr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Eval"+String:C10($colA;"00")+"_Literal")
					$field_real_Ptr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Eval"+String:C10($colA;"00")+"_Real")
					$field_nota_Ptr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Eval"+String:C10($colA;"00")+"_Nota")
					$field_puntos_Ptr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Eval"+String:C10($colA;"00")+"_Puntos")
					$field_simbolo_Ptr:=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]P0"+String:C10($periodo)+"_Eval"+String:C10($colA;"00")+"_Simbolo")
					$b_GuardarRegistro:=[Asignaturas:18]Consolidacion_EsConsolidante:35 | [Asignaturas:18]Resultado_no_calculado:47
					ASev2_RegistraCalificacion ($rnCal;aREalSubEvalP1{$el};$field_literal_Ptr;$field_real_Ptr;$field_nota_Ptr;$field_puntos_Ptr;$field_simbolo_Ptr;$b_GuardarRegistro;$userName)
					$modifiedAvegares:=EV2_Calculos ($rnCal;$periodo)
					  //===== PARA RECALCULAR PROMEDIOS ALUMNO Y CURSO
					ARRAY LONGINT:C221(aIdAlumnos_a_Recalcular;0)
					APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;[Alumnos_Calificaciones:208]ID_Alumno:6)
					modNotas:=True:C214
					AS_TareasPostEdicionNotas ($userID;"SchoolTrack Web Access")
					KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rnCal;False:C215)
					  //=======
					STWA2_Notas_DevuelvePromedios (True:C214;$periodo;$y_refJson;$notaRET)  //MONO: esto va en true siempre ya que hay una diferencia del promedio de la subasignatura ya validado en el if que estamos
				End if 
				KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
				KRL_UnloadReadOnly (->[Asignaturas:18])
				KRL_UnloadReadOnly (->[xxSTR_Subasignaturas:83])
			Else 
				$0:=False:C215
			End if 
			
			CLEAR SEMAPHORE:C144($sem)  //MONO Ticket 180633
			
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="NF")
		
	: ($dataType="calificaciones")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$tabla:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tabla"))
		$campo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"campo"))
		$rnAlumnos_Calificaciones:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$valor:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")  //LOG
		$userID:=STWA2_Session_GetUserSTID ($uuid)  //LOG
		$userName:=USR_GetUserName ($userID)+" (STWA)"  //LOG
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rnAlumnos_Calificaciones;True:C214))
			ARRAY LONGINT:C221(aIdAlumnos_a_Recalcular;0)
			APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;[Alumnos_Calificaciones:208]ID_Alumno:6)
			EV2_CargaRegistro ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6)
			$rn_Asignatura:=Find in field:C653([Asignaturas:18]Numero:1;[Alumnos_Calificaciones:208]ID_Asignatura:5)
			KRL_GotoRecord (->[Asignaturas:18];$rn_Asignatura;False:C215)
			$estilo:=[Asignaturas:18]Numero_de_EstiloEvaluacion:39
			EV2_Examenes_LeeConfigExamenes ($periodo)
			
			Case of 
				: ($valor="-10")
					$literal:=""
					$real:=-10
				: ($valor="-4")
					$literal:="*"
					$real:=-4
				: ($valor="-3")
					$literal:="X"
					$real:=-3
				: ($valor="-2")
					$literal:="P"
					$real:=-2
				Else 
					EVS_ReadStyleData ($estilo)
					Case of 
						: (iEvaluationMode=Notas)
							$literal:=$valor
							$real:=NTA_StringValue2Percent ($literal)
						: (iEvaluationMode=Simbolos)
							$literal:=aSymbol{Num:C11($valor)}
							$real:=EV2_Simbolo_a_Real ($literal)
						: (iEvaluationMode=Puntos)
							$literal:=$valor
							$real:=NTA_StringValue2Percent ($literal)
						: (iEvaluationMode=Porcentaje)
							$literal:=$valor
							$real:=NTA_StringValue2Percent ($literal)
					End case 
			End case 
			$field_literal_Ptr:=Field:C253($tabla;$campo)
			$field_real_Ptr:=Field:C253($tabla;$campo-4)
			$field_nota_Ptr:=Field:C253($tabla;$campo-3)
			$field_puntos_Ptr:=Field:C253($tabla;$campo-2)
			$field_simbolo_Ptr:=Field:C253($tabla;$campo-1)
			  //$b_GuardarRegistro:=[Asignaturas]Consolidacion_EsConsolidante | [Asignaturas]Resultado_no_calculado
			$b_GuardarRegistro:=True:C214  //20171003 ASM Ticket 190000 Esto ya se encontraba solucionado en el ticket 162120 en la fecha 20160525. en 11.12 se encuentra bien. por algún motivo acá no lo estaba.
			ASev2_RegistraCalificacion ($rnAlumnos_Calificaciones;$real;$field_literal_Ptr;$field_real_Ptr;$field_nota_Ptr;$field_puntos_Ptr;$field_simbolo_Ptr;$b_GuardarRegistro;$userName)  //LOG
			If ((Table:C252($tabla)=Table:C252(Table:C252(->[Alumnos_Calificaciones:208]))) & (Field:C253($tabla;$campo)=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);Field:C253(->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30))))
				If ((vr_MinimoExRecuperatorio>=vrNTA_MinimoEscalaReferencia) & (AS_PromediosSonCalculados ))
					ASev2_RegistraCalificacion ($rnAlumnos_Calificaciones;$real;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98)
				End if 
			End if 
			Case of 
				: (($field_literal_Ptr=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]ExamenAnual_Literal")) & ($field_literal_Ptr->="") & ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95>-10))
					ASev2_RegistraCalificacion ($rnAlumnos_Calificaciones;-10;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98;[Asignaturas:18]Consolidacion_EsConsolidante:35)
				: (($field_literal_Ptr=KRL_GetFieldPointerByName ("[Alumnos_Calificaciones]ExamenExtra_Literal")) & ($field_literal_Ptr->="") & ([Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95>-10))
					ASev2_RegistraCalificacion ($rnAlumnos_Calificaciones;-10;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Literal:99;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Real:95;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Nota:96;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Puntos:97;->[Alumnos_ComplementoEvaluacion:209]ExamenRecuperatorio_Simbolos:98;[Asignaturas:18]Consolidacion_EsConsolidante:35)
			End case 
			$rn:=Record number:C243([Alumnos_Calificaciones:208])
			$modifiedAvegares:=EV2_Calculos ($rnAlumnos_Calificaciones;$periodo)
			
			
			  //20151216 ASM Ticket 153890 Calculo los promedios post-ingreso de evaluacion en EX y EXX
			If ((KRL_isSameField ($field_literal_Ptr;->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20)) | (KRL_isSameField ($field_literal_Ptr;->[Alumnos_Calificaciones:208]ExamenExtra_Literal:25)))
				EV2_Calculos_PromediosFinales ($rnAlumnos_Calificaciones)
				$modifiedAvegares:=True:C214
			End if 
			
			  //===== PARA RECALCULAR PROMEDIOS ALUMNO Y CURSO
			modNotas:=True:C214
			AS_TareasPostEdicionNotas ($userID;"SchoolTrack Web Access")
			KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rn;False:C215)
			  //=======
			STWA2_Notas_DevuelvePromedios ($modifiedAvegares;$periodo;$y_refJson)
			KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
			KRL_UnloadReadOnly (->[Asignaturas:18])
		Else 
			$0:=False:C215
		End if 
	: ($dataType="esfuerzo")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$tabla:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tabla"))
		$campo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"campo"))
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")  //LOG
		$userID:=STWA2_Session_GetUserSTID ($uuid)  //LOG
		$rnAlumnos_Calificaciones:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$valor:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		$fieldPtr:=Field:C253($tabla;$campo)
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rnAlumnos_Calificaciones;True:C214))
			ARRAY LONGINT:C221(aIdAlumnos_a_Recalcular;0)
			APPEND TO ARRAY:C911(aIdAlumnos_a_Recalcular;[Alumnos_Calificaciones:208]ID_Alumno:6)
			$rn_Asignatura:=Find in field:C653([Asignaturas:18]Numero:1;[Alumnos_Calificaciones:208]ID_Asignatura:5)
			KRL_GotoRecord (->[Asignaturas:18];$rn_Asignatura;False:C215)
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			If (ASev2_registraEsfuerzo ($rnAlumnos_Calificaciones;$valor;$fieldPtr))
				If ((([Asignaturas:18]Pondera_Esfuerzo:61) & (r1_EvEsfuerzoIndicadores=1)) | (r2_EvEsfuerzoBonificacion=1))
					$modifiedAvegares:=EV2_Calculos ($rnAlumnos_Calificaciones;$periodo)
					$rn:=Record number:C243([Alumnos_Calificaciones:208])
					  //===== PARA RECALCULAR PROMEDIOS ALUMNO Y CURSO
					modNotas:=True:C214
					AS_TareasPostEdicionNotas ($userID;"SchoolTrack Web Access")
					KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rn;False:C215)
					  //=======
					STWA2_Notas_DevuelvePromedios ($modifiedAvegares;$periodo;$y_refJson)
				End if 
			Else 
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
		End if 
	: ($dataType="inasistencia")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$tabla:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tabla"))
		$campo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"campo"))
		$rnAlumnos_Calificaciones:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$inasistencias:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor"))
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rnAlumnos_Calificaciones;False:C215))
			EV2_CargaRegistro ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;True:C214)
			$fieldPtr:=Field:C253($tabla;$campo)
			$fieldPtr->:=$inasistencias
			SAVE RECORD:C53(Table:C252($tabla)->)
		Else 
			$0:=False:C215
		End if 
	: ($dataType="observacion")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		If ($periodo=-1)
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
		Else 
			$obsPointer:=KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10($periodo)+"_Obs_Academicas")
		End if 
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rn;False:C215))
			EV2_CargaRegistro ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;True:C214)
			If (ST_ExactlyEqual ($obs;$obsPointer->)=0)
				$obsPointer->:=$obs
				SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
				Log_RegisterEvtSTW ("Modificación de observación en Complementos de evaluación";$userID)
				  //SN3_MarcarRegistros (SN3_DTi_Observaciones;SN3_SDTx_Asignatura)//MONO 20180829 esto está dentro del trigger de complementos evaluación.
			End if 
			KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
		Else 
			$0:=False:C215
		End if 
	: ($dataType="obspj")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		If ($periodo=-1)
			$obsPointer:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
		Else 
			$obsPointer:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($periodo)+"_Observaciones_Academicas")
		End if 
		If (KRL_GotoRecord (->[Alumnos:2];$rn;False:C215))
			$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
			AL_EscribeSintesisAnual ($key;$obsPointer;->$obs;True:C214)
		Else 
			$0:=False:C215
		End if 
	: ($dataType="objetivo")
		$periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		If ($periodo=-1)
			$obsPointer:=->[Alumnos_ComplementoEvaluacion:209]Final_objetivos:105
		Else 
			$obsPointer:=KRL_GetFieldPointerByName ("[Alumnos_ComplementoEvaluacion]P0"+String:C10($periodo)+"_Objetivos")
		End if 
		If (KRL_GotoRecord (->[Alumnos_Calificaciones:208];$rn;False:C215))
			EV2_CargaRegistro ([Alumnos_Calificaciones:208]ID_Asignatura:5;[Alumnos_Calificaciones:208]ID_Alumno:6;True:C214)
			$obsPointer->:=$obs
			SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
			KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="saveregistroasistencia")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$idsesion:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idsesion"))
		$l_estado:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"estado"))
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$idsesion)
		If ($l_estado=1)
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=String:C10(Current date:C33(*);ISO date GMT:K1:10;Current time:C178(*))
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName ($userID)
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
		Else 
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=""
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=""
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215
		End if 
		SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
		KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
		
	: ($dataType="editaObservacion")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnobervacion"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"observacion")
		GOTO RECORD:C242([Alumnos_Anotaciones:11];$rn)
		KRL_ReloadInReadWriteMode (->[Alumnos_Anotaciones:11])
		If (Records in selection:C76([Alumnos_Anotaciones:11])>0)
			[Alumnos_Anotaciones:11]Observaciones:4:=$obs
			SAVE RECORD:C53([Alumnos_Anotaciones:11])
			Log_RegisterEvtSTW ("Edición de observación en anotaciones";$userID)
			KRL_UnloadReadOnly (->[Alumnos_Anotaciones:11])
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="editaObsInasistencia")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rninasistencia"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"observacion")
		GOTO RECORD:C242([Alumnos_Inasistencias:10];$rn)
		KRL_ReloadInReadWriteMode (->[Alumnos_Inasistencias:10])
		If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
			[Alumnos_Inasistencias:10]Observaciones:3:=$obs
			Log_RegisterEvtSTW ("Edición de observación en inasistencias";$userID)
			SAVE RECORD:C53([Alumnos_Inasistencias:10])
			KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
		Else 
			$0:=False:C215
		End if 
		
		
	: ($dataType="editaObsSuspensiones")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnsuspension"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"observacion")
		GOTO RECORD:C242([Alumnos_Suspensiones:12];$rn)
		KRL_ReloadInReadWriteMode (->[Alumnos_Suspensiones:12])
		If (Records in selection:C76([Alumnos_Suspensiones:12])>0)
			[Alumnos_Suspensiones:12]Observaciones:8:=$obs
			Log_RegisterEvtSTW ("Edición de observación en suspensión";$userID)
			SAVE RECORD:C53([Alumnos_Suspensiones:12])
			KRL_UnloadReadOnly (->[Alumnos_Suspensiones:12])
		Else 
			$0:=False:C215
		End if 
		
	: ($dataType="editaObscastigos")
		
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rn:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rncastigos"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"observacion")
		GOTO RECORD:C242([Alumnos_Castigos:9];$rn)
		KRL_ReloadInReadWriteMode (->[Alumnos_Castigos:9])
		If (Records in selection:C76([Alumnos_Castigos:9])>0)
			[Alumnos_Castigos:9]Observaciones:3:=$obs
			Log_RegisterEvtSTW ("Edición de observación en Castigos";$userID)
			SAVE RECORD:C53([Alumnos_Castigos:9])
			KRL_UnloadReadOnly (->[Alumnos_Castigos:9])
		Else 
			$0:=False:C215
		End if 
	: ($dataType="guardadescripcion")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$id_profe:=STWA2_Session_GetProfID ($uuid)
		$recNum:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rn"))
		$t_texto:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"texto")
		
		If (STWA2_Session_UpdateLastSeen ($uuid))
			If (KRL_GotoRecord (->[xShell_Documents:91];$recNum;False:C215))
				READ WRITE:C146([Asignaturas_Adjuntos:230])
				QUERY:C277([Asignaturas_Adjuntos:230];[Asignaturas_Adjuntos:230]ID:1=[xShell_Documents:91]RelatedID:2)
				[Asignaturas_Adjuntos:230]descripcion:3:=$t_texto
				[Asignaturas_Adjuntos:230]id_modificadoPor:8:=$id_profe
				[Asignaturas_Adjuntos:230]fecha_ultima_modificacion:6:=Current date:C33(*)
				SAVE RECORD:C53([Asignaturas_Adjuntos:230])
				Log_RegisterEvtSTW ("Material Docente: Modificación de descripción para el archivo adjunto: "+[Asignaturas_Adjuntos:230]nombre_adjunto:10;$userID)
				KRL_UnloadReadOnly (->[Asignaturas_Adjuntos:230])
			Else 
				$0:=False:C215
			End if 
		Else 
			$0:=False:C215
		End if 
	: ($dataType="motivoAtrasos")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rnMotivo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnMotivo"))
		$rnAtraso:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAtraso"))
		
		  //cargo el motivo desde la configuración
		GOTO RECORD:C242([xxSTR_JustificacionAtrasos:227];$rnMotivo)
		$l_idMotivo:=[xxSTR_JustificacionAtrasos:227]ID:1
		
		READ WRITE:C146([Alumnos_Atrasos:55])
		GOTO RECORD:C242([Alumnos_Atrasos:55];$rnAtraso)
		[Alumnos_Atrasos:55]id_justificacion:13:=$l_idMotivo
		SAVE RECORD:C53([Alumnos_Atrasos:55])
		Log_RegisterEvtSTW ("Atrasos: Se agrega justificación para el atraso número: "+String:C10([Alumnos_Atrasos:55]ID:7);$userID)
		KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
		$0:=True:C214
		
	: ($dataType="justificaAtrasos")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rnAtraso:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAtraso"))
		$justificado:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"justificado")
		$b_justificado:=Choose:C955($justificado="false";False:C215;True:C214)
		READ WRITE:C146([Alumnos_Atrasos:55])
		GOTO RECORD:C242([Alumnos_Atrasos:55];$rnAtraso)
		[Alumnos_Atrasos:55]justificado:14:=$b_justificado
		SAVE RECORD:C53([Alumnos_Atrasos:55])
		Log_RegisterEvtSTW ("Atrasos: Se justifica atraso número: "+String:C10([Alumnos_Atrasos:55]ID:7);$userID)
		KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
		$0:=True:C214
		
	: ($dataType="guardaObservacion")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rnAtraso:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAtraso"))
		$texto:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"texto")
		READ WRITE:C146([Alumnos_Atrasos:55])
		GOTO RECORD:C242([Alumnos_Atrasos:55];$rnAtraso)
		[Alumnos_Atrasos:55]Observaciones:3:=$texto
		SAVE RECORD:C53([Alumnos_Atrasos:55])
		Log_RegisterEvtSTW ("Atrasos: Se modifica observación para el  atraso número: "+String:C10([Alumnos_Atrasos:55]ID:7);$userID)
		KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
		$0:=True:C214
		
	: ($dataType="guardaDatosVistaDirectorUY")  //Uruguay Vista del Director
		C_POINTER:C301($y_eval)
		C_BOOLEAN:C305($b_esEvaluacion)
		
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$es_eval:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"es_eval")
		$recNum:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"recNum"))
		$valor:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"valor")
		$l_periodo:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"periodo"))
		$t_tipoEval:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipoEval")
		
		$b_esEvaluacion:=Choose:C955($es_eval="true";True:C214;False:C215)
		
		If ($b_esEvaluacion)
			If ($l_periodo>0)
				Case of 
					: ($t_tipoEval="1")
						$y_eval:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Control_Literal")
						$y_evalReal:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Control_Real")
						$y_evalpunto:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Control_Puntos")
						$y_evalNota:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Control_Nota")
						$y_evalSimbolo:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Control_Simbolo")
					: ($t_tipoEval="2")
						$y_eval:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_eval01_Literal")
						$y_evalReal:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_eval01_Real")
						$y_evalpunto:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_eval01_Puntos")
						$y_evalNota:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_eval01_Nota")
						$y_evalSimbolo:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_eval01_Simbolo")
					: ($t_tipoEval="3")
						$y_eval:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Final_Literal")
						$y_evalReal:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Final_Real")
						$y_evalpunto:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Final_Puntos")
						$y_evalNota:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Final_Nota")
						$y_evalSimbolo:=KRL_GetFieldPointerByName ("[alumnos_calificaciones]p0"+String:C10($l_periodo)+"_Final_Simbolo")
						
					: ($t_tipoEval="4")  //20180202 RCH
						$y_eval:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
						$y_evalReal:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
						$y_evalpunto:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
						$y_evalNota:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
						$y_evalSimbolo:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
				End case 
			Else 
				
			End if 
			READ WRITE:C146([Alumnos_Calificaciones:208])
			GOTO RECORD:C242([Alumnos_Calificaciones:208];$recNum)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Alumnos_Calificaciones:208]ID_Asignatura:5)
			EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
			$r_notaReal:=EV2_Nota_a_Real (Num:C11($valor))
			$y_eval->:=$valor
			$y_evalReal->:=$r_notaReal
			$y_evalpunto->:=EV2_Real_a_Puntos ($r_notaReal)
			$y_evalNota->:=EV2_Real_a_Nota ($r_notaReal)
			$y_evalSimbolo->:=EV2_Real_a_Simbolo ($r_notaReal)
			
			$userName:=USR_GetUserName ($userID)+" (Vista del director STWA)"
			EV2_UpdateInfoCalificaciones (Record number:C243([Alumnos_Calificaciones:208]);$y_eval;"";$userName)  //20180202 RCH
			
			SAVE RECORD:C53([Alumnos_Calificaciones:208])
			  //Log_RegisterEvtSTW ("Vista del director: Modificación de calificaciones";$userID)
			Log_RegisterEvtSTW ("Vista del director: Modificación en calificaciones "+[Alumnos_Calificaciones:208]NombreInternoAsignatura:8+", "+[Asignaturas:18]Curso:5;$userID)  //20180202 RCH
			KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
		Else 
			If ($t_tipoEval="obsFinal")
				GOTO RECORD:C242([Alumnos:2];$recNum)
				$y_observacionFinal:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($l_periodo)+"_Observaciones_Academicas")
				READ WRITE:C146([Alumnos_SintesisAnual:210])
				QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4=[Alumnos:2]numero:1)
				$y_observacionFinal->:=$valor
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
				Log_RegisterEvtSTW ("Vista del director: Modificación de observaciones";$userID)
				KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
			Else 
				READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
				GOTO RECORD:C242([Alumnos_ComplementoEvaluacion:209];$recNum)
				Case of 
					: ($l_periodo=1)
						$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19
					: ($l_periodo=2)
						$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24
					: ($l_periodo=3)
						$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29
					: ($l_periodo=4)
						$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34
					: ($l_periodo=5)
						$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39
					Else 
						$y_observacion:=->[Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46
				End case 
				
				$y_observacion->:=$valor
				SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
				Log_RegisterEvtSTW ("Vista del director: Modificación de observaciones";$userID)
				KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])
				
			End if 
			
		End if 
		
		$0:=True:C214
		
	: ($dataType="guardaObservacion")
		
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rnAtraso:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAtraso"))
		$texto:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"texto")
		READ WRITE:C146([Alumnos_Atrasos:55])
		GOTO RECORD:C242([Alumnos_Atrasos:55];$rnAtraso)
		[Alumnos_Atrasos:55]Observaciones:3:=$texto
		Log_RegisterEvtSTW ("Atrasos: Modificación de observación";$userID)
		SAVE RECORD:C53([Alumnos_Atrasos:55])
		KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
		$0:=True:C214
		
	: ($dataType="guardaExamenDiap")
		C_TEXT:C284($t_target_td;$t_new_input_id;$jsonT;$t_json;$t_msglog)
		
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		  //$rnAsig:=Num(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAsig"))
		$id_parent_td:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"id_parent_td")
		$alumnoRN:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alumnoRN"))
		$evaluacion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"evaluacion")
		$instanciaExamen:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"instanciaExamen")
		$UUID_DiapAluAsig:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"uuid_inscripcion")
		
		$t_msglog:="Evaluación de exámen "+$instanciaExamen+" DIAP, para "
		$b_habilitarExamenExtra:=False:C215
		If (Position:C15("escrito";$id_parent_td)>0)
			$t_target_td:=Replace string:C233($id_parent_td;"escrito";"oral")
		Else 
			$t_target_td:=Replace string:C233($id_parent_td;"oral";"escrito")
		End if 
		$t_new_input_id:=Replace string:C233($t_target_td;"td";"ex")
		
		READ ONLY:C145([DIAP_AlumnosAsignaturas:225])
		
		QUERY:C277([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]Auto_UUID:1=$UUID_DiapAluAsig)
		$t_msglog:=$t_msglog+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[DIAP_AlumnosAsignaturas:225]ID_Alumno:2;->[Alumnos:2]apellidos_y_nombres:40)+" ("+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->[DIAP_AlumnosAsignaturas:225]ID_Alumno:2;->[Alumnos:2]curso:20)+"), en "+KRL_GetTextFieldData (->[Asignaturas:18]Numero:1;->[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3;->[Asignaturas:18]Asignatura:3)
		EVS_ReadStyleData (KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3;->[Asignaturas:18]Numero_de_EstiloEvaluacion:39))
		
		If ($evaluacion#"")
			Case of 
				: (iEvaluationMode=Puntos)
					$r_real:=EV2_Puntos_a_Real (Num:C11($evaluacion))
				: (iEvaluationMode=Notas)
					$r_real:=EV2_Nota_a_Real (Num:C11($evaluacion))
				: (iEvaluationMode=Simbolos)
					$r_real:=EV2_Simbolo_a_Real ($evaluacion)
			End case 
		Else 
			$r_real:=-10
		End if 
		
		QUERY:C277([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]ID_Asignatura:5=[DIAP_AlumnosAsignaturas:225]ID_Asignatura:3;*)
		QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4=[DIAP_AlumnosAsignaturas:225]ID_Alumno:2;*)
		QUERY:C277([Alumnos_EvaluacionesEspeciales:211]; & ;[Alumnos_EvaluacionesEspeciales:211]Año:3=<>gyear)
		
		KRL_ReloadInReadWriteMode (->[Alumnos_EvaluacionesEspeciales:211])
		
		If ($instanciaExamen="normal")  //instancias de examen: normal y extra.
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Real:13:=$r_real
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Literal:12:=EV2_Real_a_Literal ($r_real;iEvaluationMode)
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Nota:14:=EV2_Real_a_Nota ($r_real;Notas)
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Puntos:15:=EV2_Real_a_Puntos ($r_real)
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Simbolo:16:=EV2_Real_a_Simbolo ($r_real)
			$t_msglog:=$t_msglog+"\r"+"Evaluación: "+Old:C35([Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Literal:12)+" a "+[Alumnos_EvaluacionesEspeciales:211]ExamenAnual_Literal:12
			
		Else 
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Real:93:=$r_real
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Literal:92:=EV2_Real_a_Literal ($r_real;iEvaluationMode)
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Nota:94:=EV2_Real_a_Nota ($r_real;Notas)
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Puntos:95:=EV2_Real_a_Puntos ($r_real)
			[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Simbolo:96:=EV2_Real_a_Simbolo ($r_real)
			$t_msglog:=$t_msglog+"\r"+"Evaluación: "+Old:C35([Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Literal:92)+" a "+[Alumnos_EvaluacionesEspeciales:211]ExamenAnualExtra_Literal:92
			
			  //nuevo funcionamiento.
			KRL_ReloadInReadWriteMode (->[DIAP_AlumnosAsignaturas:225])
			If ($r_real>-10)
				[DIAP_AlumnosAsignaturas:225]usaExtraExamen:9:=True:C214
			Else 
				[DIAP_AlumnosAsignaturas:225]usaExtraExamen:9:=False:C215
			End if 
			SAVE RECORD:C53([DIAP_AlumnosAsignaturas:225])
			
		End if 
		$b_habilitarExamenExtra:=[DIAP_AlumnosAsignaturas:225]usaExtraExamen:9
		
		SAVE RECORD:C53([Alumnos_EvaluacionesEspeciales:211])
		$locked:=Locked:C147([Alumnos_EvaluacionesEspeciales:211])
		KRL_UnloadReadOnly (->[Alumnos_EvaluacionesEspeciales:211])
		KRL_UnloadReadOnly (->[DIAP_AlumnosAsignaturas:225])
		If ($locked)
			$0:=False:C215
		Else 
			
			  //OB_SET ($y_refjson->;->$b_habilitarExamenExtra;"examen_extra")
			  //OB_SET ($y_refjson->;->$t_target_td;"td")
			  //OB_SET ($y_refjson->;->$t_new_input_id;"extra_input")
			$0:=True:C214
			LOG_RegisterEvt ($t_msglog;Table:C252(->[Alumnos_EvaluacionesEspeciales:211]);Record number:C243([Alumnos_EvaluacionesEspeciales:211]);$userID;"SchoolTrack Web Access")
		End if 
		
	: ($dataType="guardaObs")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alumnoRN"))
		$t_obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs")
		$t_tipo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"tipoobs")
		
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		DIAP_CreaRegistroObservacion ([Alumnos:2]numero:1)  //MONO 168851 El registro se crea al dejar disponible al curso pero si el alumno entra al curso después no queda con el registro
		
		READ WRITE:C146([DIAP_Observaciones:207])
		QUERY:C277([DIAP_Observaciones:207];[DIAP_Observaciones:207]ID_alumno:2=[Alumnos:2]numero:1)
		Case of 
			: ($t_tipo="obsAle")
				[DIAP_Observaciones:207]Observacion_Aleman:5:=$t_obs
			: ($t_tipo="obsEsp")
				[DIAP_Observaciones:207]Observacion_Español:4:=$t_obs
		End case 
		SAVE RECORD:C53([DIAP_Observaciones:207])
		Log_RegisterEvtSTW ("DIAP: Modificación de observación";$userID)
		KRL_UnloadReadOnly (->[DIAP_Observaciones:207])
		$0:=True:C214
	: ($dataType="guardaInasistenciaDiariaMobile")
		C_TEXT:C284($t_estado)
		C_BOOLEAN:C305($b_validaPermisos)
		C_BOOLEAN:C305($b_continuar)
		ARRAY DATE:C224($ad_desde;0)
		ARRAY DATE:C224($ad_hasta;0)
		ARRAY LONGINT:C221($al_licID;0)
		
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$t_vp:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"vp")
		$b_validaPermisos:=(($t_vp="true") | ($t_vp="True"))
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAlumno"))
		$t_estadoActual:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"estadoActual")
		$t_estadoAnterior:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"estadoAnterior")
		$fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs")
		$l_rnAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAsignatura"))  //MONO TICKET 180505
		$userName:=USR_GetUserName ($userID)
		$profID:=STWA2_Session_GetProfID ($uuid)
		
		  //valido permisos del usuario para registrar atrasos
		$permisocrear:=USR_checkRights ("A";->[Alumnos_Inasistencias:10];$userID)
		$permitidoEliminar:=((USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)) & (STWA2_Priv_GetMethodAccess ("AL_EliminaInasistencia";$userID)))  //MONO 150618 ticket 208223
		$puedeEliminarAtraso:=USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)
		$puedeAgregarAtraso:=USR_checkRights ("A";->[Alumnos_Conducta:8];$userID)
		$b_ConLicencia:=False:C215
		$l_firmanteProf:=Num:C11(PREF_fGet (0;"FirmantesAutorizados"))
		
		Case of 
			: ($t_estadoActual="presente")
				$b_continuar:=True:C214
				
				GOTO RECORD:C242([Alumnos:2];$rnAlumno)
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				$b_esProfesor:=(([Cursos:3]Numero_del_profesor_jefe:2=$profID) | ($l_firmanteProf=1))
				
				$b_continuar:=Choose:C955($b_validaPermisos;(($permitidoEliminar) | ($b_esProfesor));True:C214)
				
				If ($b_continuar)
					
					QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
					SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_desde;[Alumnos_Licencias:73]Hasta:3;$ad_hasta;[Alumnos_Licencias:73]ID:6;$al_licID)
					For ($i;1;Size of array:C274($ad_desde))
						If (($fecha>=$ad_desde{$i}) & ($fecha<=$ad_hasta{$i}))
							$b_ConLicencia:=True:C214
						End if 
					End for 
					
					If (Not:C34($b_ConLicencia))
						GOTO RECORD:C242([Alumnos:2];$rnAlumno)
						READ WRITE:C146([Alumnos_Inasistencias:10])
						QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$fecha)
						
						If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
							DELETE RECORD:C58([Alumnos_Inasistencias:10])
						End if 
						
						KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
						
						  //elimino el atrasos
						READ WRITE:C146([Alumnos_Atrasos:55])
						QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$fecha;*)
						QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
						
						If (Records in selection:C76([Alumnos_Atrasos:55])>0)
							KRL_DeleteSelection (->[Alumnos_Atrasos:55])
							Log_RegisterEvtSTW ("Asistencia y Atrasos: Eliminación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
						End if 
						
						KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
						OB SET:C1220($y_refJson->;"Permiso";True:C214)
						OB SET:C1220($y_refJson->;"estado";"presente")
						$0:=True:C214
						
					Else 
						OB SET:C1220($y_refJson->;"ConLicencia";True:C214)
						$0:=True:C214
					End if 
					
				Else 
					OB_SET_Boolean ($y_refJson->;False:C215;"Permiso")
					$0:=True:C214
				End if 
				
				
			: ($t_estadoActual="ausente")
				
				GOTO RECORD:C242([Alumnos:2];$rnAlumno)
				
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				$b_esProfesor:=(([Cursos:3]Numero_del_profesor_jefe:2=$profID) | ($l_firmanteProf=1))
				$b_continuar:=Choose:C955($b_validaPermisos;(($permisocrear) | ($b_esProfesor));True:C214)
				
				If ($b_continuar)
					  //busco si existen licencias
					QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
					SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_desde;[Alumnos_Licencias:73]Hasta:3;$ad_hasta;[Alumnos_Licencias:73]ID:6;$al_licID)
					For ($i;1;Size of array:C274($ad_desde))
						If (($fecha>=$ad_desde{$i}) & ($fecha<=$ad_hasta{$i}))
							$b_ConLicencia:=True:C214
							$t_justificacion:="Licencia Nº "+String:C10($al_licID{$i})
							$l_licenciaID:=$al_licID{$i}
							$i:=Size of array:C274($ad_desde)
						End if 
					End for 
					
					  //creo la inasistencia
					CREATE RECORD:C68([Alumnos_Inasistencias:10])
					[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
					[Alumnos_Inasistencias:10]Nivel_Numero:9:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->[Alumnos_Inasistencias:10]Alumno_Numero:4;->[Alumnos:2]nivel_numero:29)
					[Alumnos_Inasistencias:10]Fecha:1:=$fecha
					[Alumnos_Inasistencias:10]RegistradaEl:11:=Current date:C33(*)
					[Alumnos_Inasistencias:10]RegistradaPor:10:=$userName
					[Alumnos_Inasistencias:10]Observaciones:3:=$obs
					If ($b_ConLicencia)
						[Alumnos_Inasistencias:10]Licencia:5:=$l_licenciaID
						[Alumnos_Inasistencias:10]Justificación:2:=$t_justificacion
					End if 
					
					SAVE RECORD:C53([Alumnos_Inasistencias:10])
					
					Log_RegisterEvtSTW ("Asistencia y Atrasos: Creación de inasistencia.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
					UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
					
					  //elimino el atras
					READ WRITE:C146([Alumnos_Atrasos:55])
					
					QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$fecha;*)
					QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=False:C215)
					
					If (Records in selection:C76([Alumnos_Atrasos:55])>0)
						Log_RegisterEvtSTW ("Asistencia y Atrasos: Eliminación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
						KRL_DeleteSelection (->[Alumnos_Atrasos:55])
					End if 
					
					KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
					OB SET:C1220($y_refJson->;"Permiso";True:C214)
					OB SET:C1220($y_refJson->;"estado";"ausente")
					$0:=True:C214
				Else 
					OB SET:C1220($y_refJson->;"Permiso";False:C215)
					$0:=True:C214
				End if 
				
			: ($t_estadoActual="atrasado")
				C_TEXT:C284($t_mensaje)
				C_LONGINT:C283($l_atrasoID)
				
				$l_atrasoID:=-1
				$b_registraAtraso:=True:C214
				GOTO RECORD:C242([Alumnos:2];$rnAlumno)
				QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
				$b_esProfesor:=(([Cursos:3]Numero_del_profesor_jefe:2=$profID) | ($l_firmanteProf=1))
				$b_continuar:=Choose:C955($b_validaPermisos;(($permitidoEliminar) | ($b_esProfesor));True:C214)
				If ($b_continuar)
					  //busco si existen licencias
					GOTO RECORD:C242([Alumnos:2];$rnAlumno)
					QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
					SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_desde;[Alumnos_Licencias:73]Hasta:3;$ad_hasta;[Alumnos_Licencias:73]ID:6;$al_licID)
					For ($i;1;Size of array:C274($ad_desde))
						If (($fecha>=$ad_desde{$i}) & ($fecha<=$ad_hasta{$i}))
							$b_ConLicencia:=True:C214
						End if 
					End for 
					
					If (Not:C34($b_ConLicencia))
						READ WRITE:C146([Alumnos_Inasistencias:10])
						
						QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$fecha)
						
						If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
							Log_RegisterEvtSTW ("Asistencia y Atrasos: Eliminación de inasistencia.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
							KRL_DeleteSelection (->[Alumnos_Inasistencias:10])
						End if 
						KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
						
						If (OK=1)
							STR_LeePreferenciasAtrasos2 
							GOTO RECORD:C242([Asignaturas:18];$l_rnAsignatura)  //MONO Ticket 180505
							CREATE RECORD:C68([Alumnos_Atrasos:55])
							[Alumnos_Atrasos:55]Fecha:2:=$fecha
							[Alumnos_Atrasos:55]Alumno_numero:1:=[Alumnos:2]numero:1
							[Alumnos_Atrasos:55]Observaciones:3:=""
							[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos:2]nivel_numero:29
							[Alumnos_Atrasos:55]ID_Asignatura:15:=[Asignaturas:18]Numero:1  //MONO Ticket 180505
							If (Size of array:C274(ATSTRAL_FALTACONV)>0)
								[Alumnos_Atrasos:55]MinutosAtraso:5:=ATSTRAL_FALTACONV{1}  //20180903 ASM Ticket 215157
							End if 
							SAVE RECORD:C53([Alumnos_Atrasos:55])
							Log_RegisterEvtSTW ("Asistencia y Atrasos: Creación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
							
							$l_atrasoID:=[Alumnos_Atrasos:55]ID:7
							$l_recNumAlumno:=Record number:C243([Alumnos:2])
							
							OB SET:C1220($y_refjson->;"alumnosRN";$l_recNumAlumno)
							OB SET:C1220($y_refjson->;"atrasoID";$l_atrasoID)
							OB SET:C1220($y_refjson->;"registrado";True:C214)
							OB SET:C1220($y_refjson->;"Permiso";True:C214)
							OB SET:C1220($y_refjson->;"ConLicencia";False:C215)
							OB SET:C1220($y_refjson->;"estado";"atrasado")
							
							KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
						Else 
							OB SET:C1220($y_refjson->;"registrado";False:C215)
							OB SET:C1220($y_refjson->;"Permiso";True:C214)
							OB SET:C1220($y_refjson->;"ConLicencia";False:C215)
							
						End if 
					Else 
						OB SET:C1220($y_refjson->;"registrado";False:C215)
						OB SET:C1220($y_refjson->;"Permiso";True:C214)
						OB SET:C1220($y_refjson->;"ConLicencia";True:C214)
						$0:=True:C214
					End if 
				Else 
					OB SET:C1220($y_refjson->;"registrado";False:C215)
					OB SET:C1220($y_refjson->;"Permiso";False:C215)
					OB SET:C1220($y_refjson->;"ConLicencia";False:C215)
					
					$0:=True:C214
				End if 
				
				$0:=True:C214
				
		End case 
		
	: ($dataType="savedatosatrasos")
		
		ARRAY TEXT:C222($at_intervalos;0)
		C_TEXT:C284($t_minutos)
		C_REAL:C285(vi_TiempoAtraso)
		
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$l_atrasoID:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"atrasoID"))
		$justificado:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"justificado")
		$motivojustificacion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"motivojustificacion")
		$t_minutos:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"minutos")
		$observacion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"observacion")
		$fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha"))
		$intersesion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"inter")
		$t_crear:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"crear")
		$l_rnalumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnalumno"))
		$l_RNAsignatura:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idAsignatura"))
		STR_LeePreferenciasAtrasos2 
		ST_JustificacionAtrasos ("cargaVariables")
		
		  //20180704 ASM Ticket 210886
		AT_Text2Array (->$at_intervalos;vt_intervalos;",")
		$choice:=Find in array:C230($at_intervalos;$t_minutos)
		If ((vi_RegistrarMinutosEnAtrasos=2) & ($choice#-1))
			vi_TiempoAtraso:=ATSTRAL_FALTACONV{$choice}
		Else 
			vi_TiempoAtraso:=Num:C11($t_minutos)
			  //MONO TICKET 210959
			If (vi_TiempoAtraso>999)
				vi_TiempoAtraso:=999
			End if 
		End if 
		
		If ($t_crear="true")
			GOTO RECORD:C242([Alumnos:2];$l_rnalumno)
			GOTO RECORD:C242([Asignaturas:18];$l_RNAsignatura)
			CREATE RECORD:C68([Alumnos_Atrasos:55])
			[Alumnos_Atrasos:55]Alumno_numero:1:=[Alumnos:2]numero:1
			[Alumnos_Atrasos:55]Fecha:2:=$fecha
			[Alumnos_Atrasos:55]ID_Asignatura:15:=[Asignaturas:18]Numero:1
			[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos:2]nivel_numero:29
			Log_RegisterEvtSTW ("Asistencia y Atrasos: Creación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
		Else 
			READ WRITE:C146([Alumnos_Atrasos:55])
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]ID:7=$l_atrasoID)
			Log_RegisterEvtSTW ("Asistencia y Atrasos: Modificación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
		End if 
		
		[Alumnos_Atrasos:55]justificado:14:=($justificado="true")
		[Alumnos_Atrasos:55]id_justificacion:13:=Num:C11($motivojustificacion)
		[Alumnos_Atrasos:55]Observaciones:3:=$observacion
		[Alumnos_Atrasos:55]MinutosAtraso:5:=vi_TiempoAtraso
		[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=($intersesion="true")
		SAVE RECORD:C53([Alumnos_Atrasos:55])
		KRL_ReloadAsReadOnly (->[Alumnos_Atrasos:55])
		
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Atrasos:55]Alumno_numero:1)
		$resultado:=AL_validaIngresoAtraso ([Alumnos:2]numero:1;$fecha;vi_TiempoAtraso)
		
		If ((<>vr_InasistenciasXatrasos=1) & ($resultado=1))
			AL_TotalizaAtrasos ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		End if 
		
		$0:=True:C214
	: ($dataType="editaObservacionMobile")
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"rnAlumno"))
		$fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha"))
		$obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"obs")
		READ WRITE:C146([Alumnos_Inasistencias:10])
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_Inasistencias:10]; & ;[Alumnos_Inasistencias:10]Fecha:1=$fecha)
		
		If (Records in selection:C76([Alumnos_Inasistencias:10])>0)
			[Alumnos_Inasistencias:10]Observaciones:3:=$obs
			SAVE RECORD:C53([Alumnos_Inasistencias:10])
			Log_RegisterEvtSTW ("Asistencia y Atrasos: Modificación de observación en inasistencia.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
		End if 
		
		KRL_UnloadReadOnly (->[Alumnos_Inasistencias:10])
		
		
	: ($dataType="editaJustificacionxHora")
		
		ARRAY LONGINT:C221($al_sesion;0)
		
		$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$rnAlumno:=Num:C11(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"alumnoRN"))
		$t_obs:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"observacion")
		$t_motivo:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"motivo")
		$t_Sesion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idSesion")
		AT_Text2Array (->$al_sesion;$t_Sesion;"_")
		SORT ARRAY:C229($al_sesion;<)
		
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		
		READ WRITE:C146([Asignaturas_Inasistencias:125])
		For ($l_indice;1;Size of array:C274($al_sesion))
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$al_sesion{$l_indice})
			QUERY SELECTION:C341([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1)
			[Asignaturas_Inasistencias:125]Observaciones:5:=$t_obs
			[Asignaturas_Inasistencias:125]Justificacion:3:=$t_motivo
			SAVE RECORD:C53([Asignaturas_Inasistencias:125])
			Log_RegisterEvtSTW ("Asistencia y Atrasos: Modificación de justificación en inasistencia ID Sesión: "+String:C10($al_sesion{$l_indice})+".\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10([Asignaturas_Inasistencias:125]dateSesion:4);$userID)
		End for 
		KRL_UnloadReadOnly (->[Asignaturas_Inasistencias:125])
		
	: ($dataType="registraInasistenciaDetallada")
		$y_refJson->:=STWA2_InasistenciaPorHoraDAO ($y_Names;$y_Data)
		$0:=True:C214
	: ($dataType="marcaAsistenciaRegistrada")
		ARRAY LONGINT:C221($al_sesion;0)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha"))
		$t_Sesion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idSesion")
		$t_check:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"check")
		
		AT_Text2Array (->$al_sesion;$t_Sesion;"_")
		SORT ARRAY:C229($al_sesion;<)
		
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		For ($i;1;Size of array:C274($al_sesion))
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$al_sesion{$i})
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=(($t_check="true") | ($t_check="True"))
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=DTS_Get_GMT_TimeStamp 
			[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName ($userID)
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			Log_RegisterEvtSTW ("Asistencia y Atrasos: Se marca registro de asistencia. \rSesión: "+String:C10([Asignaturas_RegistroSesiones:168]ID_Sesion:1)+" , Fecha: "+String:C10($fecha);$userID)
		End for 
		
		$0:=True:C214
		
	: ($dataType="MarcaDesmarcaImpartida")
		ARRAY LONGINT:C221($al_sesion;0)
		$userID:=STWA2_Session_GetUserSTID ($uuid)
		$fecha:=Date:C102(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"fecha"))
		$t_Sesion:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"idSesion")
		$b_checked:=Choose:C955(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"check")="false";False:C215;True:C214)
		AT_Text2Array (->$al_sesion;$t_Sesion;"_")
		SORT ARRAY:C229($al_sesion;<)
		
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		For ($i;1;Size of array:C274($al_sesion))
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$al_sesion{$i})
			[Asignaturas_RegistroSesiones:168]Impartida:5:=$b_checked
			SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
			Log_RegisterEvtSTW ("Asistencia y Atrasos: Se marca Sesión como impartida. \rSesión: "+String:C10([Asignaturas_RegistroSesiones:168]ID_Sesion:1)+" , Fecha: "+String:C10($fecha);$userID)
			
		End for 
		
		$0:=True:C214
		
	: ($dataType="guardaNombreParciales")
		
		C_OBJECT:C1216($o_dataAsig;$o_dataSubAsig)
		C_BOOLEAN:C305($b_save)
		$o_dataAsig:=JSON Parse:C1218(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"asignatura");Is object:K8:27)
		$o_dataSubAsig:=JSON Parse:C1218(NV_GetValueFromPairedArrays ($y_Names;$y_Data;"subasignatura");Is object:K8:27)
		$b_save:=STWA2_GuardaNombreParciales ($o_dataAsig;$o_dataSubAsig;$userID)
		$0:=$b_save
		
	: ($dataType="anotacionResponsive")
		$y_refJson->:=STWA2_AnotacionResponsiveDAO ($y_Names;$y_Data)
		$0:=True:C214
		
	: ($dataType="castigosResponsive")
		$y_refJson->:=STWA2_CastigosResponsiveDAO ($y_Names;$y_Data)
		$0:=True:C214
		
	: ($dataType="suspensionesResponsive")
		$y_refJson->:=STWA2_SuspensionesResponsiveDAO ($y_Names;$y_Data)
		$0:=True:C214
		
	: ($dataType="licenciasResponsive")
		$y_refJson->:=STWA2_LicenciasResponsiveDAO ($y_Names;$y_Data)
		$0:=True:C214
		
	: ($dataType="guardarPropiedadesEvaluacion")
		$y_refJson->:=STWA2conf_GuardaConfPropEval ($y_Names;$y_Data)
		$0:=True:C214
	: ($dataType="url-guias")
		$y_refJson->:=STWA2_MaterialDocenteDAO ($y_Names;$y_Data)
		$0:=True:C214
		
	: ($dataType="guardaPrefGrafico")
		$y_refJson->:=STWA2_Dash_PrefGrafAprendizajes ("guardaPrefencia";$y_Names;$y_Data)
		$0:=True:C214
		
	Else 
		$0:=False:C215
End case 
KRL_UnloadReadOnly (->[Alumnos_Calificaciones:208])
KRL_UnloadReadOnly (->[Alumnos_ComplementoEvaluacion:209])