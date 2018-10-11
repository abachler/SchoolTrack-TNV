ARRAY LONGINT:C221($alACT_folios;0)
C_LONGINT:C283($l_indice;$vl_idRS)

READ ONLY:C145([ACT_FoliosDT:293])
READ ONLY:C145([ACT_Boletas:181])

QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_CAF:43=0;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)

If (Records in selection:C76([ACT_Boletas:181])>0)
	  //***** ASIGNO ID CAF A DOCUMENTOS DE PRUEBA *****
	  //si hay documentos de prueba emitidos para un solo caf, actualizo los ids si se puede
	READ ONLY:C145([ACT_FoliosDT:293])
	READ ONLY:C145([ACT_Boletas:181])
	QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_Estado:20=7)
	CREATE SET:C116([ACT_Boletas:181];"setPruebas")
	DISTINCT VALUES:C339([ACT_Boletas:181]codigo_SII:33;$atACT_CatDT)
	For ($l_indice;1;Size of array:C274($atACT_CatDT))
		QUERY:C277([ACT_FoliosDT:293];[ACT_FoliosDT:293]tipo_dteSII:7=$atACT_CatDT{$l_indice})
		If (Records in selection:C76([ACT_FoliosDT:293])=1)
			READ WRITE:C146([ACT_Boletas:181])
			USE SET:C118("setPruebas")
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=$atACT_CatDT{$l_indice})
			APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]ID_CAF:43:=[ACT_FoliosDT:293]id:1)
			KRL_UnloadReadOnly (->[ACT_Boletas:181])
		End if 
	End for 
	SET_ClearSets ("setPruebas")
	  //***** ASIGNO ID CAF A DOCUMENTOS DE PRUEBA *****
End if 

QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]ID_CAF:43=0;*)
QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)

If (Records in selection:C76([ACT_Boletas:181])=0)
	ALL RECORDS:C47([ACT_FoliosDT:293])
	LONGINT ARRAY FROM SELECTION:C647([ACT_FoliosDT:293];$alACT_folios;"")
	For ($l_indice;1;Size of array:C274($alACT_folios))
		READ WRITE:C146([ACT_FoliosDT:293])
		GOTO RECORD:C242([ACT_FoliosDT:293];$alACT_folios{$l_indice})
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
		QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]ID_CAF:43=[ACT_FoliosDT:293]id:1;*)
		QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		  //[ACT_FoliosDT]folio_disponible:=(([ACT_FoliosDT]hasta-[ACT_FoliosDT]desde)+1)-$l_records
		
		$b_continuar:=True:C214  //verifico si hay documentos para el CAF
		If ($l_records=0)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_records)
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33=String:C10([ACT_FoliosDT:293]tipo_dteSII:7);*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11>=[ACT_FoliosDT:293]desde:4;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Numero:11<=[ACT_FoliosDT:293]hasta:5;*)
			QUERY:C277([ACT_Boletas:181]; & ;[ACT_Boletas:181]Nula:15=False:C215)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			If ($l_records>0)
				$b_continuar:=False:C215
			End if 
		End if 
		
		If ($b_continuar)
			[ACT_FoliosDT:293]folio_disponible:6:=$l_records+1
			If ([ACT_FoliosDT:293]folio_disponible:6<=[ACT_FoliosDT:293]hasta:5)
				[ACT_FoliosDT:293]estado:3:=1
			Else 
				[ACT_FoliosDT:293]estado:3:=2
			End if 
			SAVE RECORD:C53([ACT_FoliosDT:293])
		End if 
		KRL_UnloadReadOnly (->[ACT_FoliosDT:293])
	End for 
	
	$vl_idRS:=alACTcfg_Razones{atACTcfg_Razones}
	ACTcfgbol_OpcionesDTE ("CargaArreglosCAF";->$vl_idRS)
Else 
	CD_Dlog (0;"Algunos documentos electrónicos no tienen id CAF asignado. No es posible verificar los folios.")
End if 