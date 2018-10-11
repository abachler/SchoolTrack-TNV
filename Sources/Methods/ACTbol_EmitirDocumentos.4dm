//%attributes = {}
  //ACTbol_EmitirDocumentos

C_BLOB:C604($xBlob)
C_BOOLEAN:C305(vbACT_RegistrarIDSBoletas)

If (False:C215)
	C_OBJECT:C1216(ACTbol_EmitirDocumentos ;$0)
	C_TEXT:C284(ACTbol_EmitirDocumentos ;$1)
	C_TEXT:C284(ACTbol_EmitirDocumentos ;$2)
	C_TEXT:C284(ACTbol_EmitirDocumentos ;$3)
	C_REAL:C285(ACTbol_EmitirDocumentos ;$4)
	C_REAL:C285(ACTbol_EmitirDocumentos ;$5)
	C_REAL:C285(ACTbol_EmitirDocumentos ;$6)
	C_REAL:C285(ACTbol_EmitirDocumentos ;$7)
	C_TEXT:C284(ACTbol_EmitirDocumentos ;$8)
	C_TEXT:C284(ACTbol_EmitirDocumentos ;$9)
	C_REAL:C285(ACTbol_EmitirDocumentos ;$10)
	C_REAL:C285(ACTbol_EmitirDocumentos ;$11)
End if 

$SetdeRegistros:=$1
$DocAfecto:=$2
$DocExcento:=$3
$proximaAfecta:=$4
$proximaExcenta:=$5
$IndexAfecto:=$6
$IndexExcento:=$7
$setAfecto:=$8
$setExcento:=$9
$IDCat:=$10
$vl_id_RazonSocial:=$11

$idAfecto:=alACT_IDDT{$IndexAfecto}
$idExento:=alACT_IDDT{$IndexExcento}
  //$emitidas:=0

ARRAY LONGINT:C221($al_RecNumRegistros;0)
ACTbol_FiltraCargos ($SetdeRegistros;->$al_RecNumRegistros)

