//%attributes = {}
  //ACTmnu_EmiteAvisos


If (USR_GetMethodAcces (Current method name:C684))
	vbACT_MostrarBoton:=True:C214
	If (Test semaphore:C652("ConfigACT"))
		CD_Dlog (0;"No es posible realizar la emisión de avisos en este momento."+"\r"+"Otro usuario está realizando modificaciones a la configuración de AccountTrack qu"+"e podrían afectar este proceso."+"\r\r"+"Por favor intente la emisión más tarde.")
	Else 
		$sem:=Semaphore:C143("ProcesoACT")
		ACTinit_LoadPrefs 
		WDW_OpenFormWindow (->[xxSTR_Constants:1];"ACTcc_Cobranzas";0;4;"Emisión de Avisos de Cobranza";"wdw_CloseDlog")
		DIALOG:C40([xxSTR_Constants:1];"ACTcc_Cobranzas")
		CLOSE WINDOW:C154
		If (ok=1)
			Generar:=Not:C34(b_soloProyectados)
			
			C_TEXT:C284($t_log)  //20180725 RCH Ticket 206430
			$t_log:="Inicio de emisión de Avisos de Cobranza con la opción "+ST_Qte ("Emitir solo para cargos proyectados (no se considerarán los cargos de la matriz asociada)")+" "+ST_Qte (Choose:C955(b_soloProyectados;"marcada";"desmarcada"))+"."
			$t_log:=$t_log+" Opción: Utilizar configuración: "+String:C10(cbVctoSegunConf)
			$t_log:=$t_log+". Opción: Día emisión: valor: "+String:C10(vdACT_DiaAviso)
			$t_log:=$t_log+". Opción: Último día de cada mes: Valor: "+String:C10(cbUltimoDiaMes)
			$t_log:=$t_log+". Opción: Día(s) post emisión: Valor: "+String:C10(l_diasEmision)
			$t_log:=$t_log+". Opción: Emitir en montos fijos utilizando tablas de paridad: Valor: "+String:C10(cbMontosEnMonedaPago)
			$t_log:=$t_log+". Opción: No prepagar automáticamente. Valor: "+String:C10(cb_NoPrepagarAuto)
			LOG_RegisterEvt ($t_log)
			
			ACTac_EmiteAviso 
		End if 
		LOAD RECORD:C52(yBWR_CurrentTable->)
		CLEAR SEMAPHORE:C144("ProcesoACT")
	End if 
End if 
