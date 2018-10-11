//%attributes = {}
  //ACTitems_OpcionesRecalculoTramo

C_TEXT:C284($vt_accion;$vt_retorno;$0)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1;$vy_pointer2;$vy_pointer3;$vy_pointer4)
C_DATE:C307($vd_fechaCalculo)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
If (Count parameters:C259>=3)
	$vy_pointer2:=$3
End if 
If (Count parameters:C259>=4)
	$vy_pointer3:=$4
End if 
If (Count parameters:C259>=5)
	$vy_pointer4:=$5
End if 
Case of 
	: ($vt_accion="BuscaItemsUtilizaTramo")
		READ ONLY:C145([xxACT_Items:179])
		READ ONLY:C145([xxACT_ItemsTramos:291])
		AT_Initialize ($vy_pointer1)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Utiliza_tramos:38=True:C214)
		If (Records in selection:C76([xxACT_Items:179])>0)
			KRL_RelateSelection (->[xxACT_ItemsTramos:291]id_item_de_cargo:2;->[xxACT_Items:179]ID:1;"")
			QUERY SELECTION:C341([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]valor:6#0)
			If (Records in selection:C76([xxACT_ItemsTramos:291])>0)
				KRL_RelateSelection (->[xxACT_Items:179]ID:1;->[xxACT_ItemsTramos:291]id_item_de_cargo:2;"")
				SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;$vy_pointer1->)
				$vt_retorno:="1"
			Else 
				$vt_retorno:="0"
			End if 
		Else 
			$vt_retorno:="0"
		End if 
		
	: ($vt_accion="CalculaMontosTareasFinDeDia")
		If (ACT_AccountTrackInicializado )
			C_LONGINT:C283($i)
			ARRAY LONGINT:C221($alACT_numAviso;0)
			ARRAY LONGINT:C221($alACT_recNumAviso;0)
			ARRAY LONGINT:C221($alACT_idsItemsTramos;0)
			ARRAY LONGINT:C221(alACT_idTramo;0)
			
			READ ONLY:C145([xxACT_Items:179])
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			READ ONLY:C145([ACT_Cargos:173])
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			
			$vd_fechaCalculo:=$vy_pointer1->
			ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
			ACTcfg_LeeBlob ("ACT_DescuentosFamilia")
			
			If (ACTitems_OpcionesRecalculoTramo ("BuscaItemsUtilizaTramo";->$alACT_idsItemsTramos)="1")
				
				KRL_RelateSelection (->[ACT_Cargos:173]Ref_Item:16;->[xxACT_Items:179]ID:1;"")
				QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22<=$vd_fechaCalculo)
				
				  //20150604 RCH Se estaban creando multas para cargos proyectados
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
				
				ACTitems_OpcionesRecalculoTramo ("CalculaMultaParaCargos";->$vd_fechaCalculo)
				
				  //20130705 RCH
				AT_Initialize (->alACT_recNumNewC;->alACT_recNumDelC)
			End if 
			
			  //End if 
		End if 
		
	: ($vt_accion="CalculaMultaParaCargos")
		ARRAY LONGINT:C221($alACT_recNumNewC;0)
		ARRAY LONGINT:C221($alACT_recNumDelC;0)
		ARRAY LONGINT:C221(alACT_recNumNewC;0)
		ARRAY LONGINT:C221(alACT_recNumDelC;0)
		C_BOOLEAN:C305(vbACT_TramoItemIngPago)
		
		$vd_fechaCalculo:=$vy_pointer1->
		
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_RecargoTramo:63="";*)
		QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
		  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]Saldo#0;*)
		  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]fecha_ultimo_calculo_tramos#$vd_fechaCalculo)
		  //QUERY SELECTION([ACT_Cargos]; & ;[ACT_Cargos]FechaEmision<=$vd_fechaCalculo)
		
		ARRAY LONGINT:C221($alACT_recNumCargo;0)
		ARRAY LONGINT:C221($alACT_idApdo;0)
		ARRAY LONGINT:C221($alACT_idCta;0)
		ARRAY LONGINT:C221($alACT_recNumAviso2Recalc;0)
		ARRAY LONGINT:C221($alACT_idDocCargo;0)
		ORDER BY:C49([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18;>;[ACT_Cargos:173]ID_CuentaCorriente:2;>;[ACT_Cargos:173]Ref_Item:16;>)
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$alACT_recNumCargo;[ACT_Cargos:173]ID_Apoderado:18;$alACT_idApdo;[ACT_Cargos:173]ID_CuentaCorriente:2;$alACT_idCta;[ACT_Cargos:173]ID_Documento_de_Cargo:3;$alACT_idDocCargo)
		
		If (Size of array:C274($alACT_recNumCargo)>0)
			If (bAvisoApoderado=1)
				$vt_refAviso:=String:C10($alACT_idApdo{1})
			Else 
				$vt_refAviso:=String:C10($alACT_idApdo{1})+"."+String:C10($alACT_idCta{1})
			End if 
			If (Not:C34(vbACT_TramoItemIngPago))
				$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;"Verificando montos de ítems...")
			End if 
			For ($i;1;Size of array:C274($alACT_recNumCargo))
				$vt_retorno:=ACTitems_OpcionesRecalculoTramo ("CalculaMultaParaCargo";->$alACT_recNumCargo{$i};->$vd_fechaCalculo)
				If ($vt_retorno="1")
					$vl_no_Comprobante:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$alACT_idDocCargo{$i};->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
					$vl_index:=Find in field:C653([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;$vl_no_Comprobante)
					If ($vl_index#-1)
						APPEND TO ARRAY:C911($alACT_recNumAviso2Recalc;$vl_index)
					End if 
				End if 
				
				If (bAvisoApoderado=1)
					$vt_refAviso2:=String:C10($alACT_idApdo{$i})
				Else 
					$vt_refAviso2:=String:C10($alACT_idApdo{$i})+"."+String:C10($alACT_idCta{$i})
				End if 
				If (($vt_refAviso#$vt_refAviso2) | ($i=Size of array:C274($alACT_recNumCargo)))
					  //recalculo avisos
					For ($j;1;Size of array:C274($alACT_recNumAviso2Recalc))
						ACTac_Recalcular ($alACT_recNumAviso2Recalc{$j})
					End for 
					  //esto se hace en las tareas de fin de dia
					  //ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumAviso2Recalc)
					AT_Initialize (->$alACT_recNumAviso2Recalc)
					If (bAvisoApoderado=1)
						$vt_refAviso:=String:C10($alACT_idApdo{$i})
					Else 
						$vt_refAviso:=String:C10($alACT_idApdo{$i})+"."+String:C10($alACT_idCta{$i})
					End if 
				End if 
				
				  //para ingreso de pagos
				For ($j;1;Size of array:C274(alACT_recNumNewC))
					If (alACT_recNumNewC{$j}>=0)
						APPEND TO ARRAY:C911($alACT_recNumNewC;alACT_recNumNewC{$j})
					End if 
				End for 
				For ($j;1;Size of array:C274(alACT_recNumDelC))
					If (alACT_recNumDelC{$j}>=0)
						APPEND TO ARRAY:C911($alACT_recNumDelC;alACT_recNumDelC{$j})
					End if 
				End for 
				
				  //$vt_retorno:=ACTitems_OpcionesRecalculoTramo ("CalculaMultaParaAviso";->$alACT_numAviso{$i};->$vd_fechaCalculo;->$alACT_idsItemsTramos)
				If (Not:C34(vbACT_TramoItemIngPago))
					$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNumCargo))
				End if 
			End for 
			If (Not:C34(vbACT_TramoItemIngPago))
				$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
			End if 
			
			  //almacenana nuevos cargos y cargos eliminados
			AT_DistinctsArrayValues (->$alACT_recNumNewC)
			AT_DistinctsArrayValues (->$alACT_recNumDelC)
			COPY ARRAY:C226($alACT_recNumNewC;alACT_recNumNewC)
			COPY ARRAY:C226($alACT_recNumDelC;alACT_recNumDelC)
			
		End if 
		
	: ($vt_accion="BuscaTramoItem")
		C_LONGINT:C283(vlACT_itemTramo;$vlACT_itemTramo)
		$vlACT_itemTramo:=$vy_pointer1->
		If (vlACT_itemTramo#$vlACT_itemTramo)
			vlACT_itemTramo:=$vlACT_itemTramo
			ARRAY LONGINT:C221(alACT_idTramo;0)
			READ ONLY:C145([xxACT_ItemsTramos:291])
			QUERY:C277([xxACT_ItemsTramos:291];[xxACT_ItemsTramos:291]id_item_de_cargo:2=vlACT_itemTramo;*)
			QUERY:C277([xxACT_ItemsTramos:291]; & ;[xxACT_ItemsTramos:291]valor:6#0)
			  //SELECTION TO ARRAY([xxACT_ItemsTramos]id;$alACT_idTramo)
			SELECTION TO ARRAY:C260([xxACT_ItemsTramos:291]id:1;alACT_idTramo)
		End if 
		
	: ($vt_accion="CalculaMultaParaCargo")
		ARRAY LONGINT:C221($alACT_idsItemsTramos;0)
		ARRAY LONGINT:C221($alACT_idsItemsTramosAviso;0)
		C_LONGINT:C283($vl_recNumCargo)
		C_DATE:C307($vd_fechaCalculo;$vd_lastRecalc)
		C_TEXT:C284($vt_textoDescto)
		C_LONGINT:C283($vl_existeTexto)
		ARRAY LONGINT:C221($alACT_recNumNewAC;0)
		ARRAY LONGINT:C221($alACT_recNumNewDC;0)
		ARRAY LONGINT:C221(alACT_recNumNewC;0)
		ARRAY LONGINT:C221(alACT_recNumDelC;0)
		
		$vl_recNumCargo:=$vy_pointer1->
		$vd_fechaCalculo:=$vy_pointer2->
		KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
		
		If (ok=1)
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
			$vl_idAviso:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
			$vl_idAvisoCta:=[ACT_Avisos_de_Cobranza:124]ID_CuentaCorrriente:2
			$vl_idPagare:=[ACT_Avisos_de_Cobranza:124]ID_Pagare:30
			
			If ($vl_idAviso=7781)
				
			End if 
			
			$vl_idCargo:=[ACT_Cargos:173]ID:1
			$vl_refItem:=[ACT_Cargos:173]Ref_Item:16
			$vb_emitidoEnMonedaCargo:=[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11
			$vd_FechaVencAvisoMulta:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
			  //$vl_mes:=[ACT_Cargos]Mes
			  //$vl_year:=[ACT_Cargos]Año
			$vl_mes:=Month of:C24($vd_FechaVencAvisoMulta)
			$vl_year:=Year of:C25($vd_FechaVencAvisoMulta)
			
			If ($vb_emitidoEnMonedaCargo)
				$vt_moneda:=[ACT_Cargos:173]Moneda:28
			Else 
				$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
			End if 
			$vd_fechaCalCargo:=[ACT_Cargos:173]FechaMonedaVariable:61
			$vr_montoNetoCargo:=[ACT_Cargos:173]Monto_Neto:5
			$vlACT_idDocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
			
			ACTitems_OpcionesRecalculoTramo ("BuscaTramoItem";->$vl_refItem)
			
			For ($j;1;Size of array:C274(alACT_idTramo))
				KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
				$vl_idTramo:=alACT_idTramo{$j}
				REDUCE SELECTION:C351([xxACT_ItemsTramos:291];0)
				KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsTramos:291]id:1;->$vl_idTramo)
				
				  //20150909 RCH Soportamos el dia 0 para que se calculen las multas
				  //$vd_fecha1Tramo:=DT_GetDateFromDayMonthYear ([xxACT_ItemsTramos]dia_tramo_desde;$vl_mes;$vl_year)
				If ([xxACT_ItemsTramos:291]dia_tramo_desde:3>0)
					$vd_fecha1Tramo:=DT_GetDateFromDayMonthYear ([xxACT_ItemsTramos:291]dia_tramo_desde:3;$vl_mes;$vl_year)
				Else 
					$vd_fecha1Tramo:=$vd_fechaCalculo  //20150909 RCH SI se deja 0 se calcula siempre el tramo.
				End if 
				
				$vt_llave:=ACTitems_OpcionesRecalculoTramo ("ObtieneLlave";->$vl_idAviso;->$vl_idCargo;->$vl_idTramo)
				
				$vl_existe:=Find in field:C653([ACT_Cargos:173]Ref_RecargoTramo:63;$vt_llave)
				If ($vd_fecha1Tramo<=$vd_fechaCalculo)
					If ($vl_existe=-1)
						  //$vt_monedaItem:=KRL_GetTextFieldData ([xxACT_Items]ID;->[xxACT_ItemsTramos]id_item_de_cargo;->[xxACT_Items]Moneda)
						
						If (ACTpgs_OpcionesCargosEliminados ("VerificaRecargoTramo";->$vt_llave)="1")  //20120710 RCH
							
							$vr_monto:=0
							  //If ($vb_emitidoEnMonedaCargo)
							  //If ([xxACT_ItemsTramos]es_monto_fijo)
							  //$vr_monto:=[xxACT_ItemsTramos]valor
							  //Else 
							  //  ///20150311 JVP se hace cambio para que aplique el tramo al valor previamente descontado
							  //  ////////cargo el item para verificar la configuracion
							  //QUERY([xxACT_Items];[xxACT_Items]ID=[ACT_Cargos]Ref_Item)
							
							  //If ([xxACT_Items]Tramo_desc_sobre_desc)
							  //$vr_montototaldesc:=[ACT_Cargos]Total_Desctos
							  //QUERY([ACT_Cargos];[ACT_Cargos]ID_CargoRelacionado=[ACT_Cargos]ID)
							  //QUERY SELECTION([ACT_Cargos];[ACT_Cargos]Ref_Item=-131;*)
							  //QUERY SELECTION([ACT_Cargos]; | ;[ACT_Cargos]Ref_Item=-132;*)
							  //QUERY SELECTION([ACT_Cargos]; | ;[ACT_Cargos]Ref_Item=-133;*)
							  //QUERY SELECTION([ACT_Cargos]; | ;[ACT_Cargos]Ref_Item=-130;*)
							  //QUERY SELECTION([ACT_Cargos]; | ;[ACT_Cargos]Ref_Item=-134)
							  //  //para guardar los montos de descuentos.
							  //$vr_montototaldesc:=$vr_montototaldesc+Abs(Sum([ACT_Cargos]Monto_Neto))
							  //KRL_GotoRecord (->[ACT_Cargos];$vl_recNumCargo;True)
							
							  //If (([xxACT_Items]utiliza_saldo) & ([ACT_Cargos]MontosPagados#0) & ([ACT_Cargos]Saldo#0))
							  //$vr_monto:=Round(Abs([ACT_Cargos]Saldo)*([xxACT_ItemsTramos]valor/100);Num(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
							  //Else 
							  //$vr_monto:=Round($vr_montoNetoCargo-$vr_montototaldesc*([xxACT_ItemsTramos]valor/100);Num(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
							  //KRL_GotoRecord (->[ACT_Cargos];$vl_recNumCargo;True)
							  //End if 
							  //Else 
							  //If (([xxACT_Items]utiliza_saldo) & ([ACT_Cargos]MontosPagados#0) & ([ACT_Cargos]Saldo#0))
							  //$vr_monto:=Round(Abs([ACT_Cargos]Saldo)*([xxACT_ItemsTramos]valor/100);Num(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
							  //Else 
							  //$vr_monto:=Round($vr_montoNetoCargo*([xxACT_ItemsTramos]valor/100);Num(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
							  //End if 
							  //End if 
							
							
							  //End if 
							  //Else 
							  //If ($vd_fechaCalCargo=!00-00-00!)
							  //$vd_fechaCalCargo:=Current date(*)
							  //End if 
							  //$vr_valor:=ACTut_fValorDivisa ($vt_moneda;$vd_fechaCalCargo)
							  //If ([xxACT_ItemsTramos]es_monto_fijo)
							  //$vr_monto:=ACTut_retornaMontoEnMoneda ([xxACT_ItemsTramos]valor;$vt_moneda;$vd_fechaCalCargo;ST_GetWord (ACT_DivisaPais ;1;";"))
							  //Else 
							  //If (([xxACT_Items]utiliza_saldo) & ([ACT_Cargos]MontosPagados#0) & ([ACT_Cargos]Saldo#0))
							  //$vr_monto:=Round(Abs([ACT_Cargos]Saldo)*([xxACT_ItemsTramos]valor/100);Num(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
							  //Else 
							  //$vr_monto:=Round($vr_montoNetoCargo*([xxACT_ItemsTramos]valor/100);Num(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
							  //End if 
							  //End if 
							  //End if 
							$vr_monto:=Num:C11(ACTitems_OpcionesRecalculoTramo ("CalculaMontoTramoCargo"))  //ASM 20180703 Ticket 211123
							
							READ WRITE:C146([ACT_Documentos_de_Cargo:174])
							
							  //guarda fecha de calculo para filtro posterior
							  //[ACT_Cargos]fecha_ultimo_calculo_tramos:=$vd_fechaCalculo
							  //SAVE RECORD([ACT_Cargos])
							
							
							  //***** DUPLICA DOC CARGO *****
							REDUCE SELECTION:C351([ACT_Documentos_de_Cargo:174];0)
							KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->$vlACT_idDocCargo)
							DUPLICATE RECORD:C225([ACT_Documentos_de_Cargo:174])
							$vl_idDocCargo:=SQ_SeqNumber (->[ACT_Documentos_de_Cargo:174]ID_Documento:1)
							[ACT_Documentos_de_Cargo:174]Auto_UUID:26:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
							[ACT_Documentos_de_Cargo:174]ID_Documento:1:=$vl_idDocCargo
							[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15:=$vl_idAviso
							SAVE RECORD:C53([ACT_Documentos_de_Cargo:174])
							APPEND TO ARRAY:C911($alACT_recNumNewDC;Record number:C243([ACT_Documentos_de_Cargo:174]))
							  //***** DUPLICA DOC CARGO *****
							
							  //***** DUPLICA CARGO *****
							DUPLICATE RECORD:C225([ACT_Cargos:173])
							[ACT_Cargos:173]ID:1:=SQ_SeqNumber (->[ACT_Cargos:173]ID:1)
							[ACT_Cargos:173]Auto_UUID:66:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
							  //para utilizar el mismo texto que se asigna en actcc_calculamontoitem
							$vt_textoDescto:=ACTcar_OpcionesGenerales ("ObtieneTextoDescuento")
							$vl_existeTexto:=Position:C15($vt_textoDescto;[ACT_Cargos:173]Glosa:12)
							If ($vl_existeTexto>0)
								[ACT_Cargos:173]Glosa:12:=Substring:C12([ACT_Cargos:173]Glosa:12;1;$vl_existeTexto-1)
							End if 
							
							[ACT_Cargos:173]Monto_Neto:5:=$vr_monto
							[ACT_Cargos:173]Monto_Moneda:9:=[ACT_Cargos:173]Monto_Neto:5
							[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
							[ACT_Cargos:173]Monto_Tercero:55:=0
							[ACT_Cargos:173]Descuentos_Familia:26:=0
							[ACT_Cargos:173]Descuentos_Ingresos:25:=0
							[ACT_Cargos:173]Descuentos_Cargas:51:=0
							[ACT_Cargos:173]Descuentos_Individual:31:=0
							[ACT_Cargos:173]Descuentos_XItem:35:=0
							[ACT_Cargos:173]MontoXPctDescto:36:=0
							[ACT_Cargos:173]PctDescto_XItem:34:=0
							[ACT_Cargos:173]MontosPagados:8:=0
							[ACT_Cargos:173]MontosPagadosMPago:52:=0
							[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
							[ACT_Cargos:173]ID_Documento_de_Cargo:3:=$vl_idDocCargo
							If ([ACT_Cargos:173]TasaIVA:21#0)
								$vr_afecto:=[ACT_Cargos:173]Monto_Neto:5/<>vrACT_FactorIVA
								[ACT_Cargos:173]Monto_IVA:20:=Round:C94($vr_afecto*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_moneda)))
								[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
							End if 
							[ACT_Cargos:173]Ref_RecargoTramo:63:=$vt_llave
							[ACT_Cargos:173]Id_TramoItem:62:=$vl_idTramo
							[ACT_Cargos:173]Glosa:12:=ACTcfgit_OpcionesGenerales ("retornaGlosaParaTramoPorRefItem";->[ACT_Cargos:173]Ref_Item:16;->$j)  // Modificado por: Saul Ponce (02-10-2018) Ticket Nº 187484
							SAVE RECORD:C53([ACT_Cargos:173])
							
							APPEND TO ARRAY:C911(alACT_recNumNewC;Record number:C243([ACT_Cargos:173]))
							
							ACTeod_EjecutaTareas ("AgregaElemento";->[ACT_Cargos:173]ID_Apoderado:18;->[ACT_Terceros:138]Id:1)
							
							  //***** DUPLICA CARGO *****
							
							  //20121018 RCH INICIO Requerimiento descuentos a cargos por tramo
							KRL_FindAndLoadRecordByIndex (->[xxACT_ItemsTramos:291]id:1;->$vl_idTramo)
							REDUCE SELECTION:C351([xxACT_Items:179];0)
							KRL_FindAndLoadRecordByIndex (->[xxACT_Items:179]ID:1;->[xxACT_ItemsTramos:291]id_item_de_cargo:2)
							If ([xxACT_Items:179]Aplicar_desctos_tramos:40)
								C_REAL:C285($vr_numeroHijo;$vr_numeroCargas;$vr_descIndividual;$vr_tramoIngreso)
								C_REAL:C285($vr_descuento;$vr_desctoFijo;$vr_desctosPlata;$vr_desctoXItem)
								C_TEXT:C284($vt_monedaCargo)
								C_BOOLEAN:C305($vb_cargoRelacionado)
								C_LONGINT:C283($vl_recNumCargo2)
								
								READ ONLY:C145([ACT_CuentasCorrientes:175])
								READ ONLY:C145([Personas:7])
								READ ONLY:C145([xxACT_Items:179])
								READ WRITE:C146([ACT_Cargos:173])
								
								  //$vl_recNumCargo:=$1
								$vl_recNumCargo2:=alACT_recNumNewC{Size of array:C274(alACT_recNumNewC)}
								
								  //cargo ctas y apdos para cargar variables de num hijo y num carga
								GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo2)
								If ([ACT_Cargos:173]Monto_Neto:5>0)
									KRL_FindAndLoadRecordByIndex (->[ACT_CuentasCorrientes:175]ID:1;->[ACT_Cargos:173]ID_CuentaCorriente:2)
									KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Cargos:173]ID_Apoderado:18)
									
									  //obtengo moneda para calcular descuento
									$vt_monedaCargo:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
									  //carga vars descuentos item de cargo
									ACTdesc_OpcionesVariables ("DeclaraInitLee";->[ACT_Cargos:173]Ref_Item:16)
									  //valida variables descuentos
									ACTdesc_OpcionesVariables ("LeeValidaVariablesDescuentos";->$vr_numeroHijo;->$vr_numeroCargas;->$vr_descIndividual;->$vr_tramoIngreso)
									  ///calcula descuentos
									$vr_descuento:=ACTcar_CalculaDescuentos ($vr_numeroHijo;$vr_numeroCargas;$vr_descIndividual;$vr_tramoIngreso;$vt_monedaCargo;0)
									  //escribe texto glosa
									ACTdesc_OpcionesVariables ("AsignaTextoDescuento";->$vr_descuento;->$vr_desctoFijo;->$vr_desctosPlata)
									  //calcula montos
									ACTcar_OpcionesGenerales ("CalculaMontosCargo";->$vt_monedaCargo;->$vr_descuento;->$vr_desctoXItem)
									  //calcula total descuento
									ACTcar_OpcionesGenerales ("CalculaTotalDescuento";->$vr_desctoXItem)
									[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
									SAVE RECORD:C53([ACT_Cargos:173])
									
									  //verifica si descuento se genera en lineas separadas
									If (cbCrearDctosEnLineasSeparadas=1)
										
										  // Modificado por: Saúl Ponce (30/01/2018) Nº 192927, Añadí un 4to parámetro para almacenar en el array el RN de los cargos. 
										  // Este array se utiliza en el ingreso de pagos.
										  // ACTcc_CreaRecDctoMontoItem ($vl_recNumCargo2;$vr_desctoXItem;$vb_cargoRelacionado)
										ACTcc_CreaRecDctoMontoItem ($vl_recNumCargo2;$vr_desctoXItem;$vb_cargoRelacionado;->al_RecNumsCargos)
										
										READ WRITE:C146([ACT_Cargos:173])
										GOTO RECORD:C242([ACT_Cargos:173];$vl_recNumCargo2)
										QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=[ACT_Cargos:173]ID:1)
										ARRAY LONGINT:C221($alACT_recNumCargos;0)
										LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$alACT_recNumCargos;"")
										For ($i;1;Size of array:C274($alACT_recNumCargos))
											GOTO RECORD:C242([ACT_Cargos:173];$alACT_recNumCargos{$i})
											[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
											SAVE RECORD:C53([ACT_Cargos:173])
										End for 
									End if 
								End if 
								KRL_UnloadReadOnly (->[ACT_Cargos:173])
							End if 
							  //20121018 RCH FIN Requerimiento descuentos a cargos por tramo
							
							KRL_UnloadReadOnly (->[ACT_Cargos:173])
							KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
							
							$vt_retorno:="1"
							
						Else 
							$vt_retorno:="0"
						End if 
					End if 
				Else 
					If ($vl_existe#-1)
						
						  // Modificado por: Saúl Ponce (30/01/2018) Nº 192927, los cargos por tramos comparten la misma llave.
						  // En ocasiones no se eliminaban todos cargos generados por tramo, quedando incorrectos los montos en el ingreso de pagos.
						
						  //GOTO RECORD([ACT_Cargos];$vl_existe)
						  //SET QUERY DESTINATION(Into variable;$boleta)
						  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID;*)
						  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]No_Boleta#0)
						  //SET QUERY DESTINATION(Into current selection)
						
						  //SET QUERY DESTINATION(Into variable;$vl_pagos)
						  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID;*)
						  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago#0)
						  //SET QUERY DESTINATION(Into current selection)
						  //If (($vl_idPagare=0) & ($boleta=0) & ($vl_pagos=0))
						  //While (Not(End selection([ACT_Cargos])))
						  //APPEND TO ARRAY(alACT_recNumDelC;Record number([ACT_Cargos]))
						  //NEXT RECORD([ACT_Cargos])
						  //End while 
						  //ACTcc_EliminaCargosLoop 
						  //End if 
						  //$vt_retorno:="1"
						
						
						QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Ref_RecargoTramo:63=$vt_llave)
						SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNumCargos)
						For ($r;1;Size of array:C274($al_recNumCargos))
							
							KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCargos{$r};True:C214)
							
							If (Records in selection:C76([ACT_Cargos:173])=1)
								
								SET QUERY DESTINATION:C396(Into variable:K19:4;$boleta)
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
								QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								
								SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_pagos)
								QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
								QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
								If (($vl_idPagare=0) & ($boleta=0) & ($vl_pagos=0))
									While (Not:C34(End selection:C36([ACT_Cargos:173])))
										APPEND TO ARRAY:C911(alACT_recNumDelC;Record number:C243([ACT_Cargos:173]))
										NEXT RECORD:C51([ACT_Cargos:173])
									End while 
									ACTcc_EliminaCargosLoop 
								End if 
							End if 
							
							
						End for 
						
						$vt_retorno:="1"
						
					End if 
				End if 
			End for 
			
			
			  //recalculo documento de cargo
			For ($i;1;Size of array:C274($alACT_recNumNewDC))
				ACTcc_CalculaDocumentoCargo ($alACT_recNumNewDC{$i})
			End for 
			
		Else 
			$vt_retorno:="0"
		End if 
		  //End if 
		
		  //: ($vt_accion="GetPreferenciaCalculoTramosAviso")
		  //C_TEXT($vt_prefName)
		  //$vd_fecha:=!00-00-00!
		  //$vt_prefName:=ACTitems_OpcionesRecalculoTramo ("GetNamePreferenciaCalculoTramosAvisos")
		  //$vt_retorno:=PREF_fGet (0;$vt_prefName;DTS_MakeFromDateTime ($vd_fecha))
		  //
		  //: ($vt_accion="GetNamePreferenciaCalculoTramosAvisos")
		  //$vt_retorno:="ACT_FechaRecalcTramo"
		
	: ($vt_accion="ObtieneLlave")
		$vl_idAviso:=$vy_pointer1->
		$vl_idCargo:=$vy_pointer2->
		$vl_idTramo:=$vy_pointer3->
		$vt_retorno:=ST_RigthChars (("0")*10+String:C10($vl_idAviso);10)+ST_RigthChars (("0")*10+String:C10($vl_idCargo);10)+ST_RigthChars (("0")*10+String:C10($vl_idTramo);10)
		
	: ($vt_accion="CalculaDesdeIngresoDePagos")
		C_LONGINT:C283($vl_records)
		C_BOOLEAN:C305(vbACT_TramoItemIngPago)
		C_DATE:C307($vd_fecha)
		ARRAY LONGINT:C221($alACT_idsItemsTramos;0)
		  //20120710 RCH No se calculaban correctamente...
		  //ARRAY LONGINT(alACT_idTramo;0)
		
		vbACT_TramoItemIngPago:=True:C214
		
		READ ONLY:C145([xxACT_Items:179])
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
		QUERY:C277([xxACT_Items:179];[xxACT_Items:179]Utiliza_tramos:38=True:C214)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		  // si hay algún cargo configurado se ingresa y se calcula...
		If ($vl_records>0)
			
			If (ACTitems_OpcionesRecalculoTramo ("BuscaItemsUtilizaTramo";->$alACT_idsItemsTramos)="1")
				
				$vd_fecha:=$vy_pointer2->
				READ ONLY:C145([ACT_Cargos:173])
				CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$vy_pointer1->;"")
				QUERY SELECTION WITH ARRAY:C1050([ACT_Cargos:173]Ref_Item:16;$alACT_idsItemsTramos)
				
				ACTitems_OpcionesRecalculoTramo ("CalculaMultaParaCargos";->$vd_fecha)
				
				For ($i;1;Size of array:C274(alACT_recNumNewC))
					If (Find in array:C230(al_RecNumsCargos;alACT_recNumNewC{$i})=-1)
						APPEND TO ARRAY:C911(al_RecNumsCargos;alACT_recNumNewC{$i})
					End if 
				End for 
				
				For ($i;1;Size of array:C274(alACT_recNumDelC))
					$vl_existe:=Find in array:C230(al_RecNumsCargos;alACT_recNumDelC{$i})
					If ($vl_existe#-1)
						AT_Delete ($vl_existe;1;->al_RecNumsCargos)
					End if 
				End for 
				
				AT_Initialize (->alACT_recNumNewC;->alACT_recNumDelC)
				
			End if 
		End if 
		vbACT_TramoItemIngPago:=False:C215
		
		$vr_monto:=0
		$vr_montototaldesc:=0
		$vd_fechaCalCargo:=[ACT_Cargos:173]FechaMonedaVariable:61
		$vr_montoNetoCargo:=[ACT_Cargos:173]Monto_Neto:5
		$vlACT_idDocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
		
		$vl_idCargo:=[ACT_Cargos:173]ID:1
		$vl_refItem:=[ACT_Cargos:173]Ref_Item:16
		$vb_emitidoEnMonedaCargo:=[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11
		$vd_FechaVencAvisoMulta:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
		
		$vl_mes:=Month of:C24($vd_FechaVencAvisoMulta)
		$vl_year:=Year of:C25($vd_FechaVencAvisoMulta)
		
		If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
			$vt_moneda:=[ACT_Cargos:173]Moneda:28
		Else 
			$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		End if 
		
		If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
			If ([xxACT_ItemsTramos:291]es_monto_fijo:5)
				$vr_monto:=[xxACT_ItemsTramos:291]valor:6
			Else 
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
				
				If ([xxACT_Items:179]Tramo_desc_sobre_desc:47)
					$vr_montototaldesc:=[ACT_Cargos:173]Total_Desctos:45
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=[ACT_Cargos:173]ID:1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-131;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-132;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-133;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-130;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-134)
					  //para guardar los montos de descuentos.
					$vr_montototaldesc:=$vr_montototaldesc+Abs:C99(Sum:C1([ACT_Cargos:173]Monto_Neto:5))
					KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
					
					If (([xxACT_Items:179]utiliza_saldo:49) & ([ACT_Cargos:173]MontosPagados:8#0) & ([ACT_Cargos:173]Saldo:23#0))
						$vr_monto:=Round:C94(Abs:C99([ACT_Cargos:173]Saldo:23)*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
					Else 
						$vr_monto:=Round:C94($vr_montoNetoCargo-$vr_montototaldesc*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
						KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
					End if 
				Else 
					If (([xxACT_Items:179]utiliza_saldo:49) & ([ACT_Cargos:173]MontosPagados:8#0) & ([ACT_Cargos:173]Saldo:23#0))
						$vr_monto:=Round:C94(Abs:C99([ACT_Cargos:173]Saldo:23)*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
					Else 
						$vr_monto:=Round:C94($vr_montoNetoCargo*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
					End if 
				End if 
				
				
			End if 
		Else 
			If ($vd_fechaCalCargo=!00-00-00!)
				$vd_fechaCalCargo:=Current date:C33(*)
			End if 
			$vr_valor:=ACTut_fValorDivisa ($vt_moneda;$vd_fechaCalCargo)
			If ([xxACT_ItemsTramos:291]es_monto_fijo:5)
				$vr_monto:=ACTut_retornaMontoEnMoneda ([xxACT_ItemsTramos:291]valor:6;$vt_moneda;$vd_fechaCalCargo;ST_GetWord (ACT_DivisaPais ;1;";"))
			Else 
				If (([xxACT_Items:179]utiliza_saldo:49) & ([ACT_Cargos:173]MontosPagados:8#0) & ([ACT_Cargos:173]Saldo:23#0))
					$vr_monto:=Round:C94(Abs:C99([ACT_Cargos:173]Saldo:23)*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
				Else 
					$vr_monto:=Round:C94($vr_montoNetoCargo*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
				End if 
			End if 
		End if 
		
		$vt_retorno:=String:C10($vr_monto)
		
	: ($vt_accion="CalculaMontoTramoCargo")
		
		$vd_fechaCalCargo:=[ACT_Cargos:173]FechaMonedaVariable:61
		$vr_montoNetoCargo:=[ACT_Cargos:173]Monto_Neto:5
		$vlACT_idDocCargo:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
		
		$vl_idCargo:=[ACT_Cargos:173]ID:1
		$vl_refItem:=[ACT_Cargos:173]Ref_Item:16
		$vb_emitidoEnMonedaCargo:=[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11
		$vd_FechaVencAvisoMulta:=[ACT_Cargos:173]Fecha_de_Vencimiento:7
		
		$vl_mes:=Month of:C24($vd_FechaVencAvisoMulta)
		$vl_year:=Year of:C25($vd_FechaVencAvisoMulta)
		
		If ($vb_emitidoEnMonedaCargo)
			$vt_moneda:=[ACT_Cargos:173]Moneda:28
		Else 
			$vt_moneda:=ST_GetWord (ACT_DivisaPais ;1;";")
		End if 
		
		If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
			If ([xxACT_ItemsTramos:291]es_monto_fijo:5)
				$vr_monto:=[xxACT_ItemsTramos:291]valor:6
			Else 
				  ///20150311 JVP se hace cambio para que aplique el tramo al valor previamente descontado
				  ////////cargo el item para verificar la configuracion
				QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
				
				If ([xxACT_Items:179]Tramo_desc_sobre_desc:47)
					$vr_montototaldesc:=[ACT_Cargos:173]Total_Desctos:45
					QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_CargoRelacionado:47=[ACT_Cargos:173]ID:1)
					QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-131;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-132;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-133;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-130;*)
					QUERY SELECTION:C341([ACT_Cargos:173]; | ;[ACT_Cargos:173]Ref_Item:16=-134)
					  //para guardar los montos de descuentos.
					$vr_montototaldesc:=$vr_montototaldesc+Abs:C99(Sum:C1([ACT_Cargos:173]Monto_Neto:5))
					KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
					
					If (([xxACT_Items:179]utiliza_saldo:49) & ([ACT_Cargos:173]MontosPagados:8#0) & ([ACT_Cargos:173]Saldo:23#0))
						$vr_monto:=Round:C94(Abs:C99([ACT_Cargos:173]Saldo:23)*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
					Else 
						$vr_monto:=Round:C94($vr_montoNetoCargo-$vr_montototaldesc*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
						KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo;True:C214)
					End if 
				Else 
					If (([xxACT_Items:179]utiliza_saldo:49) & ([ACT_Cargos:173]MontosPagados:8#0) & ([ACT_Cargos:173]Saldo:23#0))
						$vr_monto:=Round:C94(Abs:C99([ACT_Cargos:173]Saldo:23)*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
					Else 
						$vr_monto:=Round:C94($vr_montoNetoCargo*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
					End if 
				End if 
				
				
			End if 
		Else 
			If ($vd_fechaCalCargo=!00-00-00!)
				$vd_fechaCalCargo:=Current date:C33(*)
			End if 
			$vr_valor:=ACTut_fValorDivisa ($vt_moneda;$vd_fechaCalCargo)
			If ([xxACT_ItemsTramos:291]es_monto_fijo:5)
				$vr_monto:=ACTut_retornaMontoEnMoneda ([xxACT_ItemsTramos:291]valor:6;$vt_moneda;$vd_fechaCalCargo;ST_GetWord (ACT_DivisaPais ;1;";"))
			Else 
				If (([xxACT_Items:179]utiliza_saldo:49) & ([ACT_Cargos:173]MontosPagados:8#0) & ([ACT_Cargos:173]Saldo:23#0))
					$vr_monto:=Round:C94(Abs:C99([ACT_Cargos:173]Saldo:23)*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
				Else 
					$vr_monto:=Round:C94($vr_montoNetoCargo*([xxACT_ItemsTramos:291]valor:6/100);Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->$vt_moneda)))
				End if 
			End if 
		End if 
		
		$vt_retorno:=String:C10($vr_monto)
End case 

$0:=$vt_retorno