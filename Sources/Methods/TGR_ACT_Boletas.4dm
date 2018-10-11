//%attributes = {}
  // Método: TGR_ACT_Boletas
  //----------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 31/05/10, 09:44:34
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

C_BOOLEAN:C305(<>vb_AvoidTriggerExecution;<>vb_ImportHistoricos_STX)
If ((Not:C34(<>vb_ImportHistoricos_STX)) & (Not:C34(<>vb_AvoidTriggerExecution)))
	Case of 
		: (Trigger event:C369=On Saving New Record Event:K3:1)
			[ACT_Boletas:181]DTS_Creacion:22:=DTS_MakeFromDateTime 
			
			If (KRL_FieldChanges (->[ACT_Boletas:181]DTE_estado_id:24))
				[ACT_Boletas:181]DTE_estado_glosa:34:=ACTdte_OpcionesGenerales ("ObtieneGlosaEstadoDTE")
				C_TEXT:C284($vt_cambio)
				$vt_cambio:=DTS_MakeFromDateTime +": "
				$vt_cambio:=$vt_cambio+[ACT_Boletas:181]DTE_estado_glosa:34
				$vt_cambio:=$vt_cambio+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")
				[ACT_Boletas:181]DTE_log:26:=$vt_cambio+[ACT_Boletas:181]DTE_log:26
				
				If ([ACT_Boletas:181]DTE_estado_id:24 ?? 4)
					[ACT_Boletas:181]DTE_estado_glosa:34:=[ACT_Boletas:181]DTE_estado_glosa:34+". "+[ACT_Boletas:181]DTE_estado_glosa:34
				End if 
			End if 
			
		: (Trigger event:C369=On Saving Existing Record Event:K3:2)
			If (KRL_FieldChanges (->[ACT_Boletas:181]ID_Categoria:12))
				C_TEXT:C284($vt_cambio)
				$vt_cambio:=DTS_MakeFromDateTime +": ID Cat: "+String:C10(Old:C35([ACT_Boletas:181]ID_Categoria:12))+"->"+String:C10([ACT_Boletas:181]ID_Categoria:12)+"\r"
				[ACT_Boletas:181]LogCambios:23:=[ACT_Boletas:181]LogCambios:23+$vt_cambio
			End if 
			If (KRL_FieldChanges (->[ACT_Boletas:181]Numero:11))
				C_TEXT:C284($vt_cambio)
				$vt_cambio:=DTS_MakeFromDateTime +": Num: "+String:C10(Old:C35([ACT_Boletas:181]Numero:11))+"->"+String:C10([ACT_Boletas:181]Numero:11)+"\r"
				[ACT_Boletas:181]LogCambios:23:=[ACT_Boletas:181]LogCambios:23+$vt_cambio
			End if 
			If (KRL_FieldChanges (->[ACT_Boletas:181]FechaEmision:3))
				C_TEXT:C284($vt_cambio)
				$vt_cambio:=DTS_MakeFromDateTime +": Fecha: "+String:C10(Old:C35([ACT_Boletas:181]FechaEmision:3))+"->"+String:C10([ACT_Boletas:181]FechaEmision:3)+"\r"
				[ACT_Boletas:181]LogCambios:23:=[ACT_Boletas:181]LogCambios:23+$vt_cambio
			End if 
			
			If (KRL_FieldChanges (->[ACT_Boletas:181]DTE_estado_id:24))
				[ACT_Boletas:181]DTE_estado_glosa:34:=ACTdte_OpcionesGenerales ("ObtieneGlosaEstadoDTE")
				C_TEXT:C284($vt_cambio)
				$vt_cambio:=DTS_MakeFromDateTime +": "
				$vt_cambio:=$vt_cambio+[ACT_Boletas:181]DTE_estado_glosa:34
				$vt_cambio:=$vt_cambio+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")
				[ACT_Boletas:181]DTE_log:26:=$vt_cambio+[ACT_Boletas:181]DTE_log:26
				
			End if 
			
		: (Trigger event:C369=On Deleting Record Event:K3:3)
			READ WRITE:C146([ACT_Transacciones:178])
			QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1)
			APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9:=0)
			  //20130628 RCH Para aumentar la seguridad
			If (Records in set:C195("LockedSet")>0)
				BM_CreateRequest ("ACT_AnulaDocs";String:C10([ACT_Boletas:181]ID:1))
			End if 
			KRL_UnloadReadOnly (->[ACT_Transacciones:178])
			
	End case 
	SN3_MarcarRegistros (SN3_DTi_DTrib)
End if 


  //20180803 RCH Para obtener info sobre error de peridda de folio. Se pasa de un folio a 0
If (KRL_FieldChanges (->[ACT_Boletas:181]Numero:11))
	C_TEXT:C284($vt_cambio)
	$vt_cambio:=DTS_MakeFromDateTime +": "
	$vt_cambio:=$vt_cambio+"Cambio en número de DT. Cambió de: "+String:C10(Old:C35([ACT_Boletas:181]Numero:11))+" a "+String:C10([ACT_Boletas:181]Numero:11)+"."
	$vt_cambio:=$vt_cambio+ST_Boolean2Str ([ACT_Boletas:181]DTE_log:26="";"";"\r")
	[ACT_Boletas:181]DTE_log:26:=$vt_cambio+[ACT_Boletas:181]DTE_log:26
End if 