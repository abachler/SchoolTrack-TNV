//%attributes = {}
  //ACTdte_ObtienePDFsDesdeBrowser 

C_LONGINT:C283($vl_proc;$vl_records;$vl_recordsLocked)
C_TEXT:C284($vt_error)

If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
	$vl_records:=BWR_SearchRecords 
	If ($vl_records>0)
		
		QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
		QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];(([ACT_Boletas:181]documento_electronico:29=True:C214) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 3) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 4))))
		
		If (Records in selection:C76([ACT_Boletas:181])>0)
			
			ACTdte_ObtienePDF (True:C214)
			
		Else 
			
			C_LONGINT:C283($l_registros)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_registros)
			SET QUERY LIMIT:C395(1)
			QUERY:C277([ACT_Boletas:181];[ACT_Boletas:181]documento_electronico:29=True:C214)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			SET QUERY LIMIT:C395(0)
			If ($l_registros>0)
				REDUCE SELECTION:C351([ACT_Boletas:181];0)
				ACTdte_ObtienePDF 
			End if 
			
		End if 
		KRL_UnloadReadOnly (->[ACT_Boletas:181])
	End if 
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 