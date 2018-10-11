//%attributes = {}
  // Método: ACTac_EmiteAviso
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 15:43:24
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal



  //ACTac_EmiteAviso

SET_UseSet ("Selection")
  //Generar:=True //20160820 RCH
SET BLOB SIZE:C606(xblob;0)
ARRAY LONGINT:C221(aLong1;0)
ARRAY LONGINT:C221($aLong1;0)
SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175];aLong1)
COPY ARRAY:C226(aLong1;$aLong1)
ACTcc_OpcionesEmision ("verifcaCuentasAEmitir";->aLong1;->$aLong1)
$msg1:="Existen cuentas sin apoderado de cuentas. Los cargos no ser"+"án generados ni emitidos para dichas cuentas."
$msg1:=$msg1+"\r\r"+"Para ver las cuentas excluídas antes de emitir haga clic en el botón Ver cuenta"+"s excluídas."
$msg2:="Los cargos no fueron emitidos para ninguna cuenta corriente."
REDUCE SELECTION:C351([ACT_CuentasCorrientes:175];0)
KRL_UnloadReadOnly (->[ACT_CuentasCorrientes:175])
vReportTitle:="Cuentas corrientes que serán excluidas de la emisión"
vBtnTitle:="Cancelar emisión"
If (Size of array:C274($aLong1)>0)
	$r:=1
	vbACT_AllowGeneration:=True:C214
	If (Size of array:C274($aLong1)#Size of array:C274(aLong1))
		ACTcc_OpcionesEmision ("enviaMail")
		$r:=CD_Dlog (0;$msg1;"";"Ver cuentas excluídas";"Cancelar";"Continuar")
		If ($r=1)
			WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;"Cuentas Excluídas")
			DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
			CLOSE WINDOW:C154
			AT_Initialize (->aDeletedNames;->aMotivo)
			If (ok=0)
				$r:=2
			End if 
		End if 
	End if 
	If (($r=1) | ($r=3))
		If (cbMontosEnMonedaPago=0)
			AT_Initialize (->atACT_NombreMonedaEm;->adACT_fechasEm)
		Else 
			For ($i;Size of array:C274(atACT_NombreMonedaEm);1;-1)
				If (Not:C34(abACT_MontosFijosEm{$i}))
					AT_Delete ($i;1;->atACT_NombreMonedaEm;->adACT_fechasEm)
				End if 
			End for 
		End if 
		ARRAY LONGINT:C221($alACT_CuentasTomadas;0)
		COPY ARRAY:C226($aLong1;aLong1)
		  //BLOB_Variables2Blob (->xBlob;0;->aLong1;->b1;->b2;->b3;->bHidePrintSettings;->aMeses;->aMeses2;->viACT_DiaGeneracion;->vdACT_FechaAviso;->vdACT_DiaAviso;->bc_ExecuteOnServer;->vs1;->vs2;->Generar;->vdACT_AñoAviso;->atACT_ModelosAviso;->cbIncluirSaldosAnteriores;->mAvisoApoderado;->mAvisoAlumno;->vdACT_AñoAviso2;->vdACT_FechaUFSel;->vdACT_DiaVctoAviso;->atACT_NombreMonedaEm;->cbVctoSegunConf;->cb_NoPrepagarAuto;->adACT_fechasEm;->vbACT_montoAnual->vlACT_numeroCuotas)
		ACTcar_OpcionesGenerales ("CargaBlobParaEmision";->xBlob)
		LOG_RegisterEvt ("Inicio emisión de avisos de cobranza desde asistente.")
		If ((Application type:C494=4D Remote mode:K5:5) & (bc_ExecuteOnServer=1))
			$processID:=Execute on server:C373("ACTcc_EmiteAvisos";Pila_256K;"Emisión de Avisos";xblob;vpXS_IconModule;vsBWR_CurrentModule;<>RegisteredName;bc_SetProgTask;vdDate;vHrs;vMinutes;<>tUSR_CurrentUser)
			$procID:=IT_UThermometer (1;0;"Emitiendo avisos en el servidor...")
			$emitir:=False:C215
			DELAY PROCESS:C323(Current process:C322;60)
			While (Not:C34($emitir))
				IDLE:C311
				GET PROCESS VARIABLE:C371($processID;vbACT_TerminoEmitir;$emitir)
			End while 
			GET PROCESS VARIABLE:C371($processID;alACT_CuentasTomadas;$alACT_CuentasTomadas)
			SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeEmitir;True:C214)
			IT_UThermometer (-2;$procID)
		Else 
			$processID:=New process:C317("ACTcc_EmiteAvisos";Pila_256K;"Emisión de Avisos";xBlob;vpXS_IconModule;vsBWR_CurrentModule;<>RegisteredName;0;!00-00-00!;0;0;<>tUSR_CurrentUser)
			$emitir:=False:C215
			DELAY PROCESS:C323(Current process:C322;60)
			While (Not:C34($emitir))
				If (Process state:C330($processID)<0)
					$emitir:=True:C214
				Else 
					IDLE:C311
					GET PROCESS VARIABLE:C371($processID;vbACT_TerminoEmitir;$emitir)
				End if 
			End while 
			GET PROCESS VARIABLE:C371($processID;alACT_CuentasTomadas;$alACT_CuentasTomadas)
			SET PROCESS VARIABLE:C370($processID;vbACT_TerminardeEmitir;True:C214)
		End if 
		LOG_RegisterEvt ("Término emisión de avisos de cobranza desde asistente.")
		FLUSH CACHE:C297
		If (Size of array:C274($alACT_CuentasTomadas)>0)
			ACTcc_OpcionesEmision ("LlenaArreglosAMostrar";->$alACT_CuentasTomadas)
			ACTcc_OpcionesEmision ("enviaMail")
			vReportTitle:="Cuentas corrientes que fueron excluidas de la emisión"
			vBtnTitle:="Aceptar"
			vbACT_MostrarBoton:=False:C215  //usada para esconder el segundo boton del informe (ver form method de CtasExcluidas)
			$r:=CD_Dlog (0;"Algunas cuentas fueron excluídas de la emisión.";"";"Ver cuentas excluídas";"Aceptar")
			If ($r=1)
				WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;"Cuentas Excluídas")
				DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
				CLOSE WINDOW:C154
				AT_Initialize (->aDeletedNames;->aMotivo)
			End if 
		Else 
			vbACT_MostrarBoton:=True:C214
		End if 
	End if 
Else 
	ACTcc_OpcionesEmision ("enviaMail")
	vbACT_AllowGeneration:=False:C215
	$r:=CD_Dlog (0;$msg2;"";"Ver cuentas excluídas";"Cancelar")
	If ($r=1)
		WDW_OpenFormWindow (->[ACT_CuentasCorrientes:175];"CtasExcluidas";0;4;"Cuentas Excluídas")
		DIALOG:C40([ACT_CuentasCorrientes:175];"CtasExcluidas")
		CLOSE WINDOW:C154
		AT_Initialize (->aDeletedNames;->aMotivo)
	End if 
End if 
