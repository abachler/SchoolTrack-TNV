//%attributes = {}
  //ACTmnu_CondonaDeuda

If (USR_GetMethodAcces (Current method name:C684))
	
	  // Modificado por: Saúl Ponce (15/01/2018) Ticket 196343, declaraciones.
	C_LONGINT:C283($c;$t)
	C_REAL:C285($r_credito)
	C_BOOLEAN:C305($vb_condona)
	C_TEXT:C284($t_msj;$t_msj1)
	ARRAY LONGINT:C221($al_recNumCar;0)
	ARRAY LONGINT:C221($al_recNumTrx;0)
	ARRAY LONGINT:C221($al_idACNoCondona;0)
	
	
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
							ARRAY LONGINT:C221(alACT_tasaIVA;0)
							ARRAY REAL:C219(alACT_montosCargosMPago;0)
							ARRAY LONGINT:C221(alACT_idCtaCte;0)
							ARRAY LONGINT:C221(alACT_recNumCargos;0)
							ARRAY LONGINT:C221(alACT_idCargoRelacionado;0)
							
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
						
						If (False:C215)
							  // Modificado por: Saúl Ponce (15/01/2018) Ticket 196343, esto no quedó bien. No se pueden condonar cargos parcialmente pagados.
							  // Modificado por: Saúl Ponce (15/11/2017) Ticket Nº 188278, impedir que se condonen cargos que ya participan en documentos tributarios
							  //C_BOOLEAN($vb_avisado)
							  //$vb_avisado:=False
							  //KRL_RelateSelection (->[ACT_Transacciones]ID_Item;->[ACT_Cargos]ID;"")
							  //QUERY SELECTION([ACT_Transacciones];[ACT_Transacciones]No_Boleta>0)
							  //KRL_RelateSelection (->[ACT_Cargos]ID;->[ACT_Transacciones]ID_Item;"")
							  //If (Records in selection([ACT_Cargos])>0)
							  //CD_Dlog (0;__ ("El saldo pendiente en el aviso de cobranza número "+String([ACT_Avisos_de_Cobranza]ID_Aviso)+", pertenece a uno o más documentos tributarios. No es posible efectuar la condonación."))
							  //$vb_avisado:=True
							  //End if 
							  //CREATE SET([ACT_Cargos];"$car_boleteados")
							  //DIFFERENCE("setCargosTodos";"$car_boleteados";"setCargosTodos")
							  //CLEAR SET("$car_boleteados")
							  //USE SET("setCargosTodos")
						End if 
						
						  // Modificado por: Saúl Ponce (15/01/2018) Ticket 196343, determinar si el cargo tiene un saldo que se pueda condonar (que no esté en boleta).
						If (True:C214)
							CREATE EMPTY SET:C140([ACT_Cargos:173];"$carCondonar")
							QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23<0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173];$al_recNumCar)
							For ($c;1;Size of array:C274($al_recNumCar))
								GOTO RECORD:C242([ACT_Cargos:173];$al_recNumCar{$c})
								If ([ACT_Cargos:173]Saldo:23<0)
									
									  // Modificado por: Saúl Ponce (20/02/2018) Ticket 198780, cuando la transacción de crédito está dividida no se puede condonar con este procedimiento
									
									  //QUERY([ACT_Transacciones];[ACT_Transacciones]ID_Item=[ACT_Cargos]ID;*)
									  //QUERY([ACT_Transacciones]; & ;[ACT_Transacciones]Credito>0)
									  //SELECTION TO ARRAY([ACT_Transacciones];$al_recNumTrx)
									  //For ($t;1;Size of array($al_recNumTrx))
									  //GOTO RECORD([ACT_Transacciones];$al_recNumTrx{$t})
									  //$r_credito:=ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones]Credito)
									  //If ([ACT_Transacciones]No_Boleta=0)
									  //If ($r_credito=[ACT_Cargos]Monto_Neto)
									  //$vb_condona:=True
									  //ADD TO SET([ACT_Cargos];"$carCondonar")
									  //Else 
									  //If (Abs([ACT_Cargos]Saldo)=$r_credito)
									  //$vb_condona:=True
									  //ADD TO SET([ACT_Cargos];"$carCondonar")
									  //Else 
									  //$vb_condona:=False
									  //End if 
									  //End if 
									  //Else 
									  //$vb_condona:=False
									  //End if 
									  //End for 
									
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1)
									SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNumTrx)
									$r_creditoTotal:=ACTtra_CalculaMontos ("CalculaFromRecNum";->$al_recNumTrx;->[ACT_Transacciones:178]Credito:7)
									$r_debitoTotal:=ACTtra_CalculaMontos ("CalculaFromRecNum";->$al_recNumTrx;->[ACT_Transacciones:178]Debito:6)
									$r_condonarTotal:=($r_creditoTotal-$r_debitoTotal)
									
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]Credito:7>0)
									SELECTION TO ARRAY:C260([ACT_Transacciones:178];$al_recNumTrx)
									For ($t;1;Size of array:C274($al_recNumTrx))
										GOTO RECORD:C242([ACT_Transacciones:178];$al_recNumTrx{$t})
										If ([ACT_Transacciones:178]No_Boleta:9=0)
											$r_credito:=ACTtra_CalculaMontos ("FromCurrentRecord";->[ACT_Transacciones:178]Credito:7)
											If ($r_credito=[ACT_Cargos:173]Monto_Neto:5)
												$vb_condona:=True:C214
												ADD TO SET:C119([ACT_Cargos:173];"$carCondonar")
											End if 
											If (Abs:C99([ACT_Cargos:173]Saldo:23)=$r_credito)
												$vb_condona:=True:C214
												ADD TO SET:C119([ACT_Cargos:173];"$carCondonar")
											End if 
											  // si la transacción de crédito está dividida, entra en este caso y permite condonar
											If ($r_credito<=$r_condonarTotal)
												$vb_condona:=True:C214
												ADD TO SET:C119([ACT_Cargos:173];"$carCondonar")
											End if 
										Else 
											$vb_condona:=False:C215
										End if 
									End for 
									
									
								End if 
							End for 
							USE SET:C118("$carCondonar")
							If (Records in set:C195("$carCondonar")=0)
								APPEND TO ARRAY:C911($al_idACNoCondona;[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
							End if 
							CLEAR SET:C117("$carCondonar")
						End if 
						
						SET_ClearSets ("setCargosDcto";"setCargosTodos")
						QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Monto_Neto:5>0;*)
						QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
						APPEND TO ARRAY:C911($al_recNumAvisos2Recalc;al_recNumAvisos{$i})
						If (Records in selection:C76([ACT_Cargos:173])>0)
							ARRAY REAL:C219(alACT_AvisosSaldo;0)
							ARRAY REAL:C219(alACT_AvisosMontoCondonacion;0)
							ARRAY TEXT:C222(alACT_AvisosGlosaCargo;0)
							ARRAY LONGINT:C221(alACT_AvisosRecNumCargo;0)
							ARRAY LONGINT:C221(alACT_AvisosIDCargo;0)
							SELECTION TO ARRAY:C260([ACT_Cargos:173]Glosa:12;alACT_AvisosGlosaCargo;[ACT_Cargos:173]Saldo:23;alACT_AvisosSaldo;[ACT_Cargos:173];alACT_AvisosRecNumCargo;[ACT_Cargos:173]ID:1;alACT_AvisosIDCargo)
							For ($j;1;Size of array:C274(alACT_AvisosRecNumCargo))
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
							
							WDW_OpenFormWindow (->[ACT_Cargos:173];"ACT_CondonarDeuda";0;4;__ ("Condonación de deuda para el aviso de cobranza número ")+String:C10([ACT_Avisos_de_Cobranza:124]ID_Aviso:1))
							DIALOG:C40([ACT_Cargos:173];"ACT_CondonarDeuda")
							CLOSE WINDOW:C154
							
							If ($i#Size of array:C274(al_recNumAvisos))
								$resp:=CD_Dlog (0;__ ("¿Desea continuar condonando deuda?");__ ("");__ ("Si");__ ("No"))
								If ($resp=2)
									$i:=Size of array:C274(al_recNumAvisos)
								End if 
							End if 
							  // Modificado por: Saúl Ponce (15/01/2018) Ticket 196343, esto ya no es necesario
							  //Else 
							  //If (Not($vb_avisado))  // Modificado por: Saúl Ponce (15/11/2017) Ticket Nº 188278, incluí esto para no entregar un doble mensaje.
							  //CD_Dlog (0;__ ("No hay cargos con saldo dentro de la selección de avisos de cobranza."))
							  //End if 
						End if 
					End for 
					POST KEY:C465(-96)
				Else 
					CD_Dlog (0;__ ("Este comando opera sobre los avisos seleccionados."))
				End if 
				
				  // Modificado por: Saúl Ponce (15/01/2018) Ticket 196343
				  // Determinar si mostrar mensaje al usuario sobre la existencia de avisos de cobranza que no pueden ser condonados.
				If (Size of array:C274($al_idACNoCondona)>0)
					If (Size of array:C274($al_idACNoCondona)=1)
						$t_msj:=__ ("El saldo pendiente en el aviso de cobranza número "+String:C10($al_idACNoCondona{1})+", pertenece a uno o más documentos tributarios.")
					Else 
						SORT ARRAY:C229($al_idACNoCondona;>)
						$t_msj1:=AT_array2text (->$al_idACNoCondona;"; ")
						$t_msj:=__ ("El saldo pendiente en los avisos de cobranza números: \r")+$t_msj1+__ (", pertenecen a uno o más documentos tributarios ")
					End if 
					$t_msj:=$t_msj+__ ("\r\rNo es posible efectuar la condonación.")
					CD_Dlog (0;$t_msj)
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