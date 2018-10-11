$line:=AL_GetLine (ALP_CargosXPagar)
If ($line#0)
	  //$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el cargo seleccionado?");__ ("");__ ("No");__ ("Si"))
	$r:=CD_Dlog (0;__ ("¿Está seguro de querer eliminar el cargo seleccionado?")+"\r\r"+__ ("Los cargos asociados también serán eliminados.");__ ("");__ ("No");__ ("Si"))  //20170426 RCH
	If ($r=2)
		C_LONGINT:C283($proc)
		$proc:=IT_UThermometer (1;0;__ ("Eliminando cargo..."))
		$avisoRNOrig:=Record number:C243([ACT_Avisos_de_Cobranza:124])
		$vl_retorno:=ACTcar_Delete (alACT_RecNumsCargos{$line})
		KRL_GotoRecord (->[ACT_Avisos_de_Cobranza:124];$avisoRNOrig;True:C214)
		If ($vl_retorno=0)
			If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])=1)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1)
				KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
				vPagado:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)*-1
				AL_UpdateArrays (ALP_CargosXPagar;0)
				ACTcc_LoadCargosIntoArrays 
				AL_UpdateArrays (ALP_CargosXPagar;-2)
				UNLOAD RECORD:C212([ACT_CuentasCorrientes:175])
				If (vPagado=0)
					vPagado:=(AT_GetSumArray (->arACT_MontoPagado))*-1
				End if 
				vSaldo:=[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12*-1
				READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
				GOTO RECORD:C242([ACT_Avisos_de_Cobranza:124];$avisoRNOrig)
				KRL_FindAndLoadRecordByIndex (->[Personas:7]No:1;->[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3)
				
				  //20121222 RCH si se elimina un cargo cuando hay saldo anterior para el apoderado, se actualiza el explorador
				C_LONGINT:C283($vl_ACConSaldo)
				SET QUERY LIMIT:C395(1)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_ACConSaldo)
				QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Apoderado:3=[Personas:7]No:1;*)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12#0;*)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14#0)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
				SET QUERY LIMIT:C395(0)
				If ($vl_ACConSaldo=1)
					<>vb_Refresh:=True:C214
				End if 
			Else 
				BWR_AfterDeleteOnLoading 
			End if 
		End if 
		IT_UThermometer (-2;$proc)
	End if 
End if 
IT_SetButtonState ((Size of array:C274(alACT_RecNumsCargos)>0);->bDelCargos)