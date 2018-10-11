//%attributes = {}
  //UD_Handler
  //======================================================
  //No llamar QR_LoadLibrary!!!!!!!!!  Hay colegios que han pedido no ver los informes estandar.
  //======================================================
C_LONGINT:C283($l_versionBD)
$tempModuleName:=<>vsXS_CurrentModule
$tempModuleRef:=<>vlXS_CurrentModuleRef
vsBWR_CurrentModule:="Inicio y Actualización"
  //Initializing
C_BLOB:C604($vx_dateTimeBlob)
C_DATE:C307($currentDate)
C_TIME:C306($currentTime)
$onServer:=<>onServer
<>vb_msgOn:=True:C214
<>NoBatchProcessor:=True:C214
<>NoLog:=True:C214
READ ONLY:C145(*)
C_LONGINT:C283($l_versionPrincipal;$l_versionRevision;$l_versionBD_Build)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("principal";->$l_versionPrincipal)
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("revision";->$l_versionRevision)
$t_versionConFormato:=String:C10($l_versionPrincipal;"00")+"."+String:C10($l_versionRevision;"00")+"."+String:C10($l_versionBD_Build;"00000")
If (($l_versionBD_Build<13328) & ($l_versionPrincipal<12))
	  //UD_EjecutaMetodoActualizacion ("UD_v20140102_Shell_Queries")
	  //UD_EjecutaMetodoActualizacion ("UD_v20131220_VerificaUUID")
	UD_EjecutaMetodoActualizacion ("UD_v20140106_AsignaAutoUUID")
End if 
UD_v20140708_VerificaIndexPK 
If ($l_versionBD_Build<13151)
	ALL RECORDS:C47([xShell_Tables:51])
	KRL_DeleteSelection (->[xShell_Tables:51])
	ALL RECORDS:C47([xShell_TableAlias:199])
	KRL_DeleteSelection (->[xShell_TableAlias:199])
	ALL RECORDS:C47([xShell_Tables_RelatedFiles:243])
	KRL_DeleteSelection (->[xShell_Tables_RelatedFiles:243])
	ALL RECORDS:C47([xShell_Fields:52])
	KRL_DeleteSelection (->[xShell_Fields:52])
	ALL RECORDS:C47([xShell_FieldAlias:198])
	KRL_DeleteSelection (->[xShell_FieldAlias:198])
End if 
CFG_LoadDevelopperConfig 
SQ_SetSequences 
SQ_CargaDatos 

VS_LoadAutoFormatRefs 
STR_CargaArreglosInterproceso 
STR_LeeConfiguracion 
EVS_initialize 
EVS_LoadStyles 
EVS_CargaMatrizEstilosEval 
BBL_LeeConfiguracion 
INstk_CreaMatrizVacunacion 
MDATA_UpdateDictionnary 
STWA2_ManejaImagenResponsive ("UD_handler")
SR_CargaInformesLCD   //20180323 ASM Cargar los informes LCD para Chile
STWA2_CreaImagenAlumnosEnDisco ("ExportarTodo")  //20180616 ASM Ticket 206719

  //ACTinit_CreateUFTables  `20110609 RCH Se quita de la actualizacion debido a que cuando el colegio instala la version no siempre el IPC esta correcto en la version...
ACTwtrf_LoadLibrary 
  //ACTtrf_LoadLibrary
QRY_LoadLibrary 
  //20120111 RCH Se agega verificacion de informes SR
RIN_ActualizaInformes 
ADT_LoadMetadatos   // 20120627 ASM para cargar los metadatos estandar de ADT
<>lUSR_CurrentUserID:=0

CIM_CuentaRegistros ("GuardaArchivo")

  //AS. Elimina sisntesis anual con nivel superior al del alumno.
If ($l_versionBD_Build<12009)
	UD_v20110629_EliminaSintesisAlu 
	UD_v20110630_UserConnections 
End if 
  //PS: Se eliminan sintesis anuales de niveles menores a -1000 (niveles POST)
If ($l_versionBD_Build<12009)
	UD_v20110630_STR_DelSaPOST 
End if 
If ($l_versionBD_Build<12011)
	UD_v20110629_EliminaSintesisAlu 
End if 
If ($l_versionBD_Build<12012)
	UD_v20110721_CopyFilesADT 
End if 
If ($l_versionBD_Build<12015)
	UD_v20110728_AñosCierre 
	UD_v20110729_EstilosHistoricos 
End if 
If ($l_versionBD_Build<12019)
	  // asignación de algunos campos de la tabla mediante la lectura del blob de períodos
	  //para forzar ejecución del trigger, se autoactualiza
	ALL RECORDS:C47([xxSTR_HistoricoNiveles:191])
	READ WRITE:C146([xxSTR_HistoricoNiveles:191])
	APPLY TO SELECTION:C70([xxSTR_HistoricoNiveles:191];[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16:=[xxSTR_HistoricoNiveles:191]NumeroDePeriodos:16)
	KRL_UnloadReadOnly (->[xxSTR_HistoricoNiveles:191])
	  //recuperación de un informe para el theasurus
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26="Thesaurus, Orden alfabetico";*)
	QUERY:C277([xShell_Reports:54]; & [xShell_Reports:54]MainTable:3;=;Table:C252(->[BBL_Thesaurus:68]))
	QUERY SELECTION:C341([xShell_Reports:54];[xShell_Reports:54]ReportType:2="4DSE")
	READ WRITE:C146([xShell_Reports:54])
	DELETE SELECTION:C66([xShell_Reports:54])
	READ ONLY:C145([xShell_Reports:54])
	LICENCIA_ObtieneUUIDinstitucion 
	$t_uuidActualizacion:=RIN_RefUltimaVersion ("8d579729-1e31-41f5-b0a8-01edc9b42dbc")
	RIN_DescargaActualizacion ($t_uuidActualizacion)
End if 
If ($l_versionBD_Build<12021)
	KRL_ClearTable (->[ACT_EstadosFormasdePago:201])
	UD_v20110628_CtasContables 
	UD_v20110629_FormasDePago 
	UD_v20110713_EstadosFdPago 
	UD_v20110717_STR_Informes 
End if 
If ($l_versionBD_Build<13000)
	UD_v20110825_ConvConsolidacion 
	UD_v20110812_IdEventosAlumnos 
