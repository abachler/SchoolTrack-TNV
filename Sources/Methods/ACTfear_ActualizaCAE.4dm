//%attributes = {}
  //ACTfear_ActualizaCAE
TRACE:C157
C_REAL:C285($r_records)
C_TEXT:C284($t_mensaje;$t_caeAsignado)
C_OBJECT:C1216($ob_respuesta;$ob_error;$ob_datos)

If (USR_GetMethodAcces ("ACTfear_ObtenerCodigoAutElect"))  //Se valida el mismo permiso que para obtener cae
	
	$r_records:=BWR_SearchRecords 
	
	If ($r_records#-1)
		READ ONLY:C145([ACT_Boletas:181])
		
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214;*)
		QUERY SELECTION:C341([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
		
		If (Records in selection:C76([ACT_Boletas:181])>0)
			CREATE SET:C116([ACT_Boletas:181];"setBoletas")
			
			ARRAY LONGINT:C221($alACT_idsRS;0)
			DISTINCT VALUES:C339([ACT_Boletas:181]ID_RazonSocial:25;$alACT_idsRS)
			
			If (Find in array:C230($alACT_idsRS;0)>0)
				$alACT_idsRS{Find in array:C230($alACT_idsRS;0)}:=-1
			End if 
			
			For ($l_indice;1;Size of array:C274($alACT_idsRS))
				ACTfear_OpcionesGenerales ("CargaConf";->$alACT_idsRS{$l_indice})
				If (vtACT_errorPHPExec="")
					If (vtACT_workstation=Current machine:C483)
						USE SET:C118("setBoletas")
						QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]ID_RazonSocial:25=$alACT_idsRS{$l_indice})
						
						ARRAY LONGINT:C221($alACT_idsBoleta;0)
						SELECTION TO ARRAY:C260([ACT_Boletas:181]ID:1;$alACT_idsBoleta)
						
						For ($l_indiceDT;1;Size of array:C274($alACT_idsBoleta))
							READ WRITE:C146([ACT_Boletas:181])
							KRL_FindAndLoadRecordByIndex (->[ACT_Boletas:181]ID:1;->$alACT_idsBoleta{$l_indiceDT};True:C214)
							If (ok=1)
								If ([ACT_Boletas:181]AR_CAEcodigo:48#"")
									$l_resp:=CD_Dlog (0;"El documento tiene CAE "+ST_Qte ([ACT_Boletas:181]AR_CAEcodigo:48)+". ¿Desea continuar?";"";"Si";"No")
								Else 
									$l_resp:=1
								End if 
								If ($l_resp=1)
									$ob_respuesta:=ACTfear_FEVerificaCAE ($alACT_idsRS{$l_indice};Num:C11([ACT_Boletas:181]codigo_SII:33);[ACT_Boletas:181]Numero:11;[ACT_Boletas:181]AR_CodigoPtoVenta:47)
									$ob_error:=OB Get:C1224($ob_respuesta;"error")
									$ob_datos:=OB Get:C1224($ob_respuesta;"datos")
									
									If ((OB Get:C1224($ob_error;"codigo")=0) & (OB Get:C1224($ob_datos;"cae")#""))
										[ACT_Boletas:181]AR_CAEcodigo:48:=OB Get:C1224($ob_datos;"cae")
										[ACT_Boletas:181]AR_CAEvencimiento:49:=DTS_GetDate (OB Get:C1224($ob_datos;"fecha"))
										LOG_RegisterEvt ("CAE actualizado para DT id "+String:C10([ACT_Boletas:181]ID:1)+". CAE anterior: "+ST_Qte (Old:C35([ACT_Boletas:181]AR_CAEcodigo:48))+", fecha anterior: "+ST_Qte (String:C10(Old:C35([ACT_Boletas:181]AR_CAEvencimiento:49)))+". Nuevo CAE: "+ST_Qte ([ACT_Boletas:181]AR_CAEcodigo:48)+". Nueva fecha: "+ST_Qte (String:C10([ACT_Boletas:181]AR_CAEvencimiento:49))+".")
										SAVE RECORD:C53([ACT_Boletas:181])
										$t_caeAsignado:=$t_caeAsignado+"CAE: "+[ACT_Boletas:181]AR_CAEcodigo:48+" asignado a D.T. id "+String:C10([ACT_Boletas:181]ID:1)+"."+<>cr
									Else 
										$l_indiceDT:=Size of array:C274($alACT_idsBoleta)
										$l_indice:=Size of array:C274($alACT_idsRS)
										$t_mensaje:=OB Get:C1224($ob_error;"descripcion")
									End if 
								End if 
							Else 
								$l_indiceDT:=Size of array:C274($alACT_idsBoleta)
								$l_indice:=Size of array:C274($alACT_idsRS)
								$t_mensaje:=__ ("Habían registros en uso. La operación fue interrumpida.")
							End if 
							KRL_UnloadReadOnly (->[ACT_Boletas:181])
						End for 
					Else   //20170802 RCH
						$t_mensaje:=__ ("El computador no corresponde a lo configurado en las Facturas Electrónicas.")
					End if 
				End if 
			End for 
			
			If (($t_mensaje="") & ($t_caeAsignado#""))
				$t_mensaje:="CAE actualizado: "+<>cr+$t_caeAsignado
			Else 
				If ($t_caeAsignado#"")
					$t_mensaje:=$t_mensaje+<>cr+<>cr+"Algunos CAE lograron ser obtenidos: "+$t_caeAsignado+"."
				End if 
			End if 
			If ($t_mensaje#"")
				CD_Dlog (0;$t_mensaje)
			End if 
			SET_ClearSets ("setBoletas")
			
		Else 
			CD_Dlog (0;"No hay documentos electrónicos no nulos en la selección de documentos.")
		End if 
		
	Else 
		CD_Dlog (0;"Debe tener seleccionado algún documento en el explorador.")
	End if 
	
End if 