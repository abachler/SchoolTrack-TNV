  // MOD Ticket N° 211815 Patricio Aliaga 20180711
C_TEXT:C284($vs_nombreNuevo;$vt_textoLog)
$vs_nombreNuevo:=vsAS_ColPropPrintName
If (vs_nombreActual#$vs_nombreNuevo)
	$vt_textoLog:="Cambio en "+ST_Qte ("Nombre en informes")+" para "+atAS_EvalPropSourceName{vi_Parcial}+" (fila "+String:C10(vi_Parcial)+") en la Asignatura "+[Asignaturas:18]denominacion_interna:16+" ["+[Asignaturas:18]Curso:5+"]."
	$vt_textoLog:=$vt_textoLog+" Valor anterior: "+vs_nombreActual+", Nuevo Valor: "+String:C10($vs_nombreNuevo)+"."
	LOG_RegisterEvt ($vt_textoLog)
End if 