End if 
If ($l_versionBD_Build<13001)
	UD_v20110905_SitFinalHistorico 
	  //20110913 RCH Se ejecuta en otro proceso debido a que demora mucho en ciertas bases.
	  //UD_v20110906_Barcode_Lectores
	  //20110915 RCH Se quita llamado a metodo ya que demora mucho. A pedido de ABK a traves de LAH
	  //$pid:=New process("UD_v20110906_Barcode_Lectores";128000;__ ("Verificación códigos de barra"))
	UD_v20110907_EliminaSR 
	QR_DeleteReportStandar_Dup 
	UD_v20110912_NormalizaThumbnail 
	  //20110929 AS. se produjo un problema en el paso de las observaciones de las cuentas corrientes, con esto se soluciona el problema
	READ WRITE:C146([ACT_Cuentas_Observaciones:102])
	QUERY:C277([ACT_Cuentas_Observaciones:102];[ACT_Cuentas_Observaciones:102]Numero_Tabla_Asoc:10=0)
	APPLY TO SELECTION:C70([ACT_Cuentas_Observaciones:102];[ACT_Cuentas_Observaciones:102]Numero_Tabla_Asoc:10:=Table:C252(->[ACT_CuentasCorrientes:175]))
	KRL_UnloadReadOnly (->[ACT_Cuentas_Observaciones:102])
	UD_v20110929_PonderacionesMPA 
	UD_v20111020_OpcionesCalculoMPA 
End if 
If ($l_versionBD_Build<13002)
	  //ABK 20111102 - agregué campo SequenceID (autoincrementado) para ordenar con mayor precisión
	  //las instrucciones siguientes asignan el recnum a los registros existentes
	READ WRITE:C146([xShell_Logs:37])
	ALL RECORDS:C47([xShell_Logs:37])
	APPLY TO SELECTION:C70([xShell_Logs:37];[xShell_Logs:37]SequenceID:10:=Record number:C243([xShell_Logs:37]))
	ORDER BY:C49([xShell_Logs:37];[xShell_Logs:37]SequenceID:10;<)  //ordeno de manera descendente para obtener el recnum más alto
	SET DATABASE PARAMETER:C642([xShell_Logs:37];Table sequence number:K37:31;[xShell_Logs:37]SequenceID:10)  //cambio el sequence number para que la propiedad "autoincrementar" funcione correctamente
	KRL_UnloadAll 
End if 
If ($l_versionBD_Build<13005)
	UD_v20111118_EliminaUsersHuer 
End if 
If ($l_versionBD_Build<13008)
	READ WRITE:C146([xShell_Reports:54])
	QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26="Diagnostico")
	DELETE SELECTION:C66([xShell_Reports:54])
	KRL_UnloadReadOnly (->[xShell_Reports:54])
	$t_uuidActualizacion:=RIN_RefUltimaVersion ("d9b17d54-a474-4e94-b956-390ba834a524")
	RIN_DescargaActualizacion ($t_uuidActualizacion)
End if 
If ($l_versionBD_Build<13025)
	  //20120224 RCH Se agrega linea para eliminar posibles registros de diferentes niveles de sintesis, para un mismo año en cl
	UD_v20120224_STR_VerificaRegist 
End if 
If ($l_versionBD_Build<13028)
	If (LICENCIA_esModuloAutorizado (1;SchoolNet))
		If (Application type:C494=4D Server:K5:6)
			If ((SN3_CheckNotColegium ) & (<>bXS_esServidorOficial))
				$p:=New process:C317("SN3_SendData2SchoolNet";Pila_256K;"Envio de datos SchoolNet";False:C215;True:C214)
			End if 
		End if 
	End if 
End if 
If ($l_versionBD_Build<13030)
	UD_v20120315_Marcacheckdocente 
End if 
If ($l_versionBD_Build<13032)
	UD_v20120327_ReparaFechaTrans 
	UD_v20120330_ReparaIDXXSTR_Mate 
End if 
If ($l_versionBD_Build<13033)
	UD_v20111020_OpcionesCalculoMPA 
	UD_v20120102_CalificacionesEval 
