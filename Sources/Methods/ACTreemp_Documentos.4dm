//%attributes = {}
  //ACTreemp_Documentos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_BLOB:C604($vy_parametros)

ARRAY LONGINT:C221($alACT_idsAvisos;0)

C_REAL:C285(recNumApdo;recNumCtaCte;recNumAlumno;RNApdo;RNCta)
C_TEXT:C284($vt_log)
C_LONGINT:C283($ok)
C_LONGINT:C283($vl_recNumApdo)
C_LONGINT:C283($vl_idApoderado;$vl_idTercero)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Cargos:173])

$vl_recNumApdo:=-1

$vl_idReemp:=$1
$vy_parametros:=$2

ACTpgs_OpcionesVR ("ACT_initArrays")
ACTpgs_LimpiaVarsInterfaz ("InitVarsApdoCtaTer")
vb_interesBorrado:=False:C215
C_BOOLEAN:C305(vb_descuentoBorrado)

ACTpgs_DeclareArraysAvisos 
ACTfdp_OpcionesRecargos ("InicializaVars")

  //START TRANSACTION
  //KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera]ID;->alACTReemp_IdsDocs2Reemp{1})
  //
  //$vl_idReemp:=ACTreemp_CreaRegistro ([ACT_Documentos_en_Cartera]ID_Apoderado;[ACT_Documentos_en_Cartera]ID_Tercero;AT_GetSumArray (->arACTreemp_ResTotal);Current date(*);vlACTreemp_Modo;[ACT_Documentos_en_Cartera]ID;$vy_parametros)
  //$1->:=$vl_idReemp  //retorna id reemplazo

  //valido montos a crear
$vr_montoPagosNulos:=0
$vr_montoPagosNuevos:=0

  //anulo pagos
CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargos1")
For ($i;1;Size of array:C274(alACTReemp_IdsDocs2Reemp))
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID:1;->alACTReemp_IdsDocs2Reemp{$i};True:C214)
	If (ok=1)
		KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;True:C214)
		If (ok=1)
			  //ACTpgs_ReempCarteraAnulaDocPago (->[ACT_Documentos_de_Pago]ID;->[ACT_Documentos_en_Cartera]ID;$alACTReemp_IdsEstados{$i};$vl_idReemp)
			$vl_idDocPago:=[ACT_Documentos_de_Pago:176]ID:1
			$vl_recNumPago:=KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID_DocumentodePago:6;->$vl_idDocPago;True:C214)
			If (ok=1)
				If ($i=1)
					  //20130715 RCH Se guardan variables antes de llamar a ACTdc_CargaDCCreados
					$vdACT_FechaPago:=[ACT_Pagos:172]Fecha:2
					$vl_idApoderado:=[ACT_Pagos:172]ID_Apoderado:3
					$vl_idTercero:=[ACT_Pagos:172]ID_Tercero:26
					$vl_idCta:=[ACT_Pagos:172]ID_CtaCte:21
					ACTdc_CargaDCCreados ("GuardaDCExistentes")
				End if 
				ACTdp_OpcionesHistorialReemplaz ("AsignaID_Reemplazo";->$vl_idReemp)
				
				GOTO RECORD:C242([ACT_Pagos:172];$vl_recNumPago)
				
				$vr_montoPagosNulos:=$vr_montoPagosNulos+[ACT_Pagos:172]Monto_Pagado:5
				
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				CREATE SET:C116([ACT_Cargos:173];"setCargos2")
				UNION:C120("setCargos1";"setCargos2";"setCargos1")
				
				$vt_log:="Pago "+String:C10([ACT_Pagos:172]ID:1)+" anulado por reemplazo por varios cheques."
				vbACT_SaltarValidacion:=True:C214
				$ok:=ACTpgs_AnulaPago ($vl_recNumPago;False:C215)
				If ($ok=1)
					$vl_recNumPago:=KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID_DocumentodePago:6;->$vl_idDocPago;True:C214)
					If (ok=1)
						
						
						  //ASM 20150220 No se cargaba en escritura el documento de pago.
						LOAD RECORD:C52([ACT_Documentos_de_Pago:176])
						KRL_ReloadInReadWriteMode (->[ACT_Documentos_de_Pago:176])
						[ACT_Documentos_de_Pago:176]id_estado:53:=alACTReemp_IdsEstados{$i}
						[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
						SAVE RECORD:C53([ACT_Documentos_de_Pago:176])
						KRL_ReloadAsReadOnly (->[ACT_Documentos_de_Pago:176])
						
						KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_en_Cartera:182]ID:1;->alACTReemp_IdsDocs2Reemp{$i};True:C214)
						If (ok=1)
							[ACT_Documentos_en_Cartera:182]Estado:9:=[ACT_Documentos_de_Pago:176]Estado:14
							[ACT_Documentos_en_Cartera:182]Reemplazado:14:=True:C214
							SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
							
							$vb_ok:=True:C214
							LOG_RegisterEvt ($vt_log)
						Else 
							$vb_ok:=False:C215
							$i:=Size of array:C274(alACTReemp_IdsDocs2Reemp)
						End if 
					Else 
						$vb_ok:=False:C215
						$i:=Size of array:C274(alACTReemp_IdsDocs2Reemp)
					End if 
				Else 
					$vb_ok:=False:C215
					$i:=Size of array:C274(alACTReemp_IdsDocs2Reemp)
				End if 
			Else 
				$vb_ok:=False:C215
				$i:=Size of array:C274(alACTReemp_IdsDocs2Reemp)
			End if 
		Else 
			$vb_ok:=False:C215
			$i:=Size of array:C274(alACTReemp_IdsDocs2Reemp)
		End if 
	Else 
		$vb_ok:=False:C215
		$i:=Size of array:C274(alACTReemp_IdsDocs2Reemp)
	End if 
	KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
	KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
	KRL_UnloadReadOnly (->[ACT_Pagos:172])
