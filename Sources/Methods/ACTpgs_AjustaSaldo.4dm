//%attributes = {}
  //ACTpgs_AjustaSaldo

If (Application type:C494#4D Server:K5:6)
	If (USR_GetMethodAcces (Current method name:C684))
		If (Not:C34(Is nil pointer:C315(yBWR_currentTable)))
			If (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagos:172]))
				
				C_LONGINT:C283($i;$vl_resp;$vl_lockedRec;$vl_id_item;$vl_recNum;$cb_NoPrepagarAuto;$vl_idPago;$vl_proc)
				C_REAL:C285($vr_disponible)
				C_TEXT:C284($vt_msj)
				ARRAY LONGINT:C221($alACT_recNums_Pagos;0)
				ARRAY LONGINT:C221(alACT_idsItems;0)
				ARRAY TEXT:C222(atACT_glosasItems;0)
				
				ACTpgs_DeclareArraysCargos   //se declaran 2 arreglos utilizados en ACTpgs_CreaCargo...
				
				READ ONLY:C145([ACT_Pagos:172])
				READ ONLY:C145([ACT_Cargos:173])
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
				READ ONLY:C145([xxACT_Items:179])
				
				BWR_SearchRecords 
				QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]Saldo:15>0)
				If (Records in selection:C76([ACT_Pagos:172])>0)
					ACTqry_Items ("CargosNoRelativosNoEspecialesNoIntereses")
					ORDER BY:C49([xxACT_Items:179];[xxACT_Items:179]Glosa:2;>;[xxACT_Items:179]ID:1;>)
					SELECTION TO ARRAY:C260([xxACT_Items:179]ID:1;alACT_idsItems;[xxACT_Items:179]Glosa:2;atACT_glosasItems)
					ARRAY POINTER:C280(<>aChoicePtrs;0)
					ARRAY POINTER:C280(<>aChoicePtrs;2)
					<>aChoicePtrs{1}:=->alACT_idsItems
					<>aChoicePtrs{2}:=->atACT_glosasItems
					TBL_ShowChoiceList (0;__ ("Seleccione un cargo");2)
					If (ok=1)
						$vl_id_item:=alACT_idsItems{choiceIdx}
						If (KRL_GetBooleanFieldData (->[xxACT_Items:179]ID:1;->$vl_id_item;->[xxACT_Items:179]Imputacion_Unica:24))
							$vt_msj:=__ ("¡¡¡ ATENCIÓN !!! El ítem de cargo seleccionado está configurado como Ítem de Imputación Única. Si ya existe un cargo emitido para el presente mes, el monto disponible del pago no será utilizado.")+"\r\r"
						Else 
							$vt_msj:=""
						End if 
						$vt_msj:=$vt_msj+__ ("Se ajustará el monto disponible de ")+String:C10(Records in selection:C76([ACT_Pagos:172]))+__ (" pago(s).")
						$vt_msj:=$vt_msj+"\r"+__ ("Se generarán cargos asociados al ítem ")+ST_Qte (atACT_glosasItems{choiceIdx})+" (id "+String:C10($vl_id_item)+") para realizar dicho ajuste."
						$vt_msj:=$vt_msj+"\r\r"+__ ("¿Desea continuar?")
						$vl_resp:=CD_Dlog (0;$vt_msj;"";__ ("Si");__ ("No"))
						If ($vl_resp=1)
							$vl_proc:=IT_UThermometer (1;0;__ ("Ajustando pagos")+"...")
							LONGINT ARRAY FROM SELECTION:C647([ACT_Pagos:172];$alACT_recNums_Pagos;"")
							ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")
							$cb_NoPrepagarAuto:=cb_NoPrepagarAuto
							For ($i;1;Size of array:C274($alACT_recNums_Pagos))
								IT_UThermometer (0;$vl_proc;__ ("Ajustando pagos")+" "+String:C10($i)+"/"+String:C10(Size of array:C274($alACT_recNums_Pagos))+"...")
								READ WRITE:C146([ACT_Pagos:172])
								GOTO RECORD:C242([ACT_Pagos:172];$alACT_recNums_Pagos{$i})
								If (Not:C34(Locked:C147([ACT_Pagos:172])))
									$vr_disponible:=[ACT_Pagos:172]Saldo:15
									$vl_idPago:=[ACT_Pagos:172]ID:1
									QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=[ACT_Pagos:172]ID:1;*)
									QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_CuentaCorriente:2#0)
									$vl_recNum:=ACTpgs_CreaCargo (True:C214;[ACT_Pagos:172]ID_Apoderado:3;$vr_disponible;$vl_id_item;False:C215;Current date:C33(*);False:C215;[ACT_Pagos:172]ID_Tercero:26;[ACT_Transacciones:178]ID_Item:3)
									If ($vl_recNum>=0)
										GOTO RECORD:C242([ACT_Cargos:173];$vl_recNum)
										KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3)
										KRL_FindAndLoadRecordByIndex (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15)
										  // 20110927 RCH esta preferencia se re leia y podia no prepagarse bien
										cb_NoPrepagarAuto:=0
										ACTac_Prepagar (Record number:C243([ACT_Avisos_de_Cobranza:124]);False:C215;False:C215;$vl_idPago)
									End if 
								Else 
									$vl_lockedRec:=$vl_lockedRec+1
								End if 
							End for 
							IT_UThermometer (-2;$vl_proc)
							cb_NoPrepagarAuto:=$cb_NoPrepagarAuto
							USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
							BWR_PanelSettings 
							BWR_SelectTableData 
							
							
							If ($vl_lockedRec>0)
								CD_Dlog (0;__ ("No fue posible ajustar el disponible de todos los pagos seleccionados. Intente nu"+"evamente más tarde."))
							End if 
						End if 
					End if 
				Else 
					CD_Dlog (0;__ ("Para utilizar esta opción usted debe seleccionar Pagos con monto disponible en el"+" explorador."))
				End if 
			End if 
		End if 
	End if 
End if 