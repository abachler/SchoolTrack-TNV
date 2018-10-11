//%attributes = {}
  //dbuACT_VerificaPagosXCargo

C_LONGINT:C283($1)
ARRAY LONGINT:C221(al_NumBoleta;0)
ARRAY LONGINT:C221(al_NumPago;0)  //rch
C_LONGINT:C283(NumLastT)
C_LONGINT:C283(ContadorEtapas)
ContadorEtapas:=1  //Para que cambie en algo el mensaje y no piensen que está pegado en el proceso (ya que puede aparecer varias veces el mismo mensaje...)
READ ONLY:C145([ACT_Transacciones:178])
ALL RECORDS:C47([ACT_Transacciones:178])
NumLastT:=Max:C3([ACT_Transacciones:178]ID_Transaccion:1)  //Para modificar sólo las transacciones que se crearán
REDUCE SELECTION:C351([ACT_Transacciones:178];0)
C_LONGINT:C283($repetir)  //rch
$repetir:=1  //rch
$accountTrackIsInitialized:=Num:C11(PREF_fGet (0;"ACT_Inicializado";"0"))
If ($accountTrackIsInitialized=1)
	ACTinit_LoadPrefs 
	While ($repetir>0)  //rch
		$repetir:=0  //rch
		ARRAY LONGINT:C221($aIDCargosMalos;0)
		READ WRITE:C146([ACT_Transacciones:178])
		READ WRITE:C146([ACT_Cargos:173])
		$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Verificando Pagos por Cargo. Etapa ")+String:C10(ContadorEtapas)+__ ("..."))
		If (Count parameters:C259=1)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=$1;*)
		Else 
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]FechaEmision:22>=!2006-01-01!;*)
		End if 
		QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Monto_Neto:5>0)
		ARRAY LONGINT:C221($aCargos;0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$aCargos;"")
		For ($y;1;Size of array:C274($aCargos))
			READ WRITE:C146([ACT_Cargos:173])
			GOTO RECORD:C242([ACT_Cargos:173];$aCargos{$y})
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
			QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
			$revisar:=False:C215
			
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
				ARRAY LONGINT:C221($al_recNum;0)
				SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNum)
				$pagadoMPago:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6)
				If ($pagadoMPago#[ACT_Cargos:173]MontosPagadosMPago:52)
					$pagado:=ACTtra_CalculaMontos ("DebitoMonedaCargoFromRecNum";->$al_recNum;->[ACT_Transacciones:178]Debito:6)
					$revisar:=True:C214
				End if 
			Else 
				$pagado:=Sum:C1([ACT_Transacciones:178]Debito:6)
				If ($pagado#[ACT_Cargos:173]MontosPagados:8)
					$revisar:=True:C214
					$pagadoMPago:=$pagado
				End if 
			End if 
			
			If ($revisar)
				$repetir:=$repetir+1  //rch
				  //TRACE
				$idDoc:=[ACT_Cargos:173]ID_Documento_de_Cargo:3
				If ($pagado>[ACT_Cargos:173]Monto_Neto:5)
					$dif:=$pagado-[ACT_Cargos:173]Monto_Neto:5
					ARRAY LONGINT:C221($aTransacciones;0)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$aTransacciones;"")
					For ($i;1;Size of array:C274($aTransacciones))
						READ WRITE:C146([ACT_Transacciones:178])
						GOTO RECORD:C242([ACT_Transacciones:178];$aTransacciones{$i})
						$idPago:=[ACT_Transacciones:178]ID_Pago:4
						$idAviso:=[ACT_Transacciones:178]No_Comprobante:10
						$idApdo:=[ACT_Transacciones:178]ID_Apoderado:11
						
						If ([ACT_Transacciones:178]No_Boleta:9#0)  //guarda los numeros de boleta y de pago para posteriormente asignarlos a las nuevas transacciones que se creen
							$el:=Find in array:C230(al_NumPago;[ACT_Transacciones:178]ID_Pago:4)
							If ($el<0)
								AT_Insert (0;1;->al_NumBoleta;->al_NumPago)
								al_NumBoleta{Size of array:C274(al_NumBoleta)}:=[ACT_Transacciones:178]No_Boleta:9
								al_NumPago{Size of array:C274(al_NumPago)}:=$idPago
							End if 
						End if 
						
						If ([ACT_Transacciones:178]Debito:6>$dif)
							[ACT_Transacciones:178]Debito:6:=[ACT_Transacciones:178]Debito:6-$dif
							SAVE RECORD:C53([ACT_Transacciones:178])
							READ WRITE:C146([ACT_Pagos:172])
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=$idPago)
							  //If ([ACT_Pagos]FormaDePago#"Nota de Crédito")
							If ([ACT_Pagos:172]id_forma_de_pago:30#-12)
								[ACT_Pagos:172]Saldo:15:=[ACT_Pagos:172]Saldo:15+$dif
								SAVE RECORD:C53([ACT_Pagos:172])
							End if 
							$dif:=0
						Else 
							$deb:=[ACT_Transacciones:178]Debito:6
							DELETE RECORD:C58([ACT_Transacciones:178])
							READ WRITE:C146([ACT_Pagos:172])
							QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID:1=$idPago)
							  //If ([ACT_Pagos]FormaDePago#"Nota de Crédito")
							If ([ACT_Pagos:172]id_forma_de_pago:30#-12)
								[ACT_Pagos:172]Saldo:15:=[ACT_Pagos:172]Saldo:15+$deb
								SAVE RECORD:C53([ACT_Pagos:172])
							End if 
							$dif:=$dif-$deb
						End if 
						QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=$idApdo;*)
						QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
						ARRAY LONGINT:C221($aAvisos;0)
						LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$aAvisos)
						For ($h;1;Size of array:C274($aAvisos))
							ACTac_Prepagar ($aAvisos{$h})
						End for 
						If ($dif=0)
							$i:=Size of array:C274($aTransacciones)+1
						End if 
					End for 
				Else 
					[ACT_Cargos:173]MontosPagados:8:=$pagado
					[ACT_Cargos:173]MontosPagadosMPago:52:=$pagadoMPago
					[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
					SAVE RECORD:C53([ACT_Cargos:173])
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
					QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Aviso:1=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
					If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
						ACTac_Recalcular (Record number:C243([ACT_Avisos_de_Cobranza:124]))
					End if 
				End if 
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=$idDoc)
				If (Records in selection:C76([ACT_Documentos_de_Cargo:174])=1)
					ACTcc_CalculaDocumentoCargo (Record number:C243([ACT_Documentos_de_Cargo:174]))
				End if 
			End if 
			$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$y/Size of array:C274($aCargos);__ (""))
		End for 
		ContadorEtapas:=ContadorEtapas+1
		$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
		KRL_UnloadReadOnly (->[ACT_Cargos:173])
		KRL_UnloadReadOnly (->[ACT_Transacciones:178])
		KRL_UnloadReadOnly (->[ACT_Pagos:172])
		KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
	End while 
End if 