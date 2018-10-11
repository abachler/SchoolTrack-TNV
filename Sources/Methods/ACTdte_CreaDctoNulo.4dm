//%attributes = {}
  //ACTdte_CreaDctoNulo 

  // ----------------------------------------------------
  // Usuario (SO): Roberto Catalán
  // Fecha y hora: 24-10-16, 11:43:13
  // ----------------------------------------------------
  // Método: ACTdte_CreaDctoNulo
  // Descripción
  // Método utilizado en compilado para crear documentos nulos.
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($l_idCAF;$l_idDoc;$l_folio2Asignar)
C_BOOLEAN:C305($b_error;$b_continuar)
C_TEXT:C284($t_tipoDTE)
C_DATE:C307($d_fecha)

READ ONLY:C145([ACT_Boletas:181])

$l_idDoc:=$1
$l_folio2Asignar:=$2
If (Count parameters:C259>=3)
	$t_tipoDTE:=$3
End if 
If (Count parameters:C259>=4)
	$d_fecha:=$4
End if 

If ($t_tipoDTE="")
	$t_tipoDTE:="41"
End if 

If ($l_idDoc>0)
	$l_resp:=CD_Dlog (0;"Se asignará el folio "+String:C10($l_folio2Asignar)+", al Documento Tributario tipo 41 (Boleta Exenta Electrónica), id: "+String:C10($l_idDoc)+"."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
Else 
	$l_resp:=CD_Dlog (0;"Se generará un documento nulo asociado al Documento Tributario tipo 41 (Boleta Exenta Electrónica). El folio a usar será el "+String:C10($l_folio2Asignar)+"."+"\r\r"+"¿Desea continuar?";"";"Si";"No")
End if 
If ($l_resp=1)
	
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=$l_folio2Asignar;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]codigo_SII:33=$t_tipoDTE;*)
	QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
	
	If (Records in selection:C76([ACT_Boletas:181])=0)
		
		$b_continuar:=False:C215
		If ($l_idDoc>0)
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID:1=$l_idDoc)
			If (Records in selection:C76([ACT_Boletas:181])=1)
				$b_continuar:=True:C214
			End if 
		Else 
			SET QUERY LIMIT:C395(1)
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]Numero:11=$l_folio2Asignar;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]codigo_SII:33=$t_tipoDTE;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]documento_electronico:29=True:C214)
			SET QUERY LIMIT:C395(0)
			If (Records in selection:C76([ACT_Boletas:181])=1)
				$b_continuar:=True:C214
			End if 
		End if 
		
		If ($b_continuar)
			START TRANSACTION:C239
			DUPLICATE RECORD:C225([ACT_Boletas:181])
			[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
			[ACT_Boletas:181]Numero:11:=$l_folio2Asignar
			If ($d_fecha#!00-00-00!)
				[ACT_Boletas:181]FechaEmision:3:=$d_fecha
				[ACT_Boletas:181]FechaVencimiento:54:=$d_fecha
			End if 
			[ACT_Boletas:181]Auto_UUID:42:=Generate UUID:C1066
			[ACT_Boletas:181]ID_Estado:20:=4
			[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
			[ACT_Boletas:181]Monto_Afecto:4:=0
			[ACT_Boletas:181]Monto_IVA:5:=0
			[ACT_Boletas:181]Monto_Total:6:=0
			[ACT_Boletas:181]Monto_Exento:30:=0
			[ACT_Boletas:181]Nula:15:=True:C214
			[ACT_Boletas:181]ID_Apoderado:14:=0
			[ACT_Boletas:181]ID_Tercero:21:=0
			If ($l_idDoc>0)
				[ACT_Boletas:181]Observacion:18:=[ACT_Boletas:181]Observacion:18+Choose:C955([ACT_Boletas:181]Observacion:18="";"";"\r")+DTS_MakeFromDateTime +" Documento creado por error durante la emisión. Fue emitido un documento duplicado. Id documento original: "+String:C10($l_idDoc)+"."
			Else 
				[ACT_Boletas:181]Observacion:18:=[ACT_Boletas:181]Observacion:18+Choose:C955([ACT_Boletas:181]Observacion:18="";"";"\r")+DTS_MakeFromDateTime +" Documento creado para rellenar numeración."
			End if 
			SAVE RECORD:C53([ACT_Boletas:181])
			If ($l_idDoc>0)
				$l_idCAF:=[ACT_Boletas:181]ID_CAF:43
			Else 
				
				READ ONLY:C145([ACT_FoliosDT:293])
				QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]id_razonSocial:8=[ACT_Boletas:181]ID_RazonSocial:25;*)
				QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]estado:3=1;*)
				QUERY:C277([ACT_FoliosDT:293]; & ;[ACT_FoliosDT:293]tipo_dteSII:7=[ACT_Boletas:181]codigo_SII:33)
				ORDER BY:C49([ACT_FoliosDT:293];[ACT_FoliosDT:293]folio_disponible:6;>)
				REDUCE SELECTION:C351([ACT_FoliosDT:293];1)
				If (Records in selection:C76([ACT_FoliosDT:293])=1)
					$l_idCAF:=[ACT_FoliosDT:293]id:1
				End if 
			End if 
			
			LOG_RegisterEvt ("Creación de Documento Tributario tipo "+[ACT_Boletas:181]TipoDocumento:7+" N° "+String:C10([ACT_Boletas:181]Numero:11)+" para rellenar vacío en la numeración.")
			KRL_UnloadReadOnly (->[ACT_Boletas:181])
			
			  //aumentar la numeracion caf
			KRL_FindAndLoadRecordByIndex (->[ACT_FoliosDT:293]id:1;->$l_idCAF;True:C214)
			If (ok=1)
				[ACT_FoliosDT:293]folio_disponible:6:=[ACT_FoliosDT:293]folio_disponible:6+1
				If ([ACT_FoliosDT:293]folio_disponible:6<=[ACT_FoliosDT:293]hasta:5)
					[ACT_FoliosDT:293]estado:3:=1
				Else 
					[ACT_FoliosDT:293]estado:3:=2
				End if 
				SAVE RECORD:C53([ACT_FoliosDT:293])
			Else 
				$b_error:=True:C214
			End if 
			KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
			
			If ($b_error)
				CANCEL TRANSACTION:C241
				CD_Dlog (0;"Script no ejecutado.")
			Else 
				VALIDATE TRANSACTION:C240
				CD_Dlog (0;"Script ejecutado con éxito.")
			End if 
		Else 
			CD_Dlog (0;"Documento no encontrado.")
		End if 
	Else 
		CD_Dlog (0;"Script ya ejecutado.")
	End if 
End if 