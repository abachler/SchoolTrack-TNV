//%attributes = {}
  //ACTdte_MarcaDocumentosMasivos

C_LONGINT:C283($vl_proc;$vl_records)

If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
	If (USR_GetMethodAcces (Current method name:C684))
		$vl_records:=BWR_SearchRecords 
		If ($vl_records>0)
			$vl_proc:=IT_UThermometer (1;0;__ ("Marcando registros de documentos tributarios para envío al SII..."))
			CREATE SET:C116([ACT_Boletas:181];"temp")
			READ WRITE:C146([ACT_Boletas:181])
			USE SET:C118("temp")
			SET_ClearSets ("temp")
			  //QUERY SELECTION([ACT_Boletas];[ACT_Boletas]documento_electronico=True;*)
			  //QUERY SELECTION([ACT_Boletas]; & ;[ACT_Boletas]DTE_id_estado ?? 0)
			QUERY SELECTION:C341([ACT_Boletas:181];[ACT_Boletas:181]Nula:15=False:C215)
			QUERY SELECTION BY FORMULA:C207([ACT_Boletas:181];([ACT_Boletas:181]documento_electronico:29=True:C214) & ([ACT_Boletas:181]DTE_estado_id:24 ?? 0) & (Not:C34([ACT_Boletas:181]DTE_estado_id:24 ?? 1)))
			  //QUERY SELECTION BY FORMULA([ACT_Boletas];([ACT_Boletas]documento_electronico=True) & (Not([ACT_Boletas]DTE_id_estado ?? 1)))
			ORDER BY:C49([ACT_Boletas:181];[ACT_Boletas:181]codigo_SII:33;>;[ACT_Boletas:181]Numero:11;>)
			APPLY TO SELECTION:C70([ACT_Boletas:181];[ACT_Boletas:181]DTE_estado_id:24:=[ACT_Boletas:181]DTE_estado_id:24 ?+ 1)
			  //APPLY TO SELECTION([ACT_Boletas];[ACT_Boletas]DTE_id_estado:=[ACT_Boletas]DTE_id_estado ?- 2)
			KRL_UnloadReadOnly (->[ACT_Boletas:181])
			IT_UThermometer (-2;$vl_proc)
			POST KEY:C465(-96)
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("Su licencia no permite ejecutar esta opción."))
End if 