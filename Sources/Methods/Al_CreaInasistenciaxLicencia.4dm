//%attributes = {}


  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 10-01-18, 11:49:29
  // ----------------------------------------------------
  // Método: Al_CreaInasistenciaxLicencia
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------


C_OBJECT:C1216($o_parametros)
ARRAY LONGINT:C221($al_alumnos;0)
ARRAY TEXT:C222($at_uuidLicencias;0)
C_TEXT:C284($t_Motivo)
C_DATE:C307($d_fechaHasta)

$o_parametros:=$1

$l_CrearInasistencias:=Num:C11(OB Get:C1224($o_parametros;"crear_inasistencia"))
$l_CrearInasistenciasFuturas:=Num:C11(OB Get:C1224($o_parametros;"crear_inasistencia_futura"))
$dateFrom:=Date:C102(OB Get:C1224($o_parametros;"fecha_desde"))
$dateTo:=Date:C102(OB Get:C1224($o_parametros;"fecha_hasta"))
$t_Motivo:=OB Get:C1224($o_parametros;"motivo")
$l_nivelNumero:=Num:C11(OB Get:C1224($o_parametros;"nivel_numero"))
OB GET ARRAY:C1229($o_parametros;"licenciasUUID";$at_uuidLicencias)

PERIODOS_LoadData ($l_nivelNumero)
$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivelNumero;->[xxSTR_Niveles:6]AttendanceMode:3)