$montoAfectoTotal:=0
$montoNoAfectoTotal:=0
$pagoSinBoletaAfecto:=0
$pagoSinBoletaExento:=0
ARRAY LONGINT:C221($al_transaccionesAfectas;0)
ARRAY LONGINT:C221($al_transaccionesExentas;0)
ARRAY LONGINT:C221($aPagosaBoletaExenta;0)
ARRAY LONGINT:C221($aPagosaBoletaAfecta;0)
ARRAY LONGINT:C221($aPagosaBoletaExentaTemp;0)
ARRAY LONGINT:C221($aPagosaBoletaAfectaTemp;0)
$idApdo:=0
$id_Tercero:=0
For ($i;1;Size of array:C274($al_RecNumRegistros))
	GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$al_RecNumRegistros{$i})
	If (e3=0)
		$idApdo:=[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3
		$id_Tercero:=0
	Else 
		$idApdo:=0
		  //$id_Tercero:=[ACT_Terceros]Id
		$id_Tercero:=[ACT_Avisos_de_Cobranza:124]ID_Tercero:26
	End if 
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	If (i1=1)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23#0)
	End if 
	ARRAY LONGINT:C221($aRecNumCargos;0)
	If (e2=1)
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]ID_CuentaCorriente:2=al_idSeleccionado{0})
	End if 
	
	ACTcfg_OpcionesRazonesSociales ("SeleccionaCargos";->$vl_id_RazonSocial)
	
	ACTbol_FiltraItemsCategoria ("cargosBoleta")
	
	ACTbol_FiltraItemsMoneda ("cargosBoleta")
	
	ACTbol_FiltraItemsResponsable ("cargosBoleta")
	
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EsRelativo:10=False:C215)
	LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aRecNumCargos;"")
	For ($j;1;Size of array:C274($aRecNumCargos))
		GOTO RECORD:C242([ACT_Cargos:173];$aRecNumCargos{$j})
		If (Not:C34([ACT_Cargos:173]No_Incluir_en_DocTrib:50))
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
			CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT1")
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=-2;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
			CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT2")
			
			UNION:C120("ACT_SetT1";"ACT_SetT2";"ACT_SetT1")
			USE SET:C118("ACT_SetT1")
			SET_ClearSets ("ACT_SetT1";"ACT_SetT2")
			
			ARRAY LONGINT:C221($al_transacciones;0)
			ARRAY LONGINT:C221($al_idsTransacciones;0)
			ARRAY REAL:C219($ar_montosCredito;0)
			
			$recNumTrans:=Record number:C243([ACT_Transacciones:178])
			
			SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_transacciones;[ACT_Transacciones:178]ID_Transaccion:1;$al_idsTransacciones;[ACT_Transacciones:178]Credito:7;$ar_montosCredito)
			
			C_REAL:C285($credito;$debito)
			  //If ([ACT_Cargos]Saldo#0)
			  //$credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transacciones;->[ACT_Transacciones]Credito)
			
			ARRAY LONGINT:C221($al_transacciones2;0)
			
			  //20130403 RCH Para obtener correctamente el monto pagado...
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]ID_Pago#0)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#-1)  //20140421 ASM  ticket 131990
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_transacciones2;"")
			
			  //20130701 RCH Verifico que todas las transacciones de pago, con DT, tengan una de credito por el monto. 122649
			
			  //20140605 RCH creo set para sacar las transacciones
			If ([ACT_Cargos:173]Monto_Neto:5>0)
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
				QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Credito:7#0)
				CREATE SET:C116([ACT_Transacciones:178];"setTransBusqueda")
				If (Size of array:C274($al_idsTransacciones)>0)
					For ($l_indiceTPagos;1;Size of array:C274($al_transacciones2))
						GOTO RECORD:C242([ACT_Transacciones:178];$al_transacciones2{$l_indiceTPagos})
						If (([ACT_Transacciones:178]No_Boleta:9#0) | ([ACT_Transacciones:178]ID_Pago:4#0))  //20140605 RCH Se duplica cuando hay pago y/o boleta
							$l_registrosC:=0
							$l_idItem:=[ACT_Transacciones:178]ID_Item:3
							$r_monto:=[ACT_Transacciones:178]Debito:6
							
							USE SET:C118("setTransBusqueda")
							SET QUERY LIMIT:C395(1)
							QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$l_idItem;*)
							QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Credito:7=$r_monto)
							SET QUERY LIMIT:C395(0)
							CREATE SET:C116([ACT_Transacciones:178];"setTransBusquedaQuitar")
							DIFFERENCE:C122("setTransBusqueda";"setTransBusquedaQuitar";"setTransBusqueda")
							If (Records in set:C195("setTransBusquedaQuitar")=0)
								ACTtra_DuplicaT ($al_idsTransacciones{1};$r_monto)
							End if 
							
						End if 
					End for 
				End if 
			End if 
			SET_ClearSets ("setTransBusqueda";"setTransBusquedaQuitar")
			
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
			CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT1")
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=-2;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
			CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT2")
			
			UNION:C120("ACT_SetT1";"ACT_SetT2";"ACT_SetT1")
			USE SET:C118("ACT_SetT1")
			SET_ClearSets ("ACT_SetT1";"ACT_SetT2")
			
			
			
			ARRAY LONGINT:C221($al_transacciones;0)
			ARRAY LONGINT:C221($al_idsTransacciones;0)
			ARRAY REAL:C219($ar_montosCredito;0)
			
			$recNumTrans:=Record number:C243([ACT_Transacciones:178])
			SELECTION TO ARRAY:C260([ACT_Transacciones:178]Credito:7;$ar_montosCredito;[ACT_Transacciones:178]ID_Transaccion:1;$al_idsTransacciones;[ACT_Transacciones:178];$al_transacciones)
			If ([ACT_Cargos:173]Monto_Neto:5<0)
				COPY ARRAY:C226($al_transacciones;$al_transacciones2)
			End if 
			
			$credito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transacciones;->[ACT_Transacciones:178]Credito:7)
			$debito:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transacciones2;->[ACT_Transacciones:178]Debito:6)
			
			$sinPago:=$credito-$debito
			If ([ACT_Cargos:173]Saldo:23=0)
				$sinPago:=0
			End if 
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#-1;*)  //20140421 ASM  ticket 131990
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
			
			
			ARRAY LONGINT:C221($al_transacciones;0)
			SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_transacciones)
			$pagos:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_transacciones;->[ACT_Transacciones:178]Debito:6)
			
			  //se agregan los posibles balanceos de de descuentos para que se les asigne id bol tal como se hace al ingresar un pago
			CREATE SELECTION FROM ARRAY:C640([ACT_Transacciones:178];$al_transacciones;"")
			
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8="Balanceo @";*)
			QUERY SELECTION:C341([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
			
			
			ARRAY LONGINT:C221($alACT_idsTBalanceo;0)
			ARRAY REAL:C219($ar_montosCredito2;0)
			SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$alACT_idsTBalanceo;[ACT_Transacciones:178]Credito:7;$ar_montosCredito2)
			For ($r;1;Size of array:C274($alACT_idsTBalanceo))
				If (Find in array:C230($al_idsTransacciones;$alACT_idsTBalanceo{$r})=-1)
					APPEND TO ARRAY:C911($al_idsTransacciones;$alACT_idsTBalanceo{$r})
					APPEND TO ARRAY:C911($ar_montosCredito;$ar_montosCredito2{$r})
				End if 
			End for 
			
			If ([ACT_Cargos:173]TasaIVA:21>0)
				  //If ([ACT_Cargos]Saldo#0)  //20150326 RCH Cuando los cargos estan pagados, se asignan los ids directamente en las transacciones de pago...
				If (([ACT_Cargos:173]Saldo:23#0) | ([ACT_Cargos:173]Monto_Neto:5=0))  //20151231 RCH Para incluir líneas con monto 0
					If (i2=1)
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#-1;*)  //20140421 ASM  ticket 131990
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
						CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT1")
						
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=-2;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
						CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT2")
						
						UNION:C120("ACT_SetT1";"ACT_SetT2";"ACT_SetT1")
						USE SET:C118("ACT_SetT1")
						SET_ClearSets ("ACT_SetT1";"ACT_SetT2")
						
						ARRAY LONGINT:C221($aPagosaBoletaAfectaTemp;0)
						SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$aPagosaBoletaAfectaTemp)
						$pagoSinBoletaAfecto:=0
						For ($w;1;Size of array:C274($aPagosaBoletaAfectaTemp))
							$id:=$aPagosaBoletaAfectaTemp{$w}
							KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$id)
							  //$pagoSinBoletaAfecto:=$pagoSinBoletaAfecto+ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones]Credito)
							$pagoSinBoletaAfecto:=$pagoSinBoletaAfecto+ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones:178]Debito:6)  //cuando la transaccion estaba pagada no se generaba bien la boleta
							INSERT IN ARRAY:C227($aPagosaBoletaAfecta;Size of array:C274($aPagosaBoletaAfecta)+1;1)
							$aPagosaBoletaAfecta{Size of array:C274($aPagosaBoletaAfecta)}:=$aPagosaBoletaAfectaTemp{$w}
						End for 
					End if 
					If (Record number:C243([ACT_Cargos:173])#-1)
						  //20130624 RCH 122649
						  //$montoAfectoTotal:=$montoAfectoTotal+($SinPago-$pagos)+$pagoSinBoletaAfecto
						$montoAfectoTotal:=$montoAfectoTotal+$SinPago+$pagoSinBoletaAfecto
						
						If ($recNumTrans#-1)
							For ($y;1;Size of array:C274($al_idsTransacciones))
								SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_idTransaConBoleta)
								If (($SinPago-$pagos)=0)
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
								Else 
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6=$ar_montosCredito{$y})
								End if 
								If ($vl_idTransaConBoleta=0)
									INSERT IN ARRAY:C227($al_transaccionesAfectas;Size of array:C274($al_transaccionesAfectas)+1;1)
									  //$al_transaccionesAfectas{Size of array($al_transaccionesAfectas)}:=$idTransaccion
									$al_transaccionesAfectas{Size of array:C274($al_transaccionesAfectas)}:=$al_idsTransacciones{$y}
								End if 
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
							End for 
						End if 
					End if 
					
					
				Else 
					
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#-1;*)  //20140421 ASM  ticket 131990
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
					
					ARRAY LONGINT:C221($aPagosaBoletaAfectaTemp;0)
					SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$aPagosaBoletaAfectaTemp)
					$pagoSinBoletaAfecto:=0
					For ($w;1;Size of array:C274($aPagosaBoletaAfectaTemp))
						$id:=$aPagosaBoletaAfectaTemp{$w}
						KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$id)
						$pagoSinBoletaAfecto:=$pagoSinBoletaAfecto+ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones:178]Debito:6)  //cuando la transaccion estaba pagada no se generaba bien la boleta
						INSERT IN ARRAY:C227($al_transaccionesAfectas;Size of array:C274($al_transaccionesAfectas)+1;1)
						$al_transaccionesAfectas{Size of array:C274($al_transaccionesAfectas)}:=$aPagosaBoletaAfectaTemp{$w}
					End for 
					
					$montoAfectoTotal:=$montoAfectoTotal+$SinPago+$pagoSinBoletaAfecto
					
				End if 
				
			Else 
				  //If ([ACT_Cargos]Saldo#0)  //20150326 RCH Cuando los cargos estan pagados, se asignan los ids directamente en las transacciones de pago...
				If (([ACT_Cargos:173]Saldo:23#0) | ([ACT_Cargos:173]Monto_Neto:5=0))  //20151231 RCH Para incluir líneas con monto 0
					If (i2=1)
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#-1;*)  //20140421 ASM  ticket 131990
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
						
						CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT1")
						
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=-2;*)
						QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
						CREATE SET:C116([ACT_Transacciones:178];"ACT_SetT2")
						
						UNION:C120("ACT_SetT1";"ACT_SetT2";"ACT_SetT1")
						USE SET:C118("ACT_SetT1")
						SET_ClearSets ("ACT_SetT1";"ACT_SetT2")
						
						ARRAY LONGINT:C221($aPagosaBoletaExentaTemp;0)
						SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$aPagosaBoletaExentaTemp)
						$pagoSinBoletaExento:=0
						For ($w;1;Size of array:C274($aPagosaBoletaExentaTemp))
							$id:=$aPagosaBoletaExentaTemp{$w}
							KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$id)
							$pagoSinBoletaExento:=$pagoSinBoletaExento+ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
							INSERT IN ARRAY:C227($aPagosaBoletaExenta;Size of array:C274($aPagosaBoletaExenta)+1;1)
							$aPagosaBoletaExenta{Size of array:C274($aPagosaBoletaExenta)}:=$aPagosaBoletaExentaTemp{$w}
						End for 
					End if 
					If (Record number:C243([ACT_Cargos:173])#-1)
						  //20130624 RCH 122649
						  //$montoNoAfectoTotal:=$montoNoAfectoTotal+($SinPago-$pagos)+$pagoSinBoletaExento
						$montoNoAfectoTotal:=$montoNoAfectoTotal+$SinPago+$pagoSinBoletaExento
						If ($recNumTrans#-1)
							For ($y;1;Size of array:C274($al_idsTransacciones))
								SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_idTransaConBoleta)
								If (($SinPago-$pagos)=0)
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
								Else 
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6=$ar_montosCredito{$y})
								End if 
								If ($vl_idTransaConBoleta=0)
									INSERT IN ARRAY:C227($al_transaccionesExentas;Size of array:C274($al_transaccionesExentas)+1;1)
									  //$al_transaccionesExentas{Size of array($al_transaccionesExentas)}:=$idTransaccion
									$al_transaccionesExentas{Size of array:C274($al_transaccionesExentas)}:=$al_idsTransacciones{$y}
								End if 
								SET QUERY DESTINATION:C396(Into current selection:K19:1)
							End for 
						End if 
					End if 
					
				Else 
					
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#-1;*)  //20140421 ASM  ticket 131990
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9=0)
					
					ARRAY LONGINT:C221($al_transaccionesExentasTemp;0)
					SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Transaccion:1;$al_transaccionesExentasTemp)
					$pagoSinBoletaExento:=0
					For ($w;1;Size of array:C274($al_transaccionesExentasTemp))
						$id:=$al_transaccionesExentasTemp{$w}
						KRL_FindAndLoadRecordByIndex (->[ACT_Transacciones:178]ID_Transaccion:1;->$id)
						$pagoSinBoletaExento:=$pagoSinBoletaExento+ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones:178]Debito:6)
						INSERT IN ARRAY:C227($al_transaccionesExentas;Size of array:C274($al_transaccionesExentas)+1;1)
						$al_transaccionesExentas{Size of array:C274($al_transaccionesExentas)}:=$al_transaccionesExentasTemp{$w}
					End for 
					
					$montoNoAfectoTotal:=$montoNoAfectoTotal+$SinPago+$pagoSinBoletaExento
					
				End if 
				
			End if 
		End if 
	End for 
