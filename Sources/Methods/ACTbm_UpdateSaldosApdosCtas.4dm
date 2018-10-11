//%attributes = {}
  //ACTbm_UpdateSaldosApdosCtas

  //C_BOOLEAN($vb_mostrarTermo)

  //$vb_mostrarTermo:=True
  //COPY ARRAY(alACTtid_IdsApdos2Recalc2;alACTpp_idsPersonas)
  //ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas";->$vb_mostrarTermo)


READ ONLY:C145([Personas:7])
QUERY:C277([Personas:7];[Personas:7]ES_Apoderado_de_Cuentas:42=True:C214)
While (Not:C34(End selection:C36([Personas:7])))
	$vl_idTercero:=0
	  //20120724 RCH tareas fin de dia
	ACTeod_EjecutaTareas ("AgregaElemento";->[Personas:7]No:1;->$vl_idTercero)
	NEXT RECORD:C51([Personas:7])
End while 

READ ONLY:C145([ACT_Terceros:138])
ALL RECORDS:C47([ACT_Terceros:138])
While (Not:C34(End selection:C36([ACT_Terceros:138])))
	$vl_idApdo:=0
	  //20120724 RCH tareas fin de dia
	ACTeod_EjecutaTareas ("AgregaElemento";->$vl_idApdo;->[ACT_Terceros:138]Id:1)
	NEXT RECORD:C51([ACT_Terceros:138])
End while 