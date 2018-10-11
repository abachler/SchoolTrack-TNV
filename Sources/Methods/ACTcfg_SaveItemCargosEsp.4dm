//%attributes = {}
  //ACTcfg_SaveItemCargosEsp

If (USR_GetMethodAcces ("ACTcfg_SaveItemdeCargo";0))
	If (vl_idItemIE>-1)
		  //GOTO RECORD([xxACT_Items];vl_idItemIE)
		KRL_GotoRecord (->[xxACT_Items:179];vl_idItemIE;True:C214)
	Else 
		REDUCE SELECTION:C351([xxACT_Items:179];0)
	End if 
	If (Records in selection:C76([xxACT_Items:179])>0)
		If ([xxACT_Items:179]Glosa_de_Impresión:20="")
			[xxACT_Items:179]Glosa_de_Impresión:20:=[xxACT_Items:179]Glosa:2
			vt_glosaImpIE:=[xxACT_Items:179]Glosa_de_Impresión:20
		End if 
		If ((vi_lastLine>0) & ([xxACT_Items:179]Glosa:2#"") & ([xxACT_Items:179]Glosa_de_Impresión:20#""))
			If (USR_GetUserID >0)  //20150912 RCH Para dtenet
				[xxACT_Items:179]Glosa:2:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233([xxACT_Items:179]Glosa:2;"(";"[");")";"]");"/";"_");"\\";"_")
				vt_glosaImpIE:=Replace string:C233(Replace string:C233(Replace string:C233(Replace string:C233(vt_glosaImpIE;"(";"[");")";"]");"/";"_");"\\";"_")
			End if 
			
			[xxACT_Items:179]Glosa_de_Impresión:20:=vt_glosaImpIE
			[xxACT_Items:179]No_de_Cuenta_Contable:15:=vsACT_CtaInteresesIE
			[xxACT_Items:179]Centro_de_Costos:21:=vsACT_CentroInteresesIE
			[xxACT_Items:179]No_CCta_contable:22:=vsACT_CCtaInteresesIE
			[xxACT_Items:179]CCentro_de_costos:23:=vsACT_CCentroInteresesIE
			[xxACT_Items:179]CodAuxCta:27:=vsACT_CodInteresesIE
			[xxACT_Items:179]CodAuxCCta:28:=vsACT_CCodInteresesIE
			[xxACT_Items:179]Afecto_IVA:12:=(vr_afectoIVAIE=1)
			[xxACT_Items:179]No_incluir_en_DocTributario:31:=(vr_noDctoTIE=1)
			[xxACT_Items:179]AgruparInteresesAC:33:=(vr_agruparACIE=1)
			[xxACT_Items:179]AgruparInteresesDT:34:=(vr_agruparDTIE=1)
			[xxACT_Items:179]UbicacionInteresGenerado:30:=0
			[xxACT_Items:179]Moneda:10:=vt_monedaIE
			[xxACT_Items:179]Monto:7:=vr_montoIE
			[xxACT_Items:179]Meses_de_cargo:9:=vl_mesIE
			[xxACT_Items:179]NoAfecto_a_RecargosAut:37:=(vr_NoAfectoRecargoAut=1)
			[xxACT_Items:179]id_tipoRecargoAut:45:=Choose:C955((vr_NoAfectoRecargoAut=1);0;1)  // si es afecto se deja el campo en 0
			[xxACT_Items:179]xCentro_Costo:41:=vx_CentroCostoXNivel
			Case of 
				: (b1=1)
					[xxACT_Items:179]UbicacionInteresGenerado:30:=[xxACT_Items:179]UbicacionInteresGenerado:30 ?+ 1
				: (b2=1)
					[xxACT_Items:179]UbicacionInteresGenerado:30:=[xxACT_Items:179]UbicacionInteresGenerado:30 ?+ 2
				: (b3=1)
					[xxACT_Items:179]UbicacionInteresGenerado:30:=[xxACT_Items:179]UbicacionInteresGenerado:30 ?+ 3
				: (b4=1)
					[xxACT_Items:179]UbicacionInteresGenerado:30:=[xxACT_Items:179]UbicacionInteresGenerado:30 ?+ 4
				Else 
					If ([xxACT_Items:179]ID:1=-100)
						[xxACT_Items:179]UbicacionInteresGenerado:30:=[xxACT_Items:179]UbicacionInteresGenerado:30 ?+ 1
					End if 
			End case 
			$oldMonto:=Old:C35([xxACT_Items:179]Monto:7)
			$oldEsRelativo:=Old:C35([xxACT_Items:179]EsRelativo:5)
			$oldEsDescuento:=Old:C35([xxACT_Items:179]EsDescuento:6)
			$oldAfectoIVA:=Old:C35([xxACT_Items:179]Afecto_IVA:12)
			$oldAfectoDesctoInd:=Old:C35([xxACT_Items:179]AfectoDsctoIndividual:17)
			$oldAfectoDesctos:=Old:C35([xxACT_Items:179]Afecto_a_descuentos:4)
			$oldMoneda:=Old:C35([xxACT_Items:179]Moneda:10)
			$oldNoDocTrib:=Old:C35([xxACT_Items:179]No_incluir_en_DocTributario:31)
			
			If ([xxACT_Items:179]ID:1=-100)
				ACTcar_FechaCalculoIntereses ("GuardaConf")  //20140825 RCH Intereses
			End if 
			
			$vt_log:=ACTcfg_CreaLogItem (->[xxACT_Items:179]ID:1)
			If ($vt_log#"")
				LOG_RegisterEvt ($vt_log)
			End if 
			
			SAVE RECORD:C53([xxACT_Items:179])
			LOG_RegisterEvt ("Modificación de ítem de cargo "+[xxACT_Items:179]Glosa:2+".")
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=[xxACT_Items:179]ID:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			CREATE SET:C116([ACT_Cargos:173];"CargosAfectados")
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			CREATE SET:C116([ACT_CuentasCorrientes:175];"CurrSel")
			KRL_RelateSelection (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2;"")
			$Cargos:=Records in selection:C76([ACT_Cargos:173])
			$Ctas:=Records in selection:C76([ACT_CuentasCorrientes:175])
			USE SET:C118("CurrSel")
			CLEAR SET:C117("CurrSel")
			If (($Cargos#0) & (([xxACT_Items:179]Monto:7#$oldMonto)) | ([xxACT_Items:179]EsRelativo:5#$oldEsRelativo) | ([xxACT_Items:179]EsDescuento:6#$oldEsDescuento) | ([xxACT_Items:179]Afecto_IVA:12#$oldAfectoIVA) | ([xxACT_Items:179]AfectoDsctoIndividual:17#$oldAfectoDesctoInd) | ([xxACT_Items:179]Afecto_a_descuentos:4#$oldAfectoDesctos) | ([xxACT_Items:179]Moneda:10#$oldMoneda) | (ACTcfg_ModBlob) | ([xxACT_Items:179]No_incluir_en_DocTributario:31#$oldNoDocTrib))
				Case of 
					: ($Ctas=1)
						$accion:=CD_Dlog (0;__ ("La modificación de este item implica recalcular los cargos para 1 cuenta que tiene cargos no emitidos correspondientes a este item.");__ ("");__ ("Cancelar");__ ("Recalcular ahora");__ ("Recálculo automático"))
					: ($Ctas>0)
						  //$msg:=RP_GetIdxString (21503;72)
						  //$msg:=Replace string($msg;"ˆ0";String($ctas))
						$accion:=CD_Dlog (0;Replace string:C233(__ ("La modificación de este item implica recalcular los cargos para ˆ0 cuentas que tienen cargos no emitidos correspondientes a este item.");__ ("ˆ0");String:C10($ctas));__ ("");__ ("Cancelar");__ ("Recalcular ahora");__ ("Recálculo automático"))
					Else 
						$accion:=0
				End case 
				Case of 
					: ($accion=1)  //Cancelar
						
					: ($accion=2)  //Recalculo ahora
						SAVE RECORD:C53([xxACT_Items:179])
						alACT_idItem{vi_lastLine}:=[xxACT_Items:179]ID:1
						atACT_GlosaItem{vi_lastLine}:=[xxACT_Items:179]Glosa:2
						USE SET:C118("CargosAfectados")
						If (Records in set:C195("CargosAfectados")>0)
							ARRAY LONGINT:C221(alACT_CargosAfectados;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];alACT_CargosAfectados)
							SET BLOB SIZE:C606(xBlob;0)
							BLOB_Variables2Blob (->xBlob;0;->alACT_CargosAfectados)
						End if 
						If (Application type:C494=4D Remote mode:K5:5)
							CD_Dlog (0;__ ("El recálculo se efectuará en el servidor para liberar a su máquina de dicha tarea."))
							$proc:=Execute on server:C373("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
							$procID:=IT_UThermometer (1;0;__ ("Recalculando cargos en el servidor..."))
							DELAY PROCESS:C323(Current process:C322;120)
							$recalculando:=True:C214
							While ($recalculando)
								IDLE:C311
								GET PROCESS VARIABLE:C371(-1;<>vbACT_RecalcCargosServer;$recalculando)
							End while 
							IT_UThermometer (-2;$procID)
						Else 
							CD_Dlog (0;__ ("El recálculo se efectuará en un proceso independiente para liberar a AccountTrack de dicha tarea."))
							$proc:=New process:C317("ACTcfg_recalculatecargoOnserver";Pila_256K;"Recalculando Cargos";xBlob)
						End if 
					: (($accion=0) | ($accion=3))  //Sin ctas. afectadas o Recalculo automatico
						SAVE RECORD:C53([xxACT_Items:179])
						alACT_idItem{vi_lastLine}:=[xxACT_Items:179]ID:1
						atACT_GlosaItem{vi_lastLine}:=[xxACT_Items:179]Glosa:2
				End case 
			End if 
			
		End if 
	End if 
End if 