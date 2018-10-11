//%attributes = {}
  //ACTpgs_GenCargoDesctoEspecial
C_BOOLEAN:C305($0;$vb_ok;$vt_cancelaT)

$vb_ok:=True:C214
$vt_cancelaT:=False:C215
ARRAY LONGINT:C221($alACTpgs_Avisos2Recalc;0)
vrACT_MontoDesctoExento:=vr_montoExento
vrACT_MontoDesctoAfecto:=vr_montoAfecto+vr_montoIVA
vrACT_MontoDescto:=vrACT_MontoDesctoExento+vrACT_MontoDesctoAfecto+vr_montoIVA
READ ONLY:C145([ACT_Transacciones:178])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=vl_idDocumentoAsociado)
CREATE SET:C116([ACT_Transacciones:178];"Transacciones")
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
CREATE SET:C116([ACT_Cargos:173];"ACT_CargosDeBoleta")

ARRAY LONGINT:C221($al_recNum;0)
ARRAY LONGINT:C221($al_recNumsT2Proc;0)
ARRAY LONGINT:C221($al_recNumsC2Proc;0)
ARRAY LONGINT:C221($al_recNumsT2Proc2;0)

$vr_MaxDevolucion:=vr_montoTotal
For ($i;1;Size of array:C274(al_recNumsCargos))
	GOTO RECORD:C242([ACT_Cargos:173];al_recNumsCargos{$i})
	USE SET:C118("Transacciones")
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
	QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15=0)
	QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8#"Pago con descuento")
	
	If (vr_montoDevolucion>0)
		ORDER BY:C49([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4;<)
	End if 
	LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNum;"")
	
	For ($j;1;Size of array:C274($al_recNum))
		GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$j})
		CREATE SET:C116([ACT_Transacciones:178];"Transacciones2")
		KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->vl_idDocumentoAsociado)
		  //$vr_montoTransaccion:=ACTbol_GetMontoLinea ("Transacciones2")
		$vr_montoTransaccion:=ACTbol_GetMontoLinea ("Transacciones2";True:C214)  //20170530 RCH Para obtener solo el monto de la boleta y no considerar el que pueda estar ya en una NC
		If ($vr_montoTransaccion>=$vr_MaxDevolucion)
			$vr_montoSobrante:=$vr_montoTransaccion-$vr_MaxDevolucion
			READ WRITE:C146([ACT_Transacciones:178])
			GOTO RECORD:C242([ACT_Transacciones:178];$al_recNum{$j})
			
			If ($vr_montoSobrante>0)
				$vt_moneda:=ACTtra_RetornaInfo ("retornaMonedaT")
				$vd_fecha:=[ACT_Transacciones:178]Fecha:5
				REDUCE SELECTION:C351([ACT_Cargos:173];0)
				$vb_emitidoEnMoneda:=KRL_GetBooleanFieldData (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
				If ($vb_emitidoEnMoneda)
					If ([ACT_Transacciones:178]Debito:6>0)
						[ACT_Transacciones:178]MontoMonedaPago:14:=$vr_montoSobrante
						[ACT_Transacciones:178]Debito:6:=ACTut_retornaMontoEnMoneda ([ACT_Transacciones:178]MontoMonedaPago:14;ST_GetWord (ACT_DivisaPais ;1;";");$vd_fecha;$vt_moneda)
					Else 
						[ACT_Transacciones:178]Credito:7:=$vr_montoSobrante
					End if 
				Else 
					If ([ACT_Transacciones:178]Debito:6>0)
						[ACT_Transacciones:178]Debito:6:=$vr_montoSobrante
						[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
					Else 
						[ACT_Transacciones:178]Credito:7:=$vr_montoSobrante
					End if 
				End if 
				SAVE RECORD:C53([ACT_Transacciones:178])
				If (($vr_montoTransaccion-$vr_montoSobrante)>0)
					DUPLICATE RECORD:C225([ACT_Transacciones:178])
					[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
					[ACT_Transacciones:178]Auto_UUID:17:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
					If ($vb_emitidoEnMoneda)
						If ([ACT_Transacciones:178]Debito:6>0)
							[ACT_Transacciones:178]MontoMonedaPago:14:=$vr_montoTransaccion-$vr_montoSobrante
							[ACT_Transacciones:178]Debito:6:=ACTut_retornaMontoEnMoneda ([ACT_Transacciones:178]MontoMonedaPago:14;ST_GetWord (ACT_DivisaPais ;1;";");$vd_fecha;$vt_moneda)
						Else 
							[ACT_Transacciones:178]Credito:7:=$vr_montoTransaccion-$vr_montoSobrante
						End if 
					Else 
						If ([ACT_Transacciones:178]Debito:6>0)
							[ACT_Transacciones:178]Debito:6:=$vr_montoTransaccion-$vr_montoSobrante
							[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]Debito:6
						Else 
							[ACT_Transacciones:178]Credito:7:=$vr_montoTransaccion-$vr_montoSobrante
						End if 
					End if 
					SAVE RECORD:C53([ACT_Transacciones:178])
					APPEND TO ARRAY:C911($al_recNumsT2Proc;Record number:C243([ACT_Transacciones:178]))
				End if 
			Else 
				APPEND TO ARRAY:C911($al_recNumsT2Proc;Record number:C243([ACT_Transacciones:178]))
			End if 
			If ([ACT_Transacciones:178]Debito:6>0)
				$vr_MaxDevolucion:=$vr_MaxDevolucion-[ACT_Transacciones:178]MontoMonedaPago:14
			Else 
				$vr_MaxDevolucion:=$vr_MaxDevolucion-[ACT_Transacciones:178]Credito:7
			End if 
		Else 
			$vr_MaxDevolucion:=$vr_MaxDevolucion-$vr_montoTransaccion
			APPEND TO ARRAY:C911($al_recNumsT2Proc;$al_recNum{$j})
		End if 
		If ($vr_MaxDevolucion<=0)
			TRACE:C157
			$j:=Size of array:C274($al_recNum)
			$i:=Size of array:C274(al_recNumsCargos)
		End if 
		CLEAR SET:C117("Transacciones2")
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
	End for 
End for 

$vt_cancelaT:=(Num:C11(ACTbol_OpcionesGenerales ("FijaMontosMonedaVariable";->$al_recNumsT2Proc))=0)
If (Not:C34($vt_cancelaT))
	
	CREATE EMPTY SET:C140([ACT_Transacciones:178];"FaltaIDPago2")
	
	For ($i;1;Size of array:C274($al_recNumsT2Proc))
		READ WRITE:C146([ACT_Transacciones:178])
		GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumsT2Proc{$i})
		KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3)
		
		$lockedCargos:=False:C215
		If ([ACT_Transacciones:178]ID_Pago:4#0)
			KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;True:C214)
			$vr_monto:=ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
			If ($vr_monto=0)
				$vr_monto:=ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Credito:7)
			End if 
			If (ok=0)
				$lockedP:=True:C214
			Else 
				If (vr_MaxDevolucion>0)
					If ([ACT_Cargos:173]Monto_Neto:5>=0)
						If ([ACT_Transacciones:178]Glosa:8#"Pago con descuento")
							[ACT_Pagos:172]Saldo:15:=[ACT_Pagos:172]Saldo:15+$vr_monto
						End if 
						SAVE RECORD:C53([ACT_Pagos:172])
					End if 
					KRL_UnloadReadOnly (->[ACT_Pagos:172])
				End if 
				GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumsT2Proc{$i})
				ARRAY LONGINT:C221($al_recNumsAvisos;0)
				ARRAY LONGINT:C221($aRecNumTransacciones;0)
				APPEND TO ARRAY:C911($aRecNumTransacciones;$al_recNumsT2Proc{$i})
				$lockedCargos:=ACTpgs_EliminaPagoEnTrans (->$aRecNumTransacciones;->$al_recNumsAvisos)
			End if 
		Else 
			$vr_monto:=ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
			If ($vr_monto=0)
				$vr_monto:=ACTtra_CalculaMontos ("fromCurrentRecord";->[ACT_Transacciones:178]Credito:7)
			End if 
		End if 
		If (Not:C34($lockedCargos))
			KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4)
			If (Records in selection:C76([ACT_Pagos:172])=1)
				vdACT_FechaPago:=[ACT_Pagos:172]Fecha:2
			Else 
				vdACT_FechaPago:=vd_fechaDcto
			End if 
			vdACT_FechaUF:=vdACT_FechaPago
			vrACT_MontoPago:=0
			vsACT_FormasdePago:=""
			vlACT_FormasdePago:=0
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			vrACT_MontoDesctoExento:=0
			vrACT_MontoDesctoAfecto:=0
			If ([ACT_Cargos:173]TasaIVA:21=0)
				vrACT_MontoDesctoExento:=$vr_monto
			Else 
				vrACT_MontoDesctoAfecto:=$vr_monto
			End if 
			ACTpgs_LoadCargosIntoArrays (False:C215)
			  // Modificado por: Saúl Ponce (24-03-2017) Ticket 177232, para pasar el id de la boleta a la que se le efectúa nota de crédito
			  //$vb_ok:=ACTpgs_CreaCargoDesctoEspecial (7;8)
			  //$vb_ok:=ACTpgs_CreaCargoDesctoEspecial (7;8;vl_idDocumentoAsociado)
			$vb_ok:=ACTpgs_CreaCargoDesctoEspecial (7;8;0;vl_idDocumentoAsociado)  //20170325 RCH
			If (Not:C34($vb_ok))
				vtACT_logEmisionNC:="El descuento no pudo ser aplicado completamente."
				$i:=Size of array:C274($al_recNumsT2Proc)
			End if 
			ACTpgs_AsignaPagoACargos 
			vbACT_IngresandoPagos:=False:C215
			
			UNION:C120("FaltaIDPago";"FaltaIDPago2";"FaltaIDPago2")
			
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			KRL_UnloadReadOnly (->[ACT_Pagos:172])
			For ($x;1;Size of array:C274(alACTpgs_Avisos2Recalc))
				If (Find in array:C230($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$x})=-1)
					APPEND TO ARRAY:C911($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc{$x})
				End if 
			End for 
		Else 
			$i:=Size of array:C274($al_recNumsT2Proc)
			$vb_ok:=False:C215
			vtACT_logEmisionNC:="Los cargos no pueden ser actualizados."
		End if 
	End for 
	COPY ARRAY:C226($alACTpgs_Avisos2Recalc;alACTpgs_Avisos2Recalc)
	COPY SET:C600("FaltaIDPago2";"FaltaIDPago")
	CLEAR SET:C117("FaltaIDPago2")
	
	$vb_continuar:=True:C214
	If (Size of array:C274($al_recNumsT2Proc)>0)
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Cargos:173])
	Else 
		$vb_continuar:=False:C215
	End if 
	
	CLEAR SET:C117("ACT_CargosDeBoleta")
	CLEAR SET:C117("Transacciones")
	COPY ARRAY:C226($al_recNumsT2Proc;$1->)
Else 
	$vb_ok:=False:C215
	vtACT_logEmisionNC:="Los montos en moneda variable no pudieron ser fijados."
End if 
$0:=$vb_ok