For ($l_indice;1;Size of array:C274($at_uuidLicencias))
	QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Auto_UUID:12=$at_uuidLicencias{$l_indice})
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Licencias:73]Alumno_numero:1)
	If ((($l_CrearInasistencias=1) | ($l_CrearInasistenciasFuturas=1)) & ($l_modoRegistroAsistencia=1))
		$date:=$dateFrom
		Repeat 
			READ WRITE:C146([Alumnos_Inasistencias:10])
			QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=[Alumnos_Licencias:73]Alumno_numero:1;*)
			QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1=$date)
			If (Records in selection:C76([Alumnos_Inasistencias:10])=0)
				If ((Find in array:C230(adSTR_Calendario_Feriados;$date)=-1) & (DateIsValid ($date;0)))
					If (($date>Current date:C33(*)) & ($l_CrearInasistenciasFuturas=0))
						$date:=$dateTo+1
					Else 
						If (($date<=Current date:C33(*)) | ($l_CrearInasistenciasFuturas=1))
							CREATE RECORD:C68([Alumnos_Inasistencias:10])
							[Alumnos_Inasistencias:10]Alumno_Numero:4:=[Alumnos:2]numero:1
							[Alumnos_Inasistencias:10]Nivel_Numero:9:=[Alumnos:2]nivel_numero:29
							[Alumnos_Inasistencias:10]Fecha:1:=$date
							[Alumnos_Inasistencias:10]Licencia:5:=[Alumnos_Licencias:73]ID:6
							[Alumnos_Inasistencias:10]Justificación:2:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
							SAVE RECORD:C53([Alumnos_Inasistencias:10])
							UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
						End if 
					End if 
				End if 
			End if 
			$date:=$date+1
		Until ($date>$dateTo)
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
				UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
				NEXT RECORD:C51([Alumnos_Inasistencias:10])
			Else 
				BM_CreateRequest ("Justifica Inasistencias";String:C10([Alumnos_Licencias:73]ID:6);String:C10([Alumnos_Licencias:73]ID:6))
			End if 
		End for 
	End if 
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[Alumnos_Licencias:73]Alumno_numero:1)
	
	If ($l_modoRegistroAsistencia=2)
		
		  // justifico las inasistencias ya registradas
		QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos_Licencias:73]Alumno_numero:1;*)
		QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4>=[Alumnos_Licencias:73]Desde:2;*)
		QUERY:C277([Asignaturas_Inasistencias:125]; & [Asignaturas_Inasistencias:125]dateSesion:4<=[Alumnos_Licencias:73]Hasta:3)
		If (Records in selection:C76([Asignaturas_Inasistencias:125])>0)
			For ($i;1;Records in selection:C76([Asignaturas_Inasistencias:125]))
				$isReadWrite:=KRL_LoadRecordLoop (->[Asignaturas_Inasistencias:125];5)
				If ($isReadWrite)
					[Asignaturas_Inasistencias:125]ID_Licencia:9:=[Alumnos_Licencias:73]ID:6
					[Asignaturas_Inasistencias:125]Justificacion:3:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
					If ([Asignaturas_Inasistencias:125]Observaciones:5#"")
						[Asignaturas_Inasistencias:125]Observaciones:5:=[Alumnos_Inasistencias:10]Observaciones:3+"\r"+[Alumnos_Licencias:73]Observaciones:5
					Else 
						[Alumnos_Inasistencias:10]Observaciones:3:=[Alumnos_Licencias:73]Observaciones:5
					End if 
					SAVE RECORD:C53([Asignaturas_Inasistencias:125])
					AL_InasistenciaDiariaPorHoras ([Alumnos_Licencias:73]Alumno_numero:1;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
					UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
					NEXT RECORD:C51([Asignaturas_Inasistencias:125])
				Else 
					BM_CreateRequest ("Justifica Inasistencias";String:C10([Alumnos_Licencias:73]ID:6);String:C10([Alumnos_Licencias:73]ID:6))
				End if 
			End for 
		End if 
		
		
		  // creo las inasistencias a clases en los días en que hay sesiones de clases si la opción de creación está activada
		If ($l_CrearInasistencias=1)
			$d_fechaHasta:=Choose:C955([Alumnos_Licencias:73]Hasta:3>Current date:C33(*);Current date:C33(*);[Alumnos_Licencias:73]Hasta:3)  //Ticket 216174
			KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Licencias:73]Alumno_numero:1)
			KRL_RelateSelection (->[Asignaturas_RegistroSesiones:168]ID_Asignatura:2;->[Alumnos_Calificaciones:208]ID_Asignatura:5)
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>=[Alumnos_Licencias:73]Desde:2)
			QUERY SELECTION:C341([Asignaturas_RegistroSesiones:168]; & [Asignaturas_RegistroSesiones:168]Fecha_Sesion:3;<=;$d_fechaHasta)
			ARRAY LONGINT:C221($al_RecNums;0)
			LONGINT ARRAY FROM SELECTION:C647([Asignaturas_RegistroSesiones:168];$al_RecNums;"")
			For ($i_registros;1;Size of array:C274($al_RecNums))
				GOTO RECORD:C242([Asignaturas_RegistroSesiones:168];$al_RecNums{$i_registros})
				QUERY:C277([Asignaturas_Inasistencias:125];[Asignaturas_Inasistencias:125]ID_Alumno:2=[Alumnos_Licencias:73]Alumno_numero:1;*)
				QUERY:C277([Asignaturas_Inasistencias:125]; & ;[Asignaturas_Inasistencias:125]ID_Sesión:1=[Asignaturas_RegistroSesiones:168]ID_Sesion:1)
				If (Records in selection:C76([Asignaturas_Inasistencias:125])=0)
					CREATE RECORD:C68([Asignaturas_Inasistencias:125])
					[Asignaturas_Inasistencias:125]Año:11:=<>gYear
					[Asignaturas_Inasistencias:125]dateSesion:4:=[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3
					[Asignaturas_Inasistencias:125]Dia:7:=[Asignaturas_RegistroSesiones:168]NumeroDia:15
					[Asignaturas_Inasistencias:125]Hora:8:=[Asignaturas_RegistroSesiones:168]Hora:4
					[Asignaturas_Inasistencias:125]ID:10:=SQ_SeqNumber (->[Asignaturas_Inasistencias:125]ID:10)
					[Asignaturas_Inasistencias:125]ID_Alumno:2:=[Alumnos_Licencias:73]Alumno_numero:1
					[Asignaturas_Inasistencias:125]ID_Asignatura:6:=[Asignaturas_RegistroSesiones:168]ID_Asignatura:2
					[Asignaturas_Inasistencias:125]ID_Licencia:9:=[Alumnos_Licencias:73]ID:6
					[Asignaturas_Inasistencias:125]ID_Sesión:1:=[Asignaturas_RegistroSesiones:168]ID_Sesion:1
					[Asignaturas_Inasistencias:125]Justificacion:3:=[Alumnos_Licencias:73]Tipo_licencia:4+" Nº "+String:C10([Alumnos_Licencias:73]ID:6)
					[Asignaturas_Inasistencias:125]Observaciones:5:=[Alumnos_Licencias:73]Observaciones:5
					SAVE RECORD:C53([Asignaturas_Inasistencias:125])
					AL_InasistenciaDiariaPorHoras ([Alumnos_Licencias:73]Alumno_numero:1;[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3)
					UNLOAD RECORD:C212([Asignaturas_Inasistencias:125])
				End if 
			End for 
			$success:=AL_TotalizaInasistencias ([Alumnos_Licencias:73]Alumno_numero:1;[Alumnos:2]nivel_numero:29)
		End if 
	End if 
	
End for 