End for 

UNLOAD RECORD:C212([ACT_Cargos:173])
  //20130210 RCH Requerimiento Aleman Pto Montt
  //If (<>gCountryCode="mx")

  //If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array(alACT_IDsCats;$IDCat)}))
$vl_id_RazonSocial:=Choose:C955(($vl_id_RazonSocial=0);-1;$vl_id_RazonSocial)
$b_emisorDTECLG:=ACTdte_EsEmisorColegium ($vl_id_RazonSocial)

If ((<>gCountryCode="mx") | (abACT_EmiteAfectoExento{Find in array:C230(alACT_IDsCats;$IDCat)}) | ($b_emisorDTECLG))
	ARRAY LONGINT:C221($al_transaccionesBol;0)
	ARRAY LONGINT:C221($al_pagosEnBoleta;0)
	C_REAL:C285($vr_MontoBol)
	$vr_MontoBol:=$montoAfectoTotal+$montoNoAfectoTotal
	AT_Union (->$al_transaccionesAfectas;->$al_transaccionesExentas;->$al_transaccionesBol)
	AT_Union (->$aPagosaBoletaExenta;->$aPagosaBoletaAfecta;->$al_pagosEnBoleta)
	AT_Initialize (->$al_transaccionesExentas;->$al_transaccionesAfectas)
	AT_Initialize (->$aPagosaBoletaExenta;->$aPagosaBoletaAfecta)
	$montoAfectoTotalBolE:=$montoAfectoTotal
	
	If (cs_emisorElectronico=1)  //20130903 RCH
		
		If ($montoAfectoTotal=0)  //20130729 RCH para emitir un dcto afecto cuando hay cargos afectos
			COPY ARRAY:C226($al_transaccionesBol;$al_transaccionesExentas)
			COPY ARRAY:C226($al_pagosEnBoleta;$aPagosaBoletaExenta)
			$montoNoAfectoTotal:=$vr_MontoBol
		Else 
			COPY ARRAY:C226($al_transaccionesBol;$al_transaccionesAfectas)
			COPY ARRAY:C226($al_pagosEnBoleta;$aPagosaBoletaAfecta)
			$montoAfectoTotal:=$vr_MontoBol
		End if 
		
	Else 
		
		$montoNoAfectoTotal:=$vr_MontoBol
		$montoAfectoTotal:=0
		COPY ARRAY:C226($al_transaccionesBol;$al_transaccionesExentas)
		$vr_MontoBol:=0
		
	End if 
	
