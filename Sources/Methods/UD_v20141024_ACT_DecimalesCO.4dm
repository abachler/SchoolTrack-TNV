//%attributes = {}
  //  UD_v20141024_ACT_DecimalesCO

If (<>gCountryCode="co")
	If (<>gRolBD="500")
		TRACE:C157
		
		  //escribo 0 decimal en la base de datos
		C_TEXT:C284($t_key)
		READ WRITE:C146([xxACT_Monedas:146])
		$t_key:=<>gCountryCode+"."+ST_GetWord (ACT_DivisaPais ;1;";")
		KRL_FindAndLoadRecordByIndex (->[xxACT_Monedas:146]Key:10;->$t_key;True:C214)
		[xxACT_Monedas:146]Numero_Decimales:8:=0
		KRL_SaveUnLoadReadOnly (->[xxACT_Monedas:146])
		
		
		C_TEXT:C284($vt_monedaCargo)
		C_LONGINT:C283($l_proc)
		C_TEXT:C284($vt_monedaCargo)
		C_REAL:C285($montonetodsctos;$afecto)
		C_LONGINT:C283($l_indice;$l_indiceAC;$l_idItem)
		C_REAL:C285($r_original;$r_posterior;$r_decimales)
		
		
		ARRAY TEXT:C222($at_montos;0)
		ARRAY LONGINT:C221($DA_Return;0)
		ARRAY LONGINT:C221($alACT_recNumsAC;0)
		ARRAY LONGINT:C221($al_recNums2;0)
		ARRAY LONGINT:C221($al_recNums;0)
		ARRAY LONGINT:C221($al_recNumsCargosAC;0)
		ARRAY REAL:C219($ar_monto;0)
		
		C_BOOLEAN:C305($done)
		C_LONGINT:C283($i)
		
		READ ONLY:C145([ACT_Cargos:173])
		READ ONLY:C145([ACT_Transacciones:178])
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		
		MESSAGES OFF:C175
		
		ALL RECORDS:C47([ACT_Cargos:173])
		
		ACTutl_GetDecimalFormat 
		$r_decimales:=<>vlACT_Decimales
		
		
		$l_proc:=IT_UThermometer (1;0;"Verificando decimales en cargos...")
		SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNums;[ACT_Cargos:173]Monto_Neto:5;$ar_monto)
		
		For ($l_indice;1;Size of array:C274($ar_monto))
			APPEND TO ARRAY:C911($at_montos;String:C10($ar_monto{$l_indice}))
		End for 
		
		$at_montos{0}:=<>tXS_RS_DecimalSeparator
		
		AT_SearchArray (->$at_montos;"@";->$DA_Return)
		For (vQR_Long1;1;Size of array:C274($DA_Return))
			APPEND TO ARRAY:C911($al_recNums2;$al_recNums{$DA_Return{vQR_Long1}})
		End for 
		
		READ WRITE:C146([ACT_Cargos:173])
		
		CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$al_recNums2;"")
		
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
		
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC)
		
		CREATE EMPTY SET:C140([ACT_Pagos:172];"setPagos")
		
		QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_Vencimiento:7=!00-00-00!)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargosAC;"")
		
		For ($l_indiceAC;1;Size of array:C274($al_recNumsCargosAC))
			
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumsCargosAC{$l_indiceAC};True:C214)
			
			If (([ACT_Cargos:173]ID:1=6224) | ([ACT_Cargos:173]ID:1=6224))
				
			End if 
			[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5
			SAVE RECORD:C53([ACT_Cargos:173])
			ACTcc_CreateUpdateTransaction 
			
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
			
		End for 
		
		CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargos")
		
		For ($l_indice;1;Size of array:C274($alACT_recNumsAC))
			
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC{$l_indice})
			
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
			
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
			CREATE SET:C116([ACT_Pagos:172];"pagosAviso")
			
			UNION:C120("setPagos";"pagosAviso";"setPagos")
			
			LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumsCargosAC;"")
			
			For ($l_indiceAC;1;Size of array:C274($al_recNumsCargosAC))
				
				KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumsCargosAC{$l_indiceAC};True:C214)
				
				ADD TO SET:C119([ACT_Cargos:173];"setCargos")
				
				If (([ACT_Cargos:173]ID:1=6224) | ([ACT_Cargos:173]ID:1=6224))
					
				End if 
				
				$l_idItem:=[ACT_Cargos:173]ID:1
				$r_original:=[ACT_Cargos:173]MontosPagados:8
				[ACT_Cargos:173]Monto_Neto:5:=[ACT_Cargos:173]Monto_Neto:5
				SAVE RECORD:C53([ACT_Cargos:173])
				$r_posterior:=[ACT_Cargos:173]MontosPagados:8
				
				ACTcc_CreateUpdateTransaction 
				
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
				
				If ($r_original#$r_posterior)
					
					READ WRITE:C146([ACT_Transacciones:178])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=$l_idItem;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
					
					APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]Debito:6:=Round:C94([ACT_Transacciones:178]Debito:6;$r_decimales))
					APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]Credito:7:=Round:C94([ACT_Transacciones:178]Credito:7;$r_decimales))
					APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]MontoMonedaPago:14:=Round:C94([ACT_Transacciones:178]MontoMonedaPago:14;$r_decimales))
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					
				End if 
				
			End for 
			
		End for 
		
		
		  //recalculo avisos asociados a cargos modificados ya que los que tenian monto a pagar 0 no eran modificados.
		ARRAY LONGINT:C221($alACT_recNumsAC;0)
		USE SET:C118("setCargos")
		SET_ClearSets ("setCargos")
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC;"")
		For ($l_indice;1;Size of array:C274($alACT_recNumsAC))
			ACTac_Recalcular ($alACT_recNumsAC{$l_indice})
		End for 
		
		
		IT_UThermometer (0;$l_proc;"Revisando integridad de pagos...")
		dbuACT_VerificaIntegridadPagos ("Ignorar")
		If (Size of array:C274(aQR_Longint1)>0)
			
		End if 
		
		USE SET:C118("setPagos")
		QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;aQR_Longint1)
		DISTINCT VALUES:C339([ACT_Pagos:172]ID_Apoderado:3;aQR_Longint2)
		
		CREATE EMPTY SET:C140([ACT_Cargos:173];"setCargos")
		
		IT_UThermometer (0;$l_proc;"Revisando pagos...")
		For ($l_indice;1;Size of array:C274(aQR_Longint1))
			vQR_Real1:=(aQR_Real4{$l_indice}-aQR_Real3{$l_indice})
			If ((vQR_Real1>=-1) & (vQR_Real1<=1))
				KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->aQR_Longint1{$l_indice})
				
				If ([ACT_Pagos:172]ID:1=1708)
					
				End if 
				
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1)
				
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				CREATE SET:C116([ACT_Cargos:173];"cargosTodos")
				
				UNION:C120("setCargos";"cargosTodos";"setCargos")
				
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5=vQR_Real1)
				If (Records in selection:C76([ACT_Cargos:173])=1)
					
					ACTcar_Delete (Record number:C243([ACT_Cargos:173]))
					
				Else 
					
					READ WRITE:C146([ACT_Cargos:173])
					USE SET:C118("cargosTodos")
					
					FIRST RECORD:C50([ACT_Cargos:173])
					
					[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5+vQR_Real1;$r_decimales)
					[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
					
					$vt_monedaCargo:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
					
					If ([ACT_Cargos:173]TasaIVA:21>0)
						$montonetodsctos:=[ACT_Cargos:173]Monto_Neto:5
						$afecto:=$montonetodsctos/<>vrACT_FactorIVA
						[ACT_Cargos:173]Monto_IVA:20:=Round:C94($afecto*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
						[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
					End if 
					
					[ACT_Cargos:173]MontosPagados:8:=[ACT_Cargos:173]MontosPagados:8+vQR_Real1
					[ACT_Cargos:173]MontosPagadosMPago:52:=[ACT_Cargos:173]MontosPagadosMPago:52+vQR_Real1
					[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
					SAVE RECORD:C53([ACT_Cargos:173])
					
					READ WRITE:C146([ACT_Transacciones:178])
					QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4>0;*)
					QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Debito:6>1)
					
					If (Records in selection:C76([ACT_Transacciones:178])=1)
						FIRST RECORD:C50([ACT_Transacciones:178])
						[ACT_Transacciones:178]Debito:6:=[ACT_Transacciones:178]Debito:6+vQR_Real1
						[ACT_Transacciones:178]MontoMonedaPago:14:=[ACT_Transacciones:178]MontoMonedaPago:14+vQR_Real1
						SAVE RECORD:C53([ACT_Transacciones:178])
					Else 
						
					End if 
					
					KRL_UnloadReadOnly (->[ACT_Transacciones:178])
					
					LOG_RegisterEvt ("Disminución de deuda por: "+String:C10(Abs:C99(vQR_Real1))+" para cargo id: "+String:C10([ACT_Cargos:173]ID:1)+".")
					
					SAVE RECORD:C53([ACT_Cargos:173])
					
					KRL_UnloadReadOnly (->[ACT_Cargos:173])
				End if 
				
			End if 
		End for 
		
		dbuACT_VerificaIntegridadPagos ("Ignorar")
		If (Size of array:C274(aQR_Longint1)>0)
			
		End if 
		
		  //recalculo avisos asociados a pagos modificados ya que los que tenian monto a pagar 0 no eran modificados.
		ARRAY LONGINT:C221($alACT_recNumsAC;0)
		USE SET:C118("setCargos")
		SET_ClearSets ("setCargos")
		KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
		KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC;"")
		For ($l_indice;1;Size of array:C274($alACT_recNumsAC))
			ACTac_Recalcular ($alACT_recNumsAC{$l_indice})
		End for 
		
		IT_UThermometer (0;$l_proc;"Recalculando saldos y avisos...")
		
		ARRAY LONGINT:C221($alACT_recNumsAC;0)
		READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
		ALL RECORDS:C47([ACT_Avisos_de_Cobranza:124])
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC;"")
		ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumsAC)
		
		
		  //##### Deja en 0 avisos que estaban pagados para que no queden con monto a pagar 1 #####
		ARRAY LONGINT:C221($alACT_idsApdos;0)
		ARRAY LONGINT:C221($alACT_recNumsApdos;0)
		
		vQR_Real1:=-1
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14=Abs:C99(vQR_Real1))
		
		DISTINCT VALUES:C339([ACT_Avisos_de_Cobranza:124]ID_Apoderado:3;$alACT_idsApdos)
		
		SELECTION TO ARRAY:C260([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC)
		For ($l_indiceAC;1;Size of array:C274($alACT_recNumsAC))
			GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$alACT_recNumsAC{$l_indiceAC})
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
			
			KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
			
			If (Records in selection:C76([ACT_Pagos:172])=1)
				
				READ WRITE:C146([ACT_Cargos:173])
				KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
				
				QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23=vQR_Real1)
				
				[ACT_Cargos:173]Monto_Neto:5:=Round:C94([ACT_Cargos:173]Monto_Neto:5+vQR_Real1;$r_decimales)
				[ACT_Cargos:173]Monto_Bruto:24:=[ACT_Cargos:173]Monto_Neto:5
				$vt_monedaCargo:=Choose:C955([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
				
				If ([ACT_Cargos:173]TasaIVA:21>0)
					$montonetodsctos:=[ACT_Cargos:173]Monto_Neto:5
					$afecto:=$montonetodsctos/<>vrACT_FactorIVA
					[ACT_Cargos:173]Monto_IVA:20:=Round:C94($afecto*<>vrACT_TasaIVA/100;Num:C11(ACTcar_OpcionesGenerales ("numeroDecimales";->$vt_monedaCargo)))
					[ACT_Cargos:173]Monto_Afecto:27:=[ACT_Cargos:173]Monto_Neto:5-[ACT_Cargos:173]Monto_IVA:20
				End if 
				
				[ACT_Cargos:173]Saldo:23:=[ACT_Cargos:173]MontosPagados:8-[ACT_Cargos:173]Monto_Neto:5
				SAVE RECORD:C53([ACT_Cargos:173])
				
				KRL_UnloadReadOnly (->[ACT_Cargos:173])
			End if 
			
		End for 
		  //##### Deja en 0 avisos que estaban pagados para que no queden con monto a pagar 1 #####
		ACTmnu_RecalcularSaldosAvisos (->$alACT_recNumsAC)
		
		IT_UThermometer (0;$l_proc;"Recalculando saldos de apoderados...")
		QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
		SELECTION TO ARRAY:C260([Personas:7];$alACT_recNumsApdos)
		
		For ($i;1;Size of array:C274($alACT_recNumsApdos))
			$done:=ACTpp_RecalculaSaldoApdo ($alACT_recNumsApdos{$i})
			If (Not:C34($done))
				BM_CreateRequest ("ACTpp_Calcula_Montos_Ejercicio";String:C10($alACT_recNumsApdos{$i}))
			End if 
		End for 
		
		IT_UThermometer (-2;$l_proc)
		SET_ClearSets ("setPagos";"pagosAviso";"cargosTodos")
	End if 
End if 
