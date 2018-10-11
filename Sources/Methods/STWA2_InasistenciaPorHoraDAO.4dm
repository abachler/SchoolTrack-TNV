//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 25-07-18, 08:31:08
  // ----------------------------------------------------
  // Método: STWA2_InasistenciaPorHoraDAO
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_BOOLEAN:C305($b_continuar)
C_TEXT:C284($t_estado;$t_Sesion;$t_parametros)
C_BOOLEAN:C305($b_validaPermisos)
C_OBJECT:C1216($o_parametros)
C_OBJECT:C1216($o_respuesta)
ARRAY DATE:C224($ad_desde;0)
ARRAY DATE:C224($ad_hasta;0)
ARRAY LONGINT:C221($al_licID;0)
ARRAY LONGINT:C221($al_sesion;0)


$y_Names:=$1
$y_Data:=$2

$uuid:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"UUID")
$userID:=STWA2_Session_GetUserSTID ($uuid)
$userName:=USR_GetUserName ($userID)
$profID:=STWA2_Session_GetProfID ($uuid)


$t_parametros:=NV_GetValueFromPairedArrays ($y_Names;$y_Data;"parametros")
$o_parametros:=OB_JsonToObject ($t_parametros)

$b_validaPermisos:=OB Get:C1224($o_parametros;"vp";Is boolean:K8:9)
$rnAlumno:=OB Get:C1224($o_parametros;"rnAlumno";Is longint:K8:6)
$t_estadoActual:=OB Get:C1224($o_parametros;"estado_actual")
$t_estadoAnterior:=OB Get:C1224($o_parametros;"estado_anterior")
$fecha:=Date:C102(OB Get:C1224($o_parametros;"fecha"))
$t_Sesion:=OB Get:C1224($o_parametros;"idSesion")

  //Leo la preferencia para registrar inasistencia para  todo el día.
$l_CreaInasistenciaDiaCompleto:=Num:C11(PREF_fGet (0;"RegistraInasisteDiaCompleto";"1"))

AT_Text2Array (->$al_sesion;$t_Sesion;"_")
SORT ARRAY:C229($al_sesion;<)

  //valido permisos del usuario para registrar atrasos
$permisocrear:=USR_checkRights ("A";->[Asignaturas_Inasistencias:125];$userID)
$permitidoEliminar:=(USR_checkRights ("D";->[Asignaturas_Inasistencias:125];$userID))
$puedeEliminarAtraso:=USR_checkRights ("D";->[Alumnos_Conducta:8];$userID)
$puedeAgregarAtraso:=USR_checkRights ("A";->[Alumnos_Conducta:8];$userID)
$b_ConLicencia:=False:C215
$b_justificada:=False:C215
$l_firmanteProf:=Num:C11(PREF_fGet (0;"FirmantesAutorizados"))