Else 
	  //$montoAfectoTotalBolE:=0
	$montoAfectoTotalBolE:=$montoAfectoTotal  //20140516 RCH Las boletas se emitian sin IVA
End if 

  //20150325 RCH Si el proceso era iniciado desde 2 maquinas diferentes, el folio se podría duplicar.
While (Semaphore:C143("CreacionDT"))
	DELAY PROCESS:C323(Current process:C322;20)
End while 

ARRAY OBJECT:C1221($ao_documentos;0)
C_OBJECT:C1216($ob_Afecto;$ob_Exento;$ob_respuesta)
C_BOOLEAN:C305($b_boletaConError)

OB SET:C1220($ob_Afecto;"monto";$montoAfectoTotal)
OB SET ARRAY:C1227($ob_Afecto;"ids_transacciones";$al_transaccionesAfectas)
OB SET ARRAY:C1227($ob_Afecto;"ids_transacciones_pagos";$aPagosaBoletaAfecta)
OB SET:C1220($ob_Afecto;"fecha";DTS_MakeFromDateTime (vdACT_FEmisionBol))
OB SET:C1220($ob_Afecto;"documento_afecto";True:C214)
OB SET:C1220($ob_Afecto;"id_categoria";$IDCat)
OB SET:C1220($ob_Afecto;"id_documento";$idAfecto)
OB SET:C1220($ob_Afecto;"tipo_documento";$DocAfecto)
OB SET:C1220($ob_Afecto;"id_apoderado";$idApdo)
OB SET:C1220($ob_Afecto;"indice_configuracion";$IndexAfecto)
OB SET:C1220($ob_Afecto;"nombre_set";$setAfecto)
OB SET:C1220($ob_Afecto;"asignar_folio";True:C214)
OB SET:C1220($ob_Afecto;"monto_afecto";$montoAfectoTotalBolE)
OB SET:C1220($ob_Afecto;"id_tercero";$id_Tercero)
OB SET:C1220($ob_Afecto;"observacion";"")
OB SET:C1220($ob_Afecto;"id_razon_social";$vl_id_RazonSocial)
OB SET:C1220($ob_Afecto;"emitido_desde";1)
OB SET:C1220($ob_Afecto;"razon_referencia";0)
OB SET:C1220($ob_Afecto;"es_documento_publico_general";False:C215)
OB SET:C1220($ob_Afecto;"categoria";alACT_idsCategorias{0})
OB SET:C1220($ob_Afecto;"moneda";atACT_Monedas{0})
OB SET:C1220($ob_Afecto;"imprimir";False:C215)
OB SET:C1220($ob_Afecto;"no_abrir_dte";False:C215)
OB SET:C1220($ob_Afecto;"apoderado_responsable";alACT_Responsables{0})

