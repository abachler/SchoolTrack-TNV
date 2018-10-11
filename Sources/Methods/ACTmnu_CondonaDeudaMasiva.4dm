//%attributes = {}
  //ACTmnu_CondonaDeudaMasiva

  //ACTmnu_CondonaDeudaMasiva En Construccion...

If (USR_GetMethodAcces (Current method name:C684))
	C_LONGINT:C283($vl_records;$i;$resp)
	C_TEXT:C284($vt_dlog)
	C_LONGINT:C283(vlACT_recNumAC)
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	If (Application type:C494#4D Server:K5:6)
		If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
			If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Avisos_de_Cobranza:124]))
				ARRAY LONGINT:C221(al_recNumAvisos;0)
				ARRAY LONGINT:C221($al_recNumAvisos2Recalc;0)
				$vl_records:=BWR_SearchRecords (->[ACT_Avisos_de_Cobranza:124])
				If ($vl_records#-1)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];al_recNumAvisos;"")
					
					ARRAY LONGINT:C221(alACT_tasaIVA;0)
					ARRAY REAL:C219(alACT_montosCargosMPago;0)
					ARRAY LONGINT:C221(alACT_idCtaCte;0)
					ARRAY LONGINT:C221(alACT_recNumCargos;0)
					ARRAY LONGINT:C221(alACT_idCargoRelacionado;0)
					
					ARRAY REAL:C219(alACT_AvisosSaldo;0)
					ARRAY REAL:C219(alACT_AvisosMontoCondonacion;0)
					ARRAY TEXT:C222(alACT_AvisosGlosaCargo;0)
					ARRAY LONGINT:C221(alACT_AvisosRecNumCargo;0)
					ARRAY LONGINT:C221(alACT_AvisosIDCargo;0)
					
					For ($i;1;Size of array:C274(al_recNumAvisos))
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						READ ONLY:C145([ACT_Cargos:173])
						READ ONLY:C145([ACT_Transacciones:178])
						
						vlACT_recNumAC:=al_recNumAvisos{$i}
						
						GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];vlACT_recNumAC)
						QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Comprobante:10=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
						QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=0)
						KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
						CREATE SET:C116([ACT_Cargos:173];"setCargosTodos")
						
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5<0;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
						CREATE SET:C116([ACT_Cargos:173];"setCargosDcto")
						
						If (Records in set:C195("setCargosDcto")>0)
							
							LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];alACT_recNumCargos;"")
							For ($x;1;Size of array:C274(alACT_recNumCargos))
								GOTO RECORD:C242([ACT_Cargos:173];alACT_recNumCargos{$x})
								APPEND TO ARRAY:C911(alACT_tasaIVA;[ACT_Cargos:173]TasaIVA:21)
								APPEND TO ARRAY:C911(alACT_idCtaCte;[ACT_Cargos:173]ID_CuentaCorriente:2)
								  //APPEND TO ARRAY(alACT_montosCargosMPago;ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMEmision";->[ACT_Cargos]Saldo;->[ACT_Cargos]Saldo;Current date(*)))
								APPEND TO ARRAY:C911(alACT_montosCargosMPago;ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*)))
								APPEND TO ARRAY:C911(alACT_idCargoRelacionado;[ACT_Cargos:173]ID_CargoRelacionado:47)
							End for 
							vbACT_HayDctosSeparados:=True:C214
							AT_MultiLevelSort ("<>>>>";->alACT_idCargoRelacionado;->alACT_idCtaCte;->alACT_recNumCargos;->alACT_montosCargosMPago;->alACT_tasaIVA)
						Else 
							vbACT_HayDctosSeparados:=False:C215
						End if 
						
						  //dejo en primer lugar los items de descuento que estan asociados a cargos...
						  //AT_MultiLevelSort ("<>>>>";->alACT_idCargoRelacionado;->alACT_idCtaCte;->alACT_recNumCargos;->alACT_montosCargosMPago;->alACT_tasaIVA)
						
						USE SET:C118("setCargosTodos")
						SET_ClearSets ("setCargosDcto";"setCargosTodos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
						APPEND TO ARRAY:C911($al_recNumAvisos2Recalc;al_recNumAvisos{$i})
						If (Records in selection:C76([ACT_Cargos:173])>0)
							
							  //SELECTION TO ARRAY([ACT_Cargos]Glosa;alACT_AvisosGlosaCargo;[ACT_Cargos]Saldo;alACT_AvisosSaldo;[ACT_Cargos];alACT_AvisosRecNumCargo;[ACT_Cargos]ID;alACT_AvisosIDCargo)
							
							SELECTION TO ARRAY:C260([ACT_Cargos:173]Glosa:12;$alACT_AvisosGlosaCargo;[ACT_Cargos:173]Saldo:23;$alACT_AvisosSaldo;[ACT_Cargos:173];$alACT_AvisosRecNumCargo;[ACT_Cargos:173]ID:1;$alACT_AvisosIDCargo)
							
							$vl_inicio:=Size of array:C274(alACT_AvisosGlosaCargo)+1
							For ($j;1;Size of array:C274($alACT_AvisosGlosaCargo))
								APPEND TO ARRAY:C911(alACT_AvisosGlosaCargo;$alACT_AvisosGlosaCargo{$j})
								APPEND TO ARRAY:C911(alACT_AvisosSaldo;$alACT_AvisosSaldo{$j})
								APPEND TO ARRAY:C911(alACT_AvisosRecNumCargo;$alACT_AvisosRecNumCargo{$j})
								APPEND TO ARRAY:C911(alACT_AvisosIDCargo;$alACT_AvisosIDCargo{$j})
							End for 
							
							For ($j;$vl_inicio;Size of array:C274(alACT_AvisosRecNumCargo))
								GOTO RECORD:C242([ACT_Cargos:173];alACT_AvisosRecNumCargo{$j})
								QUERY:C277([xxACT_Items:179];[xxACT_Items:179]ID:1=[ACT_Cargos:173]Ref_Item:16)
								If (Records in selection:C76([xxACT_Items:179])=1)
									alACT_AvisosGlosaCargo{$j}:=[xxACT_Items:179]Glosa:2
								End if 
								
								If (vbACT_HayDctosSeparados)
									$iD_CtaCteCargo:=[ACT_Cargos:173]ID_CuentaCorriente:2
									$iva:=[ACT_Cargos:173]TasaIVA:21
									$vt_moneda:=ST_Boolean2Str ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11;[ACT_Cargos:173]Moneda:28;ST_GetWord (ACT_DivisaPais ;1;";"))
									ARRAY LONGINT:C221($al_result1;0)
									ARRAY LONGINT:C221($al_result2;0)
									ARRAY LONGINT:C221($al_result3;0)
									
									alACT_idCtaCte{0}:=$iD_CtaCteCargo
									AT_SearchArray (->alACT_idCtaCte;"=";->$al_result1)
									
									alACT_tasaIVA{0}:=0
									If ($iva=0)
										AT_SearchArray (->alACT_tasaIVA;"=";->$al_result2)
									Else 
										AT_SearchArray (->alACT_tasaIVA;"#";->$al_result2)
									End if 
									AT_intersect (->$al_result1;->$al_result2;->$al_result3)
									
									
									
									$vr_montoDcto:=0
									$vl_idCargo:=[ACT_Cargos:173]ID:1
									For ($y;1;Size of array:C274($al_result3))
										If ((alACT_idCargoRelacionado{$al_result3{$y}}=0) | ($vl_idCargo=alACT_idCargoRelacionado{$al_result3{$y}}))
											GOTO RECORD:C242([ACT_Cargos:173];alACT_recNumCargos{$al_result3{$y}})
											$vr_monto:=alACT_montosCargosMPago{$al_result3{$y}}
											$vr_montoDctoMoneda:=ACTcar_CalculaSaldo ("retornaPagoMonedaCargo";Current date:C33(*);->$vr_monto;->$vt_moneda)
											If ($vr_montoDctoMoneda>Abs:C99(alACT_AvisosSaldo{$j}))
												$vr_montoDctoMoneda:=Abs:C99(alACT_AvisosSaldo{$j})
											End if 
											$vr_montoDcto:=$vr_montoDcto+$vr_montoDctoMoneda
											
											$vr_montoMonedaPago:=ACTut_retornaMontoEnMoneda ($vr_montoDctoMoneda;$vt_moneda;Current date:C33(*);ST_GetWord (ACT_DivisaPais ;1;";"))
											alACT_montosCargosMPago{$al_result3{$y}}:=Round:C94(alACT_montosCargosMPago{$al_result3{$y}}-$vr_montoMonedaPago;11)
										End if 
									End for 
								Else 
									$vr_montoDcto:=0
								End if 
								$vr_montoDcto:=$vr_montoDcto*-1
								alACT_AvisosSaldo{$j}:=Abs:C99(alACT_AvisosSaldo{$j})+$vr_montoDcto
								APPEND TO ARRAY:C911(alACT_AvisosMontoCondonacion;alACT_AvisosSaldo{$j})
							End for 
							
						Else 
							  //CD_Dlog (0;"No hay cargos con saldo dentro de la selección de avisos de cobranza.")
						End if 
					End for 
					
					If (Size of array:C274(alACT_AvisosRecNumCargo)>0)
						WDW_OpenFormWindow (->[ACT_Cargos:173];"ACT_CondonarDeuda";0;4;"Condonación de deuda para el aviso "+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
						DIALOG:C40([ACT_Cargos:173];"ACT_CondonarDeuda")
						CLOSE WINDOW:C154
					Else 
						CD_Dlog (0;"No hay cargos con saldo dentro de la selección de avisos de cobranza.")
					End if 
					
					POST KEY:C465(-96)
				Else 
					CD_Dlog (0;"Este comando opera sobre los avisos seleccionados.")
				End if 
				ARRAY LONGINT:C221(al_recNumAvisos;0)
				ARRAY LONGINT:C221($al_recNumAvisos2Recalc;0)
				ARRAY LONGINT:C221(alACT_AvisosRefItem;0)
				ARRAY TEXT:C222(alACT_AvisosGlosaCargo;0)
				ARRAY REAL:C219(alACT_AvisosSaldo;0)
				ARRAY REAL:C219(alACT_AvisosMontoCondonacion;0)
				ARRAY TEXT:C222(alACT_AvisosGlosaCargo;0)
				ARRAY LONGINT:C221(alACT_AvisosRecNumCargo;0)
				ARRAY PICTURE:C279(apACT_AvisosCargoSel;0)
				ARRAY BOOLEAN:C223(abACT_AvisosCargoSel;0)
				ARRAY LONGINT:C221(alACT_AvisosIDCargo;0)
			End if 
		End if 
	End if 
End if 