//%attributes = {}
  // MÉTODO: dhBWR_BuildCommandsPopup
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 03/04/12, 11:56:28
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // dhBWR_BuildCommandsPopup()
  // ----------------------------------------------------
ARRAY TEXT:C222(atBWR_CommandsPopup;0)
ARRAY TEXT:C222(atBWR_MethodsPopup;0)
ARRAY TEXT:C222($at_menuItems;0)
ARRAY TEXT:C222($at_methodsNames;0)




  // CODIGO PRINCIPAL
Case of 
	: (<>vsXS_CurrentModule="SchoolTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Alumnos:2]))
				If (<>vtXS_CountryCode="cl")
					APPEND TO ARRAY:C911($at_menuItems;"(-")
					APPEND TO ARRAY:C911($at_menuItems;__ ("Verificar Promedios Finales"))
					APPEND TO ARRAY:C911($at_menuItems;__ ("Evaluar Situación Final"))
					APPEND TO ARRAY:C911($at_menuItems;"(-")
					APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Registros Listados a CommTrack"))
					
					APPEND TO ARRAY:C911($at_methodsNames;"-")
					APPEND TO ARRAY:C911($at_methodsNames;"AL_VerifyPromediosActas")
					APPEND TO ARRAY:C911($at_methodsNames;"AL_RecalcFinalSituation")
					APPEND TO ARRAY:C911($at_methodsNames;"-")
					APPEND TO ARRAY:C911($at_methodsNames;"CMT_SendSelRecords")
				Else 
					APPEND TO ARRAY:C911($at_menuItems;"(-")
					APPEND TO ARRAY:C911($at_menuItems;__ ("Evaluar Situación Final"))
					APPEND TO ARRAY:C911($at_menuItems;"(-")
					APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Registros Listados a CommTrack"))
					
					APPEND TO ARRAY:C911($at_methodsNames;"-")
					APPEND TO ARRAY:C911($at_methodsNames;"AL_RecalcFinalSituation")
					APPEND TO ARRAY:C911($at_methodsNames;"-")
					APPEND TO ARRAY:C911($at_methodsNames;"CMT_SendSelRecords")
				End if 
				
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Asignaturas:18]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Aplicar Estilo de Evaluación"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Recalcular Promedios"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Usar o Quitar Evaluaciones Especiales"))  //Mono Ticket 172577
				APPEND TO ARRAY:C911($at_menuItems;__ ("Bloquear Propiedades de Evaluación"))  // Ticket Nº 175179
				APPEND TO ARRAY:C911($at_menuItems;__ ("Marcar o desmarcar opción:"+ST_Qte ("No visible en SchoolTrack WebAccess")))  //ASM 198108
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"AS_ReemplazaEstiloEvaluacion")
				APPEND TO ARRAY:C911($at_methodsNames;"EV2_RecalculoAsignaturasEnBWR")
				APPEND TO ARRAY:C911($at_methodsNames;"AS_BwrOpcEvaluacionEspecial")  //Mono Ticket 172577
				APPEND TO ARRAY:C911($at_methodsNames;"AS_BloqueaPropDeEvalAsignBWR")  // Ticket Nº 175179
				APPEND TO ARRAY:C911($at_methodsNames;"AS_ConfAsignaturaNoVisibleBWR")  //ASM 198108
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Cursos:3]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Verificar Promedios Finales"))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"CU_VerifyPromedioActas")
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				APPEND TO ARRAY:C911($at_menuItems;"-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Registros Listados a CommTrack"))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"CMT_SendSelRecords")
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Profesores:4]))
				APPEND TO ARRAY:C911($at_menuItems;"-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Registros Listados a CommTrack"))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"CMT_SendSelRecords")
		End case 
		
		
		
		
		
	: (<>vsXS_CurrentModule="AccountTrack")
		Case of 
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_CuentasCorrientes:175]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Recalcular Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Inactivar Cuentas Corrientes"))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Registros Listados a CommTrack"))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTcc_RecalcSelCuentas")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_MassiveCCInactivation")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"CMT_SendSelRecords")
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[Personas:7]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Calcular Número de Cargas"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Recalcular Saldos"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Cambiar Tipo de Documento Tributario"))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Cartas de Cobranza por Correo"))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Registros Listados a CommTrack"))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTpp_CalcCargasSelApdos")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_RecalculaSaldoApdo")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_CambiarTipoDctoTrib")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"WIZ_ACT_EnvioCartasCobranza")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"CMT_SendSelRecords")
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Terceros:138]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Recalcular Saldos"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Cambiar Tipo de Documento Tributario"))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_RecalcularSaldoTercero")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_CambiarTipoDctoTrib")
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagares:184]))
				  //20120528 RCH Se agrega cambio estado...
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Anular Pagarés"))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Cambiar Estado..."))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTpagares_AnularPagares")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTpgs_CambioEstado")
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Actualizar Intereses"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Recalcular Avisos Seleccionados"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Fijar Montos en Moneda Variable"))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Condonar Deuda"))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Generar Archivos Bancarios"))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Generar Pagarés"))
				If (<>gCountryCode="mx")
					APPEND TO ARRAY:C911($at_menuItems;"(-")
					APPEND TO ARRAY:C911($at_menuItems;__ ("Consultar Referencias"))
				End if 
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_RecalcConIntereses")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_RecalcularAvisos")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_FijaMontosMonedaVariable")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_CondonaDeuda")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_ArchBancarios")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_GenerarPagaresDesdeAC")
				If (<>gCountryCode="mx")
					APPEND TO ARRAY:C911($at_methodsNames;"(-")
					APPEND TO ARRAY:C911($at_methodsNames;"ACT_OpcionesReferenciasMX")
				End if 
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Pagos:172]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Anular Pagos"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Cambiar estado de pagos..."))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Utilizar Disponible"))
				APPEND TO ARRAY:C911($at_menuItems;__ ("Ajustar Disponible"))
				If (<>gCountryCode="mx")
					APPEND TO ARRAY:C911($at_menuItems;"(-")
					APPEND TO ARRAY:C911($at_menuItems;__ ("Procesar Pagos Pendientes"))
				End if 
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTpgs_AnularPagos")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTpgs_CambioEstado")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTmnu_UtilizarDisponiblePago")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTpgs_AjustaSaldo")
				If (<>gCountryCode="mx")
					APPEND TO ARRAY:C911($at_methodsNames;"(-")
					APPEND TO ARRAY:C911($at_methodsNames;__ ("ACTpw_RevisaPagos"))
				End if 
				
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Boletas:181]))
				APPEND TO ARRAY:C911($at_menuItems;"-")
				APPEND TO ARRAY:C911($at_menuItems;"(<B<UProveedor")
				  //opcion solo para mx
				  //20120113 RCH Opcion para cl
				Case of 
					: (<>gCountryCode="mx")
						APPEND TO ARRAY:C911($at_menuItems;__ ("Generar CFDI"))
						
					: (<>gCountryCode="cl")
						APPEND TO ARRAY:C911($at_menuItems;__ ("Generar DTE"))
					Else 
						APPEND TO ARRAY:C911($at_menuItems;"("+__ ("Generar documento electrónico"))
				End case 
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTcfdi_Generacion")
				
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;"(<B<UCOLEGIUM")
				Case of 
					: (<>gCountryCode="cl")
						APPEND TO ARRAY:C911($at_menuItems;__ ("Marcar Documentos para Generación DTE"))
						APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Ahora Documentos para Generación DTE"))
						If (USR_GetUserID <0)  //20160628 RCH Por ahora se deja solo para super user
							APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar Ahora Documentos al SII"))
						End if 
						APPEND TO ARRAY:C911($at_menuItems;__ ("Obtener PDFs."))
						APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar DTEs por mail"))
						APPEND TO ARRAY:C911($at_menuItems;"-")
						APPEND TO ARRAY:C911($at_menuItems;__ ("Cambiar Fecha de Emisión de Documentos Masivamente"))
					: (<>gCountryCode="ar")
						APPEND TO ARRAY:C911($at_menuItems;__ ("Obtener Código de Autorización Electrónico"))
						APPEND TO ARRAY:C911($at_menuItems;__ ("Consultar Último Comprobante Emitido"))
						APPEND TO ARRAY:C911($at_menuItems;__ ("Actualizar Número de Comprobante"))  //20170914 RCH
						APPEND TO ARRAY:C911($at_menuItems;"-")
						APPEND TO ARRAY:C911($at_menuItems;__ ("Cambiar Fecha de Emisión de Documentos Masivamente"))
						APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar DTEs por mail"))
					: (<>gCountryCode="uy")  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, añado caso para habilitación del POP-UP de envío de documentos tributarios
						APPEND TO ARRAY:C911($at_menuItems;__ ("Enviar DTEs por mail"))
				End case 
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				Case of 
					: (<>gCountryCode="cl")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_MarcaDocumentosMasivos")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_EnviaDocumentosMasivos")
						If (USR_GetUserID <0)  //20160628 RCH Por ahora se deja solo para super user
							APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_EnviaDocumentosSII")
						End if 
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_ObtienePDFsDesdeBrowser")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_EnviarPDFsPorMail")
						APPEND TO ARRAY:C911($at_methodsNames;"-")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_Cambia_FE_DT_Masivo")
					: (<>gCountryCode="ar")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTfear_ObtenerCodigoAutElect")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTfear_ConsultaUltimoEmitido")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTfear_ActualizaCAE")  //20170914 RCH
						APPEND TO ARRAY:C911($at_methodsNames;"-")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_Cambia_FE_DT_Masivo")
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_EnviarPDFsPorMail")
					: (<>gCountryCode="uy")  // Modificado por: Saúl Ponce (05-04-2017) Ticket 168412, añado caso para habilitación del POP-UP de envío de documentos tributarios
						APPEND TO ARRAY:C911($at_methodsNames;"ACTdte_EnviarPDFsPorMail")
				End case 
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Cambiar Estado..."))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTpgs_CambioEstado")
				
			: (Table:C252(yBWR_CurrentTable)=Table:C252(->[ACT_Documentos_de_Pago:176]))
				APPEND TO ARRAY:C911($at_menuItems;"(-")
				APPEND TO ARRAY:C911($at_menuItems;__ ("Anular depositos"))
				
				APPEND TO ARRAY:C911($at_methodsNames;"-")
				APPEND TO ARRAY:C911($at_methodsNames;"ACTdd_AnularDeposito")
				
		End case 
		
		
End case 

COPY ARRAY:C226($at_menuItems;atBWR_CommandsPopup)
COPY ARRAY:C226($at_methodsNames;atBWR_MethodsPopup)
If (Size of array:C274(atBWR_CommandsPopup)>0)
	AT_Delete (1;1;->atBWR_CommandsPopup;->atBWR_MethodsPopup)
End if 
PLT_SetPopUpState 