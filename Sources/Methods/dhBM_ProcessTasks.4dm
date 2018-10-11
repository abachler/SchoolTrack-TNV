//%attributes = {}
  // MÉTODO: dhBM_ProcessTasks
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 26/12/11, 20:23:32
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // dhBM_ProcessTasks()
  // ----------------------------------------------------
C_BOOLEAN:C305($0)

C_BOOLEAN:C305($b_taskExecuted)
C_POINTER:C301($nilPointer)

If (False:C215)
	C_BOOLEAN:C305(dhBM_ProcessTasks ;$0)
End if 




  // CODIGO PRINCIPAL
Case of 
	: ([xShell_BatchRequests:48]Action:1="EV2_ResultadosAsignatura")
		$b_taskExecuted:=BM_ResultadosAsignatura (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Cuenta Inasistencias")
		$b_taskExecuted:=BM_CalculaPorcentajeAsistencia (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Totaliza Horas Inasistencia")
		$b_taskExecuted:=BM_TotalizaHorasInasistencia (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Cuenta horas de clase")
		$b_taskExecuted:=BM_CuentaHorasDeClase (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Cuenta atrasos")
		$b_taskExecuted:=BM_CuentaAtrasos (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Cuenta Anotaciones")
		$b_taskExecuted:=BM_CuentaAnotaciones (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Cuenta castigos")
		$b_taskExecuted:=BM_CuentaCastigos (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Cuenta suspensiones")
		$b_taskExecuted:=BM_CuentaSuspensiones (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Justifica Inasistencias")
		$b_taskExecuted:=BM_JustificaInasistencias (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="CalculaPromediosGenerales")
		$b_taskExecuted:=BM_CalculaPromediosAlumnos (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Recalcular situación")
		$b_taskExecuted:=BM_CalculaSituacionFinalAlumnos (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_Calcula_Montos_Ejercicio")
		$b_taskExecuted:=ACTcc_CalculaMontos (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_DepositaCheques")
		$b_taskExecuted:=ACTdc_DepositaCheque ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_ProrrogaCheques")
		$b_taskExecuted:=ACTdc_ProrrogaCheques ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_ProtestaCheques")
		$b_taskExecuted:=ACTdd_ProtestaCheques ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_ReemplazaCheques")
		$b_taskExecuted:=ACTdc_ReemplazarCheques ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_CambiaUCheques")
		$b_taskExecuted:=ACTdc_CambiaUCheques ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_BorrarCargo")
		$b_taskExecuted:=ACTcc_BorrarCargo ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_BorrarTransaccion")
		$b_taskExecuted:=ACTcc_BorrarTransaccion ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_BorrarDocdeCargo")
		$b_taskExecuted:=ACTcc_BorrarDocdeCargo ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_BorrarDescto")
		$b_taskExecuted:=ACTcc_BorrarDescto ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_AnulaDocs")
		$b_taskExecuted:=ACTbol_AnulaDocumentos ([xShell_BatchRequests:48]Msg:2)
		
		  //: ([xShell_BatchRequests]Action="EVS_RecalculaPromediosAsignaturas")
		  //$b_taskExecuted:=EVS_RecalAsignaturas ([xShell_BatchRequests]Parameters)
		
	: ([xShell_BatchRequests:48]Action:1="Recalcular Promedios Curso")
		$b_taskExecuted:=BM_CalculaPromediosCurso (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="Emitir Avisos de Cobranza")
		$b_taskExecuted:=BM_EmitirAvisos (Record number:C243([xShell_BatchRequests:48]))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_PrepagaAviso")
		$b_taskExecuted:=ACTac_PrepagarAviso ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_EmiteTransaccion")
		$b_taskExecuted:=ACTac_EmiteTransaccion ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_EmiteDoc")
		$b_taskExecuted:=ACTac_EmiteDocCargo ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_EmiteCargo")
		$b_taskExecuted:=ACTac_EmiteCargo ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACTac_CalculaInteres")
		$b_taskExecuted:=ACTac_CalculaIntereses (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="co-AsignaNumerosDeFolio")
		$b_taskExecuted:=AL_AsignaNoDeFolio 
		
	: ([xShell_BatchRequests:48]Action:1="ACT_RecalculaCargas")
		$b_taskExecuted:=ACTpp_CalculaNoCargas (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_EliminaNulas")
		$b_taskExecuted:=ACTbol_EliminaNulas (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_ModificaBoleta")
		$b_taskExecuted:=ACTbol_Modificar ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACTpp_ActualizaValores")
		$b_taskExecuted:=ACTpp_ActualizaValores (Num:C11([xShell_BatchRequests:48]Msg:2);[xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="SendSNConfigs")
		$b_taskExecuted:=True:C214
		
	: ([xShell_BatchRequests:48]Action:1="ACT_EliminarLetra")
		$b_taskExecuted:=ACTlc_EliminaLetra (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="idBolEnTransacciones")
		$b_taskExecuted:=ACTtra_AsignaIdBoleta ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="idBolPagosEnBoleta")
		$b_taskExecuted:=ACTtra_AsignaIdBoleta4Pago ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_AsignaIDTransaccion")
		$b_taskExecuted:=ACTpgs_AsignaIdTransaccion (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_AnulaYReemplazaCartera")
		$b_taskExecuted:=ACTreemp_AnulaReemplazaCartera ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="calculaMontosAvisos")
		$b_taskExecuted:=ACTac_CalculaMontos ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_RecalculaAvisosBash")
		$b_taskExecuted:=ACTmnu_RecalcSaldosAvisosOnServ ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="ACTpp_Calcula_Montos_Ejercicio")
		$b_taskExecuted:=ACTpp_RecalculaSaldoApdo (Num:C11([xShell_BatchRequests:48]Msg:2))
		
		
	: ([xShell_BatchRequests:48]Action:1="STR_ReplicaCambios")
		$b_taskExecuted:=STR_ReplicaCambios ($nilPointer;[xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="AsignaCodInternoCtaCte")
		$b_taskExecuted:=ACTcc_AsignaCodInterno (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="AsignaIDDocTrib")
		$b_taskExecuted:=ACTbol_AsignaCatDocTributario ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_CampoMatriculado")
		$b_taskExecuted:=ACTcfg_ItemsMatricula ("ProcesaBash";->[xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACTter_ActualizaValores")
		$b_taskExecuted:=ACTter_ActualizaValores (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ActualizaRazonSocial")
		$b_taskExecuted:=ACTcfg_OpcionesRazonesSociales ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ActualizaRazonSocialItems")
		$b_taskExecuted:=ACTcfg_OpcionesRazonesSociales ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="AsignaIDDocTribTercero")
		$b_taskExecuted:=ACTbol_AsignaCatDocTributarioT ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="AsignaIDDocTribDts")
		$b_taskExecuted:=ACTbol_AsignaCatDocTributarioDT ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="ACTpgs_ActualizaFechaTransacciones")
		$b_taskExecuted:=ACTpgs_ActualizaFechaTrans (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_CalculaNumeroHijo")
		$b_taskExecuted:=ACTcc_OrderCtasCtes (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_AsignaIDDctoReemp")
		$b_taskExecuted:=(ACTdp_OpcionesHistorialReemplaz ("EjecutaAsignaIDReempVariosCheques";->[xShell_BatchRequests:48]Parameters:8)=1)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_CalculaMontosProtApdo")
		$vl_idApdo:=Num:C11([xShell_BatchRequests:48]Msg:2)
		$b_taskExecuted:=ACTpp_OpcionesCalculoMontos ("CalculaMontoApdo";->$vl_idApdo)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_CalculaMontosProtTercero")
		$vl_idTer:=Num:C11([xShell_BatchRequests:48]Msg:2)
		$b_taskExecuted:=ACTpp_OpcionesCalculoMontos ("CalculaMontoApdo";->$vl_idTer)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_MarcaRegistroFolioEnviado")
		$vl_idFolio:=Num:C11([xShell_BatchRequests:48]Msg:2)
		$b_taskExecuted:=(ACTfol_OpcionesGenerales ("MarcaRegistroComoEnviado";->$vl_idFolio)="1")
		
	: ([xShell_BatchRequests:48]Action:1="ACT_CreaRegistroCAF")
		$b_taskExecuted:=(ACTfol_OpcionesGenerales ("CreaRegistroBash";->[xShell_BatchRequests:48]Parameters:8)="1")
		
	: ([xShell_BatchRequests:48]Action:1="ActualizaDatosColegio")
		C_LONGINT:C283($vl_id)
		$vl_id:=Num:C11([xShell_BatchRequests:48]Msg:2)
		$b_taskExecuted:=ACTcfg_OpcionesRazonesSociales ("ActualizaTablaColegio";->$vl_id)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_ActualizaEstadoLibro")
		C_LONGINT:C283($l_id;$l_estado)
		ST_Deconcatenate ("";[xShell_BatchRequests:48]Msg:2;->$l_id;->$l_estado)
		$b_taskExecuted:=ACTiecv_actualizaEstado ($l_id;$l_estado)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_ActualizaNombreAC")  //20130411 RCH
		$b_taskExecuted:=((ACTac_ActualizaNombre ("ProcessTask";->[xShell_BatchRequests:48]Msg:2))="1")
		
	: ([xShell_BatchRequests:48]Action:1="imprimirPDFAviso")
		ACTac_ImprimePDF (Num:C11([xShell_BatchRequests:48]Msg:2))
		$b_taskExecuted:=True:C214
		
	: ([xShell_BatchRequests:48]Action:1="ACT_escribeDTSPDF")  //20130729 RCH
		$b_taskExecuted:=ACTac_CreaDTSPDF ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="STR_EliminaEducAnterior")  //20130730 RCH
		$b_taskExecuted:=ADTcdd_DeleteEducacionAntBatch ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="NTC_AsignaBitAUsuario")  //20130822 RCH
		$b_taskExecuted:=USR_AsignaBitAUsuarioNTC ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_actualizaCCostoXNivel")  //20130909 RCH
		$b_taskExecuted:=ACTitems_AsignaCCostoXNivel (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="AL_MarcaCampoHijoFuncionario")
		$b_taskExecuted:=AL_MarcaCampoHijoFuncionario (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_rechazaDTERecibido")  //20131018 RCH
		$b_taskExecuted:=ACTdteRec_ActualizaEstado ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="STR_SeteaDiccionario")  //20140327 ASM
		$b_taskExecuted:=STR_SeteaDiccionario (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="AS_VerificaNombreHijaEnMadre")  //20140610 ASM Para verificar nombre de hijas en la configuracion de las madres.
		$b_taskExecuted:=AS_VerificaNombreHijaEnMadre (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="DisminuyeCAF")  //20141007 RCH
		$b_taskExecuted:=ACTcaf_DisminuyeFolioDisponible (Num:C11([xShell_BatchRequests:48]Msg:2))
		
	: ([xShell_BatchRequests:48]Action:1="ACT_EnviaMailDTE")  //20150806 RCH
		$b_taskExecuted:=ACTdte_enviaPDFXMail (Num:C11([xShell_BatchRequests:48]Msg:2))
	: ([xShell_BatchRequests:48]Action:1="ST_activaMalla")  //20160216 JVP
		$b_taskExecuted:=ST_activacionMallaAsignaturas ([xShell_BatchRequests:48]Msg:2)
		
	: ([xShell_BatchRequests:48]Action:1="envio log importacion alumnos web")  //ASM 20170317 Ticket 177503
		$b_taskExecuted:=ADTwa_EnviaRespuestaImportWeb ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="AL_InactivaRegistroRelacionados")  //Ticket Nº 177176 Saúl Ponce O. para inactivar familia y rel. familiares
		  //$b_taskExecuted:=AL_InactivaRegistroRelacionados ("ProcesaBash";->[xShell_BatchRequests]Msg)
		
		C_TEXT:C284($vt_accionBash)
		C_LONGINT:C283($vl_numero)
		$vt_accionBash:=ST_GetWord ([xShell_BatchRequests:48]Msg:2;1;".")
		$vl_numero:=Num:C11(ST_GetWord ([xShell_BatchRequests:48]Msg:2;2;"."))
		$b_taskExecuted:=AL_InactivaRegistroRelacionados ($vt_accionBash;$vl_numero)
		
	: ([xShell_BatchRequests:48]Action:1="Sync_LogEventoTask")  //MONO TICKET 189641
		$b_taskExecuted:=Sync_LogEventoTask ([xShell_BatchRequests:48]Parameters:8)
		
	: ([xShell_BatchRequests:48]Action:1="ACT_AgregaObservaciones")  //20171205 RCH
		$b_taskExecuted:=ACTbol_AgregaObs ([xShell_BatchRequests:48]Msg:2)
		
	Else 
		$b_taskExecuted:=False:C215
End case 

$0:=$b_taskExecuted