$montoAfectoTotalBolE:=0
OB SET:C1220($ob_Exento;"monto";$montoNoAfectoTotal)
OB SET ARRAY:C1227($ob_Exento;"ids_transacciones";$al_transaccionesExentas)
OB SET ARRAY:C1227($ob_Exento;"ids_transacciones_pagos";$aPagosaBoletaExenta)
OB SET:C1220($ob_Exento;"fecha";DTS_MakeFromDateTime (vdACT_FEmisionBol))
OB SET:C1220($ob_Exento;"documento_afecto";False:C215)
OB SET:C1220($ob_Exento;"id_categoria";$IDCat)
OB SET:C1220($ob_Exento;"id_documento";$idExento)
OB SET:C1220($ob_Exento;"tipo_documento";$DocExcento)
OB SET:C1220($ob_Exento;"id_apoderado";$idApdo)
OB SET:C1220($ob_Exento;"indice_configuracion";$IndexExcento)
OB SET:C1220($ob_Exento;"nombre_set";$setExcento)
OB SET:C1220($ob_Exento;"asignar_folio";True:C214)
OB SET:C1220($ob_Exento;"monto_afecto";$montoAfectoTotalBolE)
OB SET:C1220($ob_Exento;"id_tercero";$id_Tercero)
OB SET:C1220($ob_Exento;"observacion";"")
OB SET:C1220($ob_Exento;"id_razon_social";$vl_id_RazonSocial)
OB SET:C1220($ob_Exento;"emitido_desde";1)
OB SET:C1220($ob_Exento;"razon_referencia";0)
OB SET:C1220($ob_Exento;"es_documento_publico_general";False:C215)
OB SET:C1220($ob_Exento;"categoria";alACT_idsCategorias{0})
OB SET:C1220($ob_Exento;"moneda";atACT_Monedas{0})
OB SET:C1220($ob_Exento;"imprimir";False:C215)
OB SET:C1220($ob_Exento;"no_abrir_dte";False:C215)
OB SET:C1220($ob_Exento;"apoderado_responsable";alACT_Responsables{0})

APPEND TO ARRAY:C911($ao_documentos;$ob_Afecto)
APPEND TO ARRAY:C911($ao_documentos;$ob_Exento)
ARRAY LONGINT:C221($al_idsBoletasEmitidas;0)
$ob_respuesta:=ACTbol_CreaDTObj (->$ao_documentos;->$al_idsBoletasEmitidas)

$b_boletaConError:=OB Get:C1224($ob_respuesta;"error_validacion")
If (vbACT_RegistrarIDSBoletas)
	For ($l_boletas;1;Size of array:C274($al_idsBoletasEmitidas))
		APPEND TO ARRAY:C911(alACT_idsBoletasEmitidas;$al_idsBoletasEmitidas{$l_boletas})
	End for 
End if 

CLEAR SEMAPHORE:C144("CreacionDT")

$0:=$ob_respuesta