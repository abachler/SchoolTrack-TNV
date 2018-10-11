//%attributes = {}
  //ACTpgs_CambioEstado
  //20120528 RCH Se soporta cambio de estado de pagares y cambio desde documentos en cartera
If (USR_GetMethodAcces (Current method name:C684))
	
	$found:=BWR_SearchRecords 
	If ($found#-1)
		  //QUERY SELECTION([ACT_Pagos];[ACT_Pagos]Nulo=False)
		
		C_BOOLEAN:C305(vbACT_CEdesdePago;$vb_continuar)
		
		READ ONLY:C145([ACT_Documentos_en_Cartera:182])
		READ ONLY:C145([ACT_Pagares:184])
		READ ONLY:C145([ACT_Pagos:172])
		READ ONLY:C145([ACT_Documentos_de_Pago:176])
		
		vbACT_CEdesdePago:=False:C215
		Case of 
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagos:172]))
				vbACT_CEdesdePago:=True:C214
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Documentos_en_Cartera:182]))
				KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
				KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
				vbACT_CEdesdePago:=True:C214
				
			: (Table:C252(yBWR_currentTable)=Table:C252(->[ACT_Pagares:184]))
				vbACT_CEdesdePago:=False:C215
				
		End case 
		
		$vb_continuar:=False:C215
		If (vbACT_CEdesdePago)
			If (Records in selection:C76([ACT_Pagos:172])>0)
				If (USR_checkRights ("M";->[ACT_Pagos:172]))
					$vb_continuar:=True:C214
				Else 
					USR_ALERT_UserHasNoRights (3)
				End if 
			Else 
				CD_Dlog (0;__ ("No hay pagos seleccionados."))
			End if 
		Else 
			If (Records in selection:C76([ACT_Pagares:184])>0)
				If (USR_checkRights ("M";->[ACT_Pagares:184]))
					$vb_continuar:=True:C214
				Else 
					USR_ALERT_UserHasNoRights (3)
				End if 
			Else 
				CD_Dlog (0;__ ("No hay pagarés seleccionados."))
			End if 
		End if 
		
		
		If ($vb_continuar)
			  //If (USR_checkRights ("M";->[ACT_Pagos]))
			WDW_OpenFormWindow (->[ACT_EstadosFormasdePago:201];"CambioEstado";-1;4;"Cambio de estado")
			DIALOG:C40([ACT_EstadosFormasdePago:201];"CambioEstado")
			CLOSE WINDOW:C154
			
			If (ok=1)
				
				ARRAY LONGINT:C221($alACT_recNum;0)
				If (vbACT_CEdesdePago)
					LONGINT ARRAY FROM SELECTION:C647([ACT_Documentos_de_Pago:176];$alACT_recNum;"")
				Else 
					LONGINT ARRAY FROM SELECTION:C647([ACT_Pagares:184];$alACT_recNum;"")
				End if 
				
				If (Size of array:C274($alACT_recNum)>0)
					  //$r:=CD_Dlog (0;__ ("¿Desea realmente modificar los estados de los pagos seleccionados?. Los pagos nulos no serán modificados.");__ ("");__ ("No");__ ("Si"))
					$r:=CD_Dlog (0;__ ("¿Desea realmente modificar los estados de los registros seleccionados?");__ ("");__ ("No");__ ("Si"))
					If ($r=2)
						$l_ProgressProcID:=IT_Progress (1;0;$l_ProgressProcID;__ ("Cambiando estados..."))
						For ($i;1;Size of array:C274($alACT_recNum))
							If (vbACT_CEdesdePago)
								KRL_GotoRecord (->[ACT_Documentos_de_Pago:176];$alACT_recNum{$i};True:C214)
								ACTcfg_OpcionesCambioEstadoPago ("AsignaNuevoEstado";->vlACT_nuevoIDEstado2Asi)
								$vl_idRec:=Num:C11(ACTdp_fSave )
							Else 
								KRL_GotoRecord (->[ACT_Pagares:184];$alACT_recNum{$i};True:C214)
								$vl_idRec:=Num:C11(ACTcfg_OpcionesCambioEstadoPaga ("AsignaNuevoEstadoPagare";->vlACT_nuevoIDEstado2Asi))
							End if 
							If (($vl_idRec#0) & (vtACT_comentarioEstadoNew#""))
								KRL_FindAndLoadRecordByIndex (->[ACT_Movimientos_Estados:288]id:1;->$vl_idRec;True:C214)
								[ACT_Movimientos_Estados:288]comentario:19:=vtACT_comentarioEstadoNew
								SAVE RECORD:C53([ACT_Movimientos_Estados:288])  //20141219 RCH No se guarda el comentario.
							End if 
							KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
							KRL_UnloadReadOnly (->[ACT_Movimientos_Estados:288])
							$l_ProgressProcID:=IT_Progress (0;$l_ProgressProcID;$i/Size of array:C274($alACT_recNum))
						End for 
						ACTcfg_OpcionesCambioEstadoPago ("InicializaVars")
						$l_ProgressProcID:=IT_Progress (-1;$l_ProgressProcID)
						<>vb_Refresh:=True:C214
					End if 
				Else 
					CD_Dlog (0;__ ("No hay registros que cumplan con el criterio de búsqueda."))
				End if 
			End if 
		End if 
		
	Else 
		CD_Dlog (0;__ ("Seleccione previamente los registros que desea modificar."))
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
	End if 
End if 