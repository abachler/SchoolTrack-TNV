//%attributes = {}
  //ACTcae_DeleteArchived

KRL_UnloadAll 

READ WRITE:C146([ACT_Avisos_de_Cobranza:124])
READ WRITE:C146([ACT_Cargos:173])
READ WRITE:C146([ACT_Documentos_de_Cargo:174])
READ WRITE:C146([ACT_Transacciones:178])
READ WRITE:C146([xxACT_DesctosXItem:103])
QUERY WITH ARRAY:C644([ACT_Avisos_de_Cobranza:124]ID_Aviso:1;alACT_AvisosXEliminar)
KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID_Documento_de_Cargo:3;->[ACT_Documentos_de_Cargo:174]ID_Documento:1;"")
KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
KRL_RelateSelection (->[xxACT_DesctosXItem:103]ID_Cargo:8;->[ACT_Cargos:173]ID:1;"")
$procID:=IT_UThermometer (1;0;__ ("Eliminando cargos..."))
  //ACTcc_EliminaCargosLoop 
DELETE SELECTION:C66([xxACT_DesctosXItem:103])
DELETE SELECTION:C66([ACT_Transacciones:178])
DELETE SELECTION:C66([ACT_Cargos:173])
DELETE SELECTION:C66([ACT_Documentos_de_Cargo:174])
IT_UThermometer (-2;$procID)
$l_result:=0  //20130730 RCH
While ($l_result=0)
	$l_result:=KRL_DeleteSelection (->[ACT_Avisos_de_Cobranza:124];True:C214;__ ("Eliminando avisos de cobranza..."))
End while 
KRL_UnloadReadOnly (->[ACT_Avisos_de_Cobranza:124])
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Cargo:174])
KRL_UnloadReadOnly (->[ACT_Transacciones:178])
KRL_UnloadReadOnly (->[xxACT_DesctosXItem:103])
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Avisos de Cobranza eliminados.")

READ WRITE:C146([ACT_Pagos:172])
READ WRITE:C146([ACT_Transacciones:178])
QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;alACT_PagosXEliminar)
KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
DELETE SELECTION:C66([ACT_Transacciones:178])
$l_result:=0  //20130730 RCH
While ($l_result=0)
	$l_result:=KRL_DeleteSelection (->[ACT_Pagos:172];True:C214;__ ("Eliminando pagos..."))
End while 
KRL_UnloadReadOnly (->[ACT_Pagos:172])
KRL_UnloadReadOnly (->[ACT_Transacciones:178])
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Pagos eliminados.")

READ WRITE:C146([ACT_Documentos_de_Pago:176])
QUERY WITH ARRAY:C644([ACT_Documentos_de_Pago:176]ID:1;alACT_DocDepXEliminar)
$l_result:=0  //20130730 RCH
While ($l_result=0)
	$l_result:=KRL_DeleteSelection (->[ACT_Documentos_de_Pago:176];True:C214;__ ("Eliminando documentos depositados..."))
End while 
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Documentos depositados eliminados.")

READ WRITE:C146([ACT_Boletas:181])
QUERY WITH ARRAY:C644([ACT_Boletas:181]ID:1;alACT_DocTribXEliminar)
$l_result:=0  //20130730 RCH
While ($l_result=0)
	$l_result:=KRL_DeleteSelection (->[ACT_Boletas:181];True:C214;__ ("Eliminando documentos tributarios..."))
End while 
KRL_UnloadReadOnly (->[ACT_Boletas:181])
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Documentos Tributarios eliminados.")

READ WRITE:C146([ACT_Cargos:173])
READ WRITE:C146([ACT_Transacciones:178])
$date:=DT_GetDateFromDayMonthYear (DT_GetLastDay (vl_Mes;vl_Año);vl_Mes;vl_Año)
QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Fecha_de_generacion:4<=$date;*)
QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
$proc:=IT_UThermometer (1;0;__ ("Eliminando cargos proyectados..."))
ACTcc_EliminaCargosLoop 
IT_UThermometer (-2;$procID)
ACTcae_RegisterEvent (vl_Año;vl_Mes;"Cargos proyectados eliminados.")
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_Transacciones:178])