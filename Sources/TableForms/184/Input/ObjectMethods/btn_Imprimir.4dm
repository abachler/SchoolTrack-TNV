$cs_imprimirPagareC:=cs_imprimirPagareC
$cs_genContratoC:=cs_genContratoC
$vl_idPagare:=[ACT_Pagares:184]ID:12

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]ID_Pagare:30=$vl_idPagare)
CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"set2Emitir")

$vb_emitir:=ACTbol_ValidaEmisionDocs ("set2Emitir")

If (Not:C34($vb_emitir))
	  //CD_Dlog (0;__ ("En la selección de avisos de cobranza existen cargos relacionados a monedas con montos variables, los documentos no pueden ser generados para dichos montos."))
	$vt_msj:=__ ("En los avisos de cobranza asociados a este pagaré, existen cargos relacionados a monedas con montos variables, el pagaré no puede ser impreso para dichos montos.")
	$vt_msj:=$vt_msj+"\r\r"+__ ("¿Desea fijar los montos en moneda variable?")
	$vl_resp:=CD_Dlog (0;$vt_msj;"";__ ("Si");__ ("No"))
	If ($vl_resp=1)
		$vb_emitir:=ACTac_FijaMontosMonedaVariable ("set2Emitir")
		ACTcfg_OpcionesGeneracionP ("CalculaMontoPagare";->$vl_idPagare)
	End if 
End if 
SET_ClearSets ("set2Emitir")
KRL_FindAndLoadRecordByIndex (->[ACT_Pagares:184]ID:12;->$vl_idPagare;True:C214)
If ($vb_emitir)
	If (Shift down:C543)
		cs_imprimirPagareC:=0
		cs_genContratoC:=1
		ACTcfg_OpcionesPagares ("Print";->vtACTp_ModContrato)
	Else 
		cs_imprimirPagareC:=1
		cs_genContratoC:=0
		ACTcfg_OpcionesPagares ("Print";->vtACTp_ModPagare)
	End if 
End if 
cs_imprimirPagareC:=$cs_imprimirPagareC
cs_genContratoC:=$cs_genContratoC