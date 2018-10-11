//%attributes = {}
  //ACTdd_AnularDeposito
  //Mono: Cambio de código, el anterior se cancelaba al fallar una de todas las anulaciones.

If (USR_GetMethodAcces (Current method name:C684))
	If (Size of array:C274(abrSelect)>1)
		$r:=CD_Dlog (0;__ ("Anular depósitos puede producir errores. Verifique que efectivamente los documentos no han sido depositados.\r\r¿Desea realmente anular los depósitos?");__ ("");__ ("No");__ ("Anular"))
	Else 
		$r:=CD_Dlog (0;__ ("Anular el depósito puede producir errores. Verifique que efectivamente el documento no ha sido depositado.\r\r¿Desea realmente anular el depósito?");__ ("");__ ("No");__ ("Anular"))
	End if 
	
	If ($r=2)
		
		$cancelados:=0
		
		For ($y;1;Size of array:C274(abrSelect))
			START TRANSACTION:C239
			ok:=1
			READ WRITE:C146([ACT_Documentos_de_Pago:176])
			$recNumDocPago:=alBWR_recordNumber{abrSelect{$y}}
			lBWR_recordNumber:=abrSelect{$y}
			GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$recNumDocPago)
			$lockedDocdePago:=Locked:C147([ACT_Documentos_de_Pago:176])
			[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
			[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
			[ACT_Documentos_de_Pago:176]Depositado_en_Banco:39:=""
			[ACT_Documentos_de_Pago:176]Depositado_en_Banco_Codigo:40:=""
			[ACT_Documentos_de_Pago:176]Depositado_en_Cuenta:41:=""
			[ACT_Documentos_de_Pago:176]Depositado_Fecha:42:=!00-00-00!
			[ACT_Documentos_de_Pago:176]Depositado_Por:43:=""
			  //SAVE RECORD([ACT_Documentos_de_Pago])
			ACTdp_fSave 
			$recNum:=ACTpgs_CreacionDocCartera (-4)
			  //20120301 RCH Se hacen algunos cambios para el ticket 108043.
			READ ONLY:C145([ACT_Documentos_en_Cartera:182])
			GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$recNum)
			GOTO RECORD:C242([ACT_Documentos_de_Pago:176];$recNumDocPago)
			LOG_RegisterEvt ("Anulación de depósito: Banco "+[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7+", Serie "+[ACT_Documentos_de_Pago:176]NoSerie:12)
			
			  //If (($lockedDocdePago) | (ok=0)) está dando ok = 0 en algunos llamados en el método __ que usa get localized string 
			If ($lockedDocdePago)
				CANCEL TRANSACTION:C241
				$cancelados:=$cancelados+1
			Else 
				VALIDATE TRANSACTION:C240
				REMOVE FROM SET:C561([ACT_Documentos_de_Pago:176];"$RecordSet_Table"+String:C10(Table:C252(->[ACT_Documentos_de_Pago:176])))
			End if 
		End for 
		
		
		KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
		USE SET:C118("$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable)))
		BWR_SelectTableData 
		
		If ($cancelados>0)
			CD_Dlog (0;__ ("Existe(n) "+String:C10($cancelados)+" documento(s) bloqueado(s) en la selección, para estos la anulación no fue llevada a cabo."))
		Else 
			$0:=1
		End if 
		
	End if 
End if 