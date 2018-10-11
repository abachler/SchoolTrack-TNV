//%attributes = {}
  //ACTcfg_OpcionesRecargosAut

C_TEXT:C284($vt_accion;$1;$filter)
C_REAL:C285($0;$vr_monto;$vr_retorno)
C_POINTER:C301($ptr1;$ptr2;$vy_pointer3)
C_POINTER:C301(${2})
C_DATE:C307($vd_fecha;$vd_fechaRec)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 
If (Count parameters:C259>=3)
	$ptr2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 

Case of 
	: ($vt_accion="BuscaItemsADesplegar")
		ACTqry_Items ("CargosNoRelativosNoEspecialesNoIntereses";->[xxACT_Items:179]ID:1;->al_IdsItems;->[xxACT_Items:179]Glosa:2;->at_GlosasItems)
	: ($vt_accion="DeclaraVars")
		C_TEXT:C284(vtACTcfg_SelectedItemAut)
		C_LONGINT:C283(vlACTcfg_SelectedItemAut;cbRecargoAut;c_RecAutFijo;c_RecAutPct;cs_CargoAfectoSeparado;cs_UtilizarFechaActual;cs_GenerarMultaEnMismoAviso;cs_GenerarMultaDia1)
		C_LONGINT:C283(vl_MultasMaximas;cs_maximoMultas;vl_MultasMaximas2;cs_GenerarMultaDia1_2;vlACTcfg_SelectedItemAut_2)
		C_LONGINT:C283(cs_GenerarMultaAfecta)
		C_REAL:C285(vrACT_recargoMulta1)
		C_REAL:C285(vr_PctMontoRecAut)
		ARRAY LONGINT:C221(al_IdsItems;0)
		ARRAY TEXT:C222(at_GlosasItems;0)
		C_REAL:C285(vrACT_montoItem)
		C_LONGINT:C283(cs_ConsiderarRecargo)
		C_REAL:C285(cs_multaSobreMontoAfecto)  //20131125 RCH Nueva opcion
		
	: ($vt_accion="InitVars")
		ACTcfg_OpcionesRecargosAut ("DeclaraVars")
		cbRecargoAut:=0
		c_RecAutFijo:=0
		c_RecAutPct:=0
		vr_PctMontoRecAut:=0
		vlACTcfg_SelectedItemAut:=0
		vtACTcfg_SelectedItemAut:=""
		cs_CargoAfectoSeparado:=0
		cs_UtilizarFechaActual:=0
		cs_GenerarMultaEnMismoAviso:=0
		cs_GenerarMultaDia1:=0
		vl_MultasMaximas:=0
		cs_maximoMultas:=0
		vl_MultasMaximas2:=0
		cs_GenerarMultaDia1_2:=0
		vrACT_montoItem:=0
		vrACT_recargoMulta1:=0
		vlACTcfg_SelectedItemAut_2:=0
		cs_GenerarMultaAfecta:=0
		cs_ConsiderarRecargo:=0
		cs_multaSobreMontoAfecto:=0
		
	: ($vt_accion="CargaBlob")
		BLOB_Blob2Vars ($ptr1;0;->cbRecargoAut;->vtACTcfg_SelectedItemAut;->vlACTcfg_SelectedItemAut;->c_RecAutFijo;->c_RecAutPct;->vr_PctMontoRecAut;->cs_CargoAfectoSeparado;->cs_UtilizarFechaActual;->cs_GenerarMultaEnMismoAviso;->cs_GenerarMultaDia1;->vl_MultasMaximas;->cs_maximoMultas;->vrACT_recargoMulta1;->cs_GenerarMultaAfecta;->cs_ConsiderarRecargo;->cs_multaSobreMontoAfecto)
		
	: ($vt_accion="CreaBlob")
		BLOB_Variables2Blob ($ptr1;0;->cbRecargoAut;->vtACTcfg_SelectedItemAut;->vlACTcfg_SelectedItemAut;->c_RecAutFijo;->c_RecAutPct;->vr_PctMontoRecAut;->cs_CargoAfectoSeparado;->cs_UtilizarFechaActual;->cs_GenerarMultaEnMismoAviso;->cs_GenerarMultaDia1;->vl_MultasMaximas;->cs_maximoMultas;->vrACT_recargoMulta1;->cs_GenerarMultaAfecta;->cs_ConsiderarRecargo;->cs_multaSobreMontoAfecto)
		
	: ($vt_accion="LeeBlob")
		ACTcfg_LeeBlob ("ACTcfg_MultasRecargosAut")
		vl_MultasMaximas2:=vl_MultasMaximas
		cs_GenerarMultaDia1_2:=cs_GenerarMultaDia1
		vlACTcfg_SelectedItemAut_2:=vlACTcfg_SelectedItemAut
		vrACT_montoItem:=KRL_GetNumericFieldData (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemAut;->[xxACT_Items:179]Monto:7)
		
	: ($vt_accion="GuardaBlob")
		If (vl_MultasMaximas#vl_MultasMaximas2)
			LOG_RegisterEvt ("Multas automáticas: Máximo de multas definido en: "+String:C10(vl_MultasMaximas))
		End if 
		If (cs_GenerarMultaDia1#cs_GenerarMultaDia1_2)
			LOG_RegisterEvt ("Multas automáticas: Cambio en configuración de emisión en el día 1 del siguiente "+"mes. El nuevo valor es: "+String:C10(cs_GenerarMultaDia1)+".")
		End if 
		  //20120616 RCH se valida que solo se configure el recargo de la primera multa cuando se toma el monto del item de cargo.
		If (c_RecAutFijo=0)
			vrACT_recargoMulta1:=0
		End if 
		ACTcfg_GuardaBlob ("ACTcfg_MultasRecargosAut")
		
	: ($vt_accion="ValidaInicioRecalculoMultasFinDeDia")
		$vl_recordsLocked:=0
		ACTcfg_OpcionesRecargosAut ("LeeBlob")
		If (cbRecargoAut=1)
			If (vlACTcfg_SelectedItemAut#0)
				
				  //20120613 RCH arreglo utilizado al ingreso de pagos
				ARRAY LONGINT:C221(alACT_recNumNewC;0)
				
				READ ONLY:C145([xxACT_Items:179])
				REDUCE SELECTION:C351([xxACT_Items:179];0)
				KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->vlACTcfg_SelectedItemAut)
				If (Records in selection:C76([xxACT_Items:179])=1)
					If (Not:C34([xxACT_Items:179]EsDescuento:6))
						ACTcfg_ItemsMatricula ("InicializaYLee")
						ACTcfg_LoadConfigData (1)
						$vr_retorno:=1
					Else 
						LOG_RegisterEvt ("El recargo automático no pudo ser generado porque el ítem de cargo seleccionado n"+"o "+"es un cargo.")
					End if 
				Else 
					LOG_RegisterEvt ("El recargo automático no pudo ser generado porque el ítem de cargo seleccionado n"+"o "+"existe en la configuración o está duplicado.")
				End if 
				
				  //20120613 RCH arreglo utilizado al ingreso de pagos
				AT_Initialize (->alACT_recNumNewC)
			Else 
				LOG_RegisterEvt ("El recargo automático no pudo ser generado porque no fue seleccionado un ítem de "+"ca"+"rgo.")
			End if 
		End if 
		
	: ($vt_accion="RecalculoMultasFinDeDia")
		  //ACTcfg_OpcionesRecargosAut ("LeeBlob")
		  //If (cbRecargoAut=1)
		  //If (vlACTcfg_SelectedItemAut#0)
		  //
		  //  //20120613 RCH arreglo utilizado al ingreso de pagos
		  //ARRAY LONGINT(alACT_recNumNewC;0)
		  //
		  //READ ONLY([xxACT_Items])
		  //REDUCE SELECTION([xxACT_Items];0)
		  //KRL_FindAndLoadRecordByIndex (->[xxACT_Items]ID;->vlACTcfg_SelectedItemAut)
		  //If (Records in selection([xxACT_Items])=1)
		  //If (Not([xxACT_Items]EsDescuento))
		  //ACTcfg_ItemsMatricula ("InicializaYLee")
		  //ACTcfg_LoadConfigData (1)
		  //
		  //TRACE
		  //pasar como parametro la fecha
		  //$vd_fecha:=Current date(*)
		If (ACTcfg_OpcionesRecargosAut ("ValidaInicioRecalculoMultasFinDeDia")=1)
			$vd_fecha:=$ptr1->
			
			  //20110415 RCH Al cambiar entre generar en dia 1 y no... se eliminaran los recargos no pagados...
			C_LONGINT:C283($vl_eliminarRecargos;$vl_proc)
			
			  //20120724 RCH Se filtra por el mes.
			C_TEXT:C284($vt_dts)
			C_DATE:C307($vd_fechadts)
			ACTcfg_OpcionesRecargosAut ("ObtieneDTSFecha";->$vt_dts)
			$vd_fechadts:=DTS_GetDate ($vt_dts)
			
			$vl_eliminarRecargos:=Num:C11(PREF_fGet (0;"ACT_EliminaRecargosAut";"0"))
			If ($vl_eliminarRecargos=1)
				ACTcfg_OpcionesRecargosAut ("ValidaReferenciasCambioConf")
			End if 
			
			ARRAY LONGINT:C221($al_recNumAvisos;0)
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<Current date:C33(*);*)
			QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0;*)
			QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]EsMulta:25=False:C215)
			  //QUERY SELECTION([ACT_Avisos_de_Cobranza];[ACT_Avisos_de_Cobranza]Fecha_Emision>=!01-01-2008!)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=$vd_fechadts)
			ORDER BY:C49([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4;>;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;>)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$al_recNumAvisos;"")
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando multas automáticas..."))
			For ($i;1;Size of array:C274($al_recNumAvisos))
				$vl_recNumAviso:=$al_recNumAvisos{$i}
				ACTcfg_OpcionesRecargosAut ("GeneraMultaAutomatica";->$vl_recNumAviso;->vlACTcfg_SelectedItemAut;->$vd_fecha)
				
				  //  //20120611 RCH 
				  //KRL_GotoRecord (->[ACT_Avisos_de_Cobranza];$vl_recNumAviso;True)
				  //If (ok=1)
				  //[ACT_Avisos_de_Cobranza]Fecha_recalc_multas:=$vd_fechaRecalc
				  //SAVE RECORD([ACT_Avisos_de_Cobranza])
				  //End if 
				  //KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza])
				
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($al_recNumAvisos))
			End for 
			ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		  //Else 
		  //LOG_RegisterEvt ("El recargo automático no pudo ser generado porque el ítem de cargo seleccionado n"+"o "+"es un cargo.")
		  //End if 
		  //Else 
		  //LOG_RegisterEvt ("El recargo automático no pudo ser generado porque el ítem de cargo seleccionado n"+"o "+"existe en la configuración o está duplicado.")
		  //End if 
		  //
		  //  //20120613 RCH arreglo utilizado al ingreso de pagos
		  //AT_Initialize (->alACT_recNumNewC)
		  //
		  //Else 
		  //LOG_RegisterEvt ("El recargo automático no pudo ser generado porque no fue seleccionado un ítem de "+"ca"+"rgo.")
		  //End if 
		  //End if 
		
	: ($vt_accion="RecalculaDesdeIngresoDePagos")
		
		If (ACTcfg_OpcionesRecargosAut ("ValidaInicioRecalculoMultasFinDeDia")=1)
			ARRAY LONGINT:C221(alACT_recNumNewC;0)
			ARRAY LONGINT:C221($alACT_recNumNewC;0)
			
			  //20120724 RCH Se filtra por el mes.
			C_TEXT:C284($vt_dts)
			C_DATE:C307($vd_fechaDesde)
			ACTcfg_OpcionesRecargosAut ("ObtieneDTSFecha";->$vt_dts)
			$vd_fechaDesde:=DTS_GetDate ($vt_dts)
			
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			
			$vd_fecha:=$vy_pointer3->
			
			CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$ptr1->;"")
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=$vd_fechaDesde)
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
			
			  //elimina recargos
			CREATE SET:C116([ACT_Cargos:173];"setCargo2Delete")
			
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"setCargoEnBoleta")
			
			DIFFERENCE:C122("setCargo2Delete";"setCargoEnBoleta";"setCargo2Delete")
			
			USE SET:C118("setCargo2Delete")
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30#0)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"setCargoEnPagare")
			DIFFERENCE:C122("setCargo2Delete";"setCargoEnPagare";"setCargo2Delete")
			
			USE SET:C118("setCargo2Delete")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8=0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			
			SET_ClearSets ("setCargo2Delete")
			CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargo2Delete")
			  //elimina cargos de arreglo con recnums
			While (Not:C34(End selection:C36([ACT_Cargos:173])))
				$vd_fechaRec:=DTS_GetDate (Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;1;14))
				If ($vd_fechaRec>=$vd_fecha)
					$vl_existe:=Find in array:C230(al_RecNumsCargos;Record number:C243([ACT_Cargos:173]))
					If ($vl_existe#-1)
						AT_Delete ($vl_existe;1;->al_RecNumsCargos)
					End if 
					ADD TO SET:C119([ACT_Cargos:173];"setCargo2Delete")
				End if 
				NEXT RECORD:C51([ACT_Cargos:173])
			End while 
			
			READ WRITE:C146([ACT_Cargos:173])
			USE SET:C118("setCargo2Delete")
			ACTcc_EliminaCargosLoop 
			
			SET_ClearSets ("setCargo2Delete";"setCargoEnBoleta";"setCargoEnPagare";"setCargoEnBoletas")
			  //
			
			$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Generando multas automáticas..."))
			
			  //20120724 RCH Se filtra por el mes.
			C_TEXT:C284($vt_dts)
			C_DATE:C307($vd_fechaDesde)
			ACTcfg_OpcionesRecargosAut ("ObtieneDTSFecha";->$vt_dts)
			$vd_fechaDesde:=DTS_GetDate ($vt_dts)
			CREATE SELECTION FROM ARRAY:C640([ACT_Avisos_de_Cobranza:124];$ptr2->;"")
			ARRAY LONGINT:C221($alACT_recNumsAvisos;0)
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=$vd_fechaDesde)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAvisos;"")
			
			For ($i;1;Size of array:C274($alACT_recNumsAvisos))
				$vl_recNumAviso:=$alACT_recNumsAvisos{$i}
				ACTcfg_OpcionesRecargosAut ("GeneraMultaAutomatica";->$vl_recNumAviso;->vlACTcfg_SelectedItemAut;->$vd_fecha)
				For ($j;1;Size of array:C274(alACT_recNumNewC))
					If (alACT_recNumNewC{$j}>=0)
						APPEND TO ARRAY:C911($alACT_recNumNewC;alACT_recNumNewC{$j})
					End if 
				End for 
				$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNumsAvisos))
			End for 
			ACTcfg_ItemsMatricula ("ActualizaCampoDesdeEmitido")
			
			AT_DistinctsArrayValues (->$alACT_recNumNewC)
			For ($i;1;Size of array:C274($alACT_recNumNewC))
				If (Find in array:C230(al_RecNumsCargos;$alACT_recNumNewC{$i})=-1)
					APPEND TO ARRAY:C911(al_RecNumsCargos;$alACT_recNumNewC{$i})
				End if 
			End for 
			
			  //20120710 RCH Cuando se calculaban multas que se creaban en nuevos avisos, podian no aparecer...
			ACTac_OpcionesGenerales ("CreaArregloDesdeRecNumCargo";->al_RecNumsCargos;->alACT_RecNumsAvisos)
			
			AT_Initialize (->alACT_recNumNewC;->$alACT_recNumNewC)
			$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		End if 
		
	: ($vt_accion="GeneraMultaAutomatica")
		C_LONGINT:C283($vl_existe;$vl_idCtaCte;$vl_idAviso;$vl_idApoderado;$vl_recNumCargo)
		C_REAL:C285(vrACT_MontoMulta;vrACT_MontoMultaAfecta)
		C_DATE:C307($vd_fecha;$vd_FechaVencAvisoMulta)
		C_BOOLEAN:C305($vb_mismoAviso;$vb_enBoleta;$vb_esMulta;$vb_avisoXCta)
		C_TEXT:C284($vt_ref)
		C_BOOLEAN:C305($vbACT_Dia31)
		ARRAY LONGINT:C221(alACT_recNumNewC;0)
		
		C_REAL:C285($r_montoExtraE;$r_montoExtraA)
		
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([xxACT_Items:179])
		
		GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$ptr1->)
		KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;$ptr2)
		$vd_fechaRec:=$vy_pointer3->
		
		$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
		If (cs_UtilizarFechaActual=0)
			$vd_FechaVencAvisoMulta:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
		Else 
			$vd_FechaVencAvisoMulta:=Current date:C33(*)
		End if 
		$vb_avisoXCta:=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2>0
		$vl_idApoderado:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
		If ([ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<Current date:C33(*))
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Transacciones:178])
			  //READ ONLY([ACT_CuentasCorrientes])
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=$vl_idAviso)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]NoAfecto_a_DescuentosAut:60=False:C215)
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53="")
			
			  //para no encontrar los items de recargos por tabla
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMultaTabla:67="")
			
			  //filtra items de recargos automaticos 
			ARRAY LONGINT:C221($alACT_idItemsRec;0)
			KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[ACT_Cargos:173]Ref_Item:16;"")
			QUERY SELECTION:C341([xxACT_Items:179];[xxACT_Items:179]id_tipoRecargoAut:45=1)
			SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$alACT_idItemsRec)
			QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idItemsRec)
			  //filtro items
			
			
			  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Monto_Neto>0)  //20101025 se estaban generando multas para los descuentos en caja...
			  //20130830 RCH Para considerar los posibles descuentos por tramos
			CREATE SET:C116([ACT_Cargos:173];"setCargos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0)  //20101025 se estaban generando multas para los descuentos en caja...
			CREATE SET:C116([ACT_Cargos:173];"setCargos2")
			USE SET:C118("setCargos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Id_TramoItem:62#0)
			CREATE SET:C116([ACT_Cargos:173];"setCargos3")
			UNION:C120("setCargos2";"setCargos3";"setCargos2")
			USE SET:C118("setCargos2")
			SET_ClearSets ("setCargos";"setCargos2";"setCargos3")
			
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)  //20110414 se escribia en el log para cargos del aviso sin saldo. Ahora se filtran.
			If (Sum:C1([ACT_Cargos:173]Saldo:23)#0)
				CREATE SET:C116([ACT_Cargos:173];"setCargos")
				
				  //20151210 RCH Para marcar no incluir en DT
				C_LONGINT:C283($l_recordsInSel;$l_recordsNoEnDT)
				C_BOOLEAN:C305($b_noIncluidEnDT)
				$l_recordsInSel:=Records in selection:C76([ACT_Cargos:173])
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_recordsNoEnDT)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]No_Incluir_en_DocTrib:50=True:C214)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				If ($l_recordsInSel=$l_recordsNoEnDT)
					$b_noIncluidEnDT:=True:C214
				Else 
					$b_noIncluidEnDT:=False:C215
				End if 
				
				  //20141003 RCH verifico las razones sociales asociadas a los cargos para los que se generará multa. Si es una, se asigna ese id de razón social al cargo.
				ARRAY LONGINT:C221($alACT_idRazonSocial;0)
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID_RazonSocial:57;$alACT_idRazonSocial)
				For ($l_indice;1;Size of array:C274($alACT_idRazonSocial))
					If ($alACT_idRazonSocial{$l_indice}=0)
						$alACT_idRazonSocial{$l_indice}:=-1
					End if 
				End for 
				AT_DistinctsArrayValues (->$alACT_idRazonSocial)
				
				ARRAY LONGINT:C221($al_IdsCtas;0)
				AT_DistinctsFieldValues (->[ACT_Cargos:173]ID_CuentaCorriente:2;->$al_IdsCtas)
				If (c_RecAutFijo=1)
					AT_Delete (2;Size of array:C274($al_IdsCtas);->$al_IdsCtas)
				End if 
				For ($i;1;Size of array:C274($al_IdsCtas))
					vrACT_MontoMulta:=0
					vrACT_MontoMultaAfecta:=0
					
					  //20160511 RCH Habia problema con el calculo para más de una cuenta. Los montos comenzaban a variar
					$r_montoExtraE:=0
					$r_montoExtraA:=0
					
					  //GOTO RECORD([ACT_Avisos_de_Cobranza];$ptr1->)
					  //KRL_FindAndLoadRecordByIndex (->[xxACT_Items]ID;->vlACTcfg_SelectedItemAut)
					  //USE SET("setCargos")
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]ID_CuentaCorriente=$al_IdsCtas{$i})
					  //$vl_idCargo:=[ACT_Cargos]ID
					  //Case of 
					  //: (c_RecAutFijo=1)
					  //vrACT_MontoMulta:=[xxACT_Items]Monto
					  //
					  //: (c_RecAutPct=1)
					  //If (vr_PctMontoRecAut>0)
					  //$vt_monedaPago:=ST_GetWord (ACT_DivisaPais ;1;";")
					  //$vl_decimales:=Num(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaPago))
					  //
					  //If (cs_CargoAfectoSeparado=0)
					  //vrACT_MontoMulta:=ACTcfg_OpcionesRecargosAut ("CalculaMontoMultaPCT";->$vl_decimales;->$vt_monedaPago)
					  //Else 
					  //CREATE SET([ACT_Cargos];"setCargosMulta")
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]TasaIVA=0)
					  //vrACT_MontoMulta:=ACTcfg_OpcionesRecargosAut ("CalculaMontoMultaPCT";->$vl_decimales;->$vt_monedaPago)
					  //USE SET("setCargosMulta")
					  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]TasaIVA#0)
					  //vrACT_MontoMultaAfecta:=ACTcfg_OpcionesRecargosAut ("CalculaMontoMultaPCT";->$vl_decimales;->$vt_monedaPago)
					  //CLEAR SET("setCargosMulta")
					  //End if 
					  //Else 
					  //LOG_RegisterEvt ("El recargo automático no pudo ser generado porque se tiene configurado obtener el"+" m"+"onto desde un porcentaje pero el porcentaje no"+" fue ingresado o está en 0 en la configuración.")
					  //End if 
					  //End case 
					
					$vl_idCargo:=ACTra_RetornaMontos ($ptr1->;vlACTcfg_SelectedItemAut;$al_IdsCtas{$i};0;0)
					
					If ((vrACT_MontoMulta>0) | (vrACT_MontoMultaAfecta>0))
						$vb_mismoAviso:=True:C214
						$vl_idCtaCte:=$al_IdsCtas{$i}
						$vl_idTercero:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
						$vb_enBoleta:=False:C215
						$vb_esMulta:=(cs_GenerarMultaEnMismoAviso=0)
						
						$vl_contador:=0
						$vd_fecha:=[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5
						$vd_fecha2:=$vd_fecha
						$vbACT_Dia31:=Day of:C23($vd_fecha)=31  //si la fecha de venc del cargo es 31, los vencimientos seran el 31.
						  //While ($vd_fecha<Current date(*))
						  //200120613 RCH Para calcular multas a cierta fecha
						
						If ($vd_fecha#!00-00-00!)  //20150224 RCH En una base habian 2 avisos con fecha de vencimiento en 0-0-0
							
							While ($vd_fecha<$vd_fechaRec)
								$vl_contador:=$vl_contador+1
								$vt_ref:=String:C10(Year of:C25($vd_fecha);"0000")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Day of:C23($vd_fecha);"00")+ST_RigthChars (("0"*10)+String:C10($vl_idAviso);10)+ST_RigthChars (("0"*10)+String:C10($vl_idCtaCte);10)
								$vl_existe:=Find in field:C653([ACT_Cargos:173]Ref_AvisoMulta:53;$vt_ref)
								If ($vl_existe=-1)
									$vt_ref:=String:C10(Year of:C25($vd_fecha);"0000")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Day of:C23($vd_fecha);"00")+ST_RigthChars (("0"*10)+String:C10($vl_idAviso);10)
									$vl_existe:=Find in field:C653([ACT_Cargos:173]Ref_AvisoMulta:53;$vt_ref)
									If ($vl_existe=-1)
										$vt_ref:=String:C10(Year of:C25($vd_fecha);"0000")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Day of:C23($vd_fecha);"00")+ST_RigthChars (("0"*10)+String:C10($vl_idAviso);10)+ST_RigthChars (("0"*10)+String:C10($vl_idCtaCte);10)
									End if 
								End if 
								
								  //20100816 Cuando se pasa la primera vez, la variable 2 no cambiaba de valor y se creaba solo una multa. 
								If ($vl_existe=-1)
									$vt_ref:=String:C10(Year of:C25($vd_fecha2);"0000")+String:C10(Month of:C24($vd_fecha2);"00")+String:C10(Day of:C23($vd_fecha2);"00")+ST_RigthChars (("0"*10)+String:C10($vl_idAviso);10)+ST_RigthChars (("0"*10)+String:C10($vl_idCtaCte);10)
									$vl_existe:=Find in field:C653([ACT_Cargos:173]Ref_AvisoMulta:53;$vt_ref)
									If ($vl_contador=2)
										$vl_existe:=-1
									End if 
									If ($vl_existe=-1)
										$vt_ref:=String:C10(Year of:C25($vd_fecha2);"0000")+String:C10(Month of:C24($vd_fecha2);"00")+String:C10(Day of:C23($vd_fecha2);"00")+ST_RigthChars (("0"*10)+String:C10($vl_idAviso);10)
										$vl_existe:=Find in field:C653([ACT_Cargos:173]Ref_AvisoMulta:53;$vt_ref)
										If ($vl_contador=2)
											$vl_existe:=-1
										End if 
									End if 
									If ($vl_existe=-1)
										  //If (cs_GenerarMultaDia1=1)
										  //$vt_ref:=String(Year of($vd_fecha);"0000")+String(Month of($vd_fecha);"00")+String(Day of($vd_fecha);"00")+String($vl_idAviso)+String($vl_idCtaCte)
										  //Else 
										  //$vt_ref:=String(Year of($vd_fecha2);"0000")+String(Month of($vd_fecha2);"00")+String(Day of($vd_fecha2);"00")+String($vl_idAviso)+String($vl_idCtaCte)
										  //End if 
										$vt_ref:=String:C10(Year of:C25($vd_fecha);"0000")+String:C10(Month of:C24($vd_fecha);"00")+String:C10(Day of:C23($vd_fecha);"00")+ST_RigthChars (("0"*10)+String:C10($vl_idAviso);10)+ST_RigthChars (("0"*10)+String:C10($vl_idCtaCte);10)  //en el colegio madrid (mx) las referencias se creaban con la fecha del mes a pesar de que la coonfiguracion no estaba marcada la opcion de vencimiento el dia 1
										
										$vl_existe:=Find in field:C653([ACT_Cargos:173]Ref_AvisoMulta:53;$vt_ref)
										If ($vl_existe=-1)  //para asegurarme de que no exista la multa que creare
											$vb_continuar:=True:C214
											If (cs_maximoMultas=1)
												If ($vl_contador>vl_MultasMaximas)
													$vb_continuar:=False:C215
												End if 
											End if 
											
											  //20130806 RCH Cuando quedaba en 0 se calculaba nuevamente el monto de la multa
											  //$vl_existe:=0  //20130731 RCH para saber que hay multa
											
											If ($vb_continuar)
												
												If (ACTpgs_OpcionesCargosEliminados ("VerificaRecargoAutomatico";->$vt_ref)="1")  //20120710 RCH
													
													If (vrACT_MontoMulta>0)
														KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;$ptr2;True:C214)
														$vb_afecto:=[xxACT_Items:179]Afecto_IVA:12
														  //[xxACT_Items]Afecto_IVA:=False
														If (cs_GenerarMultaAfecta=1)
															[xxACT_Items:179]Afecto_IVA:12:=True:C214
														Else 
															[xxACT_Items:179]Afecto_IVA:12:=False:C215
														End if 
														SAVE RECORD:C53([xxACT_Items:179])
														
														  //20120611 RCH requerimiento Mackay
														If ((c_RecAutFijo=1) & (vrACT_recargoMulta1>0) & ($vl_contador=1))
															$vrACT_MontoMulta:=vrACT_MontoMulta+vrACT_recargoMulta1
														Else 
															$vrACT_MontoMulta:=vrACT_MontoMulta
														End if 
														
														  //$vl_recNumCargo:=ACTac_CreateCargoDocCargoImp (False;$ptr2->;vrACT_MontoMulta;$vd_FechaVencAvisoMulta;$vb_mismoAviso;$vl_idCtaCte;$vl_idApoderado;$vb_enBoleta;$vb_esMulta;$vl_idTercero;$vb_avisoXCta;$vl_idCargo)
														$vl_recNumCargo:=ACTac_CreateCargoDocCargoImp (False:C215;$ptr2->;$vrACT_MontoMulta;$vd_FechaVencAvisoMulta;$vb_mismoAviso;$vl_idCtaCte;$vl_idApoderado;$vb_enBoleta;$vb_esMulta;$vl_idTercero;$vb_avisoXCta;$vl_idCargo)
														APPEND TO ARRAY:C911(alACT_recNumNewC;$vl_recNumCargo)
														KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
														[ACT_Cargos:173]Ref_AvisoMulta:53:=$vt_ref
														  //20141003 RCH
														If (Size of array:C274($alACT_idRazonSocial)=1)
															[ACT_Cargos:173]ID_RazonSocial:57:=$alACT_idRazonSocial{1}
															[ACT_Cargos:173]RazonSocialAsociada:56:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$alACT_idRazonSocial{1};->[ACT_RazonesSociales:279]razon_social:2)
														End if 
														[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=$b_noIncluidEnDT  //20151210 RCH
														SAVE RECORD:C53([ACT_Cargos:173])
														
														  //20120724 RCH tareas fin de dia
														ACTeod_EjecutaTareas ("AgregaElemento";->[ACT_Cargos:173]ID_Apoderado:18;->[ACT_Cargos:173]ID_Tercero:54)
														
														KRL_UnloadReadOnly (->[ACT_Cargos:173])
														
														KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;$ptr2;True:C214)
														[xxACT_Items:179]Afecto_IVA:12:=$vb_afecto
														SAVE RECORD:C53([xxACT_Items:179])
														KRL_UnloadReadOnly (->[xxACT_Items:179])
														
														  //20130731 RCH 120832 EMA
														If ((cs_ConsiderarRecargo=1) & (c_RecAutPct=1))
															$r_montoExtraE:=$r_montoExtraE+$vrACT_MontoMulta
															ACTra_RetornaMontos ($ptr1->;vlACTcfg_SelectedItemAut;$al_IdsCtas{$i};$r_montoExtraE;0)
														End if 
														
													End if 
													
													If (vrACT_MontoMultaAfecta>0)
														KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;$ptr2;True:C214)
														$vb_afecto:=[xxACT_Items:179]Afecto_IVA:12
														[xxACT_Items:179]Afecto_IVA:12:=True:C214
														SAVE RECORD:C53([xxACT_Items:179])
														
														  //20120724 RCH requerimiento Mackay
														If ((c_RecAutFijo=1) & (vrACT_recargoMulta1>0) & ($vl_contador=1))
															$vrACT_MontoMulta:=vrACT_MontoMultaAfecta+vrACT_recargoMulta1
														Else 
															$vrACT_MontoMulta:=vrACT_MontoMultaAfecta
														End if 
														
														  //$vl_recNumCargo:=ACTac_CreateCargoDocCargoImp (False;$ptr2->;vrACT_MontoMultaAfecta;$vd_FechaVencAvisoMulta;$vb_mismoAviso;$vl_idCtaCte;$vl_idApoderado;$vb_enBoleta;$vb_esMulta;$vl_idTercero;$vb_avisoXCta;$vl_idCargo)
														$vl_recNumCargo:=ACTac_CreateCargoDocCargoImp (False:C215;$ptr2->;$vrACT_MontoMulta;$vd_FechaVencAvisoMulta;$vb_mismoAviso;$vl_idCtaCte;$vl_idApoderado;$vb_enBoleta;$vb_esMulta;$vl_idTercero;$vb_avisoXCta;$vl_idCargo)
														APPEND TO ARRAY:C911(alACT_recNumNewC;$vl_recNumCargo)
														KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
														[ACT_Cargos:173]Ref_AvisoMulta:53:=$vt_ref
														
														  //20141003 RCH
														If (Size of array:C274($alACT_idRazonSocial)=1)
															[ACT_Cargos:173]ID_RazonSocial:57:=$alACT_idRazonSocial{1}
															[ACT_Cargos:173]RazonSocialAsociada:56:=KRL_GetTextFieldData (->[ACT_RazonesSociales:279]id:1;->$alACT_idRazonSocial{1};->[ACT_RazonesSociales:279]razon_social:2)
														End if 
														[ACT_Cargos:173]No_Incluir_en_DocTrib:50:=$b_noIncluidEnDT  //20151210 RCH
														SAVE RECORD:C53([ACT_Cargos:173])
														
														  //20120724 RCH tareas fin de dia
														ACTeod_EjecutaTareas ("AgregaElemento";->[ACT_Cargos:173]ID_Apoderado:18;->[ACT_Cargos:173]ID_Tercero:54)
														
														KRL_UnloadReadOnly (->[ACT_Cargos:173])
														
														KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;$ptr2;True:C214)
														[xxACT_Items:179]Afecto_IVA:12:=$vb_afecto
														SAVE RECORD:C53([xxACT_Items:179])
														KRL_UnloadReadOnly (->[xxACT_Items:179])
														
														  //20130731 RCH 120832 EMA
														If ((cs_ConsiderarRecargo=1) & (c_RecAutPct=1))
															$r_montoExtraA:=$r_montoExtraA+$vrACT_MontoMulta
															ACTra_RetornaMontos ($ptr1->;vlACTcfg_SelectedItemAut;$al_IdsCtas{$i};0;$r_montoExtraA)
														End if 
													End if 
													
												End if 
												
											Else 
												$vd_fecha:=$vd_fechaRec
											End if 
										End if 
									End if 
									
								End if 
								
								  //20130731 RCH 120832 EMA
								If ((cs_ConsiderarRecargo=1) & (c_RecAutPct=1))
									If ($vl_existe#-1)
										GOTO RECORD:C242([ACT_Cargos:173];$vl_existe)
										$r_montoMulta:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
										If ([ACT_Cargos:173]TasaIVA:21=0)
											$r_montoExtraE:=$r_montoExtraE+$r_montoMulta
											ACTra_RetornaMontos ($ptr1->;vlACTcfg_SelectedItemAut;$al_IdsCtas{$i};$r_montoExtraE;0)
										Else 
											$r_montoExtraA:=$r_montoExtraA+$r_montoMulta
											ACTra_RetornaMontos ($ptr1->;vlACTcfg_SelectedItemAut;$al_IdsCtas{$i};0;$r_montoExtraA)
										End if 
									End if 
								End if 
								
								  //se setean variables con las 2 posibles configuraciones. Esto es para evitar que se genere un recargo para el dia 1 y otro para el dia despues del vencimiento.
								If (cs_GenerarMultaDia1=1)
									If ($vl_contador=1)
										$vd_fechaT:=$vd_fecha
										$vd_fecha:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24($vd_fecha);Year of:C25($vd_fecha));Month of:C24($vd_fecha);Year of:C25($vd_fecha))
										If (($vd_fechaT=$vd_fecha) & ($vbACT_Dia31))
											$vd_fecha:=Add to date:C393($vd_fecha;0;0;1)
											$vd_fecha:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24($vd_fecha);Year of:C25($vd_fecha));Month of:C24($vd_fecha);Year of:C25($vd_fecha))
											$vd_fecha2:=Add to date:C393($vd_fecha2;0;1;0)
										End if 
									Else 
										$vd_fecha:=Add to date:C393($vd_fecha;0;0;1)
										$vd_fecha:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24($vd_fecha);Year of:C25($vd_fecha));Month of:C24($vd_fecha);Year of:C25($vd_fecha))
										$vd_fecha2:=Add to date:C393($vd_fecha2;0;1;0)
										If ($vbACT_Dia31)
											$vd_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24($vd_fecha2);Year of:C25($vd_fecha2));Month of:C24($vd_fecha2);Year of:C25($vd_fecha2))  //me aseguro de que la fecha sea el ultimo dia del mes. Para un aviso vencido en marzo, la fecha de mayo era 20100530...
										End if 
									End if 
								Else 
									$vd_fecha:=Add to date:C393($vd_fecha;0;1;0)
									If ($vbACT_Dia31)
										$vd_fecha:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24($vd_fecha);Year of:C25($vd_fecha));Month of:C24($vd_fecha);Year of:C25($vd_fecha))  //me aseguro de que la fecha sea el ultimo dia del mes. Para un aviso vencido en marzo, la fecha de mayo era 20100530...
									End if 
									
									If ($vl_contador=1)
										$vd_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24($vd_fecha);Year of:C25($vd_fecha));Month of:C24($vd_fecha);Year of:C25($vd_fecha))
									Else 
										$vd_fecha2:=Add to date:C393($vd_fecha2;0;0;1)
										$vd_fecha2:=DT_GetDateFromDayMonthYear (DT_GetLastDay (Month of:C24($vd_fecha2);Year of:C25($vd_fecha2));Month of:C24($vd_fecha2);Year of:C25($vd_fecha2))
									End if 
								End if 
							End while 
							
						Else 
							C_LONGINT:C283($l_idCta;$l_idAl)
							$l_idCta:=$al_IdsCtas{$i}
							$l_idAl:=KRL_GetNumericFieldData (->[ACT_CuentasCorrientes:175]ID:1;->$l_idCta;->[ACT_CuentasCorrientes:175]ID_Alumno:3)
							LOG_RegisterEvt ("El recargo automático para el aviso número "+String:C10($vl_idAviso)+", para la cuenta: "+KRL_GetTextFieldData (->[Alumnos:2]numero:1;->$l_idAl;->[Alumnos:2]apellidos_y_nombres:40)+", no pudo ser generado porque la fecha de vencimiento no es válida.")
						End if 
						
					Else 
						LOG_RegisterEvt ("El recargo automático para el aviso número "+String:C10($vl_idAviso)+" no pudo ser generado porque el monto del movimiento no es m"+"ay"+"or a 0.")
					End if 
				End for 
				CLEAR SET:C117("setCargos")
			End if 
		End if 
		
	: ($vt_accion="CalculaMontoMultaPCT")
		C_REAL:C285($r_montoExtra)
		C_TEXT:C284($t_moneda)
		C_REAL:C285($r_decimales)
		$vl_decimales:=$ptr1->
		$vt_monedaPago:=$ptr2->
		
		$t_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		$r_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$t_moneda))
		
		$r_montoExtra:=$vy_pointer3->
		
		CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargosSinIVA")
		CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargosConIVA")
		
		If (cs_multaSobreMontoAfecto=1)  //si se calcula sobre el afecto separo los calculos de afectos y exentos a IVA
			CREATE SET:C116([ACT_Cargos:173];"setCargosSinIVA")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_IVA:20>0)
			CREATE SET:C116([ACT_Cargos:173];"setCargosConIVA")
			DIFFERENCE:C122("setCargosSinIVA";"setCargosConIVA";"setCargosSinIVA")
		Else 
			CREATE SET:C116([ACT_Cargos:173];"setCargosSinIVA")
		End if 
		
		If (Records in set:C195("setCargosSinIVA")>0)
			USE SET:C118("setCargosSinIVA")
			$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
			If ($vr_monto>0)  //se obtiene el monto menos los posibles descuentos asociados...
				ARRAY LONGINT:C221($alACT_idsCargos;0)
				READ ONLY:C145([ACT_Cargos:173])
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargos)
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$alACT_idsCargos)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16>=-135;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16<=-130)
				$vr_montoDescuento:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
				$vr_monto:=$vr_monto-$vr_montoDescuento
			End if 
			  //$vr_monto:=Round($vr_monto*(vr_PctMontoRecAut/100);$vl_decimales)
			$vr_monto:=Round:C94(($vr_monto+$r_montoExtra)*(vr_PctMontoRecAut/100);$vl_decimales)
			$vr_monto:=ACTut_retornaMontoEnMoneda ($vr_monto;$vt_monedaPago;Current date:C33(*);[xxACT_Items:179]Moneda:10)
			$vr_retorno:=$vr_monto
		End if 
		
		If (Records in set:C195("setCargosConIVA")>0)
			USE SET:C118("setCargosConIVA")
			  //se obtienen los montos totales cobrados
			$vr_monto:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*)))
			If ($vr_monto>0)
				  //se obtiene el monto menos los posibles descuentos asociados...
				ARRAY LONGINT:C221($alACT_idsCargos;0)
				READ ONLY:C145([ACT_Cargos:173])
				SELECTION TO ARRAY:C260([ACT_Cargos:173]ID:1;$alACT_idsCargos)
				QUERY WITH ARRAY:C644([ACT_Cargos:173]ID_CargoRelacionado:47;$alACT_idsCargos)
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16>=-135;*)
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Ref_Item:16<=-130)
				$vr_montoDescuento:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*)))
				$vr_monto:=$vr_monto-$vr_montoDescuento
			End if 
			
			  //se obtienen los montos pagados
			USE SET:C118("setCargosConIVA")
			$r_montosPagados:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)
			
			  //se obtienen la tasa IVA
			FIRST RECORD:C50([ACT_Cargos:173])
			$r_tasa:=[ACT_Cargos:173]TasaIVA:21
			$vr_monto:=$vr_monto-$r_montosPagados
			
			  //se calcula sobre el afecto
			$vr_monto:=Round:C94($vr_monto/(1+($r_tasa/100));$r_decimales)
			
			$vr_monto:=Round:C94(($vr_monto+$r_montoExtra)*(vr_PctMontoRecAut/100);$vl_decimales)
			$vr_monto:=ACTut_retornaMontoEnMoneda ($vr_monto;$vt_monedaPago;Current date:C33(*);[xxACT_Items:179]Moneda:10)
			$vr_retorno:=$vr_retorno+$vr_monto
		End if 
		
		SET_ClearSets ("setCargosSinIVA";"setCargosConIVA")
		
	: ($vt_accion="SeteaFiltroYFormatoCampoPct")
		$filter:="&"+ST_Qte ("0-9;"+<>tXS_RS_DecimalSeparator)
		OBJECT SET FILTER:C235($ptr1->;$filter)
		OBJECT SET FORMAT:C236($ptr1->;"###0"+<>tXS_RS_DecimalSeparator+"###")
		
	: ($vt_accion="ValidacionesForm")
		If (cbRecargoAut=1)
			_O_ENABLE BUTTON:C192(*;"multaAut@")
			OBJECT SET ENTERABLE:C238(*;"multaAut@";True:C214)
			If ((c_RecAutFijo=0) & (c_RecAutPct=0))
				c_RecAutFijo:=1
			End if 
			If (c_RecAutPct=1)
				OBJECT SET ENTERABLE:C238(vr_PctMontoRecAut;True:C214)
				OBJECT SET ENABLED:C1123(cs_ConsiderarRecargo;True:C214)
				OBJECT SET ENABLED:C1123(cs_multaSobreMontoAfecto;True:C214)
				_O_ENABLE BUTTON:C192(cs_CargoAfectoSeparado)
			Else 
				vr_PctMontoRecAut:=0
				cs_ConsiderarRecargo:=0
				cs_multaSobreMontoAfecto:=0
				OBJECT SET ENTERABLE:C238(vr_PctMontoRecAut;False:C215)
				OBJECT SET ENABLED:C1123(cs_ConsiderarRecargo;False:C215)
				OBJECT SET ENABLED:C1123(cs_multaSobreMontoAfecto;False:C215)
				_O_DISABLE BUTTON:C193(cs_CargoAfectoSeparado)
			End if 
			If (Size of array:C274(at_GlosasItems)=0)
				ACTcfg_OpcionesRecargosAut ("BuscaItemsADesplegar")
			End if 
			
			OBJECT SET ENTERABLE:C238(*;"multaAut16";False:C215)
			OBJECT SET ENTERABLE:C238(*;"multaAut17";False:C215)
			
		Else 
			_O_DISABLE BUTTON:C193(*;"multaAut@")
			OBJECT SET ENTERABLE:C238(*;"multaAut@";False:C215)
			ACTcfg_OpcionesRecargosAut ("InitVars")
		End if 
		If (vtACTcfg_SelectedItemAut="")
			vlACTcfg_SelectedItemAut:=0
		End if 
		If (c_RecAutPct=0)
			vr_PctMontoRecAut:=0
		End if 
		If (cs_maximoMultas=1)
			OBJECT SET ENTERABLE:C238(vl_MultasMaximas;True:C214)
		Else 
			vl_MultasMaximas:=0
			OBJECT SET ENTERABLE:C238(vl_MultasMaximas;False:C215)
		End if 
		OBJECT SET ENTERABLE:C238(*;"multaAut17";False:C215)
		
	: ($vt_accion="ValidaReferenciasCambioApdo")
		  //se usa cuando hay cambio de apoderado con creacion de aviso nuevo. Se actualizan las referencias
		C_LONGINT:C283($vl_newID;$vl_oldID;$i;$vl_recordsLocked)
		C_TEXT:C284($vt_referenciaFecha;$vt_idCta;$vt_referenciaIdAviso;$vt_referenciaIdCta)
		C_BOOLEAN:C305($vb_refTieneIDCta)
		ARRAY LONGINT:C221($alACT_recNumsCargos;0)
		
		$vl_newID:=$ptr1->
		
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Cargos:173])
		
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$vl_newID)
		KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumsCargos;"")
		
		For ($i;1;Size of array:C274($alACT_recNumsCargos))
			KRL_GotoRecord (->[ACT_Cargos:173];$alACT_recNumsCargos{$i};True:C214)
			If (ok=1)
				$vt_referenciaFecha:=Substring:C12([ACT_Cargos:173]Ref_AvisoMulta:53;1;8)
				$vt_idCta:=String:C10([ACT_Cargos:173]ID_CuentaCorriente:2)
				$vb_refTieneIDCta:=False:C215
				Case of 
					: (Length:C16([ACT_Cargos:173]Ref_AvisoMulta:53)=28)
						$vb_refTieneIDCta:=True:C214
					: (Length:C16([ACT_Cargos:173]Ref_AvisoMulta:53)>Length:C16($vt_referenciaFecha+$vt_idCta))
						$vb_refTieneIDCta:=True:C214
				End case 
				$vt_referenciaIdAviso:=ST_RigthChars (("0"*10)+String:C10($vl_newID);10)
				If ($vb_refTieneIDCta)
					$vt_referenciaIdCta:=ST_RigthChars (("0"*10)+$vt_idCta;10)
					[ACT_Cargos:173]Ref_AvisoMulta:53:=$vt_referenciaFecha+$vt_referenciaIdAviso+$vt_referenciaIdCta
				Else 
					[ACT_Cargos:173]Ref_AvisoMulta:53:=$vt_referenciaFecha+$vt_referenciaIdAviso
				End if 
				SAVE RECORD:C53([ACT_Cargos:173])
			Else 
				$i:=Size of array:C274($alACT_recNumsCargos)
				$vl_recordsLocked:=$vl_recordsLocked+1
			End if 
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		End for 
		$vr_retorno:=$vl_recordsLocked
		
	: ($vt_accion="ValidaReferenciasCambioConf")
		  //se usa cuando se cambia la preferencia emitir segunda multa desde dia 1
		
		C_LONGINT:C283($vl_idAviso;$vl_proc;$i)
		C_TEXT:C284($vt_referencia;$vt_referenciaOrg)
		C_DATE:C307($vd_fechaVencimientoOrg;$vd_referenciaFecha)
		C_LONGINT:C283($vl_mes;$vl_year;$vl_ultimoDia;$vl_dia)
		C_BOOLEAN:C305($vbACT_ultimoDia)
		
		ARRAY LONGINT:C221($alACT_idsCargos;0)
		ARRAY DATE:C224($adACT_fechasVencimiento;0)
		_O_ARRAY STRING:C218(80;$asACT_referencias;0)
		_O_ARRAY STRING:C218(80;$asACT_referenciasNuevas;0)
		ARRAY LONGINT:C221($alACT_idsCargos2Del;0)
		
		READ WRITE:C146([ACT_Cargos:173])
		READ ONLY:C145([ACT_Documentos_de_Cargo:174])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		READ ONLY:C145([ACT_Transacciones:178])
		
		If (Not:C34(Is nil pointer:C315($ptr1)))
			$vl_idAviso:=$ptr1->
		End if 
		
		$vl_proc:=IT_UThermometer (1;0;__ ("Buscando cargos.."))
		If ($vl_idAviso=0)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
		Else 
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=$vl_idAviso)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_AvisoMulta:53#"")
		End if 
		IT_UThermometer (0;$vl_proc;__ ("Actualizando referencias..."))
		
		SELECTION TO ARRAY:C260([ACT_Cargos:173]Ref_AvisoMulta:53;$asACT_referencias;[ACT_Cargos:173]Fecha_de_Vencimiento:7;$adACT_fechasVencimiento;[ACT_Cargos:173]ID:1;$alACT_idsCargos)
		
		For ($i;1;Size of array:C274($adACT_fechasVencimiento))
			$vt_referencia:=$asACT_referencias{$i}
			$vt_referenciaOrg:=$vt_referencia
			$vd_fechaVencimientoOrg:=$adACT_fechasVencimiento{$i}
			$vd_referenciaFecha:=DTS_GetDate (Substring:C12($vt_referencia;1;8))
			
			$vl_mes:=Month of:C24($vd_fechaVencimientoOrg)
			$vl_year:=Year of:C25($vd_fechaVencimientoOrg)
			$vl_ultimoDia:=DT_GetLastDay ($vl_mes;$vl_year)
			$vbACT_ultimoDia:=Day of:C23($vd_fechaVencimientoOrg)=$vl_ultimoDia
			
			$vl_mes:=Num:C11(Substring:C12($vt_referencia;5;2))
			$vl_year:=Num:C11(Substring:C12($vt_referencia;1;4))
			
			$vl_ultimoDia:=DT_GetLastDay ($vl_mes;$vl_year)
			Case of 
				: ($vd_referenciaFecha=$vd_fechaVencimientoOrg)
					  //si es el primer cargo se deja igual
				: (Month of:C24($vd_fechaVencimientoOrg)=$vl_mes)
					  //si es el segundo cargo o pirmero dentro del mismo mes se deja igual
				Else 
					If (cs_GenerarMultaDia1=1)
						  //se utiliza el ultimo dia
						$vl_dia:=$vl_ultimoDia
					Else 
						$vl_dia:=Day of:C23($vd_fechaVencimientoOrg)
						If ($vl_dia>$vl_ultimoDia)
							$vl_dia:=$vl_ultimoDia
						End if 
					End if 
					If ($vbACT_ultimoDia)
						$vl_dia:=$vl_ultimoDia
					End if 
					$vt_referencia:=Substring:C12($vt_referencia;1;6)+String:C10($vl_dia;"00")+Substring:C12($vt_referencia;9;Length:C16($vt_referencia))
			End case 
			APPEND TO ARRAY:C911($asACT_referenciasNuevas;$vt_referencia)
			
			  //se obtiene la fecha de referencia de la multa. Si es superior a la fecha actual se intentara eliminar. Caso: multa generada el dia 1 y cambio en conf a dia de vencimiento (ejemplo dia 10) y la fecha actual es 5.
			$vd_referenciaFecha:=DTS_GetDate (Substring:C12($vt_referencia;1;8))
			If ($vd_referenciaFecha>Current date:C33(*))
				APPEND TO ARRAY:C911($alACT_idsCargos2Del;$alACT_idsCargos{$i})
			End if 
			
			  //si se desmarca cs_GenerarMultaDia1, podria existir una multa generada para el ultimo dia del mes, dentro del primer mes de cobro. esa multa se intentara eliminar.
			If (cs_GenerarMultaDia1=0)
				If (Substring:C12($vt_referenciaOrg;1;6)=(String:C10(Year of:C25($vd_fechaVencimientoOrg);"0000")+String:C10(Month of:C24($vd_fechaVencimientoOrg);"00")))
					If ($vd_referenciaFecha#$vd_fechaVencimientoOrg)
						APPEND TO ARRAY:C911($alACT_idsCargos2Del;$alACT_idsCargos{$i})
					End if 
				End if 
			End if 
			
		End for 
		
		For ($i;Size of array:C274($alACT_idsCargos);1;-1)
			If ($asACT_referencias{$i}=$asACT_referenciasNuevas{$i})
				AT_Delete ($i;1;->$alACT_idsCargos;->$adACT_fechasVencimiento;->$asACT_referencias;->$asACT_referenciasNuevas)
			End if 
		End for 
		
		IT_UThermometer (0;$vl_proc;__ ("Guardando datos..."))
		SORT ARRAY:C229($alACT_idsCargos;$adACT_fechasVencimiento;$asACT_referencias;$asACT_referenciasNuevas;>)
		
		QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$alACT_idsCargos)
		ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID:1;>)
		
		ARRAY TO SELECTION:C261($asACT_referenciasNuevas;[ACT_Cargos:173]Ref_AvisoMulta:53)
		
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		
		If (Size of array:C274($alACT_idsCargos2Del)>0)
			IT_UThermometer (0;$vl_proc;__ ("Verificando recargos..."))
			AT_DistinctsArrayValues (->$alACT_idsCargos2Del)
			QUERY WITH ARRAY:C644([ACT_Cargos:173]ID:1;$alACT_idsCargos2Del)
			CREATE SET:C116([ACT_Cargos:173];"setCargo2Delete")
			
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9#0)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"setCargoEnBoleta")
			
			DIFFERENCE:C122("setCargo2Delete";"setCargoEnBoleta";"setCargo2Delete")
			
			USE SET:C118("setCargo2Delete")
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
			QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30#0)
			KRL_RelateSelection (->[ACT_Transacciones:178]No_Comprobante:10;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			CREATE SET:C116([ACT_Cargos:173];"setCargoEnPagare")
			DIFFERENCE:C122("setCargo2Delete";"setCargoEnPagare";"setCargo2Delete")
			
			READ WRITE:C146([ACT_Cargos:173])
			USE SET:C118("setCargo2Delete")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]MontosPagados:8=0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			ARRAY LONGINT:C221($alACT_recNumsAvisos;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAvisos;"")
			IT_UThermometer (0;$vl_proc;__ ("Eliminando recargos no pagados. Eliminando cargos.."))
			ACTcc_EliminaCargosLoop 
			IT_UThermometer (0;$vl_proc;__ ("Eliminando recargos no pagados. Recalculando avisos.."))
			ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumsAvisos)
			SET_ClearSets ("setCargo2Delete";"setCargoEnBoleta";"setCargoEnPagare";"setCargoEnBoletas")
		End if 
		PREF_Set (0;"ACT_EliminaRecargosAut";"0")
		LOG_RegisterEvt ("Verificación de referencias de recargos automáticos por cambio de configuración.")
		IT_UThermometer (-2;$vl_proc)
		
	: ($vt_accion="LimpiaPrimerRecargoAlCambioItem")
		If ((vlACTcfg_SelectedItemAut_2#0) & (vlACTcfg_SelectedItemAut_2#vlACTcfg_SelectedItemAut))
			vlACTcfg_SelectedItemAut_2:=vlACTcfg_SelectedItemAut
			If (vrACT_recargoMulta1#0)
				vrACT_recargoMulta1:=0
				CD_Dlog (0;__ ("El recargo para la primera multa se deberá reconfigurar."))
			End if 
		End if 
		
	: ($vt_accion="ObtieneDTSFecha")
		$ptr1->:=DTS_MakeFromDateTime (!2008-01-01!)
		
		
End case 

$0:=$vr_retorno