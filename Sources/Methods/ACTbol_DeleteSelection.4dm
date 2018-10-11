//%attributes = {}
  //ACTbol_DeleteSelection
  //metodo que elimina boletas nulas. Para AR se reasignan los folios siguientes. Para el resto solo se elimina.

  //20171115 RCH Se valida solo por id de documento y no se considera el id de la RS que aveces podría estar con valor 0.

C_LONGINT:C283($del)
$0:=0
If (USR_checkRights ("D";->[ACT_Boletas:181]))
	
	QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_Estado:20=4)
	If (Records in selection:C76([ACT_Boletas:181])>0)
		$r:=CD_Dlog (0;__ ("La eliminación de Documentos Tributarios nulos no toma en cuenta el motivo de la anulación y es irreversible.\r¿Desea continuar?")+"\r\r"+"Se eliminará(n) "+String:C10(Records in selection:C76([ACT_Boletas:181]))+" Documento(s) Tributario(s).";"";__ ("Si");__ ("No"))
		If ($r=1)
			ARRAY LONGINT:C221($al_idsBol;0)
			ARRAY TEXT:C222($at_tiposBol;0)
			ARRAY LONGINT:C221($al_numsBol;0)
			ARRAY LONGINT:C221($al_idTipo;0)
			ARRAY LONGINT:C221($al_idRS;0)
			
			START TRANSACTION:C239
			
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]TipoDocumento:7;>;[ACT_Boletas:181]Numero:11;>;[ACT_Boletas:181]ID:1;>)
			SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$al_idsBol;[ACT_Boletas:181]TipoDocumento:7;$at_tiposBol;[ACT_Boletas:181]Numero:11;$al_numsBol;[ACT_Boletas:181]ID_Documento:13;$al_idTipo;[ACT_Boletas:181]ID_RazonSocial:25;$al_idRS)
			$del:=KRL_DeleteSelection (->[ACT_Boletas:181];True:C214;__ ("Eliminando Documentos Tributarios nulos..."))
			If ($del=0)
				CD_Dlog (0;__ ("La selección  no pudo ser eliminada."))
			Else 
				C_TEXT:C284($t_log)
				C_LONGINT:C283($l_indice)
				For ($l_indice;1;Size of array:C274($al_idsBol))
					$t_log:=Choose:C955($t_log="";"";$t_log+"; ")+"Tipo de documento: "+$at_tiposBol{$l_indice}+", folio:"+String:C10($al_numsBol{$l_indice})+", Idbol: "+String:C10($al_idsBol{$l_indice})
				End for 
				LOG_RegisterEvt ("Eliminación de documentos tributarios: "+$t_log+".")
				
				
				If (<>gCountryCode="ar")
					  //AT_DistinctsArrayValues (->$al_idRS)// no se deja unico porque con esto se buscaran los distintos tipos de documentos que pudieran haber eliminado
					READ ONLY:C145([ACT_RazonesSociales:279])
					QUERY WITH ARRAY:C644([ACT_RazonesSociales:279]id:1;$al_idRS)
					QUERY SELECTION:C341([ACT_RazonesSociales:279];[ACT_RazonesSociales:279]emisor_electronico:30=True:C214)
					
					If (Records in selection:C76([ACT_RazonesSociales:279])>0)
						AT_DistinctsArrayValues (->$al_idTipo)
						For ($l_indice;1;Size of array:C274($al_idTipo))
							READ ONLY:C145([ACT_Boletas:181])
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=$al_idTipo{$l_indice};*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215;*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]AR_CAEcodigo:48#"";*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
							
							ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;<)
							
							$l_desde:=[ACT_Boletas:181]Numero:11
							
							READ WRITE:C146([ACT_Boletas:181])
							QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=$al_idTipo{$l_indice};*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11>$l_desde;*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215;*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]AR_CAEcodigo:48="";*)
							QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
							
							If (Records in selection:C76([ACT_Boletas:181])>0)  //hay boletas con folio con numero superior...
								  //quito los que puedas estar correlativos
								CREATE SET:C116([ACT_Boletas:181];"setBoletas")
								ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
								While (Not:C34(End selection:C36([ACT_Boletas:181])))
									If ([ACT_Boletas:181]Numero:11=($l_desde+1))
										REMOVE FROM SET:C561([ACT_Boletas:181];"setBoletas")
										$l_desde:=$l_desde+1
									Else 
										LAST RECORD:C200([ACT_Boletas:181])
									End if 
									NEXT RECORD:C51([ACT_Boletas:181])
								End while 
								USE SET:C118("setBoletas")
								
								
								If (Records in selection:C76([ACT_Boletas:181])>0)  //hay boletas con folio con numero superior...
									QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=$al_idTipo{$l_indice};*)
									QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=True:C214;*)
									QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]AR_CAEcodigo:48="";*)
									QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
									CREATE SET:C116([ACT_Boletas:181];"posiblesNulos")
									C_TEXT:C284($t_mensajeAnulados)
									$t_mensajeAnulados:=""
									If (Records in selection:C76([ACT_Boletas:181])>0)
										$t_mensajeAnulados:=__ ("Para el mismo tipo de documento hay otro")+Choose:C955(Records in selection:C76([ACT_Boletas:181])>1;"(s)";"")+__ (" documento(s) nulo(s). Si continúa, dicho(s) Documento(s) también será(n) eliminado(s).")
									End if 
									
									$l_resp:=CD_Dlog (0;__ ("Hay Documentos Tributarios no nulos con numeración posterior al folio eliminado. Para dichos Documentos no podrá obtener el CAE debido a que se producirá un salto en la numeración.")+"\r\r"+__ ("Si continúa se reasignarán los folios de dichos Documentos Tributarios para mantener la correlatividad.")+Choose:C955($t_mensajeAnulados="";"";"\r\r"+$t_mensajeAnulados)+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
									If ($l_resp=1)
										
										  //elimino los nulos porque podrían causar problemas al reasignar y se deja en log
										USE SET:C118("posiblesNulos")
										ARRAY LONGINT:C221($al_idsBol2;0)
										ARRAY TEXT:C222($at_tiposBol2;0)
										ARRAY LONGINT:C221($al_numsBol2;0)
										SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$al_idsBol2;[ACT_Boletas:181]TipoDocumento:7;$at_tiposBol2;[ACT_Boletas:181]Numero:11;$al_numsBol2)
										$del:=KRL_DeleteSelection (->[ACT_Boletas:181];True:C214;__ ("Eliminando Documentos Tributarios nulos..."))
										If ($del=0)
											CD_Dlog (0;__ ("La selección  no pudo ser eliminada."))
											$l_indice:=Size of array:C274($al_idTipo)
										Else 
											
											$t_log:=""
											For ($l_indiceLog;1;Size of array:C274($al_idsBol2))
												$t_log:=Choose:C955($t_log="";"";$t_log+"; ")+"Tipo de documento: "+$at_tiposBol2{$l_indiceLog}+", folio:"+String:C10($al_numsBol2{$l_indiceLog})+", Idbol: "+String:C10($al_idsBol2{$l_indiceLog})
											End for 
											LOG_RegisterEvt ("Eliminación de documentos tributarios: "+$t_log+".")
											
											  //reasignar folios
											ARRAY LONGINT:C221($alACT_num;0)
											ARRAY LONGINT:C221($alACT_idParaLog;0)
											ARRAY TEXT:C222($atACT_tipoParaLog;0)
											READ WRITE:C146([ACT_Boletas:181])
											USE SET:C118("setBoletas")
											ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;>)
											SELECTION TO ARRAY:C260([ACT_Boletas:181]Numero:11;$alACT_num;[ACT_Boletas:181]ID:1;$alACT_idParaLog;[ACT_Boletas:181]TipoDocumento:7;$atACT_tipoParaLog)
											
											For ($l_indiceIds;1;Size of array:C274($alACT_num))
												LOG_RegisterEvt ("Cambio de asignación automática de folios para el Documento Tributario Electrónico tipo: "+$atACT_tipoParaLog{$l_indiceIds}+", id: "+String:C10($alACT_idParaLog{$l_indiceIds})+". Folio anterior: "+String:C10($alACT_num{$l_indiceIds})+", nuevo folio asignado: "+String:C10($l_desde+$l_indiceIds)+".")
												$alACT_num{$l_indiceIds}:=$l_desde+$l_indiceIds
											End for 
											
											ARRAY TO SELECTION:C261($alACT_num;[ACT_Boletas:181]Numero:11)
											If (Records in set:C195("LockedSet")>0)
												$del:=0
												$l_indice:=Size of array:C274($al_idTipo)
											End if 
											
											  //verifico posible duplicación
											For ($l_indiceIds;1;Size of array:C274($alACT_num))
												QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=$al_idTipo{$l_indice};*)
												QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11=$alACT_num{$l_indiceIds};*)
												QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215;*)
												QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]AR_CAEcodigo:48="";*)
												QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
												If (Records in selection:C76([ACT_Boletas:181])>1)
													$del:=0
													$l_indice:=Size of array:C274($al_idTipo)
													CD_Dlog (0;__ ("Error de validación de documentos. La eliminación no pudo ser completada."))
												End if 
											End for 
											
										End if 
									End if 
									SET_ClearSets ("posiblesNulos")
								End if 
								
								SET_ClearSets ("setBoletas")
								
							End if 
							
							  //cambio en la numeración de la configuración
							If ($del=1)
								  //$l_pos:=Find in array(alACT_IDDT;$al_idDocRS{$l_indiceDocRS})
								$l_pos:=Find in array:C230(alACT_IDDT;$al_idTipo{$l_indice})
								
								If ($l_pos>0)
									C_LONGINT:C283($l_proximo)
									
									While (Semaphore:C143("NumeracionDT"))
										DELAY PROCESS:C323(Current process:C322;20)
									End while 
									
									ACTcfg_LoadConfigData (8)
									
									READ ONLY:C145([ACT_Boletas:181])
									QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Documento:13=$al_idTipo{$l_indice};*)
									QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
									ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]Numero:11;<)
									$l_proximo:=[ACT_Boletas:181]Numero:11+1
									$l_old:=alACT_Proxima{$l_pos}
									If ($l_old#$l_proximo)
										If (Test semaphore:C652("ProcesoACT"))
											$del:=0
											CD_Dlog (0;__ ("Se están ejecutando procesos que no permiten la modificación de la configuración de AccountTrack. Inténtelo de nuevo más tarde."))
										Else 
											If (Semaphore:C143("ConfigACT"))
												$del:=0
												CD_Dlog (0;__ ("La configuración de AccountTrack está siendo modificada por otro usuario.\rInténtelo más tarde.");__ ("");__ ("Aceptar"))
											Else 
												$l_resp:=CD_Dlog (0;__ ("Se modificará la numeración de la definición ")+atACT_NombreDoc{$l_pos}+", cambiará de "+String:C10($l_old)+" a "+String:C10($l_proximo)+"."+"\r\r"+__ ("¿Desea continuar?");"";__ ("Si");__ ("No"))
												  //cambiar próximo número en definiciones
												If ($l_resp=1)
													
													ACTcfg_LoadConfigData (8)
													alACT_Proxima{$l_pos}:=$l_proximo
													ACTcfg_SaveConfig (8)
													LOG_RegisterEvt ("Modificación de la numeración de "+atACT_NombreDoc{$l_pos}+" (id: "+String:C10(alACT_IDDT{$l_pos})+") de "+String:C10($l_old)+" a "+String:C10($l_proximo))
												Else 
													LOG_RegisterEvt ("El usuario eligió no cambiar la numeración de la definición "+atACT_NombreDoc{$l_pos}+" (id: "+String:C10(alACT_IDDT{$l_pos})+") de "+String:C10($l_old)+" a "+String:C10($l_proximo))
												End if 
											End if 
										End if 
									End if 
									
									CLEAR SEMAPHORE:C144("ConfigACT")
									CLEAR SEMAPHORE:C144("NumeracionDT")
									
								End if 
							End if 
							KRL_UnloadReadOnly (->[ACT_Boletas:181])
							  //End for 
						End for 
						
					End if 
				End if 
				
			End if 
			
			If ($del=1)
				VALIDATE TRANSACTION:C240
			Else 
				CANCEL TRANSACTION:C241
			End if 
			
		End if 
	Else 
		CD_Dlog (0;__ ("Solamente es posible eliminar Documentos Tributarios Nulos.")+"\r\r"+__ ("No hay Documentos Tributarios nulos entre los seleccionados."))
	End if 
	KRL_UnloadReadOnly (->[ACT_Boletas:181])
	
Else 
	USR_ALERT_UserHasNoRights (3)
End if 

$0:=$del