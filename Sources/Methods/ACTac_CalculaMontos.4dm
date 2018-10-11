//%attributes = {}
  //ACTac_CalculaMontos

C_BOOLEAN:C305($done)
ARRAY LONGINT:C221(al_idsCargos;0)
C_DATE:C307(vd_fecha)
C_LONGINT:C283(vl_idAviso;$i;$vl_idCargo)
C_BLOB:C604(xBlob)
C_TEXT:C284($setCargosInvolucrados)
C_BOOLEAN:C305(vbACTpgs_NoUtilizarDctos)
C_BOOLEAN:C305(vbACTpgs_CalcularAvisosArr)

vd_fecha:=!00-00-00!
vl_idAviso:=0
$setCargosInvolucrados:="ACTac_CalculaMontos"
SET BLOB SIZE:C606(xBlob;0)

xBlob:=$1
BLOB_Blob2Vars (->xBlob;0;->vl_idAviso;->vd_fecha)
SET BLOB SIZE:C606(xBlob;0)

If (vl_idAviso>0)
	ACT_LeeMoneda   //20160509 RCH
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->vl_idAviso;True:C214)
	If (ok=1)
		QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=vl_idAviso)
		If (Records in selection:C76([ACT_Documentos_de_Cargo:174])>0)
			KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-2)
			CREATE SET:C116([ACT_Cargos:173];"ACTac_Todos")
			If ([ACT_Avisos_de_Cobranza:124]Fecha_Emision:4>=!2009-01-01!)
				ACTac_ValidaMontosEmision ("ACTac_Todos";vd_fecha)
				USE SET:C118("ACTac_Todos")
			End if 
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16#-100)
			[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12:=0
			If ([ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24=True:C214)
				CREATE SET:C116([ACT_Cargos:173];$setCargosInvolucrados)
				[ACT_Avisos_de_Cobranza:124]Monto_Afecto_IVA:9:=ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$setCargosInvolucrados;->[ACT_Cargos:173]Monto_Afecto:27;vd_fecha)
				[ACT_Avisos_de_Cobranza:124]Monto_Bruto:8:=ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$setCargosInvolucrados;->[ACT_Cargos:173]Monto_Bruto:24;vd_fecha)
				[ACT_Avisos_de_Cobranza:124]Monto_IVA:10:=ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$setCargosInvolucrados;->[ACT_Cargos:173]Monto_IVA:20;vd_fecha)
				[ACT_Avisos_de_Cobranza:124]Monto_Neto:11:=ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$setCargosInvolucrados;->[ACT_Cargos:173]Monto_Neto:5;vd_fecha)
			Else 
				[ACT_Avisos_de_Cobranza:124]Monto_Afecto_IVA:9:=Sum:C1([ACT_Cargos:173]Monto_Afecto:27)
				[ACT_Avisos_de_Cobranza:124]Monto_Bruto:8:=Sum:C1([ACT_Cargos:173]Monto_Bruto:24)
				[ACT_Avisos_de_Cobranza:124]Monto_IVA:10:=Sum:C1([ACT_Cargos:173]Monto_IVA:20)
				[ACT_Avisos_de_Cobranza:124]Monto_Neto:11:=Sum:C1([ACT_Cargos:173]Monto_Neto:5)
			End if 
			
			USE SET:C118("ACTac_Todos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-100)
			CREATE SET:C116([ACT_Cargos:173];$setCargosInvolucrados)
			If ([ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24)
				[ACT_Avisos_de_Cobranza:124]Intereses:13:=Abs:C99(ACTcar_CalculaMontos ("calcMontoFromSetMEmision";->$setCargosInvolucrados;->[ACT_Cargos:173]Monto_Neto:5;vd_fecha))
			Else 
				[ACT_Avisos_de_Cobranza:124]Intereses:13:=Abs:C99(Sum:C1([ACT_Cargos:173]Monto_Neto:5))
			End if 
			SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
			
			USE SET:C118("ACTac_Todos")
			CREATE SET:C116([ACT_Cargos:173];$setCargosInvolucrados)
			If ([ACT_Avisos_de_Cobranza:124]EmitidoSegunMonedaCargo:24)
				[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMEmision";->$setCargosInvolucrados;->[ACT_Cargos:173]Saldo:23;vd_fecha))
				[ACT_Avisos_de_Cobranza:124]Moneda:17:=<>vsACT_MonedaColegio  //Los cargos se recalcula con esta moneda
				If ([ACT_Avisos_de_Cobranza:124]Moneda:17="")  //20110331 RCH Hay casos en que esto esta vacio y provoca problemas...
					[ACT_Avisos_de_Cobranza:124]Moneda:17:=ST_GetWord (ACT_DivisaPais ;1;";")
				End if 
				If (ACTcar_CalculaSaldo ("retornaSaldoMonedaPago";vd_fecha;->[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14;->[ACT_Avisos_de_Cobranza:124]Moneda:17)<Num:C11(ACTcar_OpcionesGenerales ("pagoMinimo")))
					If (Not:C34(vbACTpgs_NoUtilizarDctos) | (vbACTpgs_CalcularAvisosArr))
						$vb_continuar:=True:C214
						If ((vbACTpgs_CalcularAvisosArr) & (vbACTpgs_NoUtilizarDctos))
							If (Find in array:C230(alACT_idsAvisosDctos2Rec;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)>0)
							Else 
								$vb_continuar:=False:C215
							End if 
						End if 
						If ($vb_continuar)
							  //*********tb se usa mas abajo *********
							USE SET:C118("ACTac_Todos")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0;*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
							If (Records in selection:C76([ACT_Cargos:173])>0)
								ARRAY LONGINT:C221($al_recNumsDcto;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsDcto;"")
								USE SET:C118("ACTac_Todos")
								QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0;*)
								QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
								ARRAY LONGINT:C221($al_recNumsCargos;0)
								LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
								CREATE EMPTY SET:C140([ACT_Transacciones:178];"ACT_setTransPagos")
								For ($x;1;Size of array:C274($al_recNumsCargos))
									vdACT_FechaUF:=vd_fecha
									ACTac_UtilizaDescuentos ($al_recNumsCargos{$x};"ACT_setTransPagos";0;->$al_recNumsDcto)
									If (Size of array:C274($al_recNumsDcto)=0)
										$x:=Size of array:C274($al_recNumsCargos)
									End if 
								End for 
								ACTpgs_AsignaIDPagoEnTrans ("ACT_setTransPagos";-2)
								KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->vl_idAviso;True:C214)
								[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=0
								SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
							End if 
							  //*********tb se usa mas abajo *********
						End if 
					End if 
					[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=0
				End if 
				[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=Abs:C99(ACTcar_CalculaMontos ("redondeadoFromSetMPago";->$setCargosInvolucrados;->[ACT_Cargos:173]Saldo:23;vd_fecha))
			Else 
				[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=Abs:C99(Sum:C1([ACT_Cargos:173]Saldo:23))
				[ACT_Avisos_de_Cobranza:124]Moneda:17:=ST_GetWord (ACT_DivisaPais ;1;";")  //Los avisos anteriores deben se emitieron segœn la moneda del pa’s
				[ACT_Avisos_de_Cobranza:124]Monto_A_Pagar_Moneda:16:=[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14
			End if 
			[ACT_Avisos_de_Cobranza:124]LastDateRecalc:23:=vd_fecha
			SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
			ok:=ACTpgs_CalculaDesctoRXA ("ValidaMontoRXA";->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			If (ok=0)
				$done:=False:C215
			End if 
			If (Not:C34(vbACTpgs_NoUtilizarDctos) | (vbACTpgs_CalcularAvisosArr))
				$vb_continuar:=True:C214
				If ((vbACTpgs_CalcularAvisosArr) & (vbACTpgs_NoUtilizarDctos))
					If (Find in array:C230(alACT_idsAvisosDctos2Rec;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)>0)
					Else 
						$vb_continuar:=False:C215
					End if 
				End if 
				If ($vb_continuar)
					If ([ACT_Avisos_de_Cobranza:124]Monto_Neto:11+[ACT_Avisos_de_Cobranza:124]Intereses:13=0)
						  //*********tb se usa mas arriba *********
						USE SET:C118("ACTac_Todos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
						If (Records in selection:C76([ACT_Cargos:173])>0)
							ARRAY LONGINT:C221($al_recNumsDcto;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsDcto;"")
							USE SET:C118("ACTac_Todos")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0;*)
							QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
							ARRAY LONGINT:C221($al_recNumsCargos;0)
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargos;"")
							CREATE EMPTY SET:C140([ACT_Transacciones:178];"ACT_setTransPagos")
							For ($x;1;Size of array:C274($al_recNumsCargos))
								vdACT_FechaUF:=vd_fecha
								ACTac_UtilizaDescuentos ($al_recNumsCargos{$x};"ACT_setTransPagos";0;->$al_recNumsDcto)
								If (Size of array:C274($al_recNumsDcto)=0)
									$x:=Size of array:C274($al_recNumsCargos)
								End if 
							End for 
							ACTpgs_AsignaIDPagoEnTrans ("ACT_setTransPagos";-2)
							KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->vl_idAviso;True:C214)
							[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14:=0
							SAVE RECORD:C53([ACT_Avisos_de_Cobranza:124])
						End if 
						  //*********tb se usa mas arriba ********* 
					End if 
				End if 
			End if 
			CLEAR SET:C117("ACTac_Todos")
			CLEAR SET:C117($setCargosInvolucrados)
			$done:=True:C214
		Else 
			$done:=True:C214
		End if 
		KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
	Else 
		  //20130411 RCH Si el aviso era eliminado la tarea podia permanecer infinitamente...
		  //$done:=False
		If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=0)
			$done:=True:C214
		Else 
			$done:=False:C215
		End if 
	End if 
Else 
	$done:=True:C214
End if 
$0:=$done