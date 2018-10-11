//%attributes = {}
  //ACTpgs_AsignaCuentasContables

C_LONGINT:C283($vl_idPago)
C_POINTER:C301($1)
C_BOOLEAN:C305($0)

$vl_idPago:=$1->
$0:=True:C214

KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->$vl_idPago;True:C214)
If (ok=1)
	KRL_FindAndLoadRecordByIndex (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Pagos:172]ID_DocumentodePago:6)
	ACTcfg_OpcionesFormasDePago ("CargaCuentasContables";->[ACT_Documentos_de_Pago:176]Tipodocumento:5;->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
	[ACT_Pagos:172]No_Cuenta_Contable:16:=vsACT_CtaContablePago
	[ACT_Pagos:172]No_CCta_Contable:19:=vsACT_CCtaContablePago
	[ACT_Pagos:172]Centro_de_costos:17:=vsACT_CentroContablePago
	[ACT_Pagos:172]CCentro_de_costos:20:=vsACT_CCentroContablePago
	[ACT_Pagos:172]CodAuxCta:22:=vsACT_CodAuxCtaPago
	[ACT_Pagos:172]CodAuxCCta:23:=vsACT_CodAuxCCtaPago
	KRL_SaveUnLoadReadOnly (->[ACT_Pagos:172])
Else 
	If (Records in selection:C76([ACT_Pagos:172])>0)
		BM_CreateRequest ("ACT_AsignaCuentasContables";String:C10($vl_idPago);String:C10($vl_idPago))
	Else 
		$0:=False:C215
	End if 
End if 