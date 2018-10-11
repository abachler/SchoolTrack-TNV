//%attributes = {}
TRACE:C157

  //SET TEXT TO PASTEBOARD(SYS_GetServerProperty (XS_MachineName))
  //CONDOR
  //ACTwiz_AsignaGlosaTramos 
  //ACTwiz_AsignaIDGlosaTramosMas 


  //Métodos modificados:
  //ACTcfgit_OpcionesGenerales 
  //[xxACT_ItemsTramos];"Configuration"
  //[xxACT_Items].Configuration.Variable2()
  //ACTitems_OpcionesRecalculoTramo 


  //Utilidades_CatalogoFuncionesInf

TRACE:C157
If (False:C215)
	  //ACTwiz_AsignaIDGlosaTramosMas 
	  //ACTcfgit_OpcionesGenerales 
	  //[xxACT_ItemsTramos].Configuration
	  //[xxACT_Items].Configuration.Variable2()
	  //ACTitems_OpcionesRecalculoTramo
	TRACE:C157
	TRACE:C157
	  //READ ONLY([xShell_ExecutionErrors])
	  //QUERY([xShell_ExecutionErrors];[xShell_ExecutionErrors]error_date=Current date(*))
	  //ALERT(String(Records in selection([xShell_ExecutionErrors])))
	
	  //STWA2_CreaImagenAlumnosEnDisco
	
	TRACE:C157  //Ticket 215404
	  //xAL_ACT_CB_GenDesctos 
	
	  //[xxSTR_Constants];"ACTcc_GenDesctos"
	  //  //Botón invisible2
	  //  //Variable4
	  //AL_ExitCell (xALP_Desctos)
	  //QR_ImprimeInforme 
	  //SN3_BuildMenu
	  //PREF_Set 
	  //USR_GetUserID 
	
	  //SC_ObtieneUrlDocsFunciones
	TRACE:C157
	
	TRACE:C157
	ARRAY TEXT:C222($at_informesUUID;0)
	APPEND TO ARRAY:C911($at_informesUUID;"35D2EF9C4F544CE089F8D36CC522F5E5")
	APPEND TO ARRAY:C911($at_informesUUID;"0F1B8ECEE6F047F3B6FF1CEE7D88E9FE")
	APPEND TO ARRAY:C911($at_informesUUID;"0B94166FBA6E46F4833197B5D007B181")
	APPEND TO ARRAY:C911($at_informesUUID;"DD1F305D1A794D2993BA22070EE2B976")
	APPEND TO ARRAY:C911($at_informesUUID;"186DC9619CAF46EB8C139C1F486DD224")
	APPEND TO ARRAY:C911($at_informesUUID;"7ED626B0DC5F44AE9A0AE6F53F62CA2D")
	APPEND TO ARRAY:C911($at_informesUUID;"D43CCEB705C97A47848E94A54BB16C63")
	
	READ ONLY:C145([xShell_Reports:54])
	QUERY WITH ARRAY:C644([xShell_Reports:54]UUID:47;$at_informesUUID)
	While (Not:C34(End selection:C36([xShell_Reports:54])))
		
		NEXT RECORD:C51([xShell_Reports:54])
	End while 
	
	
	TRACE:C157
	ACTabc_ImportProcess 
	ACTabc_ImportPorColegio 
	ACTwiz_ImportBancarios 
	  //ACTtf_OpcionesTextosImp 
	  //xALP_ACT_ExportBankFiles
	  //ACTabc_OpcionesWizard 
	  //ACTabc_ImportByWizard 
	  //  [xxACT_ArchivosBancarios]"WizardO".validar"
	  //SET DATABASE LOCALIZATION("en")
	  //SET DATABASE LOCALIZATION("es")
	  //SYS_SetFormatResources 
	TRACE:C157
	  //ACTabc_ImportByWizard 
	  //ACTabc_ImportPorColegio 
	  //ACTtf_OpcionesTextosImp 
	  //UD_v20180816_AsistenteTransfere 
	  //UD_Handler
	  //"[xxACT_ArchivosBancarios]";"WizardO.Botón invisble 3"
	  //"[xxACT_ArchivosBancarios]";"WizardO.validar"
	  //"[xxACT_ArchivosBancarios]";"WizardO"
	  //[xxACT_ArchivosBancarios];"WizardO"
	TRACE:C157
	  //  //ADTwa_ProcesaSolicitud 
	  //$r_error:=0
	  //$json:=ADTwa_RespuestaError ($r_error)
	  //SET TEXT TO PASTEBOARD($json)
	  //  //Else 
	
	
	  //ARRAY LONGINT($alACT_idsPagos;0)
	  //APPEND TO ARRAY($alACT_idsPagos;1092)
	  //$r_ordenCompra:=1234
	
	  //C_OBJECT($ob_raiz;$ob_datos;$ob_datosPago)
	  //OB SET($ob_datos;"codigo";$r_error)
	  //OB SET($ob_datos;"descripcion";"ok.")
	  //OB SET($ob_datosPago;"id_act";$alACT_idsPagos{1})
	  //OB SET($ob_datosPago;"oc";$r_ordenCompra)
	  //OB SET($ob_raiz;"estado";$ob_datos)
	  //OB SET($ob_raiz;"datosdepago";$ob_datosPago)
	  //$json:=JSON Stringify($ob_raiz)
	  //SET TEXT TO PASTEBOARD($json)
	  //TRACE
	  //XCRwa_OnWebConnection 
	
	  //$r_error:=0
	  //$json:=XCRwa_RespuestaError ($r_error)
	  //SET TEXT TO PASTEBOARD($json)
	
	  //ARRAY LONGINT($alACT_idsPagos;0)
	  //APPEND TO ARRAY($alACT_idsPagos;1092)
	  //$r_ordenCompra:=1234
	
	  //C_OBJECT($ob_raiz;$ob_datos;$ob_datosPago)
	  //OB SET($ob_datos;"codigo";0)
	  //OB SET($ob_datos;"descripcion";"ok.")
	  //OB SET($ob_raiz;"estado";$ob_datos)
	  //OB SET($ob_datosPago;"id";$alACT_idsPagos{1})
	  //OB SET($ob_datosPago;"oc";$r_ordenCompra)
	  //OB SET($ob_raiz;"estado";$ob_datos)
	  //OB SET($ob_raiz;"datosdepago";$ob_datosPago)
	  //$json:=JSON Stringify($ob_raiz)
	  //SET TEXT TO PASTEBOARD($json)
	  //RINSCwa_GeneraAvisos
	
	UD_Handler 
	TRACE:C157
	ACTmnu_OpcionesGeneracionIECV 
	ACTdte_OpcionesGeneralesIE 
	IT_MODIFIERS 
	UD_Handler 
	WIZ_ACT_GeneracionIEC_IEV 
	
	UD_v20180724_CambioFechaEmiVenc 
	
	  //STWA2_CreaImagenAlumnosEnDisco ("actualizaImagen";[Alumnos]Auto_UUID) 
	TRACE:C157
	
	MPA_CompetenciaAdquirida 
	
	TRACE:C157
	READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
	QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=126795)
	If (Not:C34(Locked:C147([ACT_Avisos_de_Cobranza:124])))
		TRACE:C157
	End if 
	KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
	TRACE:C157
	  //dhBM_ProcessTasks
	  //BM_ACT_RecalculaAviso 
	  //ACTac_Recalcular 
	  //ACTac_OpcionesGenerales 
	
	ACTpgs_Delete 
	ACTpgs_DeleteSelection 
	ACTpgs_AnulaPago 
	ACTac_OpcionesGenerales 
	ACTac_Recalcular 
	
	
	  //ACTmnu_EmiteAvisos
	  //[xxSTR_Constants]."ACTcc_Cobranzas"
	  //ACTcc_ModificaFechasEmisVencAC 
	  //ACTcc_EmisionAvisos 
	  //ACTcar_OpcionesGenerales 
	  //UD_Handler
	  //TRACE
	
	  //If (Application type=4D Remote mode)
	  //$o_id:=Execute on server(Current method name;0;"Verificando")
	  //Else 
	  //  //SET TEXT TO PASTEBOARD(4D_BuscaObjetos ("SinFuente"))
	  //  //4D_XLIFF_CreateFiles 
	
	  //CIM_FTP_ConnectionData 
	  //$t_rutaarchivo:=xfGetFileName 
	  //  //$t_nombreProc:="Test"
	  //  //$t_rutaRespaldo:="Test Respaldo"+SYS_FolderDelimiter +SYS_Path2FileName ($t_rutaarchivo)
	  //If (Test path name($t_rutaarchivo)=Is a document)
	  //  //$l_nuevoProceso:=New process("FTP_Upload";0;$t_nombreProc;0;"/";$t_rutaRespaldo;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;"Client";<>RegisteredName;False;True)
	  //$l_error:=FTP_Upload (0;"/";$t_rutaarchivo;vtFTP_Url;vtWS_ftpLoginName;vtWS_ftppassword;"Client";<>RegisteredName;False;True)
	  //Else 
	  //TRACE
	
	  //End if 
	
	  //End if 
	
	
	
	  //  //BKP_SubeRespaldo 
	  //  //BKPs3_SubeRespaldo
	
	  //  //If (False)
	  //  //$l_proc:=IT_Progress (1;0;0;"Generando archivo forms.xlf...")
	  //  //$l_table:=Table(->[xShell_Dialogs])
	  //  //For ($i_table;$l_table;$l_table)
	  //  //If (Is table number valid($i_table))
	  //  //$y_table:=Table($i_table)
	  //  //FORM GET NAMES($y_table->;$at_forms)
	  //  //For ($i_forms;1;Size of array($at_forms))
	  //  //If ($at_forms{$i_forms}="RGB_Colors")
	  //  //$t_groupXML:=4D_XLIFF_FormTexts ($y_table;$at_forms{$i_forms})
	  //  //If ($t_groupXML#"")
	  //  //$t_bodyXML:=$t_bodyXML+$t_groupXML
	  //  //End if 
	  //  //End if 
	  //  //End for 
	  //  //End if 
	  //  //IT_Progress (0;$l_proc;$i_table/Get last table number)
	  //  //End for 
	  //  //IT_Progress (-1;$l_proc)
	  //  //End if 
	  //  //4D_XLIFF_CreateFiles
	
	  //TRACE
	  //  //$t_mensajeCambioPassw:=__ ("Su contraseña expiró el "+String(Current date(*))+" \rPor favor establezca su nueva contraseña.")
	  //  //USR_ChangePassword ($t_mensajeCambioPassw)
	  //TRACE
	  //  //BUILD_Start
	  //  //SET TEXT TO PASTEBOARD(4D_BuscaObjetos ("SinFuente"))
	  //  //TRACE
	
	  //  //[xxSTR_Constants];"STR_Eximición"OK
	  //  //[xxSTR_Constants];"STR_SpecialFind2" OK
	  //  //[xxSTR_Constants];"STR_SpecialFind2" OK
	  //  //[xxSTR_Constants];"STR_SeleccionaNivelRango" OK
	  //  //[xxSTR_Constants];"STR_SeleccionaNivelRango" OK
	  //  //[Profesores];"Input" OK
	  //  //[Profesores];"Input" OK
	  //  //[Profesores];"Input" OK
	  //  //[BBL_Registros];"Periodicals" OK
	
	
	  //If (False)
	  //ACTpgs_AsignaCuentasContables 
	
	  //ACTcfg_OpcionesFormasDePago 
	  //ACTinit_LoadFdPago 
	  //  //WSscripts_EjemplosConsumo 
	  //  //dhBWR_PanelSettings 
	  //TRACE
	  //  //$t_objetos:=4D_BuscaObjetos ("SinFuente")
	  //  //SET TEXT TO PASTEBOARD($t_objetos)
	  //TRACE
	  //  //[xxSTR_Constants];"STR_Eximición"
	  //  //[xxSTR_Constants];"STR_SpecialFind2"
	  //  //[xxSTR_Constants];"STR_SpecialFind2"
	  //  //[xxSTR_Constants];"STR_SeleccionaCurso"
	  //  //[xxSTR_Constants];"STR_SeleccionaCurso"
	  //  //[xxSTR_Constants];"STR_SeleccionaNivelRango"
	  //  //[xxSTR_Constants];"STR_SeleccionaNivelRango"
	  //  //[Alumnos];"Ficha del alumno [1]"
	  //  //[Cursos];"Inasistencias"
	  //  //[Profesores];"Input"
	  //  //[Profesores];"Input"
	  //  //[Profesores];"Input"
	  //  //[Alumnos_Castigos];"MultiInput"
	  //  //[xxSTR_Materias];"Print"
	  //  //[BBL_Registros];"Periodicals"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xShell_InfoMachines];"Impresion"
	  //  //[xxSTR_HistoricoNiveles];"Propiedades"
	
	  //TRACE
	  //  //Ticket 206788
	  //  //MSG_ActualizaDesdeIntranet 
	  //  //MSG_EliminaEnIntranet 
	  //  //RIN_BuscaInformes
	  //  //RIN_ComparaInforme 
	  //  //RIN_DescargaActualizacion 
	  //  //RIN_DescargaEjemplo 
	  //  //RIN_EnviaInforme 
	  //  //RIN_hayVersionActualizada 
	  //  //RIN_InfoExplorador
	  //  //RIN_LeeInformaciones 
	  //  //RIN_RefUltimaVersion 
	  //  //VC4D_CheckServerConnection 
	  //  //VC4D_ComparaCodigo 
	  //  //VC4D_LoadChanges 
	  //  //VC4D_MuestraCodigoRemoto 
	  //  //VC4D_UpdateMethod 
	  //  //WS_GetFtpLoginInfo 
	  //  //WS_SendSystemInfo 
	  //  //WSact_DesmarcaProcesado 
	  //  //WSact_sincronizaFoliosDisponib 
	  //  //WSexe_LeeScript_in 
	  //  //WSexe_ListaScriptsRemotos_in 
	  //  //WSout_EnviaInfoMaquinas 
	  //  //[xShell_Reports];"EnvioRepositorio"
	  //  //[xShell_Reports];"ReportProperties"
	  //TRACE
	
	  //READ ONLY([Profesores])
	  //QUERY([Profesores];[Profesores]Auto_UUID="f6d51fdb-728b-c54a-b0fd-c0ebbc2478e9")
	
	  //  //SERwa_OnWebConnection
	  //CONDOR_Export_Asignaturas 
	  //TRACE
	  //  //STR_ValidaCreacionRegistro 
	  //  //AL_fSave 
	  //  //IOstr_ProcessStudentRecord
	  //  //PP_fSave 
	  //  //IOstr_ProcessParentRecord 
	  //  //FM_fSave 
	  //  //IOstr_ProcessFamilyRecord 
	  //  //IOstr_ImportStudentData
	
	
	
	  //$processID:=ST_EjecutaProcesoServidor ("dbu_CreaSesiones";"CreacionDeSesiones")
	  //  //Sync_Activar
	  //  //PCSrun_ACT_MailSender
	  //TRACE
	  //$l_rec:=Records in table([Asignaturas_RegistroSesiones])
	  //TRACE
	  //$t_texto:=4D_BuscaObjetos ("SinFuente")
	  //TRACE
	  //If ($t_texto#"")
	  //SET TEXT TO PASTEBOARD($t_texto)
	  //End if 
	
	
	  //TRACE
	  //DIALOG("STWA2_Administracion")  //OK
	  //DIALOG("VC4D")  //OK
	  //DIALOG("SR_SectionProperties")  //OK
	  //DIALOG([xxSTR_Constants];"ACTdcApdos_Reemplazador")
	  //DIALOG([xxSTR_Constants];"ACTdc_CambiadordeUbicacion")
	  //DIALOG([xxSTR_Constants];"ACTdc_Prorrogador")
	  //DIALOG([xxSTR_Constants];"ACTdc_Reemplazador")
	  //DIALOG([xxSTR_Constants];"ACTdd_Protestador")
	  //DIALOG([xxSTR_Constants];"ACTpgs_Documentar")
	  //DIALOG([xxSTR_Constants];"ACTwiz_EmisionBoletas")
	  //DIALOG([xxSTR_Constants];"ACTwiz_GeneracionCargos")
	  //DIALOG([xxSTR_Constants];"ACT_IngresoPagosCaja")
	  //DIALOG([xxSTR_Constants];"ACTcc_Asignacion_de_Matriz")
	  //DIALOG([xxSTR_Constants];"ACTcc_Cobranzas")
	  //DIALOG([xxSTR_Constants];"ACTcfg_Boletas")
	  //DIALOG([xxSTR_Constants];"STR_ImportHistorico")
	  //DIALOG([xxSTR_Constants];"STR_CL_Asistente_Subvenciones")
	  //DIALOG([xxSTR_Constants];"STR_Asistente_CreaAsignaturas")
	  //DIALOG([xxSTR_Constants];"STR_Asistente_CreacionCursos")
	  //DIALOG([xxSTR_Constants];"STR_Asistente_ImportaAlumnos")
	  //DIALOG([xxSTR_Constants];"STR_Asistente_ImportaProfes")
	  //DIALOG([xxSTR_Constants];"ACT_VentaRapida")
	  //DIALOG([xxSTR_Constants];"STR_PlanillaAsistencia")
	  //DIALOG([xxSTR_Constants];"ACTac_Impresor")
	  //DIALOG([xxSTR_Constants];"ACTcc_EliminarCargos")
	  //DIALOG([xxSTR_Constants];"ACTcc_CambiarFechaProyectados")
	  //DIALOG([xxSTR_Constants];"ACTbol_Impresor")
	  //DIALOG([xxSTR_Constants];"ACTcc_GenDesctos")
	  //DIALOG([xxSTR_Constants];"ACT_Asistente_Contables")
	  //DIALOG([xxSTR_Constants];"ACT_AsistenteArchBancos")
	  //DIALOG([xxSTR_Constants];"ACTcfg_General")
	  //DIALOG([xxSTR_Constants];"ACT_ArchaImportar")
	  //DIALOG([xxSTR_Constants];"STR_OpcionesInformeLogros")
	  //DIALOG([xxSTR_Constants];"ACTcc_ImportadorCargos")
	  //DIALOG([xxSTR_Constants];"ACTwiz_ImportDatosPagoApdos")
	  //DIALOG([xxSTR_Constants];"STR_SeleccionaMes2")
	  //DIALOG([xxSTR_Constants];"STR_SeleccionaCurso")
	  //DIALOG([xxSTR_Constants];"STR_SeleccionaNivelRango")
	  //DIALOG([xxSTR_Constants];"STR_OpcInfColumnasEval")
	  //DIALOG([xxSTR_Constants];"STR_ImportNotasActuales")
	  //DIALOG([xxSTR_Constants];"ADTmnu_ImportPost")
	  //DIALOG([xxSTR_Constants];"WZD_ImportacionFotografias")
	  //DIALOG([xxSTR_Constants];"WZD_ProcesamientoFotografias")
	  //DIALOG([xxSTR_Constants];"MT_ImportaPréstamos")
	  //DIALOG([xxSTR_Constants];"WIZ_ImportRegistros_BBL")
	  //DIALOG([xxSTR_Constants];"WIZ_ImportAnaliticos_BBL")
	  //DIALOG([xxSTR_Constants];"STR_PlanillaAsist_Media")
	  //DIALOG([xxSTR_Constants];"STR_PlanillaAsist_Basica")
	  //DIALOG([xxSTR_Constants];"STR_PlanillaAsist_Kinder")
	  //DIALOG([xxSTR_Constants];"STR_PlanillaAsist_PreKinder")
	  //DIALOG([xxSTR_Constants];"STR_CL_Asistente_RECH")
	  //DIALOG([xxSTR_Constants];"STR_Legionarios_ConoVtas")
	  //DIALOG([xxSTR_Constants];"ACTcc_ImportadorItems")
	  //DIALOG([xxSTR_Constants];"ACTwiz_ImportadorUserFields")
	  //DIALOG([xxSTR_Constants];"SIGE_panel_de_control")
	  //DIALOG([xxSTR_Constants];"Cierre")
	  //DIALOG([xxSTR_Constants];"STR_Check_SN3")
	  //DIALOG([xxSTR_Constants];"ACTwiz_ImportadorChequesDepo")
	  //DIALOG([Alumnos];"CdctaPers")
	  //DIALOG([Alumnos];"Dossier_SaludyOrientación")
	  //DIALOG([Alumnos];"Horario")
	  //DIALOG([Alumnos];"output")
	  //DIALOG([Alumnos];"Input")
	  //DIALOG([Alumnos];"rep_PLPform")
	  //DIALOG([Cursos];"Horario")
	  //DIALOG([Cursos];"rep_PlanillaNotas")
	  //DIALOG([Cursos];"pe_NominaMatricula")
	  //DIALOG([Cursos];"Frecuencias")
	  //DIALOG([Cursos];"Input")
	  //DIALOG([Profesores];"Input")
	  //DIALOG([Profesores];"Horario")
	  //DIALOG([xxSTR_Niveles];"Certificado")
	  //DIALOG([xxSTR_Niveles];"Configuration")
	  //DIALOG([Alumnos_Castigos];"Salida")
	  //DIALOG([Alumnos_Castigos];"Cumplimientos")
	  //DIALOG([Alumnos_Castigos];"Cumplimientos1")
	  //DIALOG([Alumnos_Inasistencias];"STR_Importador_Asist_Atrasos")
	  //DIALOG([xShell_UserGroups];"PrintDetailGroup")
	  //DIALOG([Asignaturas];"Propiedades_Evaluación")
	  //DIALOG([Asignaturas];"TextoObs")
	  //DIALOG([Asignaturas];"TextoObjetivos")
	  //DIALOG([Asignaturas];"Input")
	
	  //DIALOG([Asignaturas];"OpcionesObject")
	
	  //DIALOG([xShell_ExecutableCommands];"Output")
	  //DIALOG([Alumnos_EventosOrientacion];"TipoEventoSelec")
	  //DIALOG([xxSTR_DatosDeCierre];"Asistente_CierreAgno_cl")
	  //DIALOG([xxSTR_DatosDeCierre];"Asistente_CierreAgno_co")
	  //DIALOG([Actividades];"StudSelection")
	  //DIALOG([Actividades];"Lista")
	  //DIALOG([xxSTR_EstilosEvaluacion];"Configuration")
	  //DIALOG([ADT_Candidatos];"Importador")
	  //DIALOG([xShell_Reports];"PLP_USLetterPaysage")
	  //DIALOG([xShell_Reports];"PLP_USLetterPortrait")
	  //DIALOG([xShell_Reports];"XS_ReportManager")
	  //DIALOG([xShell_Reports];"SaveReport")
	  //DIALOG([xShell_Reports];"OpenReport")
	  //DIALOG([xShell_Reports];"EnvioRepositorio")
	  //DIALOG([xShell_Reports];"ReportProperties")
	  //DIALOG([xShell_Reports];"Repositorio")
	  //DIALOG([Alumnos_Atrasos];"Salida")
	  //DIALOG([BBL_Items];"FichaCatalografica")
	  //DIALOG([BBL_Items];"Input")
	  //DIALOG([BBL_Items];"Busqueda")
	  //DIALOG([xxBBL_Preferencias];"CFG_Generales")
	  //DIALOG([BBL_Registros];"Input")
	  //DIALOG([BBL_Registros];"ListaRegistros")
	  //DIALOG([BBL_Thesaurus];"Asignador")
	  //DIALOG([BBL_Lectores];"List")
	  //DIALOG([xxSTR_Subasignaturas];"PlanillaSubAsignatura")
	  //DIALOG([xxSTR_HistoricoEstilosEval];"Lista")
	  //DIALOG([ADT_Contactos];"Input")
	  //DIALOG([xxACT_ArchivosHistoricos];"Entrada")
	  //DIALOG([xShell_Dialogs];"MSN_DisplayMsnOnClient")
	  //DIALOG([xShell_Dialogs];"XS_MASTER_WZDDialogs")
	  //DIALOG([xxACT_Datos_de_Cierre];"Entrada")
	  //DIALOG([xxACT_ArchivosBancarios];"WizardO")
	  //DIALOG([xxACT_Bancos];"Lista")
	  //DIALOG([Alumnos_ResultadosEgreso];"Entrada")
	  //DIALOG([xxACT_ObservacionesCondonacion];"Entrada")
	  //DIALOG([ACT_Terceros];"Input")
	  //DIALOG([CMT_Transferencia];"Salida")
	  //DIALOG([SN3_PublicationPrefs];"ConsultaUsuarios")
	  //DIALOG([SN3_PublicationPrefs];"Generales")
	  //DIALOG([ACT_Pagos];"DescuentosXTramo")
	
	  //DIALOG([ACT_CuentasCorrientes];"Input")
	
	  //DIALOG([ACT_Documentos_de_Pago];"ElegirCtaDeposito")
	  //DIALOG([ACT_Matrices];"InformeMatrices")
	  //DIALOG([ACT_Transacciones];"Lista")
	  //DIALOG([xxACT_Items];"ItemsEspeciales")
	  //DIALOG([ACT_Boletas];"Input")
	  //DIALOG([ACT_Boletas];"setDePruebas")
	  //DIALOG([ACT_Boletas];"setPruebasListado")
	  //DIALOG([Alumnos_Calificaciones];"Lista")
	  //DIALOG([Alumnos_Calificaciones];"Salida")
	  //DIALOG([Alumnos_ComplementoEvaluacion];"Observaciones")
	  //DIALOG([ACT_IECV];"Entrada")
	  //DIALOG([ACT_IECV];"ACT_Asistente_IEC_IEV")
	  //DIALOG([xxADN_LOG];"Entrada")
	  //DIALOG([XShell_ReportObjLib_Clases];"Manager")
	  //DIALOG([ACT_Cuentas_Contables];"Formulario1")
	  //DIALOG([ACT_Movimientos_Estados];"Formulario1")
	  //DIALOG([ACT_MatricesAsignacionAut];"Reglas")
	  //DIALOG([xxACT_ItemsTramos];"Configuration")
	
	
	  //TRACE
	  //  //[act_terceros].Input.Field4
	  //  //[act_terceros].Input.Pactado
	  //  //ACTter_OnRecordLoad 
	  //  //dhBWR_OnSaveRecord 
	  //  //ACTter_CreateRecord 
	  //  //ACTter_fSave 
	
	  //TRACE
	  //  //STWA2_OWC_conductaInit
	  //TRACE
	  //  //4D_XLIFF_FormTexts
	  //  //4D_XLIFF_CreateFiles 
	  //  //$t_texto:=CD_Dlog (0;__ ("En el colegio hay ^0 alumnos con problemas de repitencia en ^1 cursos.");"";__ ("Si");__ ("No"))
	  //  //STWA2_OWC_VistaDirector
	  //  //STWA2_SaveDato
	  //TRACE
	
	  //  //dhBM_TareasInicioDiario (True)
	  //$bb:=LICENCIA_VerificaModCondorAct ("Comunicaciones")
	
	  //SN3_SendData2SchoolNet 
	
	  //TRACE
	
	  //READ ONLY([xxBBL_Preferencias])
	  //ALL RECORDS([xxBBL_Preferencias])
	
	  //TRACE
	  //  //Servicio SBIF
	  //C_TEXT($t_resp;$t_content)
	  //C_LONGINT($l_http)
	  //$l_http:=HTTP Request(HTTP GET method;"api.sbif.cl/api-sbifv3/recursos_api/ipc/2016?apikey=6e0bd93f6d0a04bd65553198b32ee6b4d967c44d&formato=json";$t_content;$t_resp)
	  //SET TEXT TO PASTEBOARD($t_resp)
	  //  //Servicio SBIF
	  //TRACE
	
	  //LICENCIA_ObtieneUUIDinstitucion (True)
	
	  //TRACE
	  //  // XSvers_buildNumber()
	  //  // Por: Alberto Bachler: 02/04/13, 05:22:43
	  //  //  ---------------------------------------------
	  //  //
	  //  //
	  //  //  ---------------------------------------------
	  //C_LONGINT($l_plataforma;$l_version_BuildNumber;$l_version_Mayor;$l_version_Revision;$l_nuevoBuildNumber)
	  //C_TEXT($t_textoError;$t_version_completa;$t_version_Larga)
	  //C_BOOLEAN($1;$b_versionDesarrollo)
	  //C_LONGINT($2)
	
	  //If (Count parameters=1)
	  //$b_versionDesarrollo:=$1
	  //End if 
	  //$t_VersionCompleta:=SYS_LeeVersionEstructura ("aplicacion";->$t_version_Larga)
	  //$t_VersionCompleta:=SYS_LeeVersionEstructura ("principal";->$l_version_Mayor)
	  //$t_VersionCompleta:=SYS_LeeVersionEstructura ("revision";->$l_version_Revision)
	  //$t_VersionCompleta:=SYS_LeeVersionEstructura ("build";->$l_version_BuildNumber)
	  //$t_version_SinBuild:=String($l_version_Mayor)+"."+String($l_version_Revision;"00")
	  //$t_version_SinBuild:=String($l_version_Mayor)+"."+String($l_version_Revision)
	
	
	
	  //PLATFORM PROPERTIES($l_plataforma)
	
	  //  //20180125 RCH Se llama directo a IN3 por problemas de conexión entre intranet 2 y pa IP 0.47
	  //If (False)
	  //WEB SERVICE SET PARAMETER("plataforma";$l_plataforma)
	  //WEB SERVICE SET PARAMETER("version";$t_version_SinBuild)
	  //WEB SERVICE SET PARAMETER("build";$l_version_BuildNumber)
	  //WEB SERVICE SET PARAMETER("versionDesarrollo";$b_versionDesarrollo)
	
	
	  //$t_textoError:=WS_CallIntranetWebService ("WSvers_BuildNumber")
	  //$l_nuevoBuildNumber:=-1
	
	  //If ($t_textoError="")
	  //WEB SERVICE GET RESULT($l_nuevoBuildNumber;"resultado";*)
	  //If ($l_nuevoBuildNumber>=$l_version_BuildNumber)
	  //  //SYS_EstableceVersionEstructura ("Build";String($l_nuevoBuildNumber))
	  //End if 
	  //End if 
	  //Else 
	  //  //C_TEXT($t_json)
	  //  //C_OBJECT($ob_request)
	  //  //OB SET($ob_request;"plataforma";$l_plataforma)
	  //  //OB SET($ob_request;"version";$t_version_SinBuild)
	  //  //OB SET($ob_request;"build";$l_version_BuildNumber)
	  //  //OB SET($ob_request;"versionDesarrollo";$b_versionDesarrollo)
	  //  //$t_jsonRequest:=JSON Stringify($ob_request)
	  //  //$httpStatus_l:=Intranet3_LlamadoWS ("WSvers_BuildNumber";$t_jsonRequest;->$t_json)  //MONO TICKET 183850
	
	  //C_TEXT($t_body;$t_json)
	  //ARRAY TEXT($at_httpHeaderNames;0)
	  //ARRAY TEXT($at_httpHeaderValues;0)
	
	  //APPEND TO ARRAY($at_httpHeaderNames;"content-type")
	  //APPEND TO ARRAY($at_httpHeaderValues;"application/x-www-form-urlencoded")
	
	  //$l_nuevoBuildNumber:=-1
	  //$t_body:="build="+String($l_version_BuildNumber)+"&version="+$t_version_SinBuild+"&plataforma="+String($l_plataforma)+"&versionDesarrollo="+String($b_versionDesarrollo)
	  //$httpStatus_l:=Intranet3_LlamadoWS ("WSvers_BuildNumber";$t_body;->$t_json;->$at_httpHeaderNames;->$at_httpHeaderValues)  //MONO TICKET 183850
	
	  //If ($httpStatus_l=200)
	  //C_OBJECT($ob_response)
	  //$ob_response:=JSON Parse($t_json;Is object)
	  //If ((OB Is defined($ob_response;"resultado")))
	  //$l_nuevoBuildNumber:=OB Get($ob_response;"resultado")
	  //End if 
	  //End if 
	  //End if 
	  //$0:=$l_nuevoBuildNumber
	
	  //  //STWA2_MO_Builder 
	
	  //TRACE
	
	  //If (False)
	  //While (True)
	  //READ ONLY([xShell_Prefs])
	  //QUERY([xShell_Prefs];[xShell_Prefs]Reference="XS_HESR_@")
	  //While (Not(End selection([xShell_Prefs])))
	  //SET TEXT TO PASTEBOARD(JSON Stringify([xShell_Prefs]_objeto;*))
	  //NEXT RECORD([xShell_Prefs])
	  //End while 
	  //End while 
	
	  //End if 
	  //TRACE
	
	  //SERwa_Ejecuta 
	  //SERwa_EjecutaScript 
	  //WSscripts_Ejecuta 
	  //SERwa_OnWebConnection 
	
	
	  //  ///
	  //XS_VerificaRegistroServidor 
	  //WSout_EnviaInfoMaquinas 
	
	  //Intranet3_LlamadoWS 
	
	  //TRACE
	  //  //[ACT_RazonesSociales] nuevos campos
	  //  //[Personas]
	  //  //[ACT_Terceros]
	  //  //ACTcfg_OpcionesRazonesSociales 
	  //  //ACTbol_GeneraArchivoDigital 
	  //  //[xxSTR_Constants]ACTcfg_General
	  //  //[Personas]Input_ACT
	  //  //[ACT_Terceros]input
	  //  //PP_OnRecordLoad 
	  //  //PP_fSave
	  //  //[Personas]Input
	  //  //ACTter_PageGeneral 
	  //  //ACTter_fSave
	  //  //[Personas];"ACT_DireccionFacturacion"
	  //  //[ACT_Terceros];"ACT_DireccionFacturacion"
	  //TRACE
	  //  //[xxACT_ItemsCategorias]Codigo
	  //  //  //ACTic_CargaListas
	
	
	  //TRACE
	
	  //  //UD_v20141006_ACT_FormaPago 
	  //  //UD_v20171221_FormaPagoWeb 
	  //  //UD_Handler 
	  //  //ACTpgs_DatosPagosWeb 
	  //  //  //[ACT_Documentos_de_Pago]Input
	  //  //ACTpgs_onRecordLoad
	  //TRACE
	  //  //C_OBJECT($ob_validacion)
	  //  //ARRAY TEXT($atACT_CargosUUIDAl;0)
	  //  //ARRAY REAL($arACT_CargosIDACT;0)
	  //  //ARRAY TEXT($atACT_CargosMontos;0)
	
	  //  //For ($i;1;10)
	  //  //APPEND TO ARRAY($atACT_CargosUUIDAl;String($i))
	  //  //APPEND TO ARRAY($arACT_CargosIDACT;$i)
	  //  //APPEND TO ARRAY($atACT_CargosMontos;String($i+100))
	  //  //End for 
	
	  //  //OB SET ARRAY($ob_validacion;"uuidal";$atACT_CargosUUIDAl)
	  //  //OB SET ARRAY($ob_validacion;"idcargo";$arACT_CargosIDACT)
	  //  //OB SET ARRAY($ob_validacion;"montos";$atACT_CargosMontos)
	
	
	
	  //  //TRACE
	  //  //  //WIZ_STR_ImportacionAlumnos 
	  //  //  //WIZ_STR_CargaDatosEncabezadotxt 
	  //  //  //[xxSTR_Constants];"STR_EncabezadosImportacionAlu"
	  //  //  //  //boton descarga archivo con encabezado
	  //  //  //IOstr_ImportStudentData 
	  //  //  //IOstr_ProcessStudentRecord 
	  //  //  //IOstr_ProcessFamilyRecord 
	  //  //  //IOstr_ProcessParentRecord 
	  //  //  //IOstr_linkStudentToFamily 
	  //  //  //ADT_postEnviaRespuestaImport 
	  //  //  //IOstr_ProcessTeacherRecord
	  //  //  //ADTwa_PostProcesaSolicitud
	  //  //TRACE
	
	
	  //  //TRACE
	
	  //  //C_TEXT($t_dts;$t_versionEstructura)
	  //  //$t_versionEstructura:=SYS_LeeVersionEstructura ("dts";->$t_dts)
	  //  //$t_versionEstructura:="Version: "+$t_versionEstructura+"\r"+DTS_GetDateTimeString ($t_dts;System date long;HH MM)+" (GMT)"
	
	  //  //TRACE
	  //  //C_LONGINT($l_idRS)
	  //  //$l_idRS:=-1
	  //  //TRACE
	  //  //SET TEXT TO PASTEBOARD(RINSCwa_EnviaCargos )
	
	
	  //  //TRACE
	  //  //C_TEXT($domain)
	  //  //C_LONGINT($port)
	  //  //$domain:="sync-api.colegium.com"
	  //  //$port:=8443
	  //  //ALERT(String(Num(INET_IsHostAvailable ($domain;$port))))
	
	  //  //C_TEXT($t_ultimaCarga;$cUUID;$t_resp)
	  //  //READ ONLY([sync_diccionario])
	  //  //ALL RECORDS([sync_diccionario])
	  //  //ORDER BY([sync_diccionario];[sync_diccionario]dts;<)
	  //  //$t_ultimaCarga:=[sync_diccionario]dts
	  //  //If ($t_ultimaCarga="")
	  //  //$t_ultimaCarga:="2000-01-01T00:00:00Z"  //solo para primera vez!!!
	  //  //End if 
	  //  //ALERT("ÚLTIMA CARGA: "+$t_ultimaCarga)
	  //  //$cUUID:=Util_MakeUUIDCanonical (<>GUUID)
	  //  //ALERT("UUID: "+$cUUID)
	  //  //C_OBJECT($emptyobject;$answer)
	  //  //$answer:=SYNC_APICall ("actualizadiccionario";HTTP GET method;$emptyobject;$cUUID;$t_ultimaCarga)
	  //  //ALERT("RESPUESTA"+String(Num(SYNC_CHECKERROR ($answer))))
	  //  //$t_resp:=JSON Stringify($answer)
	  //  //SET TEXT TO PASTEBOARD($t_resp)
	  //  //ALERT("respuesta stringify: "+$t_resp)
	  //  //<>b_sincronizar:=OB Get($answer;"sincronizar";Is Boolean)
	  //  //<>t_nombreBDCondor:=OB Get($answer;"nombrebd")
	  //  //ALERT("SINCRO: "+String(Num(<>b_sincronizar)))
	  //  //ALERT("NOM: "+<>t_nombreBDCondor)
	
	
	  //  //TRACE
	  //  //  //$l_idCargo:=115866
	
	  //  //  //$l_tiempo:=IT_StartTimer 
	  //  //  //ACTcar_EsCargoEliminable ($l_idCargo)
	  //  //  //IT_StopTimer ($l_tiempo)
	  //  //  //TRACE
	  //  //  //$l_tiempo:=IT_StartTimer 
	  //  //  //ACTcar_EsCargoEliminable ($l_idCargo)
	  //  //  //IT_StopTimer ($l_tiempo)
	
	
	  //  //TRACE
	  //  //  //$b_valido:=ACTbol_ValidaEmisionDT(3339)
	  //  //While (True)
	  //  //READ ONLY([ACT_Avisos_de_Cobranza])
	  //  //$l_idAC:=53197
	  //  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=$l_idAC)
	  //  //LOCKED BY([ACT_Avisos_de_Cobranza];$l_proceso;$t_usuario4D;$t_sesionUsuario;$t_nombreProceso)
	  //  //TRACE
	  //  //$l_idAC:=53198
	  //  //QUERY([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]ID_Aviso=$l_idAC)
	  //  //LOCKED BY([ACT_Avisos_de_Cobranza];$l_proceso;$t_usuario4D;$t_sesionUsuario;$t_nombreProceso)
	  //  //TRACE
	  //  //End while 
	  //  //TRACE
	  //  //  //ACTpgs_AnulaPago
	
	  //  //TRACE
	  //  //ACTcar_EsCargoEliminable 
	
	  //  //If (False)
	  //  //  //Nuevo campo en Cargos [ACT_Cargos]OB_Responsable
	  //  //  //Nuevo campo en Ctas Ctes [ACT_CuentasCorrientes]o_pct_emision
	  //  //  //[ACT_Documentos_de_Cargo]ID_Responsable
	  //  //  //[ACT_Avisos_de_Cobranza]ID_Responsable
	  //  //  //ACTcc_DividirEmision
	  //  //  //ACTcc_fSave 
	  //  //  //ACTcc_OnRecordLoad NO
	  //  //  //[xxSTR_Constants].IngresaValor
	  //  //  //[ACT_CuentasCorrientes].Input
	  //  //  //ACTcc_EmisionAvisos
	  //  //  //ACTac_Delete 
	  //  //  //ACTcfg_ItemsMatricula
	  //  //  //[ACT_Avisos_de_Cobranza].Input NO
	  //  //  //ACTac_OnLoadAviso
	  //  //  //[ACT_CuentasCorrientes].Input.Variable213
	  //  //  //ACTac_CreateCargoDocCargo4Int 
	  //  //  //ACTpgs_CreaCargoDesctoEspecial
	  //  //  //[xxSTR_Constants].ACTcfg_general
	  //  //  //ACTbol_MontosFromPagos 
	  //  //  //ACTbol_CreaDTObj
	  //  //  //ACTbol_EmitirDocumentos
	  //  //  //ACTac_Recalcular 
	  //  //  //ACTpgs_DescuentosXTramo
	  //  //  //ACTdxt_CalculaDesdeIDAC 
	  //  //  //ACTdxt_ObtieneMontosDesdeSetCar 
	  //  //  //QA_Pruebas
	  //  //  //ACTbol_validaInfo
	  //  //  //ACTbol_EMasivaDocTribs4Pagos 
	  //  //  //ACTbol_FiltraItemsResponsable 
	  //  //  //ACTbol_EmitirDocumentos4Pagos 
	  //  //  //ACTbol_EMasivaDocTribs 
	  //  //  //Compiler_Methods
	  //  //  //xALSet_AL_AreasFamilia
	  //  //  //ACTbol_FiltraItemsMoneda
	  //  //  //ACTcc_LoadCargosIntoArrays
	  //  //  //[xxSTR_Constants].ACTcfg_general.FormMethod
	  //  //  //ACTcfg_LeeBlob
	  //  //  //ACTcfg_LoadConfigData 
	  //  //  //ACTcfg_SaveConfig
	  //  //  //ACTcfg_GuardaBlob
	  //  //  //ACTbol_CreateRecord
	  //  //  //ACTinit_LoadPrefs
	  //  //  //ACTcar_Delete
	  //  //  //ACTcfg_OpcionesGenRecibo 
	  //  //  //ACTpgs_CargaModelosRecibos 
	  //  //  //[xxSTR_Constants]ACT_IngresoPagosCaja.Ingresar
	  //  //  //[xxSTR_Constants].ACTpgs_VentasRapidas.ingresar2
	  //  //  //ACTpgs_EmitirBoletasDocumentar 
	  //  //  //[xxSTR_Constants].ACTac_Impresor.Variable65
	  //  //  //PCSrun_ACT_MailSender
	  //  //  //ACTmnu_ImprimeEnviaAvisos
	  //  //  //[xxSTR_Constants].ACTac_Impresor
	  //  //  //[xxSTR_Constants].ACTac_Impresor.FormMethod
	  //  //  //ACTqry_AvisosParaUnMes 
	  //  //  //dhSR_InitVariables
	  //  //  //SRcust_SetAvisosVariables
	  //  //  //SRACTac_EndAviso
	  //  //  //SRACTac_InitPrintingVariables 
	  //  //  //SRACTac_CargaCargos
	  //  //  //ACTac_ImpresionAvisos 
	  //  //  //[ACT_Pagos].DescuentosXTramo
	  //  //  //ACTqry_CargoEspecial
	  //  //  //ACTinit_CreateDescuentoTramoA 
	  //  //  //ACTabc_ImportProcess
	  //  //  //ACTmnu_UtilizarDisponiblePago
	  //  //  //ACTreemp_Documentos
	  //  //  //ACTreemp_VariosCheques
	  //  //  //[xxSTR_Constants].ACT.CargosAviso.Cargos
	  //  //  //[xxSTR_Constants].ACT_IngresoPagosCaja
	  //  //  //[xxSTR_Constants].ACTpgs_AvisosDocumentar.Cargos
	  //  //  //[xxSTR_Constants].ACTpgs_Documentar
	  //  //  //ACTpgs_CargaDatosPagoApdo 
	  //  //  //ACTpgs_CargaDatosPagoCta
	  //  //  //ACTpgs_CargaDatosPagoTercero
	  //  //  //ACTpgs_IngresarPagos 
	  //  //  //ACTpgs_CalculaInteresCargos 
	  //  //  //ACTac_CreateCargoDocCargoImp
	  //  //  //ACTpgs_RecalculaAvisosInArrays
	  //  //  //ACTac_Prepagar
	  //  //  //ACTpgs_IngresarDocumentos
	  //  //  //ACTdesc_OpcionesGenerales
	  //  //  //[xxACT_Items].ItemsEspeciales
	  //  //  //LOC_LoadList
	  //  //  //ACTcc_onLoad 
	  //  //  //AL_LoadFamRels
	  //  //  //ACTac_UtilizaDescuentos 
	
	  //  //ACTpgs_AnulaPago 
	
	  //  //End if 
	  //  //TRACE
	  //  //SET DATABASE LOCALIZATION("en")
	  //  //SET DATABASE LOCALIZATION("es-cl")
	  //  //TRACE
	  //  //SYS_SetFormatResources 
	
	  //  //TRACE
	  //  //  //LOC_ObtieneReferencia
	  //  //xliff_CargaFormatos 
	  //  //SYS_SetFormatResources 
	  //  //LOC_ChangeLanguage 
	
	  //  //SYS_OpenLangageResource 
	
	
	
	  //  //  //[xxSTR_Constants].ACTcfg_General.Boton Invisible2
	  //  //If (False)
	
	  //  //ALERT(String(1000;"|Despliegue_ACT")+". "+String(1000;"|Despliegue_ACT_Pagos"))
	  //  //ALERT(String(-1000;"|Despliegue_ACT")+". "+String(-1000;"|Despliegue_ACT_Pagos"))
	  //  //End if 
	  //  //If (False)
	
	  //  //$t_local:=Get database localization(1)
	  //  //SET DATABASE LOCALIZATION($t_local)
	
	  //  //$t_descripcion:=Get database localization(Current localization)
	  //  //SHOW ON DISK(Get 4D folder(Current resources folder))
	  //  //SYS_SetFormatResources 
	  //  //xliff_CargaFormatos 
	  //  //End if 
	  //  //  //SYS_EstableceVersionBaseDeDatos 
	
	  //  //TRACE
	  //  //  //CFGstr_GuardaObsSubsectores 
	  //  //  //CFGstr_LeeObsSubsectores 
	  //  //  //UD_v20151130_ObservacionesMater 
	  //  //  //[xxSTR_Materias].Input
	  //  //  //[xxSTR_Materias].Input AGREGAR PÁGINA 2 AL FORM
	  //  //  //[xxSTR_Materias].Input Metodo de form
	  //  //  //[xxSTR_Materias].Input objetos pagina 0
	  //  //  // [xxSTR_Materias].Input.Pestaña()
	  //  //  // [xxSTR_Materias].Input.listbox.niveles()
	  //  //  //AS_PageObs 
	  //  //  //STWA2_SaveDato 
	  //  //TRACE
	
	  //  //  //If (False)
	  //  //  //If (Application type=4D Remote mode)
	  //  //  //$l_pid:=Execute on server(Current method name;Pila_256K;"S3")
	  //  //  //Else 
	  //  //  //TRACE
	  //  //  //BKPs3_SubeRespaldo 
	  //  //  //End if 
	  //  //  //End if 
	
	  //  //TRACE
	  //  //  //AS_PropEval_Configura 
	  //  //  //dbu_VerificaConsolidaciones 
	  //  //  //TRACE
	  //  //  //LICENCIA_Verifica 
	  //  //  //Valida_json 
	  //  //  //UD_Handler 
	  //  //TRACE
	
	  //  //  //BKPs3_SubeRespaldo 
	  //  //  //BKP_CierraRespaldo 
	  //  //  //BKPs3_EscribeLog 
	  //  //  //CIM_GotoPage_BKP 
	  //  //  //CIM_Principal
	  //  //  //BKPs3_ConsultaLog 
	  //  //  //BKPwa_SolicitaRespaldo 
	  //  //  //Agregar componente
	  //  //  //BKPs3_AnalizaRespuesta
	  //  //  //BKPs3_ObtieneXMLConfiguracion 
	  //  //  //BKPs3_ObtieneXMLCredenciales
	  //  //TRACE
	
	  //  //  //CTRY_UY_VerifIDNacional
	  //  //  //CTRY_CL_VerifRUT 
	  //  //  //[Alumnos]CustmIds.Variable1
	  //  //  //[Alumnos]Identificadores.Variable1
	  //  //  //IOstr_ProcessParentRecord 
	  //  //  //[Personas]CustmIds.Variable1
	  //  //  //[Personas]Identificadores.Variable1
	  //  //  //[Profesores]CustmIds.Variable1
	  //  //  //[Profesores]Identificadores.Variable1
	  //  //TRACE
	  //  //  //ACTfdp_CargaFormasDePago 
	  //  //  //ACTfdp_EstadosXDefecto 
	  //  //  //UD_v20170526_FdpServipag 
	  //  //  //UD_Handler 
	  //  //  //ACTwa_OnWebConnection
	  //  //  //ACTwa_IngresaPago
	
	  //  //TRACE
	  //  //  //If (Not(Is compiled mode))
	  //  //  //QUERY([ACT_Boletas];[ACT_Boletas]ID=3318)
	  //  //  //End if 
	
	  //  //  //READ ONLY([ACT_Transacciones])
	  //  //  //READ ONLY([ACT_CuentasCorrientes])
	  //  //  //READ ONLY([Alumnos])
	
	  //  //  //ACTbol_BuscaCargosCargaSet ("$Transacciones";[ACT_Boletas]ID)
	  //  //  //USE SET("$Transacciones")
	  //  //  //CLEAR SET("$Transacciones")
	
	  //  //  //KRL_RelateSelection (->[ACT_CuentasCorrientes]ID;->[ACT_Transacciones]ID_CuentaCorriente;"")
	  //  //  //KRL_RelateSelection (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno;"")
	
	  //  //  //vQR_Text1:=""
	  //  //  //While (Not(End selection([Alumnos])))
	  //  //  //vQR_Text1:=Choose(vQR_Text1="";"";vQR_Text1+", ")+[Alumnos]Apellidos_y_Nombres+", "+[Alumnos]Curso
	  //  //  //NEXT RECORD([Alumnos])
	  //  //  //End while 
	
	  //  //  //ALERT(vQR_Text1)
	  //  //If (False)
	  //  //TRACE
	
	  //  //$t_rutEmisor:=""
	  //  //$t_tipoDocumento:="PDF"
	  //  //$b_cedible3:=(r_obtieneCopiaCedible=1)
	  //  //$d_fechaE:=[ACT_Boletas]FechaEmision
	  //  //$t_tipo:=[ACT_Boletas]codigo_SII+":"+[ACT_Boletas]TipoDocumento
	  //  //$r_folio:=[ACT_Boletas]Numero
	  //  //$t_ruta:=ACTdteEmi_Generales ("ObtieneRUTADocumentos";->$t_rutEmisor;->$t_tipoDocumento;->$b_cedible3;->$d_fechaE;->$t_tipo;->$r_folio)
	
	  //  //  //20150710 RCH Si no se ha obtenido el PDF, se intenta obtener
	  //  //If (Test path name($t_ruta)#Is a document)
	  //  //If (ACTdte_EsEmisorColegium ([ACT_Boletas]ID_RazonSocial))
	  //  //If (USR_GetMethodAcces ("ACTdte_ObtienePDF"))  //tiene permiso para obtener PDF
	  //  //ACTdte_ObtienePDFDT ([ACT_Boletas]ID)
	  //  //End if 
	  //  //End if 
	  //  //End if 
	
	  //  //TRACE
	
	  //  //If (False)
	  //  //$elements:=""
	  //  //$itemCount:=ST_CountWords ($elements;1;";")
	  //  //TRACE
	  //  //SHOW ON DISK(Get 4D folder(4D Client database folder))
	
	  //  //ARRAY TEXT($at_array;0)
	  //  //ARRAY TEXT(atACT_GlosaImpTemp;0)
	
	
	
	  //  //$t_texto:="1;2;3;4;5"
	  //  //AT_Text2Array (->$at_array;$t_texto)
	  //  //$nombresCat:=AT_array2text (->$at_array)
	  //  //AT_AppendItems2TextArray (->atACT_GlosaImpTemp;$nombresCat)
	
	
	  //  //TRACE
	
	  //  //TRACE
	  //  //ARRAY LONGINT(aQR_Longint1;0)
	  //  //ARRAY LONGINT(aQR_Longint2;0)
	  //  //ARRAY LONGINT(aQR_Longint3;0)
	
	  //  //READ ONLY([Asignaturas])
	  //  //ALL RECORDS([Asignaturas])
	  //  //SELECTION TO ARRAY([Asignaturas]Profesor_Numero;aQR_Longint1)
	
	  //  //COPY ARRAY(aQR_Longint1;aQR_Longint2)
	  //  //AT_DistinctsArrayValues (->aQR_Longint2)
	  //  //SORT ARRAY(aQR_Longint2;>)
	  //  //For (vQR_Long1;1;Size of array(aQR_Longint2))
	  //  //APPEND TO ARRAY(aQR_Longint3;Count in array(aQR_Longint1;aQR_Longint2{vQR_Long1}))
	  //  //End for 
	  //  //SET TEXT TO PASTEBOARD(AT_array2text (->aQR_Longint2;"\r";"######"))
	  //  //ALERT("1")
	  //  //SET TEXT TO PASTEBOARD(AT_array2text (->aQR_Longint3;"\r";"######"))
	  //  //ALERT("2")
	
	  //  //TRACE
	  //  //EXE_Execute 
	
	
	  //  //C_LONGINT($i)
	  //  //C_REAL(vlSelAño)
	  //  //C_DATE($vd_fechaIni;$vd_fechaFin)
	  //  //vlSelAño:=2017
	
	  //  //ARRAY TEXT(aQR_Text1;0)
	  //  //APPEND TO ARRAY(aQR_Text1;"Ene")
	  //  //APPEND TO ARRAY(aQR_Text1;"Feb")
	  //  //APPEND TO ARRAY(aQR_Text1;"Mar")
	  //  //APPEND TO ARRAY(aQR_Text1;"Abr")
	  //  //APPEND TO ARRAY(aQR_Text1;"May")
	  //  //APPEND TO ARRAY(aQR_Text1;"Jun")
	  //  //APPEND TO ARRAY(aQR_Text1;"Jul")
	  //  //APPEND TO ARRAY(aQR_Text1;"Ago")
	  //  //APPEND TO ARRAY(aQR_Text1;"Sep")
	  //  //APPEND TO ARRAY(aQR_Text1;"Oct")
	  //  //APPEND TO ARRAY(aQR_Text1;"Nov")
	  //  //APPEND TO ARRAY(aQR_Text1;"Dic")
	
	  //  //For ($i;1;12)
	  //  //$vd_fechaIni:=DT_GetDateFromDayMonthYear (1;$i;vlSelAño)
	  //  //$vd_fechaFin:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($i;vlSelAño);$i;vlSelAño)
	  //  //ALERT(String($vd_fechaIni)+" - "+String($vd_fechaFin))
	  //  //End for 
	  //  //TRACE
	
	  //  //vl_therm:=IT_UThermometer (1;0;"Buscando información para el año "+String(vlSelAño)+". Un momento por favor")
	  //  //READ ONLY([ACT_Cargos])
	  //  //READ ONLY([ACT_Pagos])
	  //  //READ ONLY([ACT_Transacciones])
	  //  //C_LONGINT($i;$mes;$mes2)
	  //  //C_DATE($vd_fechaIni;$vd_fechaFin)
	  //  //C_TEXT(vText1;vText2;vText3;vText4)
	  //  //vText1:=""
	  //  //vText2:=""
	  //  //vText3:=""
	  //  //vText4:=""
	  //  //C_REAL(vReal1;vReal2;vReal3)
	  //  //vReal1:=0
	  //  //vReal2:=0
	  //  //vReal3:=0
	  //  //ARRAY TEXT(aText1;0)
	  //  //ARRAY TEXT(aText2;0)
	  //  //ARRAY TEXT(aText3;0)
	  //  //ARRAY REAL(aReal1;0)
	  //  //ARRAY REAL(aReal2;0)
	  //  //ARRAY REAL(aReal3;0)
	  //  //ARRAY REAL(aReal4;0)
	  //  //ARRAY REAL(aReal5;0)
	  //  //ARRAY LONGINT(aQR_Longint1;0)
	  //  //AT_Insert (0;12;->aText1)
	  //  //LIST TO ARRAY("XS_Meses";aText1)
	  //  //  //AT_Delete (1;2;->aText1)
	  //  //For ($i;1;12)
	  //  //IT_UThermometer (0;vl_therm;"Buscando información para el período "+String($i;"00")+String(vlSelAño)+". Un momento por favor")
	  //  //$vd_fechaIni:=DT_GetDateFromDayMonthYear (1;$i;vlSelAño)
	  //  //$vd_fechaFin:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($i;vlSelAño);$i;vlSelAño)
	  //  //QUERY([ACT_Cargos];[ACT_Cargos]FechaEmision>=$vd_fechaIni;*)
	  //  //QUERY([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision<=$vd_fechaFin)
	
	  //  //AT_Insert (0;1;->aReal2)  //total pagado
	  //  //aReal2{Size of array(aReal2)}:=Sum([ACT_Cargos]MontosPagadosMPago)
	
	  //  //AT_Insert (0;1;->aReal1)  //total a pagar
	  //  //aReal1{Size of array(aReal1)}:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Monto_Neto;->[ACT_Cargos]Monto_Neto;Current date(*))
	  //  //AT_Insert (0;1;->aReal3)  //saldo adeudado
	  //  //aReal3{Size of array(aReal3)}:=aReal1{Size of array(aReal1)}-aReal2{Size of array(aReal2)}
	  //  //AT_Insert (0;1;->aReal5)  //% de morosidad num
	  //  //If (aReal1{Size of array(aReal1)}>0)
	  //  //aReal5{Size of array(aReal5)}:=aReal3{Size of array(aReal3)}*100/aReal1{Size of array(aReal1)}
	  //  //Else 
	  //  //aReal5{Size of array(aReal5)}:=0
	  //  //End if 
	  //  //AT_Insert (0;1;->aText2)  //% de morosidad texto
	  //  //aText2{Size of array(aText2)}:=String(Round(aReal5{Size of array(aReal5)};2))+"%"
	  //  //AT_Insert (0;1;->aReal4)  //saldo acumulado
	  //  //aReal4{Size of array(aReal4)}:=AT_GetSumArray (->aReal3)
	  //  //AT_Insert (0;1;->aText3)  //
	  //  //aText3{Size of array(aText3)}:=String(Round(aReal4{Size of array(aReal4)}*100/AT_GetSumArray (->aReal1);2))+"%"
	  //  //End for 
	  //  //IT_UThermometer (-2;vl_therm)
	
	
	
	  //  //TRACE
	  //  //  //ARRAY LONGINT($al_idsApdos;0)
	
	  //  //  //READ ONLY([Personas])
	  //  //  //READ ONLY([Familia_RelacionesFamiliares])
	  //  //  //READ ONLY([Familia])
	
	  //  //  //ALL RECORDS([Personas])
	
	  //  //  //FIRST RECORD([Personas])
	
	  //  //  //While (Not(End selection([Personas])))
	  //  //  //QUERY([Familia_RelacionesFamiliares];[Familia_RelacionesFamiliares]ID_Persona=[Personas]No)
	  //  //  //KRL_RelateSelection (->[Familia]Numero;->[Familia_RelacionesFamiliares]ID_Familia;"")
	  //  //  //QUERY SELECTION([Familia];[Familia]Inactiva=False)
	  //  //  //If (Records in selection([Familia])>1)
	  //  //  //APPEND TO ARRAY($al_idsApdos;[Personas]No)
	  //  //  //End if 
	  //  //  //NEXT RECORD([Personas])
	  //  //  //End while 
	  //  //  //$t_text:=AT_array2text (->$al_idsApdos;"\n";"#########")
	  //  //  //SET TEXT TO PASTEBOARD($t_text)
	  //  //  //TRACE
	
	  //  //TRACE
	  //  //  //20170507 RCH
	  //  //  //Metodo de formulario actcfg_general
	  //  //  //formualrio generales. Se mueven objetos y se agrega preferencia
	  //  //  //ACTcfg_LeeBlob 
	  //  //  //ACTcfg_SaveConfig 
	  //  //  //ACTinit_CreateGenerationPrefs 
	  //  //  //UD_v20170507_PrefEmisionAC 
	  //  //  //UD_Handler 
	  //  //  //ACTcc_EmisionAvisos 
	
	  //  //  //ACTdesc_OpcionesGenerales 
	  //  //  //PREF_fGetObject 
	  //  //  //  //nuevo campo [xShell_Prefs]_objeto
	  //  //  //PREF_SetObject 
	  //  //  //formulario xxactitems]itemsEspeciales Página 3 y 4
	  //  //  //método de formulario xxactitems]itemsEspeciales
	  //  //  //formulario xxstr_constants]ACT_IngresoPagosCaja. Calcula descuento
	  //  //  //método de formulario xxstr_constants]ACT_IngresoPagosCaja
	  //  //  //formulario xxstr_constants]ACTpgs_documentar.Boton1 Calcula descuento
	  //  //  //método de formulario xxstr_constants]ACTpgs_documentar
	  //  //  //20170507 RCH
	
	
	
	
	
	  //  //$t_fecha:="2016-04-17"
	  //  //SET TEXT TO PASTEBOARD($t_fecha)
	  //  //$t_uuid:=Generate UUID
	  //  //SET TEXT TO PASTEBOARD($t_uuid)
	  //  //DASHwa_VerificaLlave ($t_fecha;$t_uuid;$t_llave)
	
	  //  //TRACE
	
	  //  //ACTint_OpcionesGenerales ("GuardaBlob")
	
	  //  //4D_ListaIDsTablasDisponibles 
	  //  //TRACE
	
	  //  //$t_principal:=JSON New 
	  //  //$r_idError:=-8
	  //  //$t_descripcion:="El servidor no está configurado como servidor oficial."
	  //  //$node:=JSON Append real ($t_principal;"error";$r_idError)
	  //  //$node:=JSON Append text ($t_principal;"mensaje";$t_descripcion)
	
	  //  //$json:=JSON Export to text ($t_principal;JSON_WITHOUT_WHITE_SPACE)
	  //  //JSON CLOSE ($t_principal)
	
	  //  //$json2:=BKPwa_GeneraRespuesta (-8)
	
	  //  //If ($json=$json2)
	
	  //  //Else 
	
	  //  //End if 
	  //  //TRACE
	
	  //  //UD_v20161017_ImportaMaterialDoc 
	  //  //  //hmBC_text2PictCode39 
	  //  //  //hmBC_text2PictPDF417
	
	  //  //C_LONGINT($l_id)
	  //  //C_TEXT($alias;$country;$langage)
	  //  //$l_id:=10
	  //  //$alias:="hola"
	  //  //$country:="cl"
	  //  //$langage:="es"
	
	  //  //READ ONLY([xShell_ExecCommands_Localized])
	
	  //  //ALL RECORDS([xShell_ExecCommands_Localized])
	  //  //QUERY([xShell_ExecCommands_Localized];[xShell_ExecCommands_Localized]ID_ExecCommand;=$l_id;*)
	  //  //QUERY([xShell_ExecCommands_Localized]; & ;[xShell_ExecCommands_Localized]Alias=$alias;*)
	  //  //QUERY([xShell_ExecCommands_Localized]; & ;[xShell_ExecCommands_Localized]Country_Code=$country;*)
	  //  //QUERY([xShell_ExecCommands_Localized]; & ;[xShell_ExecCommands_Localized]Language_Code=$langage)
	  //  //TRACE
	
	
	  //  //  //  //READ WRITE([ACT_Pagos])
	  //  //  //  //QUERY([ACT_Pagos];[ACT_Pagos]ID:=
	  //  //  //  //[ACT_Pagos]id_forma_de_pago:=-18
	  //  //  //  //SAVE RECORD([ACT_Pagos])
	  //  //  //  //KRL_UnloadReadOnly (->[ACT_Pagos])
	  //  //  //TRACE
	  //  //  //$d_fecha:=!2016-10-10!
	  //  //  //$json1:=ACTwp_GeneraJSONPagos ($d_fecha)
	  //  //  //SET TEXT TO PASTEBOARD($json1)
	  //  //  //$json2:=_0000_TestsRCH2 ($d_fecha)
	  //  //  //SET TEXT TO PASTEBOARD($json2)
	
	
	  //  //  //TRACE
	
	  //  //  //ACTpw_RetreivePagosBC 
	  //  //  //ACTpw_RevisaPagos 
	
	  //  //  //C_TEXT(t_ref;t_rbd;t_cc;$t_json)
	  //  //  //C_TEXT($t_referencia;$t_json;$err)
	  //  //  //C_LONGINT($vl_pID;$l_indice)
	  //  //  //C_TEXT($t_referencia;$t_avisos;$t_montos;$t_montototal;$t_idrelfamiliar;$t_fecha_pago;$t_valor)
	
	
	  //  //  //TRACE
	  //  //  //$t_referencia:="400701000001315064268"
	  //  //  //t_rbd:="1"
	  //  //  //t_cc:="mx"
	
	  //  //  //WEB SERVICE SET PARAMETER("rol";t_rbd)
	  //  //  //WEB SERVICE SET PARAMETER("codigopais";t_cc)
	  //  //  //WEB SERVICE SET PARAMETER("referencia";$t_referencia)
	
	  //  //  //$vl_pID:=IT_UThermometer (1;0;__ ("Interrogando SchoolNet...");-1)
	
	  //  //  //$err:=SN3_CallWebService ("sn3ws_PagoOnline_proceso.consulta_referencia")
	
	  //  //  //IT_UThermometer (-2;$vl_pID)
	  //  //  //If ($err="")
	  //  //  //WEB SERVICE GET RESULT($t_json;"resultado";*)
	
	  //  //  //If (ok=1)
	
	  //  //  //C_OBJECT($ob)
	  //  //  //$ob:=JSON Parse($t_json)
	  //  //  //$t_referencia:=OB Get($ob;"referencia")
	
	  //  //  //$t_avisos:=OB Get($ob;"avisos")
	
	  //  //  //$t_montos:=OB Get($ob;"montos")
	  //  //  //$t_montos:=Replace string($t_montos;".";<>tXS_RS_DecimalSeparator)
	  //  //  //$t_montos:=Replace string($t_montos;",";<>tXS_RS_DecimalSeparator)
	
	  //  //  //$t_montototal:=OB Get($ob;"montototal")
	  //  //  //$t_montototal:=Replace string($t_montototal;".";<>tXS_RS_DecimalSeparator)
	  //  //  //$t_montototal:=Replace string($t_montototal;",";<>tXS_RS_DecimalSeparator)
	
	  //  //  //$t_idrelfamiliar:=OB Get($ob;"idrelfamiliar")
	
	  //  //  //$t_fecha_pago:=OB Get($ob;"fecha_pago")
	  //  //  //$t_fecha_pago:=Substring($t_fecha_pago;1;10)
	  //  //  //$d:=DT_GetDateFromDayMonthYear (Num(Substring($t_fecha_pago;9;2));Num(Substring($t_fecha_pago;6;2));Num(Substring($t_fecha_pago;1;4)))
	  //  //  //If ($t_json#"false")
	  //  //  //$t_ref:=JSON Parse text ($t_json)
	  //  //  //  //
	  //  //  //ARRAY TEXT(aQR_Text18;0)
	  //  //  //ARRAY TEXT(aQR_Text14;0)
	  //  //  //ARRAY LONGINT(aQR_Longint5;0)
	
	  //  //  //JSON GET CHILD NODES ($t_ref;aQR_Text18;aQR_Longint5;aQR_Text14)
	  //  //  //For ($l_indice;1;Size of array(aQR_Text14))
	  //  //  //$t_valor:=JSON Get text (aQR_Text18{$l_indice})
	  //  //  //Case of 
	  //  //  //: (aQR_Text14{$l_indice}="referencia")
	  //  //  //$t_referencia:=$t_valor
	  //  //  //: (aQR_Text14{$l_indice}="avisos")
	  //  //  //$t_avisos:=$t_valor
	  //  //  //: (aQR_Text14{$l_indice}="montos")
	  //  //  //$t_montos:=$t_valor
	  //  //  //$t_montos:=Replace string($t_montos;".";<>tXS_RS_DecimalSeparator)
	  //  //  //$t_montos:=Replace string($t_montos;",";<>tXS_RS_DecimalSeparator)
	  //  //  //: (aQR_Text14{$l_indice}="montototal")
	  //  //  //$t_montototal:=$t_valor
	  //  //  //$t_montototal:=Replace string($t_montototal;".";<>tXS_RS_DecimalSeparator)
	  //  //  //$t_montototal:=Replace string($t_montototal;",";<>tXS_RS_DecimalSeparator)
	  //  //  //: (aQR_Text14{$l_indice}="idrelfamiliar")
	  //  //  //$t_idrelfamiliar:=$t_valor
	  //  //  //: (aQR_Text14{$l_indice}="fecha_pago")
	  //  //  //$t_fecha_pago:=Substring($t_valor;1;10)
	  //  //  //End case 
	  //  //  //End for 
	  //  //  //JSON CLOSE ($t_ref)
	  //  //  //End if 
	  //  //  //End if 
	  //  //  //End if 
	
	
	
	  //  //  //C_LONGINT($l_time)
	
	  //  //  //C_TEXT($t_rol;$t_country)
	  //  //  //$t_rol:="120863"
	  //  //  //$t_country:="cl"
	
	  //  //  //$l_time:=IT_StartTimer 
	  //  //  //C_OBJECT($ob)
	  //  //  //OB SET($ob;"rolBD";$t_rol)
	  //  //  //OB SET($ob;"codigoPais";$t_country)
	  //  //  //$t_jsonDatosColegio2:=JSON Stringify($ob)
	  //  //  //IT_StopTimer ($l_time)
	
	  //  //  //$l_contador:=0
	  //  //  //While ($y#200)
	  //  //  //$y:=HTTP Request(HTTP POST method;$t_urlIntranet;$t_jsonDatosColegio;$t_DatosConexion;$at_httpHeaderNames;$at_httpHeaderValues)
	  //  //  //$l_contador:=$l_contador+1
	  //  //  //If ($l_contador>100)
	  //  //  //TRACE
	  //  //  //End if 
	  //  //  //End while 
	
	  //  //  //If ($y=200)
	  //  //  //  // extraigo el dato desde el Json.
	  //  //  //$t_ref:=JSON Parse text ($t_DatosConexion)
	  //  //  //JSON GET CHILD NODES ($t_ref;$nodes;$types;$names)
	
	  //  //  //$t_url:=""
	  //  //  //$l_puerto:=0
	  //  //  //$t_direccionIP:=""
	
	  //  //  //For ($i;1;Size of array($nodes))
	  //  //  //$t_node:=$nodes{$i}
	  //  //  //$t_name:=$names{$i}
	  //  //  //Case of 
	  //  //  //: ($t_name="datos")
	  //  //  //$stwa:=JSON Get text ($t_node)
	  //  //  //$stwa:=Replace string(Replace string($stwa;"[";"");"]";"")
	  //  //  //$root:=JSON Parse text ($stwa)
	  //  //  //JSON_ExtraeValor ($root;"direccionstwa2";->$t_url)
	  //  //  //JSON_ExtraeValor ($root;"puerto";->$l_puerto)
	  //  //  //JSON_ExtraeValor ($root;"direccionip";->$t_direccionIP)
	  //  //  //End case 
	  //  //  //End for 
	  //  //  //JSON CLOSE ($t_ref)
	
	  //  //  //C_OBJECT($ob)
	  //  //  //$ob:=JSON Parse($t_DatosConexion)
	  //  //  //$t_dato:=OB Get(OB Get($ob;"datos");"direccionstwa2")
	
	
	  //  //  //End if 
	
	  //  //  //TRACE
	  //  //  //C_TEXT($t_codigo;$t_paraPortapapeles)
	  //  //  //For ($l_indice;1;Size of array(<>aNacion))
	  //  //  //$t_codigo:=ACTdte_ObtieneCodigoPaisSII (<>aNacion{$l_indice})
	  //  //  //$t_paraPortapapeles:=$t_paraPortapapeles+<>aNacion{$l_indice}+"\t"+$t_codigo+"\r"
	  //  //  //End for 
	  //  //  //SET TEXT TO PASTEBOARD($t_paraPortapapeles)
	
	  //  //  //  //Descuentos
	  //  //  //  //[ACT_CFG_DctosIndividuales]Aplica_a_total
	  //  //  //  //[ACT_Cargos]Detalle_CalculoDescuento
	
	  //  //  //  //ACTcc_CreaRecDctoMontoItem 
	  //  //  //  //ACTcc_DuplicaCargoDcto 
	
	  //  //  //  //ACTcar_CalculaDescuentos 
	  //  //  //  //ACTcfg_OpcionesDescuentos 
	  //  //  //  //ACTdctos_OnRecordLoad
	
	  //  //  //  //input ACT.maximo dcto
	  //  //  //  //Descuentos
	  //  //  //  //METHOD Get attribute
	  //  //  //  //FORM GET OBJECTS
	  //  //  //  //EXE_Execute
	  //  //  //  //ACTabc_CreaDocumento 
	  //  //  //  //ACTabc_CreaRutaCarpetas 
	  //  //  //  //PROCESS 4D TAGS
	
	  //  //  //  //CD_THERMOMETREXSEC (1;0;"prueba")
	  //  //  //  //CD_THERMOMETREXSEC (0;25;"test")
	  //  //  //  //TRACE
	  //  //  //  //CD_THERMOMETREXSEC (0;50;"test")
	  //  //  //  //TRACE
	  //  //  //  //CD_THERMOMETREXSEC (0;75;"test")
	  //  //  //  //TRACE
	  //  //  //  //CD_THERMOMETREXSEC (-1)
	
	  //  //  //  //$l_proc:=IT_Progress (1)
	  //  //  //  //IT_Progress (0;$l_proc;2/10)
	  //  //  //  //IT_Progress (0;$l_proc;5/10)
	  //  //  //  //IT_Progress (0;$l_proc;7/10)
	  //  //  //  //IT_Progress (-1;$l_proc)
	
	  //  //  //TRACE
	
	  //  //  //SHOW ON DISK(Get 4D folder(1))
	
	  //  //  //C_OBJECT($t_ref)
	  //  //  //$year:=2017
	  //  //  //$json:=DASH_GeneraJSON ("dashboard";->$year)
	  //  //  //$t_ref:=OB_JsonToObject ($json)
	  //  //  //$t_text:=JSON Stringify($t_ref;*)
	
	  //  //  //SET TEXT TO PASTEBOARD($t_text)
	
	  //  //  //TRACE
	
	
	  //  //  //TRACE
	
	
	  //  //  //C_POINTER($vyQRY_TablePointer;vyQRY_TablePointer)
	  //  //  //C_POINTER(yBWR_currentTable;$yBWR_currentTable)
	  //  //  //C_TEXT(vsBWR_CurrentModule;$vsBWR_CurrentModule)
	
	  //  //  //C_LONGINT($l_matrixID)
	  //  //  //$l_matrixID:=[ACT_Matrices]ID
	
	
	  //  //  //$vyQRY_TablePointer:=vyQRY_TablePointer
	  //  //  //vyQRY_TablePointer:=->[ACT_CuentasCorrientes]
	  //  //  //$vsBWR_CurrentModule:=vsBWR_CurrentModule
	  //  //  //vsBWR_CurrentModule:="AccountTrack"
	  //  //  //$yBWR_currentTable:=yBWR_currentTable
	  //  //  //yBWR_currentTable:=->[ACT_CuentasCorrientes]
	
	  //  //  //WDW_OpenFormWindow (->[ACT_MatricesAsignacionAut];"Reglas";-1;4;"Reglas")
	  //  //  //DIALOG([ACT_MatricesAsignacionAut];"Reglas")
	  //  //  //CLOSE WINDOW
	
	  //  //  //  //Se restauran valores de conf.
	  //  //  //vyQRY_TablePointer:=$vyQRY_TablePointer
	  //  //  //vsBWR_CurrentModule:=$vsBWR_CurrentModule
	  //  //  //yBWR_currentTable:=$yBWR_currentTable
	
	  //  //  //If ($l_matrixID>0)
	  //  //  //ACTcfg_loadMatrixItems ($l_matrixID)
	  //  //  //End if 
	
	  //  //  //  //TRACE
	  //  //  //  //GET RELATION PROPERTIES(2;1;$tablaUno;$campUno;$discriminante;$autoUno;$autoMuchos)
	  //  //  //  //GET FIELD PROPERTIES
	
	  //  //  //  //GET FIELD RELATION
	
	  //  //  //  //ARRAY LONGINT($al_tabla;0)
	  //  //  //  //ARRAY LONGINT($al_campo;0)
	  //  //  //  //ARRAY LONGINT($al_tablaRel;0)
	  //  //  //  //ARRAY LONGINT($al_campoRel;0)
	  //  //  //  //ARRAY LONGINT($al_atributo;0)
	  //  //  //  //ARRAY TEXT($at_lista;0)
	
	  //  //  //  //For ($i;1;Get last table number)
	  //  //  //  //If (Is table number valid($i))
	  //  //  //  //For ($j;1;Get last field number($i))
	  //  //  //  //AP Get field infos ($i;$j;$tablaRel;$campoRel;$atributo;$lista;$resultado)
	
	  //  //  //  //$y_puntero:=Field($i;$j)
	
	  //  //  //  //If (($tablaRel>0) | ($campoRel>0))
	
	  //  //  //  //APPEND TO ARRAY($al_tabla;$i)
	  //  //  //  //APPEND TO ARRAY($al_campo;$j)
	
	  //  //  //  //APPEND TO ARRAY($al_tablaRel;$tablaRel)
	  //  //  //  //APPEND TO ARRAY($al_campoRel;$campoRel)
	  //  //  //  //APPEND TO ARRAY($al_atributo;$atributo)
	  //  //  //  //APPEND TO ARRAY($at_lista;$lista)
	  //  //  //  //Else 
	
	  //  //  //  //End if 
	  //  //  //  //End for 
	  //  //  //  //End if 
	  //  //  //  //End for 
	
	  //  //  //  //$t_texto:=AT_Arrays2Text (<>cr;<>tb;->$al_tabla;->$al_campo;->$al_tablaRel;->$al_campoRel;->$al_atributo;->$at_lista)
	  //  //  //  //SET TEXT TO PASTEBOARD($t_texto)
	
	  //  //  //  //ARRAY LONGINT($aTransaccionesAfectas;0)
	  //  //  //  //ARRAY TEXT($at_transaccionesAfectas;0)
	
	  //  //  //  //APPEND TO ARRAY($aTransaccionesAfectas;12)
	  //  //  //  //APPEND TO ARRAY($aTransaccionesAfectas;123)
	  //  //  //  //APPEND TO ARRAY($aTransaccionesAfectas;12445)
	  //  //  //  //APPEND TO ARRAY($aTransaccionesAfectas;1266789)
	
	  //  //  //  //APPEND TO ARRAY($at_transaccionesAfectas;AT_array2text (->$aTransaccionesAfectas;";";"#########"))
	
	  //  //  //  //ARRAY LONGINT($aTransaccionesAfectas2;0)
	
	  //  //  //  //AT_Text2Array (->$aTransaccionesAfectas2;$at_transaccionesAfectas{1})
	
	
	  //  //  //  //If (Application type=4D Remote mode)
	  //  //  //  //C_LONGINT($l_pid)
	  //  //  //  //$l_pid:=Execute on server(Current method name;64000)
	  //  //  //  //Else 
	  //  //  //  //TRACE
	  //  //  //  //SHOW ON DISK(Get 4D folder(1))
	  //  //  //  //If (False)
	  //  //  //  //TRACE
	  //  //  //  //$b_error:=GIT_PullSTWA (->$t_respuestaPull)  //20160822 RCH
	  //  //  //  //If (Not($b_error))
	  //  //  //  //CONFIRM("Pull de cambios STWA. Respuesta: "+<>cr+<>cr+$t_respuestaPull;"Continuar";"Cancelar")
	  //  //  //  //If (ok=1)
	  //  //  //  //TRACE
	  //  //  //  //Else 
	  //  //  //  //TRACE
	  //  //  //  //End if 
	  //  //  //  //Else 
	  //  //  //  //ALERT("Error al hacer pull desde bitbucket. "+<>cr+"Error: "+<>cr+ST_Qte ($t_respuestaPull)+<>cr+"La generación de versiones fue cancelada.")
	  //  //  //  //End if 
	  //  //  //  //End if 
	  //  //  //  //End if 
	
	  //  //  //  //If (False)
	  //  //  //  //TRACE
	  //  //  //  //PREF_SetBlob (0;"ACT_CONF_FECHA_CALC_INTERESES";$xBlob)
	  //  //  //  //READ WRITE([xShell_Prefs])
	  //  //  //  //QUERY([xShell_Prefs];[xShell_Prefs]User=0;*)
	  //  //  //  //QUERY([xShell_Prefs]; & ;[xShell_Prefs]Reference="ACT_CONF_FECHA_CALC_INTERESES")
	  //  //  //  //DELETE RECORD([xShell_Prefs])
	  //  //  //  //KRL_UnloadReadOnly (->[xShell_Prefs])
	
	  //  //  //  //ACTint_OpcionesGenerales ("CreaPreferenciaXDefecto")
	
	
	  //  //  //  //$t_ruta:=Get 4D folder(HTML Root folder)
	
	  //  //  //  //  //READ ONLY([ACT_CuentasCorrientes])
	  //  //  //  //  //READ ONLY([ACT_Terceros])
	  //  //  //  //  //READ ONLY([ACT_Terceros_Pactado])
	
	  //  //  //  //  //QUERY([ACT_CuentasCorrientes];[ACT_CuentasCorrientes]ID_Apoderado=8230)
	  //  //  //  //  //  //KRL_RelateSelection (->[ACT_Terceros_Pactado]Id_CuentaCorriente;->[ACT_CuentasCorrientes]ID;"")
	  //  //  //  //  //KRL_RelateSelection (->[ACT_Terceros]Id;->[ACT_Terceros_Pactado]Id_Tercero;"")
	  //  //  //  //  //  //READ ONLY([ACT_Terceros])
	  //  //  //  //  //  //QUERY([ACT_Terceros];[ACT_Terceros]Id=0)
	  //  //  //  //  //ARRAY LONGINT($al_idTerceros;0)
	  //  //  //  //  //LONGINT ARRAY FROM SELECTION([ACT_Terceros];$al_idTerceros;"")
	
	  //  //  //  //If (Application type=4D Remote mode)
	  //  //  //  //C_LONGINT($l_pid)
	  //  //  //  //$l_pid:=Execute on server(Current method name;64000)
	  //  //  //  //Else 
	  //  //  //  //TRACE
	  //  //  //  //SHOW ON DISK(Get 4D folder(1))
	  //  //  //  //If (False)
	  //  //  //  //TRACE
	  //  //  //  //$b_error:=GIT_PullSTWA (->$t_respuestaPull)  //20160822 RCH
	  //  //  //  //If (Not($b_error))
	  //  //  //  //CONFIRM("Pull de cambios STWA. Respuesta: "+<>cr+<>cr+$t_respuestaPull;"Continuar";"Cancelar")
	  //  //  //  //If (ok=1)
	  //  //  //  //TRACE
	  //  //  //  //Else 
	  //  //  //  //TRACE
	  //  //  //  //End if 
	  //  //  //  //Else 
	  //  //  //  //ALERT("Error al hacer pull desde bitbucket. "+<>cr+"Error: "+<>cr+ST_Qte ($t_respuestaPull)+<>cr+"La generación de versiones fue cancelada.")
	  //  //  //  //End if 
	  //  //  //  //End if 
	  //  //  //  //End if 
	
	
	
	  //  //  //  //If (False)
	  //  //  //  //SHOW ON DISK(Get 4D folder(3))
	
	  //  //  //  //If (Application type=4D Remote mode)
	  //  //  //  //$l_pid:=Execute on server(Current method name;1024*64)
	  //  //  //  //TRACE
	  //  //  //  //Else 
	
	  //  //  //  //$l_id2:=IT_UThermometer (1;0;"Prueba IT_UThermometer...")
	
	  //  //  //  //$l_id:=IT_Progress (1;0;0;"Prueba it IT_Progress...")
	
	  //  //  //  //CD_THERMOMETREXSEC (1;0;"test CD_THERMOMETREXSEC")
	  //  //  //  //$l_contador:=1
	  //  //  //  //While ($l_contador<=10)
	  //  //  //  //DELAY PROCESS(Current process;60)
	  //  //  //  //$l_contador:=$l_contador+1
	
	  //  //  //  //CD_THERMOMETREXSEC (0;$l_contador*100/10)
	  //  //  //  //IT_Progress (0;$l_id;$l_contador/10)
	  //  //  //  //End while 
	  //  //  //  //CD_THERMOMETREXSEC (-1)
	  //  //  //  //IT_Progress (-1;$l_id)
	
	
	  //  //  //  //IT_UThermometer (-2;$l_id2)
	  //  //  //  //End if 
	  //  //  //  //End if 
	
	  //  //  //  //  //C_BOOLEAN($b_ambienteProd)
	  //  //  //  //  //C_TEXT($t_req1;$t_req2)
	  //  //  //  //  //$b_ambienteProd:=(Num(PREF_fGet (0;"ACT_AMBIENTE_CERTIFICACION_SII";"1"))=0)
	
	
	  //  //  //  //  //  //$b_ambienteProduccion:=False
	  //  //  //  //  //  //$b_ambienteProduccion:=True
	  //  //  //  //  //$t_ref:=JSON New 
	  //  //  //  //  //$t_r:=JSON Append text ($t_ref;"codpais";<>gCountryCode)
	  //  //  //  //  //$t_r:=JSON Append text ($t_ref;"rolbd";<>gRolBD)
	  //  //  //  //  //$t_r:=JSON Append text ($t_ref;"produccion";String(Num($b_ambienteProd)))
	  //  //  //  //  //$t_req1:=JSON Export to text ($t_ref;JSON_WITHOUT_WHITE_SPACE)
	  //  //  //  //  //JSON CLOSE ($t_ref)
	
	  //  //  //  //  //C_OBJECT($ob_json)
	  //  //  //  //  //OB SET($ob_json;"codpais";<>gCountryCode;"rolbd";<>gRolBD;"produccion";String(Num($b_ambienteProd)))
	  //  //  //  //  //$t_req2:=JSON Stringify($ob_json)
	
	  //  //  //  //  //If ($t_req1=$t_req2)
	  //  //  //  //  //alert("ok")
	  //  //  //  //  //Else 
	  //  //  //  //  //alert("no ok")
	  //  //  //  //  //end if
	
	  //  //  //  //End if 
	  //  //End if 
	  //  //End if 
	  //End if 
End if 