End if 
If ($l_versionBD_Build<13035)
	ALL RECORDS:C47([Alumnos_EvaluacionAprendizajes:203])
	READ WRITE:C146([Alumnos_EvaluacionAprendizajes:203])
	MESSAGES ON:C181
	<>SN3_NoMarcar:=True:C214
	$p:=IT_UThermometer (1;0;"Actualizando registros de evaluación de aprendizajes.\rEsta operación puede tardar, por favor espere a que finalice.")
	APPLY TO SELECTION:C70([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2:=[Alumnos_EvaluacionAprendizajes:203]ID_Matriz:2)
	$p:=IT_UThermometer (-2;$p)
	<>SN3_NoMarcar:=False:C215
	MESSAGES OFF:C175
	KRL_UnloadReadOnly (->[Alumnos_EvaluacionAprendizajes:203])
End if 
If ($l_versionBD_Build<13041)
	UD_v20120510_FixHistInfoDecreto 
End if 
If ($l_versionBD_Build<13042)
	UD_v20120511_MigrateProxyOpts 
End if 
If ($l_versionBD_Build<13048)
	UD_v20120608_ActualizaBlob 
End if 
If (($l_versionBD_Build<13049) & ($l_versionBD_Build<11247))  //MONO: tambien esto está en publica pero debe ejecutarse 1 vez
	UD_v20120611_CL_JornadaCode 
End if 
If ($l_versionBD_Build<13050)
	UD_v20120611_ACTActualizaBlob 
End if 
If ($l_versionBD_Build<13052)
	UD_v20120626_ACT_IDRSBoletas 
End if 
If ($l_versionBD_Build<13053)
	UD_v20120629_ACT_UpdateBlob 
End if 
If ($l_versionBD_Build<13054)
	UD_v20120703_ACT_UpdateBlob 
End if 
If ($l_versionBD_Build<13060)
	UD_v20120723_ACT_UpdateBlob 
End if 
If ($l_versionBD_Build<13067)
	UD_v20120731_BitsNivelesMPA 
	UD_v20120618_UserNotifications 
	MPAdbu_VerificaMapas 
	MPAdbu_VerificaMatrices 
	MPAdbu_VerificaOpcionesCalculo 
	MPAdbu_VerificaRegistrosEval 
	MPAdbu_VerificaCalculos 
	UD_v20120712_HistoricoAsignatur 
	UD_v20120809_ActualizaCompoundI 
End if 
If ($l_versionBD_Build<13069)
	UD_v20110326_MonedaMX 
	UD_v20120814_SIGECodNivel 
End if 
If ($l_versionBD_Build<13073)
	  //ASM 20130726. No es necesario ejecutar este metodo, ya que los datos se inician y se envian en el metodo SN3_SendPubConfigs
	  //UD_v20120724_SN3IniNewOpt
End if 
If ($l_versionBD_Build<13084)
	UD_v20120910_ActuaDatosEditOpt 
End if 
If ($l_versionBD_Build<13092)
	MPAdbu_VerificaNombresEtapas 
End if 
If ($l_versionBD_Build<13093)
	ACTcfgfdp_OpcionesGenerales ("ActualizaIDEnElColegio")
End if 
If ($l_versionBD_Build<13094)
	UD_v20121005_ActuaDatosGrupo 
End if 
If ($l_versionBD_Build<13096)
	  //20121011 RCH Se encontro un defecto con las ctas por defecto al crear ctas especiales
	READ WRITE:C146([ACT_Cuentas_Contables:286])
	QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_tipo_cta:2=0;*)
	QUERY:C277([ACT_Cuentas_Contables:286]; & ;[ACT_Cuentas_Contables:286]id:1<0)
	APPLY TO SELECTION:C70([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id_tipo_cta:2:=3)
	KRL_UnloadReadOnly (->[ACT_Cuentas_Contables:286])
End if 
If ($l_versionBD_Build<13098)
	UD_v20121016_PromAsigSinCalc 
End if 
If ($l_versionBD_Build<13103)
	dbu_VerificaConsolidaciones 
End if 
If ($l_versionBD_Build<13104)
	  //20121031 ASM para actualizar el campo ModoRegistroAsistencia/
	UD_v20121031_ActHistNiveles 
End if 
If ($l_versionBD_Build<13105)
	CMT_Transferencia ("CargaLibreria")  //MONO:Religión y Grupos disponibles para CT. en el alumno faltaba el apellido paterno posible corrupción del archivo de config
End if 
If ($l_versionBD_Build<13108)
	  //20121026 ASM para actualizar tag de metadatos por defecto
	READ WRITE:C146([xxADT_MetaDataDefinition:79])
	QUERY:C277([xxADT_MetaDataDefinition:79];[xxADT_MetaDataDefinition:79]Tag:5="Es_Apoderado_@";*)
	QUERY:C277([xxADT_MetaDataDefinition:79]; | ;[xxADT_MetaDataDefinition:79]Tag:5="Nivel_de_es@")
	DELETE SELECTION:C66([xxADT_MetaDataDefinition:79])
	KRL_UnloadReadOnly (->[xxADT_MetaDataDefinition:79])
	ADT_LoadMetadatos 
End if 
If ($l_versionBD_Build<13113)
	UD_v20121124_ACT_ArchivosContab 
	MPAdbu_ReconstruyeMatrices 
End if 
If ($l_versionBD_Build<13114)
	  //20121127 ASM. Para eliminar registros duplicados, y en caso de no tener licencia CMT eliminar todo.
	C_LONGINT:C283($i;$l_proc)
	ARRAY LONGINT:C221($al_RecNum;0)
	ARRAY LONGINT:C221($al_RecNumEliminar;0)
	ARRAY TEXT:C222($at_Key;0)
	ARRAY TEXT:C222($at_Keymodificaciones;0)
	$l_proc:=IT_UThermometer (1;0;"Verificando datos de CMT_Modificaciones...")
	READ WRITE:C146([CMT_Modificaciones:159])
	If (LICENCIA_esModuloAutorizado (1;CommTrack))
		0xDev_DetectaDuplicados (->[CMT_Modificaciones:159]Key:7)
		SELECTION TO ARRAY:C260([CMT_Modificaciones:159];$al_RecNum;[CMT_Modificaciones:159]Key:7;$at_Key)
		For ($i;1;Size of array:C274($at_Key))
			If (Find in array:C230($at_Keymodificaciones;$at_Key{$i})=-1)
				APPEND TO ARRAY:C911($al_RecNumEliminar;$al_RecNum{$i})
			End if 
		End for 
		CREATE SELECTION FROM ARRAY:C640([CMT_Modificaciones:159];$al_RecNumEliminar)
	Else 
		ALL RECORDS:C47([CMT_Modificaciones:159])
	End if 
	DELETE SELECTION:C66([CMT_Modificaciones:159])
	KRL_UnloadReadOnly (->[CMT_Modificaciones:159])
	IT_UThermometer (-2;$l_proc)
	UD_v20121127_EliminaSintAnual 
	  //20121128 RCH se quita recalculo de metodo anterior
	C_BLOB:C604($xBlob_EV213114)
	EV2dbu_Recalculos ($xBlob_EV213114;False:C215)
End if 
If ($l_versionBD_Build<13130)
	UD_v20130108_VerificaPagosTerc 
	  //opción de bloqueo de anotaciones por días
	_O_C_INTEGER:C282(<>vi_nd_reg_anotacion)
	PREF_Set (0;"ST_BloqueoAnotacionDias";String:C10(<>vi_nd_reg_anotacion))
	  // asignación de año a registros de inasistencias
	  // asignación de Ids negativos para Alumnos y Asignaturas en las tablas [Asignaturas_registrosSesiones] y [Asignaturas_inasistencias] en fechas anteriores al año actual
	UD_v20121224_Sesiones_Y_Asist 
	  //.
	DBUas_SesionesInvalidas 
	DBUas_InasistenciasInvalidas 
	  // elimina eventuales duplicados en matrices de evaluación que puedan existir por errores anteriores
	  // no afecta las matrices ni la evaluación.
	  // deja registro en el Centro de Notificaciones
	UD_v20130214_LlaveObjetosMPA 
	MPAdbu_DuplicadosEnMatrices 
End if 
If ($l_versionBD_Build<13133)
	UD_v20130118_IdModoPagoTercero 
End if 
If ($l_versionBD_Build<13135)
	dbuACT_VerificaDTNoArchivados 
	UD_v20121221_UpdateSN3PubConfig 
End if 
If ($l_versionBD_Build<13136)
	UD_v20130128_PrefACT 
End if 
If ($l_versionBD_Build<13138)
	UD_v20130130_ACTpref 
End if 
If ($l_versionBD_Build<13140)
	UD_v20130202_ACT_NuevaPref 
End if 
If ($l_versionBD_Build<13142)
	UD_v20130209_ACT_RSociales 
	UD_v20130210_ACT_ConfDT 
End if 
If ($l_versionBD_Build<13143)
	UD_v20130214_LlaveObjetosMPA 
	UD_v20130213_NombresAlumnos 
	UD_v20130214_PropAsignaturas 
End if 
If ($l_versionBD_Build<13152)
	UD_v20130306_ACT_UpdateBlob 
End if 
If ($l_versionBD_Build<13155)
	UD_v20130315_titulosProfesores 
	UD_v20130315_VerificaAlumnosAsi 
End if 
If ($l_versionBD_Build<13160)
	UD_v20130320_DiaEnSesiones 
End if 
If ($l_versionBD_Build<13161)
	C_LONGINT:C283($p)
	$p:=IT_UThermometer (1;0;__ ("Reestableciendo configuración de Commtrack"))
	CMT_Transferencia ("LimpiaTabla")
	C_TEXT:C284($vt_modulo)
	$vt_modulo:=String:C10(CommTrack)
	CMT_Transferencia ("CargaLibreria";->$vt_modulo)
	IT_UThermometer (-2;$p)
End if 
If ($l_versionBD_Build<13163)
	UD_v20130301_ActuaDatosNewField 
End if 
If ($l_versionBD_Build<13167)
	UD_v20130408_PctAprobacion 
	ALL RECORDS:C47([Asignaturas_Historico:84])
	ARRAY LONGINT:C221($al_Ceros;Records in selection:C76([Asignaturas_Historico:84]))
	$l_cero:=0
	AT_Populate (->$al_Ceros;->$l_cero)
	KRL_Array2Selection (->$al_Ceros;->[Asignaturas_Historico:84]HorasAnuales:29)
	KRL_UnloadReadOnly (->[Asignaturas_Historico:84])
End if 
If ($l_versionBD_Build<13172)
	UD_v20130402_SN3AgendaOpc 
	UD_v20130305_ACT_GenerarPDF 
	UD_v20130417_NotasEnPalabras 
End if 
If ($t_versionBaseDeDatos<"11.2.13176")
	UD_v20130423_GenerarPDF2 
End if 
If ($t_versionConFormato<"11.02.13182")
	UD_v20130425_EstadisticasUso 
End if 
If ($t_versionConFormato<"11.02.13183")
	UD_v20130503_SubtablasFMedica 
End if 
If ($t_versionConFormato<"11.02.13188")
	SN3_VerificarIntegridadMarcasEl 
End if 
If ($t_versionConFormato<"11.02.13190")
	UD_v20130516_NewAliasPerGroup 
End if 
If ($t_versionConFormato<"11.03.13212")
	  //20130611 RCH Para eliminar reportes asociados a tablas eliminadas
	UD_EjecutaMetodoActualizacion ("UD_v20130610_VerificaReportes")
	UD_EjecutaMetodoActualizacion ("UD_v20130625_SN3RegXEnviar")
End if 
If ($t_versionConFormato<"11.03.13216")
	UD_EjecutaMetodoActualizacion ("dbu_VerificaConsolidaciones";True:C214)
End if 
If ($t_versionConFormato<"11.03.13220")
	UD_EjecutaMetodoActualizacion ("UD_v20130625_SesionesInasist";True:C214)
End if 
If ($t_versionConFormato<"11.03.13225")
	CREATE EMPTY SET:C140([Asignaturas_RegistroSesiones:168];"$SesionesInvalidas")
	QUERY:C277([Asignaturas_RegistroSesiones:168];[Asignaturas_RegistroSesiones:168]Fecha_Sesion:3>Current date:C33(*))
	KRL_DeleteSelection (->[Asignaturas_RegistroSesiones:168])
End if 
If ($t_versionConFormato<"11.03.13231")
	UD_EjecutaMetodoActualizacion ("UD_v20110912_NormalizaThumbnail")
End if 
If ($t_versionConFormato<"11.04.13234")
	UD_EjecutaMetodoActualizacion ("UD_v20130725_AsignaturasEnSNT")
	UD_EjecutaMetodoActualizacion ("UD_v20130726_PrefBarcodeLector")
	UD_EjecutaMetodoActualizacion ("UD_v20130730_DTSPDF")
	UD_EjecutaMetodoActualizacion ("UD_v20130730_ACT_Cantidad")
	UD_EjecutaMetodoActualizacion ("UD_v20130731_ACT_Blob")
	XSusr_ListaSuperUsuarios_in 
End if 
If ($t_versionConFormato<"11.04.13236")
	UD_EjecutaMetodoActualizacion ("UD_v20130806_NoNivelAnotaInas")
End if 
If ($t_versionConFormato<"11.04.13245")
	UD_EjecutaMetodoActualizacion ("UD_v20130819_NormalizaListas")
End if 
If ($t_versionConFormato<"11.04.13251")
	UD_EjecutaMetodoActualizacion ("UD_v20130822_ACT_IDFDP")
	UD_EjecutaMetodoActualizacion ("UD_v20120618_UserNotifications";True:C214)  //20130822 RCH
	UD_EjecutaMetodoActualizacion ("UD_v20130823_HorasPlanesDeClase")  //20130823 ABK
End if 
If ($t_versionConFormato<"11.04.13252")
	UD_EjecutaMetodoActualizacion ("UD_v20130823_Calificaciones")
End if 
If ($t_versionConFormato<"11.04.13257")
	UD_EjecutaMetodoActualizacion ("UD_v20130903_FechaMatricula")  //MONO FECHA DE MATRICULA ACTUAL
	UD_EjecutaMetodoActualizacion ("UD_v20130903_ACT_IAPM")  //20130903 RCH Aleman Pto Montt. Boletas
End if 
If ($t_versionConFormato<"11.05.13265")
	UD_EjecutaMetodoActualizacion ("UD_v20130917_MarcaHijoFuncionar")
End if 
If ($t_versionConFormato<"11.05.13266")
	UD_EjecutaMetodoActualizacion ("UD_v20130916_ACT_ItemsAño")
End if 
If ($t_versionConFormato<"11.05.13277")
	UD_EjecutaMetodoActualizacion ("UD_v20131017_VerificaIndiceDocT")
End if 
If ($t_versionConFormato<"11.05.13284")
	UD_EjecutaMetodoActualizacion ("UD_v20131104_LimpiaCampoFM")
	  //20131104 ASM para cambiar estado "Cancelada" a "Pagada"
	If (<>vtXS_CountryCode="mx")
		$l_therm:=IT_UThermometer (1;0;"Verificando estado de Documentos Tributarios.")
		READ WRITE:C146([ACT_Boletas:181])
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Estado:20=3)
		APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]Estado:2:=<>atACT_EstadosBoletas{3})
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
		IT_UThermometer (-2;$l_therm)
	End if 
