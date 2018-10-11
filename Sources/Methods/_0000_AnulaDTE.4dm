//%attributes = {}
  //_0000_AnulaDTE
C_LONGINT:C283($l_resp;$l_idDT;$l_bloqueado)

READ WRITE:C146([ACT_Boletas:181])

$l_idDT:=0

QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_DctoAsociado:19=$l_idDT)
If (Records in selection:C76([ACT_Boletas:181])=0)
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$l_idDT)
	If (Records in selection:C76([ACT_Boletas:181])=1)
		$l_resp:=CD_Dlog (0;"El Documento Tributario id "+String:C10($l_idDT)+", folio("+String:C10([ACT_Boletas:181]Numero:11)+") será anulado sin ninguna verificación adicional."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
		If ($l_resp=1)
			If (Not:C34(Locked:C147([ACT_Boletas:181])))
				START TRANSACTION:C239
				
				READ WRITE:C146([ACT_Transacciones:178])
				QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
				APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
				If (Records in set:C195("LockedSet")>0)
					$l_bloqueado:=$l_bloqueado+1
				End if 
				KRL_UnloadReadOnly (->[ACT_Transacciones:178])
				
				READ WRITE:C146([ACT_Boletas:181])
				QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$l_idDT)
				If (Not:C34(Locked:C147([ACT_Boletas:181])))
					[ACT_Boletas:181]ID_Estado:20:=4
					[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
					[ACT_Boletas:181]Monto_Afecto:4:=0
					[ACT_Boletas:181]Monto_IVA:5:=0
					[ACT_Boletas:181]Monto_Total:6:=0
					[ACT_Boletas:181]Monto_Exento:30:=0
					[ACT_Boletas:181]Nula:15:=True:C214
					
					If (Not:C34(ACTcaf_DisminuyeFolioDisponible ([ACT_Boletas:181]ID_CAF:43)))
						BM_CreateRequest ("DisminuyeCAF";String:C10([ACT_Boletas:181]ID_CAF:43);String:C10([ACT_Boletas:181]ID:1))
					End if 
					
					SAVE RECORD:C53([ACT_Boletas:181])
				Else 
					$l_bloqueado:=$l_bloqueado+1
				End if 
				
				If ($l_bloqueado=0)
					VALIDATE TRANSACTION:C240
					LOG_RegisterEvt ("El Documento Tributario tipo: "+[ACT_Boletas:181]TipoDocumento:7+", id registro: ("+String:C10([ACT_Boletas:181]ID:1)+"), folio "+String:C10([ACT_Boletas:181]Numero:11)+", fue anulado.")
					CD_Dlog (0;"Script ejecutado correctamente.")
				Else 
					CANCEL TRANSACTION:C241
					CD_Dlog (0;"Habíán registros en uso. El script no pudo ser ejecutado.")
				End if 
			Else 
				CD_Dlog (0;"Registro en uso. El script no fue ejecutado.")
			End if 
		End if 
	Else 
		CD_Dlog (0;"Documento no encontrado. El script no fue ejecutado.")
	End if 
Else 
	CD_Dlog (0;"El documento a anular tiene documentos asociados. El script no pudo ser ejecutado.")
End if 
KRL_UnloadReadOnly (->[ACT_Boletas:181])