End for 

If ($vb_ok)
	ACTpgs_InitArraysDocumentar ("CargaVars")
	
	READ ONLY:C145([Personas:7])
	READ ONLY:C145([ACT_CuentasCorrientes:175])
	READ ONLY:C145([ACT_Terceros:138])
	READ ONLY:C145([Alumnos:2])
	
	QUERY:C277([Personas:7];[Personas:7]No:1=$vl_idApoderado)
	QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$vl_idCta)
	QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
	QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$vl_idTercero)
	ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
	RNApdo:=Record number:C243([Personas:7])
	RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
	RNTercero:=Record number:C243([ACT_Terceros:138])
	$vl_recNumApdo:=RNApdo
	
	For ($j;1;Size of array:C274(alACTreemp_ResForma))
		
		QUERY:C277([Personas:7];[Personas:7]No:1=$vl_idApoderado)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID:1=$vl_idCta)
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1=[ACT_CuentasCorrientes:175]ID_Alumno:3)
		QUERY:C277([ACT_Terceros:138];[ACT_Terceros:138]Id:1=$vl_idTercero)
		ACTpgs_LimpiaVarsInterfaz ("CapturaRecNumsRegistros")
		RNApdo:=Record number:C243([Personas:7])
		RNCta:=Record number:C243([ACT_CuentasCorrientes:175])
		RNTercero:=Record number:C243([ACT_Terceros:138])
		$vl_recNumApdo:=RNApdo
		vdACT_FechaPago:=$vdACT_FechaPago
		
		  //SE CARGAN LOS CARGOS A PAGAR
		C_TEXT:C284($vt_set)
		$vt_set:="setCargos1"
		USE SET:C118($vt_set)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
		ACTpgs_LoadCargosIntoArrays 
		
		vrACT_MontoAdeudado:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$vt_set;->[ACT_Cargos:173]Saldo:23;vdACT_FechaPago))
		
		  //SE RECALCULA LOS AVISOS
		USE SET:C118("setCargos1")
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
		KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
		DISTINCT VALUES:C339([ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;$alACT_idsAvisos)
		
		For ($i;1;Size of array:C274($alACT_idsAvisos))
			READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
			$vl_idAviso:=$alACT_idsAvisos{$i}
			KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso)
			ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]);vdACT_FechaPago)
		End for 
		ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
		ACTpgs_LimpiaVarsInterfaz ("VarsFiltroCargos")
		ACTpgs_LimpiaVarsInterfaz ("SetVarsIngresoPago")
		ACTcfgmyt_OpcionesGenerales ("InicializaVars")
		vb_multaGenerada:=True:C214
		If (cbDatosApdo=1)
			vbACT_PagoXApdo:=True:C214
		Else 
			  //KRL_RelateSelection (->[ACT_CuentasCorrientes]ID;->[ACT_Cargos]ID_CuentaCorriente;"")
			  //FIRST RECORD([ACT_CuentasCorrientes])
			  //KRL_FindAndLoadRecordByIndex (->[Alumnos]Número;->[ACT_CuentasCorrientes]ID_Alumno)
			  //RNCta:=Record number([ACT_CuentasCorrientes])
			  //recNumCtaCte:=Record number([ACT_CuentasCorrientes])
			  //recNumAlumno:=Record number([Alumnos])
			  //vbACT_PagoXCuenta:=True
		End if 
		
		ARRAY LONGINT:C221(alACT_IDAviso;0)
		
		$vl_indice:=alACTreemp_ResRef{$j}
		vrACT_MontoPago:=0
		vlACT_FormasdePago:=alACTreemp_ResForma{$j}
		vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
		C_TEXT:C284(vtACT_ObservacionesPago;vsACT_LugardePago)
		vtACT_ObservacionesPago:="Pago ingresado por reemplazo de documento."
		vsACT_LugardePago:=""
		
		Case of 
			: (vlACT_FormasdePago=-4)  // cheque
				vACT_FechaDoc:=adACTreemp_CH_Fecha{$vl_indice}
				vACT_Cuenta:=atACTreemp_CH_NoCta{$vl_indice}
				vACT_Titular:=atACTreemp_CH_Titular{$vl_indice}
				vACT_BancoNombre:=atACTreemp_CH_Banco{$vl_indice}
				vACT_Serie:=atACTreemp_CH_Serie{$vl_indice}
				vrACT_MontoPago:=arACTreemp_CH_Monto{$vl_indice}
				vACT_BancoCodigo:=atACTreemp_CH_BancoC{$vl_indice}
				
				  //
				vtACT_BancoNombre:=vACT_BancoNombre
				vtACT_BancoCodigo:=vACT_BancoCodigo
				vtACT_BancoCuenta:=vACT_Cuenta
				vdACT_FechaDocumento:=vACT_FechaDoc
				vtACT_NoSerie:=vACT_Serie
				vtACT_BancoRUTTitular:=""
				vtACT_BancoTitular:=vACT_Titular
				
			: (vlACT_FormasdePago=-6)  // TC
				vtACT_TCDocumento:=atACTreemp_TC_Op{$vl_indice}
				vtACT_TCTipo:=atACTreemp_TC_TipoT{$vl_indice}
				vtACT_TCBancoEmisor:=atACTreemp_TC_BE{$vl_indice}
				vtACT_TCBancoCodigo:=atACTreemp_TC_BEC{$vl_indice}
				vtACT_TCNumero:=atACTreemp_TC_NumT{$vl_indice}
				vtACT_TCMesVencimiento:=atACTreemp_TC_VencM{$vl_indice}
				vtACT_TCAgnoVencimiento:=atACTreemp_TC_VencA{$vl_indice}
				vtACT_TCTitular:=atACTreemp_TC_Tit{$vl_indice}
				vtACT_TCRUTTitular:=atACTreemp_TC_RutT{$vl_indice}
				vrACT_MontoPago:=arACTreemp_TC_Monto{$vl_indice}
				
				vtACT_TCNumero:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->vtACT_TCNumero;->[ACT_Documentos_de_Pago:176]xPass:49)
				vtACT_TCCodigo:=""
				
			: (vlACT_FormasdePago=-8)  // Letra
				vtACT_LDocumento:=atACTreemp_L_Num{$vl_indice}
				vdACT_LFechaEmision:=afACTreemp_L_FE{$vl_indice}
				vdACT_LFechaVencimiento:=afACTreemp_L_FV{$vl_indice}
				vtACT_LTitular:=atACTreemp_L_Tit{$vl_indice}
				vtACT_LRUTTitular:=atACTreemp_L_RutTit{$vl_indice}
				vrACT_MontoPago:=arACTreemp_L_Monto{$vl_indice}
				
				vrACT_LImpuesto:=ACTlc_CalculaImpuesto (vdACT_LFechaEmision;vdACT_LFechaVencimiento;[ACT_Documentos_de_Pago:176]MontoPago:6)
				vtACT_LIndiceLetras:="1;1"  //índice por defecto al ingrsar por caja
				
			: (vlACT_FormasdePago=-7)
				vtACT_RDocumento:=atACTreemp_RC_NumO{$vl_indice}
				vrACT_MontoPago:=arACTreemp_RC_Monto{$vl_indice}
				  //********Ticket 116401
				vtACT_TDTipo:=atACTreemp_RC_TipoT{$vl_indice}
				vtACT_TDBancoEmisor:=atACTreemp_RC_BE{$vl_indice}
				vtACT_TDBancoCodigo:=atACTreemp_RC_BEC{$vl_indice}
				vtACT_TDNumero:=atACTreemp_RC_NumT{$vl_indice}
				vtACT_TDMesVencimiento:=atACTreemp_RC_VencM{$vl_indice}
				vtACT_TDAgnoVencimiento:=atACTreemp_RC_VencA{$vl_indice}
				vtACT_TDTitular:=atACTreemp_RC_Tit{$vl_indice}
				vtACT_TDRUTTitular:=atACTreemp_RC_RutT{$vl_indice}
				  //**************************
			Else 
				vsACT_DocsReemp2:=atACTreemp_OT_Forma{$vl_indice}
				vlACT_ReempPor2:=alACTreemp_OT_Forma{$vl_indice}
				vrACT_MontoPago:=arACTreemp_OT_Monto{$vl_indice}
				
		End case 
		
		  //se llenan variables del ingreso de pagos
		IDParaTrans:=0
		ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215;vdACT_FechaPago;True:C214)
		If (IDParaTrans>0)
			  //pago ingresado
			  //APPEND TO ARRAY($1->;IDParaTrans)
			KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->IDParaTrans)
			KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6;True:C214)
			If (ok=1)
				[ACT_Documentos_de_Pago:176]id_reemplazador:63:=$vl_idReemp
				SAVE RECORD:C53([ACT_Documentos_de_Pago:176])
				
				$vr_montoPagosNuevos:=$vr_montoPagosNuevos+[ACT_Documentos_de_Pago:176]MontoPago:6
			Else 
				$vb_ok:=False:C215
				$j:=Size of array:C274(alACTreemp_ResForma)
			End if 
			KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		Else 
			$vb_ok:=False:C215
			$j:=Size of array:C274(alACTreemp_ResForma)
		End if 
		
		  //20120525 RCH Los campos quedaban no ingresables...
		IT_SetEnterable (True:C214;0;->vtACT_BancoNombre;->vtACT_BancoCuenta;->vtACT_BancoTitular;->vtACT_BancoRUTTitular;->vtACT_NoSerie;->vdACT_FechaDocumento;->vrACT_MontoPrimero)
		
	End for 
End if 

If ($vr_montoPagosNulos#$vr_montoPagosNuevos)
	  //error. Pagos ingresados por un monto diferente al original.
	$vb_ok:=False:C215
End if 

If ($vb_ok)
	  //calcula protesto...
	ACTpp_OpcionesCalculoMontos ("CalculaMontoApdo";->$vl_idApoderado)
	ACTpp_OpcionesCalculoMontos ("CalculaMontoTercero";->$vl_idTercero)
	
	  //20120522 RCH No estaba quedando bien el saldo del apdo...
	If ($vl_recNumApdo>=0)
		ACTpp_RecalculaSaldoApdo ($vl_recNumApdo)
	End if 
	If ($vl_idTercero>0)
		ACTter_ActualizaValores ($vl_idTercero)
	End if 
	$0:=True:C214
Else 
	$0:=False:C215
End if 

KRL_UnloadReadOnly (->[Personas:7])
ACTdc_CargaDCCreados ("BuscaNuevosDC")
SET_ClearSets ("setCargos1";"setCargos2")
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Pagos:172])