End if 
If ($t_versionConFormato<"11.06.13290")
	  // ABK 20140817
	  // DESHABILITADO: no se deben utilizar recnums para acceder a registros en otra base de datos
	  // (los recnums pueden cambiar como consecuencia a una eliminación de registros o compactaje de base de datos)
	If (False:C215)
		  //Para cargar el reporte _Consola Reporte Pagos [Detalle Cargos seleccionados]
		C_LONGINT:C283($recNum)
		$recNum:=793  //RecNum del repositorio
		  //QR_RIN_CargaInforme_RecNum ($recNum)
	End if 
End if 
If ($t_versionConFormato<"11.06.13286")
	UD_EjecutaMetodoActualizacion ("UD_v20130726_PrefBarcodeLector")
	UD_EjecutaMetodoActualizacion ("UD_v20130828_BarcodeRegistros")
	UD_EjecutaMetodoActualizacion ("UD_v20130825_BarcodeLectores")
	UD_EjecutaMetodoActualizacion ("UD_v20131112_RetiradoDeNominas")
End if 
If ($t_versionConFormato<"11.06.13289")
	UD_EjecutaMetodoActualizacion ("UD_v20131106_ACT_CCO")
	UD_EjecutaMetodoActualizacion ("UD_v20131024_ACT_ActNomCompTer")
End if 
If ($t_versionConFormato<"11.06.13291")
	UD_EjecutaMetodoActualizacion ("UD_v20131122_GruposLectores")
End if 
If ($t_versionConFormato<"11.06.13297")
	UD_EjecutaMetodoActualizacion ("UD_v20131125_ACT_RecargosAut")
End if 
If ($t_versionConFormato<"11.06.13299")
	UD_EjecutaMetodoActualizacion ("UD_v20131130_EliminaLogsBBL")
