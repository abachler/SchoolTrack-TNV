//%attributes = {}
  //ACTmnu_FijaMontosMonedaVariable
C_BOOLEAN:C305($vb_ejecutado)
READ ONLY:C145([ACT_Avisos_de_Cobranza:124])

BWR_SearchRecords 
If (Records in selection:C76([ACT_Avisos_de_Cobranza:124])>0)
	CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisos")
	$vb_ejecutado:=ACTac_FijaMontosMonedaVariable ("setAvisos")
	If ($vb_ejecutado)
		<>vb_Refresh:=True:C214
	End if 
	SET_ClearSets ("setAvisos")
Else 
	CD_Dlog (0;__ ("No hay registros seleccionados."))
End if 
