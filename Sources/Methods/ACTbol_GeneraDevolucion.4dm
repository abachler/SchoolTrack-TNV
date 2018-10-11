//%attributes = {}
  //ACTbol_GeneraDevolucion

ARRAY LONGINT:C221($al_idsPagos;0)
C_REAL:C285(vr_montoDevolucion;vr_monto)
C_LONGINT:C283($id_boleta)
C_LONGINT:C283($index;$vl_idPago;$vl_decimales)
C_LONGINT:C283($vl_idCargoRelacionado)

vr_montoDevolucion:=$1
COPY ARRAY:C226($2->;$al_idsPagos)
$id_boleta:=$3->
$vl_idCargoRelacionado:=$4

For ($x;1;Size of array:C274($al_idsPagos))
	vr_monto:=0
	If (vr_montoDevolucion>0)
		READ WRITE:C146([ACT_Pagos:172])
		$index:=Find in field:C653([ACT_Pagos:172]ID:1;$al_idsPagos{$x})
		If ($index#-1)
			GOTO RECORD:C242([ACT_Pagos:172];$index)
			If (Not:C34(Locked:C147([ACT_Pagos:172])))
				$vl_decimales:=Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->[ACT_Pagos:172]Moneda:27))
				If (vr_montoDevolucion<=[ACT_Pagos:172]Saldo:15)
					[ACT_Pagos:172]Saldo:15:=Round:C94([ACT_Pagos:172]Saldo:15-vr_montoDevolucion;$vl_decimales)
					SAVE RECORD:C53([ACT_Pagos:172])
					vr_monto:=vr_montoDevolucion
				Else 
					vr_monto:=[ACT_Pagos:172]Saldo:15
					[ACT_Pagos:172]Saldo:15:=Round:C94([ACT_Pagos:172]Saldo:15-vr_monto;$vl_decimales)
					SAVE RECORD:C53([ACT_Pagos:172])
				End if 
				$vl_idPago:=[ACT_Pagos:172]ID:1
				$vl_idTercero:=[ACT_Pagos:172]ID_Tercero:26
				vr_montoDevolucion:=vr_montoDevolucion-vr_monto
				
				If (vr_monto>0)
					AT_Initialize (->alACT_RecNumsCargos)
					ACTcfg_LoadCargosEspeciales (9)
					ACTcfg_LoadConfigData (9)
					ACTpgs_OpcionesVR ("ACT_initArrays")
					ACTcfgmyt_OpcionesGenerales ("InicializaVars")
					vlACT_FormasdePago:=-12
					vsACT_FormasdePago:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_FormasdePago)
					vdACT_fecha:=Current date:C33(*)
					$vb_cargoVD:=(KRL_GetNumericFieldData (->[ACT_Cargos:173]ID:1;->$vl_idCargoRelacionado;->[ACT_Cargos:173]ID_CuentaCorriente:2)=0)
					
					  //20171221 RCH
					  //$recNumCargo:=ACTpgs_CreaCargo (True;vl_idApdo;vr_monto;vl_idIE;False;vdACT_fecha;True;$vl_idTercero;$vl_idCargoRelacionado;$vb_cargoVD)
					  //20120419 RCH Habia un error cuando era un item de venta directa...
					  //KRL_FindAndLoadRecordByIndex (->[ACT_Terceros]Id;->$vl_idTercero)
					  //KRL_FindAndLoadRecordByIndex (->[Personas]No;->vl_idApdo)
					$l_idApdo:=[ACT_Pagos:172]ID_Apoderado:3
					$l_idTercero:=[ACT_Pagos:172]ID_Tercero:26
					$recNumCargo:=ACTpgs_CreaCargo (True:C214;$l_idApdo;vr_monto;vl_idIE;False:C215;vdACT_fecha;True:C214;$l_idTercero;$vl_idCargoRelacionado;$vb_cargoVD)
					KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->$l_idTercero)
					KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->$l_idApdo)
					
					$vl_idItem:=[ACT_Cargos:173]ID:1
					REDUCE SELECTION:C351([ACT_Cargos:173];0)
					GOTO RECORD:C242([ACT_Cargos:173];$recNumCargo)
					
					READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					$vl_idAviso:=KRL_GetNumericFieldData (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
					
					ACTpgs_LoadCargosIntoArrays (False:C215)
					vdACT_FechaPago:=Current date:C33(*)
					vrACT_MontoPago:=vr_monto
					ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->vsACT_FormasdePago;->vlACT_FormasdePago)
					  //vsACT_FormasdePago:=$vt_formaDePago
					vrACT_MontoAdeudado:=vrACT_MontoPago
					vb_NoMostrarAlertas:=True:C214
					
					  //20111130 RCH Se crea observacion
					$vt_tipoDocumento:=KRL_GetTextFieldData (->[ACT_Boletas:181]ID:1;->$id_boleta;->[ACT_Boletas:181]TipoDocumento:7)
					$vl_numero:=KRL_GetNumericFieldData (->[ACT_Boletas:181]ID:1;->$id_boleta;->[ACT_Boletas:181]Numero:11)
					$vt_obs:=__ ("Devolución asociada a Documento Tributario tipo ")+$vt_tipoDocumento+", "+__ ("número")+": "+String:C10($vl_numero)+"."
					vtACT_ObservacionesPago:=$vt_obs
					  //vtACT_ObservacionesPago:=""
					vsACT_LugardePago:=""
					
					  //20171221 RCH Para generar pago para el apoderado o tercero original
					  //vbACT_PagoXApdo:=(vl_idApdo>0)
					  //vbACT_PagoXCuenta:=False
					  //vbACTpgs_PagoXTercero:=(vl_idTercero>0)
					GOTO RECORD:C242([ACT_Pagos:172];$index)
					vbACT_PagoXApdo:=([ACT_Pagos:172]ID_Apoderado:3>0)
					vbACT_PagoXCuenta:=False:C215
					vbACTpgs_PagoXTercero:=([ACT_Pagos:172]ID_Tercero:26>0)
					If (vbACT_PagoXApdo)
						KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Pagos:172]ID_Apoderado:3)
					Else 
						KRL_FindAndLoadRecordByIndex (->[ACT_Terceros:138]Id:1;->[ACT_Pagos:172]ID_Tercero:26)
					End if 
					
					
					
					vrACT_MontoDescto:=0
					ARRAY LONGINT:C221(aIDPagosDocumentar;0)
					ARRAY TEXT:C222(aCtasApdo;0)
					ACTpgs_OpcionesVR ("ACT_initArrays")
					ACTpgs_IngresarPagos (vlACT_FormasdePago;False:C215;False:C215)
					vb_NoMostrarAlertas:=False:C215
					READ WRITE:C146([ACT_Transacciones:178])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$vl_idItem;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
					SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$al_transaccionesBol)
					  //  `creo transacción para relacionar el nuevo pago con el pago original
					LOAD RECORD:C52([ACT_Transacciones:178])
					DUPLICATE RECORD:C225([ACT_Transacciones:178])
					[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
					[ACT_Transacciones:178]ID_Pago:4:=$vl_idPago
					[ACT_Transacciones:178]No_Boleta:9:=0
					[ACT_Transacciones:178]ID_DctoRelacionado:15:=$id_boleta
					[ACT_Transacciones:178]Auto_UUID:17:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					SAVE RECORD:C53([ACT_Transacciones:178])
					SET BLOB SIZE:C606($xBlob;0)
					$al_transaccionesBol{0}:=0
					ARRAY LONGINT:C221($DA_Return;0)
					AT_SearchArray (->$al_transaccionesBol;"=";->$DA_Return)
					For ($j;Size of array:C274($DA_Return);1;-1)
						AT_Delete (0;1;->$al_transaccionesBol)
					End for 
					BLOB_Variables2Blob (->$xBlob;0;->$id_boleta;->$al_transaccionesBol)
					$ok:=ACTtra_AsignaIdBoleta ($xBlob)
					If (Not:C34($ok))
						BM_CreateRequest ("idBolEnTransacciones";"";"";$xBlob)
					End if 
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					
					  //20111130 RCH Se crea observacion
					KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->$vl_idAviso;True:C214)
					[ACT_Avisos_de_Cobranza:124]Observaciones:15:=$vt_obs
					[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=0
					[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=0
					[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=0
					SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
					KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
					
				End if 
			End if 
			KRL_UnloadReadOnly (->[ACT_Pagos:172])
		End if 
	End if 
End for 