//%attributes = {}
  //CAE_EjecutaCierreAgnoEscolar

C_BLOB:C604(xblob;$1)
xBlob:=$1


If (Not:C34(Semaphore:C143("CierreAñoEscolar")))
	BLOB_Blob2Vars (->xBlob;0;->bHistorico;->vi_AgnosHistorico;->bEnfermeria;->vi_AgnosEnfermeria;->bOrientacion;->vi_AgnosOrientacion;->bEventos;->vi_AgnosEventos;->bColación;->bFotografia;->r1InitPropEvaluacion;->r2InitPropEvaluacion;->bBackup;->bInitPonderaciones;->bEliminarSubasignaturas;->bInicializarConsolidaciones;->bInitNumMatricula;->i1InitNumMatricula;->i2InitNumMatricula;->vt_backupFolder;->vt_backupFile;->c1_EnCursos;->c2_enCursosTemporales;->cb_InscribeEnAsignaturas;->bArchive;->bDeleteRejected;->cbDeleteArchive;->vlADT_YearDeleteArchives)
	$onServer:=<>onServer
	<>stopDaemons:=True:C214
	0xDev_AvoidTriggerExecution (True:C214)
	<>onServer:=False:C215
	<>NoBatchProcessor:=True:C214
	<>NoLog:=True:C214
	<>MarcaRegistrosCMT:=True:C214  // para evitar que se marquen los registros de CMT
	
	dhXS_StopApplicationProcess 
	
	SYS_READVERSION 
	STR_LeeConfiguracion 
	EVS_LoadStyles 
	STR_CargaArreglosInterproceso 
	STR_Inicializaciones 
	
	TRACE:C157
	
	If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
		$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
		If ($step=0)
			If (Position:C15("//";vt_backupFolder)>0)
				vt_backupFolder:=Substring:C12(vt_backupFolder;Position:C15("//";vt_backupFolder)+2)
			End if 
			<>vd_FechaBloqueoSchoolTrack:=Current date:C33(*)
			PREF_Set (0;"BloqueoRecalculosSchoolTrack";String:C10(<>vd_FechaBloqueoSchoolTrack))
			SYS_CopiaArchivosBD (vt_backupFolder)
			PREF_Set (0;"Cierre del año escolar";"-1:Respaldo realizado")
			LOG_RegisterEvt ("Cierre de año escolar: Respaldo realizado.")
		End if 
	End if 
	
	QUERY:C277([xShell_Logs:37];[xShell_Logs:37]Module:8#"AccountTrack")
	  //KRL_DeleteSelection (->[xShell_Logs];True;__ ("Eliminando entradas en el registro de actividades..."))
	APPLY TO SELECTION:C70([xShell_Logs:37];[xShell_Logs:37]Periodo_Cerrado:9:=True:C214)
	KRL_UnloadReadOnly (->[xShell_Logs:37])
	FLUSH CACHE:C297
	DELAY PROCESS:C323(Current process:C322;60)
	
	READ WRITE:C146([xxSTR_DatosDeCierre:24])
	QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1=<>gYear)
	If (Records in selection:C76([xxSTR_DatosDeCierre:24])=0)
		CREATE RECORD:C68([xxSTR_DatosDeCierre:24])
	End if 
	[xxSTR_DatosDeCierre:24]Year:1:=<>gYear
	[xxSTR_DatosDeCierre:24]xPreferences:4:=xBlob
	SAVE RECORD:C53([xxSTR_DatosDeCierre:24])
	KRL_ReloadAsReadOnly (->[xxSTR_DatosDeCierre:24])
	
	If (bEnfermeria=1)
		$date:=DT_GetDateFromDayMonthYear (1;1;vi_AgnosEnfermeria)
		READ WRITE:C146([Alumnos_EventosEnfermeria:14])
		QUERY:C277([Alumnos_EventosEnfermeria:14];[Alumnos_EventosEnfermeria:14]Fecha:2<$date)
		DELETE SELECTION:C66([Alumnos_EventosEnfermeria:14])
		LOG_RegisterEvt ("Cierre de año escolar: Eliminación de registros de eventos enfermería anteriores "+"a "+String:C10(vi_AgnosEnfermeria))
	End if 
	
	If (bOrientacion=1)
		$date:=DT_GetDateFromDayMonthYear (1;1;vi_AgnosOrientacion)
		READ WRITE:C146([Alumnos_EventosOrientacion:21])
		QUERY:C277([Alumnos_EventosOrientacion:21];[Alumnos_EventosOrientacion:21]Fecha:2<$date)
		DELETE SELECTION:C66([Alumnos_EventosOrientacion:21])
		
		$date:=DT_GetDateFromDayMonthYear (1;1;vi_AgnosOrientacion)
		READ WRITE:C146([Alumnos_ObsOrientacion:127])
		QUERY:C277([Alumnos_ObsOrientacion:127];[Alumnos_ObsOrientacion:127]Fecha_observación:2<$date)
		DELETE SELECTION:C66([Alumnos_ObsOrientacion:127])
		LOG_RegisterEvt ("Cierre de año escolar: Eliminación de registros de eventos orientación de alumnos"+" anteriores "+"a "+String:C10(vi_AgnosOrientacion))
	End if 
	
	If (bEventos=1)
		$date:=DT_GetDateFromDayMonthYear (1;1;vi_AgnosEventos)
		READ WRITE:C146([Alumnos_EventosPersonales:16])
		QUERY:C277([Alumnos_EventosPersonales:16];[Alumnos_EventosPersonales:16]Fecha:3<$date)
		DELETE SELECTION:C66([Alumnos_EventosPersonales:16])
		
		$date:=DT_GetDateFromDayMonthYear (1;1;vi_AgnosEventos)
		READ WRITE:C146([Familia_RegistroEventos:140])
		QUERY:C277([Familia_RegistroEventos:140];[Familia_RegistroEventos:140]Fecha_Evento:2<$date)
		DELETE SELECTION:C66([Familia_RegistroEventos:140])
		LOG_RegisterEvt ("Cierre de año escolar: Eliminación de registros de eventos personales de alumnos "+"anteriores "+"a "+String:C10(vi_AgnosEventos))
		FLUSH CACHE:C297
	End if 
	
	$date:=DT_GetDateFromDayMonthYear (1;1;vi_AgnosHistorico)
	QUERY:C277([Asignaturas_PlanesDeClases:169];[Asignaturas_PlanesDeClases:169]Desde:3<$Date)
	KRL_DeleteSelection (->[Asignaturas_PlanesDeClases:169];True:C214;__ ("Eliminando Planes de Clases anteriores a ")+String:C10(vi_AgnosHistorico)+"...")
	LOG_RegisterEvt ("Cierre de año escolar: Eliminación de registros de planes de clases "+"anteriores "+"a "+String:C10(vi_AgnosHistorico))
	FLUSH CACHE:C297
	
	$date:=DT_GetDateFromDayMonthYear (1;1;vi_AgnosHistorico)
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3<$Date)
	KRL_DeleteSelection (->[Asignaturas_RegistroSesiones:168];True:C214;__ ("Eliminando registros de Sesiones de Clases anteriores a ")+String:C10(vi_AgnosHistorico)+"...")
	LOG_RegisterEvt ("Cierre de año escolar: Eliminación de registros evaluación de destrezas "+"anteriores "+"a "+String:C10(vi_AgnosHistorico))
	FLUSH CACHE:C297
	
	ALL RECORDS:C47([xxBBL_Logs:41])
	KRL_DeleteSelection (->[xxBBL_Logs:41];True:C214;__ ("Eliminando Bitácora de Circulación Mediatrack..."))
	DELAY PROCESS:C323(Current process:C322;60)
	LOG_RegisterEvt ("Cierre de año escolar: Eliminación de bitácora de circulación de MediaTrack")
	FLUSH CACHE:C297
	
	
	ALL RECORDS:C47([xShell_ErrorLog:34])
	KRL_DeleteSelection (->[xShell_ErrorLog:34];True:C214;__ ("Eliminando Bitácora de errores..."))
	DELAY PROCESS:C323(Current process:C322;60)
	LOG_RegisterEvt ("Cierre de año escolar: Eliminación de bitácora de errores")
	FLUSH CACHE:C297
	
	
	ALL RECORDS:C47([xxSNT_LOG:93])
	KRL_DeleteSelection (->[xxSNT_LOG:93];True:C214;__ ("Eliminando Bitácora de eventos SchoolNet..."))
	DELAY PROCESS:C323(Current process:C322;60)
	LOG_RegisterEvt ("Cierre de año escolar: Eliminación de bitácora de eventos SchoolNet")
	FLUSH CACHE:C297
	
	  //20131217 RCH Se eliminan registros historicos de info calificacion
	READ WRITE:C146([xxSTR_InfoCalificaciones:142])
	ALL RECORDS:C47([xxSTR_InfoCalificaciones:142])
	KRL_DeleteSelection (->[xxSTR_InfoCalificaciones:142];True:C214;__ ("Eliminando info calificaciones..."))
	KRL_UnloadReadOnly (->[xxSTR_InfoCalificaciones:142])
	LOG_RegisterEvt ("Cierre de año escolar: Eliminación de info calificaciones")
	FLUSH CACHE:C297
	
	  //inicializacion de campos propios
	CAE_InicializeUserFields ("SchoolTrack")
	CAE_InicializeUserFields ("MediaTrack")
	CAE_InicializeUserFields ("AdmissionTrack")
	LOG_RegisterEvt ("Cierre de año escolar: inicialización de campos propios")
	FLUSH CACHE:C297
	
	
	  //inicialización de propiedades de Evaluacion
	CAE_InitPropiedadesEvaluacion 
	LOG_RegisterEvt ("Cierre de año escolar: Inicialización de propiedades de evaluación según preferen"+"cias para el año "+String:C10(<>gYear))
	PREF_Set (0;"Cierre del año escolar";"1: Eliminación de registros e inicializaciones previas al archivaje")
	FLUSH CACHE:C297
	
	
	$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
	If ($step<2)
		vl_UltimoAño:=<>gYear
		vt_NombreUltimoAñoEscolar:=<>gNombreAgnoEscolar
		CAE_CreaHistoricoEstilosEval 
		CAE_CreaHistoricoNiveles 
		CAE_AperturaNuevoAgnoEscolar 
		PREF_Set (0;"Cierre del año escolar";"2:Año"+String:C10(<>gYear)+" iniciado")
	End if 
	
	  //Proceso de archivage  
	$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
	If ($step<3)
		CAE_CreaArchivosHistoricos 
	End if 
	
	
	
	0xDev_AvoidTriggerExecution (False:C215)  //se reestablece la ejecució de triggers para que la inicialización de evaluaciones se haga correctamente.
	
	  //PROCESO DE PROMOCION
	$step:=Num:C11(ST_GetWord (PREF_fGet (0;"Cierre del año escolar";"0");1;":"))
	If ($step<9)
		CAE_PromueveAlumnos 
		PREF_Set (0;"Cierre del año escolar";"9:Promoción terminada")
		LOG_RegisterEvt ("Cierre de año escolar: Promoción de alumnos terminada.")
	End if 
	FLUSH CACHE:C297
	
	
	$step:=Num:C11(Substring:C12(PREF_fGet (0;"Cierre del año escolar");1;2))
	If ($step<10)
		ARRAY LONGINT:C221($aIds;0)
		
		$pId:=IT_UThermometer (1;0;__ ("Cerrando registros de [Asignaturas_SintesisAnual] del año ")+vt_NombreUltimoAñoEscolar)
		  //fuerzo la ejecución del trigger en los registros del año anterior y pasarlos los Ids a negativo (en el trigger) impidiendo así que los registros de años anteriores se cargen al activar la relación
		READ WRITE:C146([Asignaturas_SintesisAnual:202])
		QUERY:C277([Asignaturas_SintesisAnual:202];[Asignaturas_SintesisAnual:202]Año:3;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Asignaturas_SintesisAnual:202]ID_Asignatura:2;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Asignaturas_SintesisAnual:202]ID_Asignatura:2)
		UNLOAD RECORD:C212([Asignaturas_SintesisAnual:202])
		READ ONLY:C145([Asignaturas_SintesisAnual:202])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_SintesisAnual] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_SintesisAnual:210])
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]ID_Alumno:4;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_SintesisAnual:210]ID_Alumno:4)
		UNLOAD RECORD:C212([Alumnos_SintesisAnual:210])
		READ ONLY:C145([Alumnos_SintesisAnual:210])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Cursos_SintesisAnual] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Cursos_SintesisAnual:63])
		QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Cursos_SintesisAnual:63]ID_Curso:52;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Cursos_SintesisAnual:63]ID_Curso:52)
		UNLOAD RECORD:C212([Cursos_SintesisAnual:63])
		READ ONLY:C145([Cursos_SintesisAnual:63])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_ComplementoEvaluacion] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_ComplementoEvaluacion:209])
		QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]Año:3;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]ID_Alumno:6;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6)
		UNLOAD RECORD:C212([Alumnos_ComplementoEvaluacion:209])
		READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Calificaciones] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_Calificaciones:208])
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Año:3;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_Calificaciones:208]ID_Alumno:6)
		UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
		READ ONLY:C145([Alumnos_Calificaciones:208])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_EvaluacionesEspeciales] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_EvaluacionesEspeciales:211])
		QUERY:C277([Alumnos_EvaluacionesEspeciales:211];[Alumnos_EvaluacionesEspeciales:211]Año:3;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_EvaluacionesEspeciales:211]ID_Alumno:4)
		UNLOAD RECORD:C212([Alumnos_EvaluacionesEspeciales:211])
		READ ONLY:C145([Alumnos_EvaluacionesEspeciales:211])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Anotaciones] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_Anotaciones:11])
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Año:11;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_Anotaciones:11]Alumno_Numero:6;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_Anotaciones:11]Alumno_Numero:6)
		UNLOAD RECORD:C212([Alumnos_Anotaciones:11])
		READ ONLY:C145([Alumnos_Anotaciones:11])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Inasistencias] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_Inasistencias:10])
		QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Año:8;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_Inasistencias:10]Alumno_Numero:4;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_Inasistencias:10]Alumno_Numero:4)
		UNLOAD RECORD:C212([Alumnos_Inasistencias:10])
		READ ONLY:C145([Alumnos_Inasistencias:10])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Atrasos] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_Atrasos:55])
		QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Año:6;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_Atrasos:55]Alumno_numero:1;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_Atrasos:55]Alumno_numero:1)
		UNLOAD RECORD:C212([Alumnos_Atrasos:55])
		READ ONLY:C145([Alumnos_Atrasos:55])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Castigos] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_Castigos:9])
		QUERY:C277([Alumnos_Castigos:9];[Alumnos_Castigos:9]Año:5;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_Castigos:9]Alumno_Numero:8;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_Castigos:9]Alumno_Numero:8)
		UNLOAD RECORD:C212([Alumnos_Castigos:9])
		READ ONLY:C145([Alumnos_Castigos:9])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Suspensiones] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_Suspensiones:12])
		QUERY:C277([Alumnos_Suspensiones:12];[Alumnos_Suspensiones:12]Año:1;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_Suspensiones:12]Alumno_Numero:7;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_Suspensiones:12]Alumno_Numero:7)
		UNLOAD RECORD:C212([Alumnos_Suspensiones:12])
		READ ONLY:C145([Alumnos_Suspensiones:12])
		
		$pId:=IT_UThermometer (0;$pID;__ ("Cerrando registros de [Alumnos_Licencias] del año ")+vt_NombreUltimoAñoEscolar)
		READ WRITE:C146([Alumnos_Licencias:73])
		QUERY:C277([Alumnos_Licencias:73];[Alumnos_Licencias:73]Año:9;=;vl_UltimoAño)
		SELECTION TO ARRAY:C260([Alumnos_Licencias:73]Alumno_numero:1;$aIds)
		ARRAY TO SELECTION:C261($aIds;[Alumnos_Licencias:73]Alumno_numero:1)
		UNLOAD RECORD:C212([Alumnos_Licencias:73])
		READ ONLY:C145([Alumnos_Licencias:73])
		$pId:=IT_UThermometer (-2;$pId)
		
		
		  //JVP 20160706 metodo para limpiar la evaluacion personal
		CAE_InitEvaluacionValorica 
		  //
		
		
		  //----
		  //20111203 Se comenta el metodo porque estaba desactivando los triggers
		  //CAE_Familias_Apoderados_Cuentas 
		dbu_CountFamilyStudents 
		ALL RECORDS:C47([Cursos_Delegados:110])
		READ WRITE:C146([Cursos_Delegados:110])
		DELETE SELECTION:C66([Cursos_Delegados:110])
		
		
		STR_ReadGlobals 
		CAE_InicializaActividades   //20160531 ASM Ticket 162338 No se inizializan las actividades 
		CAE_InicializacionAsignaturas 
		CAE_InicializacionAlumnos 
		CAE_InicializacionCursos 
		dbu_CountSubjectStudents 
		CAE_AsignaNumerosLista 
		PCSrun_AS_AsignaNumerosDeLista (2)
		
		<>vd_FechaBloqueoSchoolTrack:=!00-00-00!
		PREF_Set (0;"BloqueoRecalculosSchoolTrack";String:C10(<>vd_FechaBloqueoSchoolTrack))
		
		PREF_Set (0;"Cierre del año escolar";"10:Inicialización "+String:C10(<>gYear))
		LOG_RegisterEvt ("Cierre de año escolar: Inicialización para el año "+String:C10(<>gYear)+" terminada")
		FLUSH CACHE:C297
	End if 
	
	
	PREF_Set (0;"Cierre del año escolar";"0")
	FLUSH CACHE:C297
	CLEAR SEMAPHORE:C144("CierreAñoEscolar")
	SET BLOB SIZE:C606(xBlob;0)
	
	CD_Dlog (0;__ ("Clausura del año escolar terminada\rNo olvide configurar correctamente los períodos escolares para el nuevo año escolar."))
	CAE_VerificaPromocionAlumnos 
	
	OK:=CD_Dlog (0;__ ("SchoolTrack puede verificar la base de datos para detectar eventuales registros o index corruptos.\r\r\r¿Desea usted verificar el estado de su base de datos post cierre del año escolar?");__ ("");__ ("Si");__ ("No. ahora no"))
	If (OK=1)
		OK:=KRL_CheckAndFix_Database 
		If (OK=1)
			LOG_RegisterEvt ("La base de datos fue verificada exitosamente después de terminar el cierre del añ"+"o escolar.")
		Else 
			LOG_RegisterEvt ("Se detectó corrupción de la base de datos después de terminar el cierre del año e"+"scolar.")
		End if 
	Else 
		LOG_RegisterEvt ("No se realizó la verificación de la base de datos post cierre del año escolar por"+" decisión del usuario.")
	End if 
	
	
	<>onServer:=$onserver
	<>NoBatchProcessor:=False:C215
	<>NoLog:=False:C215
	<>stopDaemons:=False:C215
	
	  // para enviar datos a CMT post cierre.
	NET_Configuration ("Read")
	If ((<>vl_CMT_OnOff=1) & (LICENCIA_esModuloAutorizado (1;CommTrack)))
		<>MarcaRegistrosCMT:=False:C215
		If (Application type:C494=4D Server:K5:6)
			If (<>bXS_esServidorOficial)
				CMT_Send_Info 
			End if 
		Else 
			$resp:=CD_Dlog (0;__ ("¿Desea hacer un envío completo de datos a Commtrack?.");__ ("");__ ("Si");__ ("No"))
			If ($resp=1)
				CMT_Send_Info 
			End if 
		End if 
	End if 
	
	dhXS_StartApplicationProcesses 
	
	LOG_RegisterEvt ("El cierre de año "+String:C10(<>gyear-1)+" fue realizado con la versión "+SYS_LeeVersionBaseDeDatos )
	
End if 