//%attributes = {}
  //ACTdc_CargaDCCreados

C_TEXT:C284($1;$vt_accion)
C_POINTER:C301($ptr1)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

Case of 
	: ($vt_accion="InitAll")
		ACTdc_CargaDCCreados ("InitArray")
		ACTdc_CargaDCCreados ("InitVars")
		
	: ($vt_accion="InitArray")
		ARRAY LONGINT:C221(alACT_recNumsDctosCartera;0)
		
	: ($vt_accion="InitVars")
		C_LONGINT:C283(vlACTdc_IdApoderado;vlACTdc_IdTercero)
		vlACTdc_IdApoderado:=0
		vlACTdc_IdTercero:=0
		
	: ($vt_accion="GuardaDCExistentes")
		vlACTdc_IdApoderado:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
		vlACTdc_IdTercero:=[ACT_Documentos_de_Pago:176]ID_Tercero:48
		If (vlACTdc_IdTercero=0)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=vlACTdc_IdApoderado)
		Else 
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=vlACTdc_IdTercero)
		End if 
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=-4)
		CREATE SET:C116([ACT_Pagos:172];"PagosCheque1")
		
	: ($vt_accion="BuscaNuevosDC")
		If (vlACTdc_IdTercero=0)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=vlACTdc_IdApoderado)
		Else 
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=vlACTdc_IdTercero)
		End if 
		QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]id_forma_de_pago:30=-4)
		CREATE SET:C116([ACT_Pagos:172];"PagosCheque2")
		DIFFERENCE:C122("PagosCheque2";"PagosCheque1";"PagosCheque1")
		USE SET:C118("PagosCheque1")
		FIRST RECORD:C50([ACT_Pagos:172])
		While (Not:C34(End selection:C36([ACT_Pagos:172])))
			QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_DocdePago:3=[ACT_Pagos:172]ID_DocumentodePago:6)
			If (Records in selection:C76([ACT_Documentos_en_Cartera:182])>0)
				$vl_recNum:=Record number:C243([ACT_Documentos_en_Cartera:182])
				ACTdc_CargaDCCreados ("LlenaArrayDesdeRecNum";->$vl_recNum)
			End if 
			NEXT RECORD:C51([ACT_Pagos:172])
		End while 
		SET_ClearSets ("PagosCheque1";"PagosCheque2")
		
		
	: ($vt_accion="CargaNuevosDC")
		$set:="$RecordSet_Table"+String:C10(Table:C252(yBWR_currentTable))
		CREATE SELECTION FROM ARRAY:C640([ACT_Documentos_en_Cartera:182];alACT_recNumsDctosCartera;"")
		If (Records in selection:C76([ACT_Documentos_en_Cartera:182])>0)
			CREATE SET:C116([ACT_Documentos_en_Cartera:182];"Nuevos")
			UNION:C120($set;"Nuevos";$set)
			CLEAR SET:C117("Nuevos")
		End if 
		ACTdc_CargaDCCreados ("InitAll")
		
	: ($vt_accion="LlenaArrayDesdeRecNum")
		If (Find in array:C230(alACT_recNumsDctosCartera;$ptr1->)=-1)
			APPEND TO ARRAY:C911(alACT_recNumsDctosCartera;$ptr1->)
		End if 
		
		
End case 