Case of 
	: ($t_estadoActual="presente")
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		$b_permiso:=True:C214
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		
		QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_sesion)
		$b_esProfesor:=(([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=$profID) | ($l_firmanteProf=1))
		$b_continuar:=Choose:C955($b_validaPermisos;(($permitidoEliminar) | ($b_esProfesor));True:C214)
		
		If ($b_continuar)
			QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
			SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_desde;[Alumnos_Licencias:73]Hasta:3;$ad_hasta;[Alumnos_Licencias:73]ID:6;$al_licID)
			For ($i;1;Size of array:C274($ad_desde))
				If (($fecha>=$ad_desde{$i}) & ($fecha<=$ad_hasta{$i}))
					$b_ConLicencia:=True:C214
				End if 
			End for 
			
			QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_sesion)
			ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Hora:4;>)
			LAST RECORD:C200([Asignaturas_RegistroSesiones:168])
			$l_numeroHora:=[Asignaturas_RegistroSesiones:168]Hora:4
			
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$fecha;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Hora:8>$l_numeroHora)
			KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->[Asignaturas_Inasistencias:125]ID_Sesión:1;"")
			KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
			APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215)
			APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:="")
			APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:="")
			
			For ($l_indice;1;Size of array:C274($al_sesion))
				$l_idSesion:=$al_sesion{$l_indice}
				QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$l_idSesion)
				QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
				$l_hora:=[Asignaturas_RegistroSesiones:168]Hora:4
				
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$fecha;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_idSesion)
				
				$b_continuar:=Choose:C955($b_validaPermisos;((($puedeEliminarAtraso) | ($puedeAgregarAtraso)) | ($t_estadoAnterior#"atrasado") | ($b_esProfesor));True:C214)
				If ($b_continuar)
					
					If (KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])=1)
						  //elimino el atraso
						READ WRITE:C146([Alumnos_Atrasos:55])
						
						QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
						QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$fecha;*)
						QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=$l_hora)
						
						If (Records in selection:C76([Alumnos_Atrasos:55])>0)
							Log_RegisterEvtSTW ("Asistencia y Atrasos: Eliminación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
							KRL_DeleteSelection (->[Alumnos_Atrasos:55])
						End if 
						
						KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
						
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=DTS_Get_GMT_TimeStamp 
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName ($userID)
						SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
						
					End if 
					OB SET:C1220($o_respuesta;"estado";"presente")
				Else 
					$l_indice:=Size of array:C274($al_sesion)+1
					$b_permiso:=False:C215
				End if 
				
			End for 
			
		Else 
			OB SET:C1220($o_respuesta;"Permiso";False:C215)
			
		End if 
		OB SET:C1220($o_respuesta;"Permiso";$b_permiso)
		AL_InasistenciaDiariaPorHoras ([Alumnos:2]numero:1;$fecha)
		
		
	: ($t_estadoActual="ausente")
		
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		
		  //busco si existen licencias
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
		SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_desde;[Alumnos_Licencias:73]Hasta:3;$ad_hasta;[Alumnos_Licencias:73]ID:6;$al_licID)
		
		$b_esProfesor:=(([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=$profID) | ($l_firmanteProf=1))
		$b_continuar:=Choose:C955($b_validaPermisos;(($permisocrear) | ($b_esProfesor));True:C214)
		$b_registrado:=False:C215
		$b_justificada:=False:C215
		If ($b_continuar)
			  // si es la primera hora, dejo al alumno ausente el resto del día
			QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_sesion)
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Hora:4=1)
			If ((Records in selection:C76([Asignaturas_RegistroSesiones:168])>0) & ($l_CreaInasistenciaDiaCompleto=1))
				QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6=[Alumnos:2]numero:1)
				KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
				QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3=$fecha)
				SELECTION TO ARRAY:C260([Asignaturas_RegistroSesiones:168];$al_registroSesiones)
				
				For ($l_Sesione;1;Size of array:C274($al_registroSesiones))
					GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_registroSesiones{$l_Sesione})
					CREATE RECORD:C68([Asignaturas_Inasistencias:125])
					[Asignaturas_Inasistencias:125]ID_Alumno:2:=[Alumnos:2]numero:1
					[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
					[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
					[Asignaturas_Inasistencias:125]ID_Sesión:1:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
					[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
					[Asignaturas_Inasistencias:125]Dia:7:=[Asignaturas_RegistroSesiones:168]NumeroDia:15
					[Asignaturas_Inasistencias:125]Año:11:=[Asignaturas_RegistroSesiones:168]Año:13
					
					For ($i;1;Size of array:C274($ad_desde))
						If (($fecha>=$ad_desde{$i}) & ($fecha<=$ad_hasta{$i}))
							  //[Asignaturas_Inasistencias]ID_Licencia:=$lic{$jj}
							[Asignaturas_Inasistencias:125]ID_Licencia:9:=$al_licID{$i}  //20170913 RCH
							[Asignaturas_Inasistencias:125]Justificacion:3:="Licencia Nº "+String:C10($al_licID{$i})
							[Asignaturas_Inasistencias:125]Observaciones:5:="Licencia Nº "+String:C10($al_licID{$i})
							$i:=Size of array:C274($ad_desde)
						End if 
					End for 
					SAVE RECORD:C53([Asignaturas_Inasistencias:125])
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
					$t_mensaje:="Asistencia y Atrasos: Creación de inasistencia. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+", Fecha: "+String:C10($fecha)+"\rHora:"+String:C10([Asignaturas_RegistroSesiones:168]Hora:4)+"\r"
					$t_mensaje:=$t_mensaje+"Asignatura : "+[Asignaturas:18]Asignatura:3+" (ID: "+String:C10([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)+")"
					Log_RegisterEvtSTW ($t_mensaje;$userID)
					
					
					  //elimino el atraso
					READ WRITE:C146([Alumnos_Atrasos:55])
					
					QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$fecha;*)
					QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=[Asignaturas_RegistroSesiones:168]Hora:4)
					
					If (Records in selection:C76([Alumnos_Atrasos:55])>0)
						Log_RegisterEvtSTW ("Asistencia y Atrasos: Eliminación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
						KRL_DeleteSelection (->[Alumnos_Atrasos:55])
					End if 
					
					KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
					
					If ([Asignaturas_RegistroSesiones:168]Hora:4=1)
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=DTS_Get_GMT_TimeStamp 
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName ($userID)
					End if 
					SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
					OB SET:C1220($o_respuesta;"estado";"ausente")
					OB SET:C1220($o_respuesta;"inasistencia";[Asignaturas_Inasistencias:125]ID:10)
					UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
				End for 
			Else 
				For ($l_indice;1;Size of array:C274($al_sesion))
					$l_idSesion:=$al_sesion{$l_indice}
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$l_idSesion)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
					
					  //busco si existen licencias
					QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
					SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_desde;[Alumnos_Licencias:73]Hasta:3;$ad_hasta;[Alumnos_Licencias:73]ID:6;$al_licID)
					
					  //creo la inasistencia
					
					CREATE RECORD:C68([Asignaturas_Inasistencias:125])
					[Asignaturas_Inasistencias:125]ID_Alumno:2:=[Alumnos:2]numero:1
					[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
					[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
					[Asignaturas_Inasistencias:125]ID_Sesión:1:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
					[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
					[Asignaturas_Inasistencias:125]Dia:7:=[Asignaturas_RegistroSesiones:168]NumeroDia:15
					[Asignaturas_Inasistencias:125]Año:11:=[Asignaturas_RegistroSesiones:168]Año:13
					
					For ($i;1;Size of array:C274($ad_desde))
						If (($fecha>=$ad_desde{$i}) & ($fecha<=$ad_hasta{$i}))
							  //[Asignaturas_Inasistencias]ID_Licencia:=$lic{$jj}
							[Asignaturas_Inasistencias:125]ID_Licencia:9:=$al_licID{$i}  //20170913 RCH
							[Asignaturas_Inasistencias:125]Justificacion:3:="Licencia Nº "+String:C10($al_licID{$i})
							[Asignaturas_Inasistencias:125]Observaciones:5:="Licencia Nº "+String:C10($al_licID{$i})
							$i:=Size of array:C274($ad_desde)
							$b_justificada:=True:C214
						End if 
					End for 
					$b_registrado:=True:C214
					SAVE RECORD:C53([Asignaturas_Inasistencias:125])
					
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
					$t_mensaje:="Asistencia y Atrasos: Creación de inasistencia. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+", Fecha: "+String:C10($fecha)+"\rHora:"+String:C10([Asignaturas_RegistroSesiones:168]Hora:4)+"\r"
					$t_mensaje:=$t_mensaje+"Asignatura : "+[Asignaturas:18]Asignatura:3+" (ID: "+String:C10([Asignaturas_RegistroSesiones:168]ID_Asignatura:2)+")"
					Log_RegisterEvtSTW ($t_mensaje;$userID)
					
					[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
					[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=DTS_Get_GMT_TimeStamp 
					[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName ($userID)
					SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
					
					  //elimino el atraso
					READ WRITE:C146([Alumnos_Atrasos:55])
					
					QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
					QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$fecha;*)
					QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=[Asignaturas_RegistroSesiones:168]Hora:4)
					
					
					If (Records in selection:C76([Alumnos_Atrasos:55])>0)
						Log_RegisterEvtSTW ("Asistencia y Atrasos: Eliminación de atraso.\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
						KRL_DeleteSelection (->[Alumnos_Atrasos:55])
					End if 
					
					
					
					KRL_UnloadReadOnly (->[Alumnos_Atrasos:55])
					OB SET:C1220($o_respuesta;"estado";"ausente")
					OB SET:C1220($o_respuesta;"inasistencia";[Asignaturas_Inasistencias:125]ID:10)
					OB SET:C1220($o_respuesta;"motivo";[Asignaturas_Inasistencias:125]Justificacion:3)
					OB SET:C1220($o_respuesta;"observacion";[Asignaturas_Inasistencias:125]Observaciones:5)
					OB SET:C1220($o_respuesta;"esLicencia";[Asignaturas_Inasistencias:125]ID_Licencia:9#0)
					UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
				End for 
			End if 
			KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
			OB SET:C1220($o_respuesta;"Permiso";True:C214)
			OB SET:C1220($o_respuesta;"justificada";$b_justificada)
			OB SET:C1220($o_respuesta;"registrado";$b_registrado)
			If ($b_justificada)
				OB SET:C1220($o_respuesta;"estado";"justificado")
			End if 
		Else 
			OB SET:C1220($o_respuesta;"False";True:C214)
			OB SET:C1220($o_respuesta;"justificada";$b_justificada)
			OB SET:C1220($o_respuesta;"registrado";$b_registrado)
		End if 
		AL_InasistenciaDiariaPorHoras ([Alumnos:2]numero:1;$fecha)
		
	: ($t_estadoActual="atrasado")
		READ WRITE:C146([Asignaturas_RegistroSesiones:168])
		C_TEXT:C284($t_mensaje)
		C_LONGINT:C283($l_atrasoID)
		
		$l_atrasoID:=-1
		$b_registraAtraso:=True:C214
		
		GOTO RECORD:C242([Alumnos:2];$rnAlumno)
		
		QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_sesion)
		$b_esProfesor:=(([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=$profID) | ($l_firmanteProf=1))
		
		  //QUERY([Cursos];[Cursos]Curso=[Alumnos]Curso)
		  //$b_esProfesor:=$b_esProfesor | ([Cursos]Numero_del_profesor_jefe=$profID)
		$b_continuar:=Choose:C955($b_validaPermisos;(($permitidoEliminar) | ($b_esProfesor));True:C214)
		
		If ($b_continuar)
			  //verifico si existen inasistencias registradas posterior al cambio de estado para eliminarlas.
			QUERY WITH ARRAY:C644([Asignaturas_RegistroSesiones:168]ID_Sesion:1;$al_sesion)
			ORDER BY:C49([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Hora:4;>)
			LAST RECORD:C200([Asignaturas_RegistroSesiones:168])
			$l_numeroHora:=[Asignaturas_RegistroSesiones:168]Hora:4
			
			  //busco si existen licencias
			QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Alumno_numero:1=[Alumnos:2]numero:1)
			SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Desde:2;$ad_desde;[Alumnos_Licencias:73]Hasta:3;$ad_hasta;[Alumnos_Licencias:73]ID:6;$al_licID)
			For ($i;1;Size of array:C274($ad_desde))
				If (($fecha>=$ad_desde{$i}) & ($fecha<=$ad_hasta{$i}))
					$b_ConLicencia:=True:C214
				End if 
			End for 
			
			  //If (Not($b_ConLicencia))
			QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$fecha;*)
			QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]Hora:8>$l_numeroHora)
			KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Sesion:1;->[Asignaturas_Inasistencias:125]ID_Sesión:1;"")
			KRL_DeleteSelection (->[Asignaturas_Inasistencias:125])
			APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=False:C215)
			APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:="")
			APPLY TO SELECTION:C70([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:="")
			
			$b_atrasoRegistrado:=False:C215
			$b_continuar:=Choose:C955($b_validaPermisos;(($puedeAgregarAtraso) | ($b_esProfesor));True:C214)
			If ($b_continuar)
				For ($l_indice;1;Size of array:C274($al_sesion))
					$l_idSesion:=$al_sesion{$l_indice}
					QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$l_idSesion)
					QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
					
					$b_continuar:=Choose:C955($b_validaPermisos;(($puedeEliminarAtraso) | ($puedeAgregarAtraso) | ($b_esProfesor));True:C214)
					If ($b_continuar)
						
						QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
						QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$fecha;*)
						QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_idSesion)
						
						If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
							Log_RegisterEvtSTW ("Asistencia y Atrasos: Eliminación de inasistencia ID Sesión: "+String:C10($l_idSesion)+"\rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
						End if 
						DELETE RECORD:C58([Asignaturas_Inasistencias:125])
						
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada:18:=True:C214
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_DTS:19:=DTS_Get_GMT_TimeStamp 
						[Asignaturas_RegistroSesiones:168]AsistenciaRegistrada_Por:20:=USR_GetUserName ($userID)
						SAVE RECORD:C53([Asignaturas_RegistroSesiones:168])
						
						If ((OK=1) & (Not:C34($b_atrasoRegistrado)))
							
							  //verifico si existe ya un atraso registrado para esta hora
							QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=[Alumnos:2]numero:1;*)
							QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]Fecha:2=$fecha;*)
							QUERY:C277([Alumnos_Atrasos:55]; & ;[Alumnos_Atrasos:55]NumeroHora:11=[Asignaturas_RegistroSesiones:168]Hora:4)
							If (Records in selection:C76([Alumnos_Atrasos:55])=0)
								PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
								STR_LeePreferenciasAtrasos2 
								QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$l_idSesion)
								$l_posicionHora:=Find in array:C230(aiSTR_Horario_HoraNo;[Asignaturas_RegistroSesiones:168]Hora:4)
								
								CREATE RECORD:C68([Alumnos_Atrasos:55])
								[Alumnos_Atrasos:55]Fecha:2:=$fecha
								[Alumnos_Atrasos:55]Alumno_numero:1:=[Alumnos:2]numero:1
								[Alumnos_Atrasos:55]Observaciones:3:=""
								[Alumnos_Atrasos:55]MinutosAtraso:5:=ATSTRAL_FALTACONV{1}
								[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos:2]nivel_numero:29
								[Alumnos_Atrasos:55]id_justificacion:13:=0
								[Alumnos_Atrasos:55]justificado:14:=False:C215
								[Alumnos_Atrasos:55]NumeroHora:11:=[Asignaturas_RegistroSesiones:168]Hora:4
								[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=True:C214
								[Alumnos_Atrasos:55]HoradeAtraso:12:=alSTR_Horario_Desde{$l_posicionHora}+(ATSTRAL_FALTACONV{1}*60)
								[Alumnos_Atrasos:55]ID_Asignatura:15:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2  //MONO TICKET 180505
								SAVE RECORD:C53([Alumnos_Atrasos:55])
								If (Records in selection:C76([Alumnos_Atrasos:55])>0)
									Log_RegisterEvtSTW ("Asistencia y Atrasos: Creación de atraso. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
								End if 
								$b_atrasoRegistrado:=True:C214
								$l_recNumAlumno:=Record number:C243([Alumnos:2])
								$l_atrasoID:=[Alumnos_Atrasos:55]ID:7
								
								C_TEXT:C284($t_intervalo)
								ARRAY TEXT:C222($at_intervalos;0)
								STR_LeePreferenciasAtrasos2 
								AT_Text2Array (->$at_intervalos;vt_intervalos;",")
								$choice:=Find in array:C230(ATSTRAL_FALTACONV;[Alumnos_Atrasos:55]MinutosAtraso:5)
								If ($choice#-1)
									If (Size of array:C274($at_intervalos)>0)
										$t_intervalo:=$at_intervalos{$choice}
									End if 
								End if 
								
								OB SET:C1220($o_respuesta;"atrasoID";$l_atrasoID)
								OB SET:C1220($o_respuesta;"alumnosRN";$l_recNumAlumno)
								OB SET:C1220($o_respuesta;"estado";"atrasado")
								OB SET:C1220($o_respuesta;"registrado";$b_atrasoRegistrado)
								OB SET:C1220($o_respuesta;"mensaje";$t_mensaje)
								OB SET:C1220($o_respuesta;"ConLicencia";False:C215)
								OB SET:C1220($o_respuesta;"inter";True:C214)
								OB SET:C1220($o_respuesta;"intervalo_actual";$t_intervalo)
								OB SET:C1220($o_respuesta;"minutos";[Alumnos_Atrasos:55]MinutosAtraso:5)
								OB SET:C1220($o_respuesta;"motivoJustificacion";[Alumnos_Atrasos:55]id_justificacion:13)
								OB SET:C1220($o_respuesta;"justificado";[Alumnos_Atrasos:55]justificado:14)
								OB SET:C1220($o_respuesta;"observacion";[Alumnos_Atrasos:55]Observaciones:3)
								$b_atrasoRegistrado:=True:C214
								
								  // ASM Ticket 208501 Registro de atraso de inicio de jornada cuando se crear atraso en la primera hora.
								If ([Asignaturas_RegistroSesiones:168]Hora:4=1)
									If (Num:C11(PREF_fGet (0;"CrearAtrasoInicioJornada";"0"))=1)
										CREATE RECORD:C68([Alumnos_Atrasos:55])
										[Alumnos_Atrasos:55]Fecha:2:=$fecha
										[Alumnos_Atrasos:55]Alumno_numero:1:=[Alumnos:2]numero:1
										[Alumnos_Atrasos:55]Observaciones:3:=""
										[Alumnos_Atrasos:55]MinutosAtraso:5:=ATSTRAL_FALTACONV{1}
										[Alumnos_Atrasos:55]Nivel_Numero:8:=[Alumnos:2]nivel_numero:29
										[Alumnos_Atrasos:55]id_justificacion:13:=0
										[Alumnos_Atrasos:55]justificado:14:=False:C215
										[Alumnos_Atrasos:55]NumeroHora:11:=[Asignaturas_RegistroSesiones:168]Hora:4
										[Alumnos_Atrasos:55]EsAtrasoInterSesiones:4:=False:C215
										[Alumnos_Atrasos:55]CreadoPorConfiguracion:16:=True:C214
										[Alumnos_Atrasos:55]HoradeAtraso:12:=alSTR_Horario_Desde{$l_posicionHora}+(ATSTRAL_FALTACONV{1}*60)
										[Alumnos_Atrasos:55]ID_Asignatura:15:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2  //MONO TICKET 180505
										SAVE RECORD:C53([Alumnos_Atrasos:55])
										Log_RegisterEvtSTW ("Asistencia y Atrasos: Atraso de inicio de jornada creado automáticamente por configuración.. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
									End if 
								End if 
								
							Else 
								OB SET:C1220($o_respuesta;"registrado";True:C214)
								OB SET:C1220($o_respuesta;"ConLicencia";False:C215)
							End if 
							
						Else 
							$l_indice:=Size of array:C274($al_sesion)+1
							OB SET:C1220($o_respuesta;"registrado";$b_atrasoRegistrado)
							OB SET:C1220($o_respuesta;"ConLicencia";False:C215)
						End if 
					Else 
						$l_indice:=Size of array:C274($al_sesion)+1
						OB SET:C1220($o_respuesta;"registrado";False:C215)
						OB SET:C1220($o_respuesta;"ConLicencia";True:C214)
						
					End if 
					
				End for 
			Else 
				OB SET:C1220($o_respuesta;"registrado";False:C215)
				OB SET:C1220($o_respuesta;"ConLicencia";False:C215)
				
			End if 
			  //Else 
			  //OB_SET_Boolean ($y_refJson->;False;"registrado")
			  //OB_SET_Boolean ($y_refJson->;True;"ConLicencia")
			  //$0:=True
			  //End if 
			
		Else 
			OB SET:C1220($o_respuesta;"registrado";False:C215)
			OB SET:C1220($o_respuesta;"ConLicencia";False:C215)
			
		End if 
		KRL_UnloadReadOnly (->[Asignaturas_RegistroSesiones:168])
		AL_InasistenciaDiariaPorHoras ([Alumnos:2]numero:1;$fecha)
		
		
		
	: ($t_estadoActual="justificado")
		For ($l_indice;1;Size of array:C274($al_sesion))
			$l_idSesion:=$al_sesion{$l_indice}
			$b_registrado:=True:C214
			$b_esLicencia:=False:C215
			GOTO RECORD:C242([Alumnos:2];$rnAlumno)
			QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]ID_Sesion:1=$l_idSesion)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2)
			$b_esProfesor:=(([Asignaturas_RegistroSesiones:168]ProfesorAs_ID:10=$profID) | ($l_firmanteProf=1))
			
			  //QUERY([Cursos];[Cursos]Curso=[Alumnos]Curso)
			  //$b_esProfesor:=$b_esProfesor | ([Cursos]Numero_del_profesor_jefe=$profID)
			
			$b_continuar:=Choose:C955($b_validaPermisos;(($permisocrear) | ($b_esProfesor));True:C214)
			
			If ($b_continuar)
				
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Sesión:1=$l_idSesion;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos:2]numero:1;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]dateSesion:4=$fecha)
				[Asignaturas_Inasistencias:125]Justificacion:3:="justificada"
				[Asignaturas_Inasistencias:125]Observaciones:5:=""
				SAVE RECORD:C53([Asignaturas_Inasistencias:125])
				UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
				NEXT RECORD:C51([Asignaturas_Inasistencias:125])
				OB SET:C1220($o_respuesta;"registrado";$b_registrado)
				OB SET:C1220($o_respuesta;"esLicencia";$b_esLicencia)
				Log_RegisterEvtSTW ("Asistencia y Atrasos: Justificación de inasistencia. \rAlumno: "+[Alumnos:2]apellidos_y_nombres:40+" , Fecha: "+String:C10($fecha);$userID)
				OB SET:C1220($o_respuesta;"estado";"justificado")
				OB SET:C1220($o_respuesta;"motivo";"")
				OB SET:C1220($o_respuesta;"observacion";"")
				OB SET:C1220($o_respuesta;"esLicencia";[Asignaturas_Inasistencias:125]ID_Licencia:9#0)
			Else 
				OB SET:C1220($o_respuesta;"permiso";False:C215)
			End if 
		End for 
End case 

$0:=$o_respuesta