End if 
If ($t_versionConFormato<"11.06.13303")
	UD_EjecutaMetodoActualizacion ("BBLsys_LoadSystemUsers")
	UD_EjecutaMetodoActualizacion ("UD_v20130726_PrefBarcodeLector")
	UD_EjecutaMetodoActualizacion ("UD_v20131206_UpdateUsuariosBBL")
End if 
If ($t_versionConFormato<"11.06.13315")
	UD_EjecutaMetodoActualizacion ("UD_v20131216_ActuaDatosNewField")
End if 
If ($t_versionConFormato<"11.05.13316")
	UD_EjecutaMetodoActualizacion ("UD_v20131217_EliminaInfoCalif")
End if 
If ($t_versionConFormato<"11.06.13319")
	If (($t_versionConFormato>="11.06.13286") & ($t_versionConFormato<="11.06.13318"))
		UD_EjecutaMetodoActualizacion ("BBLdbu_RebuildStatistics")
	End if 
End if 
If ($t_versionConFormato<"11.06.13350")
	UD_EjecutaMetodoActualizacion ("UD_v20140226_VerificaNivelAtras")
End if 
If ($t_versionConFormato<"11.07.13355")
	UD_EjecutaMetodoActualizacion ("UD_v20140307_HabProcAutoDescto")
End if 
If ($t_versionConFormato<"11.06.13361")
	UD_EjecutaMetodoActualizacion ("UD_v20140313_BBL_UsSistema")
End if 
If ($t_versionConFormato<"11.06.13362")
	UD_EjecutaMetodoActualizacion ("UD_v20140315_LimiteRegAnotacion")
	UD_EjecutaMetodoActualizacion ("UD_v20140315_Periodos_TipoHora")
End if 
If ($t_versionConFormato<"11.07.13366")
	UD_EjecutaMetodoActualizacion ("UD_v20140319_ListaIntervalo")
End if 
If ($t_versionConFormato<"11.07.13370")
	UD_EjecutaMetodoActualizacion ("UD_v20140325_ACT_BoletasM0")
End if 
If ($t_versionConFormato<"11.07.13370")
	UD_EjecutaMetodoActualizacion ("UD_v20140326_Listas")
End if 
If ($t_versionConFormato<"11.07.13373")
	UD_EjecutaMetodoActualizacion ("UD_v20140328_ACT_Saldo")
End if 
If ($t_versionConFormato<"11.07.13374")
	UD_EjecutaMetodoActualizacion ("UD_v20140401_Fallecimiento")
End if 
If ($t_versionConFormato<"11.07.13381")
	UD_EjecutaMetodoActualizacion ("UD_v20130809_ACT_FormaPago")
End if 
If ($t_versionConFormato<"11.07.13389")
	UD_EjecutaMetodoActualizacion ("UD_v20140417_FirmaDocOficiales")
	UD_EjecutaMetodoActualizacion ("UD_v20140417_ProfJefeHistoricos")
End if 
If ($t_versionConFormato<"11.07.13391")
	UD_EjecutaMetodoActualizacion ("ACTfdp_EstadosXDefecto")
End if 
If ($t_versionConFormato<"11.07.13395")
	UD_EjecutaMetodoActualizacion ("UD_v20140423_ActuaDatosNewField")
	UD_EjecutaMetodoActualizacion ("UD_v20140425_EliminaPrefLicenci")
End if 
  //If ($t_versionConFormato<"11.07.13403")
  //PREF_Set (0;"actualizarw2pdf";"si")
  //End if 
If ($t_versionConFormato<"11.06.13405")
	UD_EjecutaMetodoActualizacion ("UD_v20140510_ACT_RecAut")
End if 
If ($t_versionConFormato<"11.06.13406")
	  // eliminacion de datos de cierre inválidos
	QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1><>gYear;*)
	QUERY:C277([xxSTR_DatosDeCierre:24]; | ;[xxSTR_DatosDeCierre:24]Year:1<=1990)
	KRL_DeleteSelection (->[xxSTR_DatosDeCierre:24])
End if 
If ($t_versionConFormato<"11.06.13407")
	UD_EjecutaMetodoActualizacion ("UD_v20140514_Elimina_SA_Nivel0")
End if 
If ($t_versionConFormato<"11.07.13408")
	UD_EjecutaMetodoActualizacion ("UD_v20140516_ACT_BoletasIVA")
End if 
If ($t_versionConFormato<"11.07.13410")
	UD_EjecutaMetodoActualizacion ("UD_v20140522_ACT_Venc")
End if 
If ($t_versionConFormato<"11.08.13411")
	C_LONGINT:C283($l_locked;$l_therm)
	READ WRITE:C146([Alumnos:2])
	$l_therm:=IT_UThermometer (1;0;"Verificando fecha de retiro en alumnos con estado Activo")
	QUERY:C277([Alumnos:2];[Alumnos:2]Status:50="Activ@";*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Fecha_de_retiro:42#!00-00-00!)
	APPLY TO SELECTION:C70([Alumnos:2];[Alumnos:2]Fecha_de_retiro:42:=!00-00-00!)
	$l_locked:=Records in set:C195("LockedSet")
	IT_UThermometer (-2;$l_therm)
	KRL_UnloadReadOnly (->[Alumnos:2])
End if 
If ($t_versionConFormato<"11.08.13412")  //20140604 RCH Ejecuto nuevamente las lineas (si el metodo ya se ejecuto en la base no se ejecutará de nuevo) porque puede que no se hayan ejecutado por el número de versión incorrecto.
	UD_EjecutaMetodoActualizacion ("UD_v20140510_ACT_RecAut")
	UD_EjecutaMetodoActualizacion ("UD_v20140514_Elimina_SA_Nivel0")
	  // eliminacion de datos de cierre inválidos
	QUERY:C277([xxSTR_DatosDeCierre:24];[xxSTR_DatosDeCierre:24]Year:1><>gYear;*)
	QUERY:C277([xxSTR_DatosDeCierre:24]; | ;[xxSTR_DatosDeCierre:24]Year:1<=1990)
	KRL_DeleteSelection (->[xxSTR_DatosDeCierre:24])
	UD_EjecutaMetodoActualizacion ("UD_v20140530_TomaDeAsistencia")
End if 
If ($t_versionConFormato<"11.08.13420")
	UD_EjecutaMetodoActualizacion ("UD_v20140616_BorraInfoRetirados")
End if 
If ($t_versionConFormato<"11.08.13433")
	UD_EjecutaMetodoActualizacion ("UD_v20140701_Listas_a_json")
	UD_EjecutaMetodoActualizacion ("UD_v20140626_Medicos")
End if 
If ($t_versionConFormato<"11.08.13429")
	ARRAY LONGINT:C221($al_RecNum;0)
	C_LONGINT:C283($i;$l_therm)
	$l_therm:=IT_UThermometer (1;0;"Verificando ID funcionario...")
	ALL RECORDS:C47([Colegio:31])
	SELECTION TO ARRAY:C260([Colegio:31];$al_RecNum)
	For ($i;1;Size of array:C274($al_RecNum))
		READ WRITE:C146([Colegio:31])
		GOTO RECORD:C242([Colegio:31];$al_RecNum{$i})
		If ([Colegio:31]Director_IdFuncionario:61=0) & ([Colegio:31]Director_RUN:28#"")
			QUERY:C277([Profesores:4];[Profesores:4]RUT:27=[Colegio:31]Director_RUN:28)
			[Colegio:31]Director_IdFuncionario:61:=[Profesores:4]Numero:1
			SAVE RECORD:C53([Colegio:31])
		End if 
		KRL_UnloadReadOnly (->[Colegio:31])
	End for 
	IT_UThermometer (-2;$l_therm)
End if 
If ($t_versionConFormato<"11.08.13434")
	UD_EjecutaMetodoActualizacion ("UD_v20140703_VerificaMatricesAs")
End if 
If ($t_versionConFormato<"11.09.13441")
	UD_v20140714_VerifUUIDColegio 
End if 
If ($t_versionConFormato<"11.09.13452")
	UD_EjecutaMetodoActualizacion ("UD_v20140721_BBL_FechaLog")
End if 
If ($t_versionConFormato<"11.09.13462")
	UD_EjecutaMetodoActualizacion ("UD_v20140814_Boletas")
End if 
If ($t_versionConFormato<"11.09.13468")
	UD_EjecutaMetodoActualizacion ("UD_v20140824_CrossRefTheasurus")
End if 
If ($t_versionConFormato<"11.09.13488")
	LICENCIA_Descarga 
End if 
If ($t_versionConFormato<"11.09.13498")
	UD_EjecutaMetodoActualizacion ("UD_v20141006_ACT_FormaPago")
End if 
If ($t_versionConFormato<"11.09.13500")
	UD_EjecutaMetodoActualizacion ("ACTfdp_EstadosXDefecto";True:C214)
End if 
If ($t_versionConFormato<"11.09.13505")
	UD_EjecutaMetodoActualizacion ("UD_v20141015_VerificaIVAboletaE";True:C214)
End if 
If ($t_versionConFormato<"11.09.13510")
	If (False:C215)
		  // el informe referenciado mas abajo no existe en el repositorio. Genera un error al actualizar
		READ WRITE:C146([xShell_Reports:54])
		QUERY:C277([xShell_Reports:54];[xShell_Reports:54]ReportName:26="Diagnostico")
		DELETE SELECTION:C66([xShell_Reports:54])
		KRL_UnloadReadOnly (->[xShell_Reports:54])
		$t_uuidActualizacion:=RIN_RefUltimaVersion ("D9B17D54A4744E94B956390BA834A524")
		RIN_DescargaActualizacion ($t_uuidActualizacion;False:C215)
	End if 
End if 
If ($t_versionConFormato<"11.09.13511")
	UD_EjecutaMetodoActualizacion ("UD_v20141024_ACT_DecimalesCO")
End if 
If ($t_versionConFormato<"11.09.13565")
	UD_EjecutaMetodoActualizacion ("UD_v20150117_ExAlumnos")
End if 
If ($t_versionConFormato<"11.09.13574")
	UD_EjecutaMetodoActualizacion ("UD_v20150206_IndiceFolios")
End if 
If ($t_versionConFormato<"11.09.13575")
	  //UD_EjecutaMetodoActualizacion ("UD_v20150219_VerificaEstadoPers")
End if 
If ($t_versionConFormato<"11.09.13581")
	UD_EjecutaMetodoActualizacion ("UD_v20150302_FichaSalud")
End if 
If ($t_versionConFormato<"11.09.13582")
	UD_EjecutaMetodoActualizacion ("UD_v20150310_Obsoletos")
End if 
If ($t_versionConFormato<"11.09.13584")
	UD_EjecutaMetodoActualizacion ("dbuSTR_ReparaTipoApoderadoRF";True:C214)
End if 
If ($t_versionConFormato<"11.10.13612")
	UD_EjecutaMetodoActualizacion ("UD_v20150402_Conexiones")
End if 
If ($t_versionConFormato<"11.10.13643")
	UD_EjecutaMetodoActualizacion ("UD_v20150414_EstadosNulos")
End if 
If ($t_versionConFormato<"11.10.13653")
	UD_EjecutaMetodoActualizacion ("UD_v20150422_CleanCTlog")
End if 
If ($t_versionConFormato<"11.10.13665")
	UD_EjecutaMetodoActualizacion ("UD_v20150504_ReparaExtensionDoc")
	UD_EjecutaMetodoActualizacion ("UD_v20150413_UpdateExeCommName";True:C214)
End if 
If ($t_versionConFormato<"11.10.13682")
	UD_EjecutaMetodoActualizacion ("UD_v20141210_MateriasItems")
End if 
If ($t_versionConFormato<"11.10.13683")
	UD_EjecutaMetodoActualizacion ("UD_v20150529_SexoEnAprendizajes")
End if 
If ($t_versionConFormato<"11.10.13686")
	UD_EjecutaMetodoActualizacion ("UD_v20150604_ACT_Tramos")
End if 
If ($t_versionConFormato<"11.10.13688")
	UD_EjecutaMetodoActualizacion ("UD_v20150608_CompetenciasDobles")
End if 
If ($t_versionConFormato<"11.10.13707")
	UD_EjecutaMetodoActualizacion ("UD_v20150714_ACT_RSEnIntereses")
End if 
If ($t_versionConFormato<"11.10.13759")
	UD_EjecutaMetodoActualizacion ("UD_v20151014_Actualiza_procesos")
End if 
If ($t_versionConFormato<"11.10.13771")
	dbu_UpdateFamily 
End if 
If ($t_versionConFormato<"11.10.13775")
	UD_EjecutaMetodoActualizacion ("UD_v20151109_ActualizaPromUChil")
End if 
CIM_CuentaRegistros ("GuardaArchivo")


If ($t_versionConFormato<"12.0@")
	UD_EjecutaMetodoActualizacion ("UD_v20140226_ConvObjetoActas")
	UD_EjecutaMetodoActualizacion ("UD_v20140223_Ob_Firmantes")
	UD_EjecutaMetodoActualizacion ("UD_v20151130_ObservacionesMater")
	UD_EjecutaMetodoActualizacion ("UD_v20160119_CreaFdpPayWorks")
End if 


If ($t_versionConFormato<"12.00.13823")
	UD_EjecutaMetodoActualizacion ("UD_v20151130_ObservacionesMater")
End if 


If ($t_versionConFormato<"12.00.13850")
	UD_EjecutaMetodoActualizacion ("UD_v20160321_SRP2_to_SRP3")
End if 

If ($t_versionConFormato<"12.00.13878")
	UD_EjecutaMetodoActualizacion ("UD_v20160413_BlobCalendarioCur")
	UD_EjecutaMetodoActualizacion ("UD_v20160413_ConfigBlockEvtNiv")
End if 

If ($t_versionConFormato<"12.00.13893")
	UD_EjecutaMetodoActualizacion ("UD_v20160520_ACT_PREF_Orden")
End if 

If ($t_versionConFormato<"12.00.13893")
	UD_EjecutaMetodoActualizacion ("UD_v20160525_SyncPrefRegCambios")
End if 

If ($t_versionConFormato<"12.00.13898")
	UD_EjecutaMetodoActualizacion ("UD_v20160606_Log")
End if 

If ($t_versionConFormato<"12.00.13915")
	UD_EjecutaMetodoActualizacion ("UD_v20160512_ConfigExamenes")
	UD_EjecutaMetodoActualizacion ("UD_v20160621_Bonificaciones")
	UD_EjecutaMetodoActualizacion ("UD_v20160624_InitCamposBonif")
End if 
If ($t_versionConFormato<"12.00.13939")
	UD_EjecutaMetodoActualizacion ("UD_v20160706_AgregaVacunas";True:C214)
End if 

If ($t_versionConFormato<"12.00.13942")
	UD_EjecutaMetodoActualizacion ("UD_v20160712_DescuentosIndiv")
End if 

If ($t_versionConFormato<"12.00.13952")
	UD_EjecutaMetodoActualizacion ("UD_v20160820_ACT_NuevaPrefBol")
End if 

If ($t_versionConFormato<"12.00.13967")
	UD_EjecutaMetodoActualizacion ("UD_v20160909_ACT_FechaInt")
End if 

If ($t_versionConFormato<"12.00.13997")
	UD_EjecutaMetodoActualizacion ("UD_v20160924_ACT_NuevaPrefBol")
	UD_EjecutaMetodoActualizacion ("UD_v20160924_ACTbol_FechaVenc")
End if 

If ($t_versionConFormato<"12.00.14001")
	UD_EjecutaMetodoActualizacion ("UD_v20161013_VerificaDocCargo")
End if 


If ($t_versionConFormato<"12.00.14111")
	UD_EjecutaMetodoActualizacion ("UD_v20170310_VerificaTiConAEnf")
End if 


If ($t_versionConFormato<"12.00.14093")
	UD_EjecutaMetodoActualizacion ("UD_v20170217_ImagenesEnBD")
End if 

If ($t_versionConFormato<"12.01.14132")
	UD_EjecutaMetodoActualizacion ("AS_ObjOpcEvaluacionEspecial")  //Mono Ticket 172577 Evaluacion Especial
	UD_EjecutaMetodoActualizacion ("AsignaturaConfigBlob2Object")  //MONO Ticket 171910
End if 


If ($t_versionConFormato<"12.01.14143")
	UD_EjecutaMetodoActualizacion ("UD_v20170405_EnfermeriaSTWA")
End if 

If ($t_versionConFormato<"12.01.14153")
	UD_EjecutaMetodoActualizacion ("UD_v20170507_DTS_enLOG")
	UD_EjecutaMetodoActualizacion ("UD_v20170507_PrefEmisionAC")
End if 

If ($t_versionConFormato<="12.01.14161")
	UD_EjecutaMetodoActualizacion ("UD_v20161128_ACT_ConfigCCXN";True:C214)
End if 

If ($t_versionConFormato<="12.01.14163")
	UD_EjecutaMetodoActualizacion ("UD_v20170517_EnvioDatosCondor")
End if 

If ($t_versionConFormato<="12.01.14173")
	UD_EjecutaMetodoActualizacion ("UD_v20170530_FixPropEvalObj")
End if 

If ($t_versionConFormato<="12.01.14183")
	UD_EjecutaMetodoActualizacion ("UD_v20170608_EstilosEvaluacion")
	UD_EjecutaMetodoActualizacion ("UD_v20170608_NuevaPrefinJfCurso")  // Nueva Preferencia, informe formulario Jefatura de Curso Ticket N° 182255
End if 

If ($t_versionConFormato<"12.02.14184")
	UD_EjecutaMetodoActualizacion ("UD_v20170526_FdpServipag")
	UD_EjecutaMetodoActualizacion ("UD_v20170610_ACT_ConfNoPermPag")  // Modificado por: Saúl Ponce (10-06-2017) Ticket Nº 179864
End if 

If ($t_versionConFormato<="12.02.14230")
	UD_EjecutaMetodoActualizacion ("UD_v20170711_ValidaSimbolos";True:C214)
End if 

If ($t_versionConFormato<="12.02.14234")
	UD_EjecutaMetodoActualizacion ("UD_v20170731_VerificaBlobActas")
End if 

If ($t_versionConFormato<="12.02.14239")  //MONO TICKET 175179
	UD_EjecutaMetodoActualizacion ("AS_ObjOpc_BlockPropEval")
	UD_EjecutaMetodoActualizacion ("UD_v20170804_FixCursosADT")
	
End if 

  // Modificado por: Alexis Bustamante (23/08/2017)


  //Agrego metodo creado para eliminar informes duplicados en la BD
  //184745
If ($t_versionConFormato<="12.02.14257")
	UD_EjecutaMetodoActualizacion ("EliminaInformesLibreria")
End if 

If ($t_versionConFormato<="12.02.14262")
	UD_EjecutaMetodoActualizacion ("UD_v20170904_SQ_AsigAdjuntos")
End if 

If ($t_versionConFormato<="12.02.14264")
	UD_EjecutaMetodoActualizacion ("UD_v20170905_ListCleanDuplicate")
End if 

If ($t_versionConFormato<="12.02.14271")
	UD_EjecutaMetodoActualizacion ("UD_v20170927_VerificaCamposProp")
	UD_EjecutaMetodoActualizacion ("UD_v20170930_CargaResposableLB")
End if 

If ($t_versionConFormato<="12.03.14274")
	UD_EjecutaMetodoActualizacion ("UD_v20170913_SubEvalBlob2Obj")  //MONO Ticket 187315
End if 

If ($t_versionConFormato<="12.01.14262")  // Modificado por: Saul Ponce (12/10/2017) Ticket 188310, elimina cargos sin documentos
	UD_EjecutaMetodoActualizacion ("UD_v20171012_ValidaCargosSinDoc")
End if 

If ($t_versionConFormato<="12.03.14284")
	LOC_ObjNombreColumnasEval ("iniciar")  //MONO Ticket 186325 Personalizar nombres de evaluaciones generales
End if 

If ($t_versionConFormato<="12.03.14285")
	UD_EjecutaMetodoActualizacion ("UD_v20171026_CreaObjetoSegurida")  //175748 ABC REQ CLAVES
End if 

If ($t_versionConFormato<="12.03.14318")
	UD_EjecutaMetodoActualizacion ("UD_v20171213_FixEVSBonificacion")  //194786 MONO
End if 

If ($t_versionConFormato<="12.03.14321")
	UD_EjecutaMetodoActualizacion ("UD_v20171223_FixARCodeSII")  // Saúl Ponce, Ticket Nº 196102.
End if 

If ($t_versionConFormato<="12.03.14322")
	DBU_AsignaUUIDdeMateria 
End if 

If ($t_versionConFormato<="12.03.14323")
	UD_EjecutaMetodoActualizacion ("UD_v20141006_ACT_FormaPago";True:C214)  // 20171229 RCH 195027
End if 

If ($t_versionConFormato<="12.03.14325")
	UD_EjecutaMetodoActualizacion ("UD_v20171229_CodImpHorario";True:C214)  // MONO
End if 

If ($t_versionConFormato<="12.03.14333")
	UD_EjecutaMetodoActualizacion ("UD_v20180121_Informes")
End if 

If ($t_versionConFormato<="12.03.14343")
	UD_EjecutaMetodoActualizacion ("UD_v20180130_VerificaRutRS")
End if 

If ($t_versionConFormato<="12.03.14348")
	XS_ActivarDesactivarPAutorizado ("SchoolTrack Web Access: Configuración";True:C214)
	UD_EjecutaMetodoActualizacion ("UD_v20180223_ReparaSubAsignatur")
End if 

If ($t_versionConFormato<="12.04.14349")
	UD_EjecutaMetodoActualizacion ("UD_v20180228_InitOpcNoVisible")
	UD_EjecutaMetodoActualizacion ("UD_v20180301_BlobHorario2Object")  //MONO Ticket 144924
	UD_EjecutaMetodoActualizacion ("UD_v20180126_NewKeyCursoSACurso")  //MONO 184433
End if 

If ($t_versionConFormato<="12.04.14368")
	UD_EjecutaMetodoActualizacion ("UD_v20180223_ReparaSubAsignatur";True:C214)  //MONO Ticket 202205
End if 

If ($t_versionConFormato<="12.04.14372")
	UD_EjecutaMetodoActualizacion ("UDv_20180326_Fix200133";True:C214)
End if 

If ($t_versionConFormato<="12.04.14384")
	UD_EjecutaMetodoActualizacion ("UDv_20180418_FixHorasEfectivas";True:C214)
End if 

If ($t_versionConFormato<="12.04.14397")
	UD_EjecutaMetodoActualizacion ("UDv_20180518Fix207230";True:C214)  //MONO 207230
End if 

If ($t_versionConFormato<="12.04.14399")
	UD_EjecutaMetodoActualizacion ("UD_v20180522_Fix_207269";True:C214)  //MONO 207269
End if 

If ($t_versionConFormato<="12.04.14424")
	UD_EjecutaMetodoActualizacion ("UD_v20180705_UpdateConfPrInfJef";True:C214)  //Patricio Aliaga 20180705 TIcket N° 209201
End if 

If ($t_versionConFormato<="12.04.14436")  //ASM Ticket 212688
	UD_EjecutaMetodoActualizacion ("UD_v20180706_UpdateNomColEvaGen";True:C214)  //Patricio Aliaga 20180706 TIcket N° 211356 
End if 

If ($t_versionConFormato<="12.04.14429")
	UD_EjecutaMetodoActualizacion ("UD_v20180714_InitColorGraficosE";True:C214)  //ASM 20180714 Ticket 211218
End if 

If ($t_versionConFormato<="12.04.14432")
	UD_EjecutaMetodoActualizacion ("UD_v20180718_ReparaObjMaterias";True:C214)  //ASM 20180718 Ticket 211873
End if 

If ($t_versionConFormato<="12.04.14436")
	UD_EjecutaMetodoActualizacion ("UD_v20180724_CambioFechaEmiVenc")  //20180725 RCH Ticket 206430
	UD_EjecutaMetodoActualizacion ("UD_v20180714_InitColorGraficosE";True:C214)  //MONO Ticket 213076
End if 

If ($t_versionConFormato<="12.04.14438")
	UD_EjecutaMetodoActualizacion ("UD_v20180814_FixNameAuthProcess")  //MONO Ticket 214177
End if 

If ($t_versionConFormato<="12.04.14439")
	UD_EjecutaMetodoActualizacion ("UD_v20180720_UpdateNomColEvaGen")  //MONO Ticket 114780
End if 

If ($t_versionConFormato<="12.04.14440")
	UD_EjecutaMetodoActualizacion ("UD_v20180816_AsistenteTransfere")  //20180817 RCH ticket 214673
	UD_EjecutaMetodoActualizacion ("UD_v20180822_FixPF_AsigEvaPtos")  //MONO TICKET 214665
End if 

If ($t_versionConFormato<="12.04.14442")
	UD_EjecutaMetodoActualizacion ("UD_v20180816_FixObsAsig_213584";True:C214)  //MONO Ticket 213584
	UD_EjecutaMetodoActualizacion ("UD_v20180829_AnotacionesSTWA";True:C214)
End if 

If ($t_versionConFormato<="12.04.14446")
	UD_EjecutaMetodoActualizacion ("UD_v20180906_NoEmployee")  //20180906 RCH Ticket 215763
End if 

If ($t_versionConFormato<="12.04.14448")
	UD_EjecutaMetodoActualizacion ("UD_v20180912_VerificaObjPropEva")  //20180912 ASM Ticket 216494
End if 

If ($t_versionConFormato<="12.04.14453")
	UD_EjecutaMetodoActualizacion ("UD_v20181002_SN3PubConfigUpd")  //MONO Ticket 209421
End if 

If ($t_versionConFormato<="12.04.14456")
	UD_EjecutaMetodoActualizacion ("UD_v20150302_FichaSalud";True:C214)  //20181008 ASM Ticket 214887
	UD_EjecutaMetodoActualizacion ("UD_v20181008_FixSexoAlumnos")  // 20181008 Patricio Aliaga Ticket N° 204363
	UD_EjecutaMetodoActualizacion ("UD_v20181008STR_ordenNominas")  // 20181008 Patricio Aliaga Ticket N° 204363
	UD_EjecutaMetodoActualizacion ("UD_v20181003_ControlAobjeto";True:C214)  //20181003 ASM Ticket 194524
End if 



$currentDate:=Current date:C33(*)
$currentTime:=Current time:C178(*)
BLOB_Variables2Blob (->$vx_dateTimeBlob;0;->$currentDate;->$currentTime)
PREF_SetBlob (0;"AppUDdate";$vx_dateTimeBlob)
SYS_EstableceVersionBaseDeDatos 
$t_versionBaseDeDatos:=SYS_LeeVersionBaseDeDatos ("build";->$l_versionBD_Build)
UD_EnviaCorreoActualizacion 
PREF_LoadParametersBD 
<>NoBatchProcessor:=False:C215
<>NoLog:=False:C215
<>onServer:=$onServer
<>vb_msgOnServer:=False:C215
<>vsXS_CurrentModule:=$tempModuleName
<>vlXS_CurrentModuleRef:=$tempModuleRef
vsBWR_CurrentModule:=<>vsXS_CurrentModule