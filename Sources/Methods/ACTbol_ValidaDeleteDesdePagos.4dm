//%attributes = {}
  //ACTbol_ValidaDeleteDesdePagos

C_BOOLEAN:C305($0;$go)
C_LONGINT:C283($1;$vl_idPago;$vl_NoRegistros)
ARRAY TEXT:C222($at_moneda;0)
ARRAY LONGINT:C221($al_idItem;0)
ARRAY LONGINT:C221($al_idItem2;0)

READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Cargos:173])

$vl_idPago:=$1

QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$vl_idPago;*)
QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Boleta:9#0)
CREATE SET:C116([ACT_Transacciones:178];"actbol_validaDel")
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")

  //valida RXA
SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_NoRegistros)
QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=-101)
SET QUERY DESTINATION:C396(Into current selection:K19:1)
If ($vl_NoRegistros>0)
	$go:=False:C215
Else 
	$go:=True:C214
End if 
If ($go)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	CREATE SET:C116([ACT_Transacciones:178];"actbol_validaDel2")
	INTERSECTION:C121("actbol_validaDel";"actbol_validaDel2";"actbol_validaDel")
	USE SET:C118("actbol_validaDel")
	SELECTION TO ARRAY:C260([ACT_Transacciones:178]ID_Item:3;$al_idItem;[ACT_Cargos:173]Moneda:28;$at_moneda;[ACT_Cargos:173]ID:1;$al_idItem2)
	$at_moneda{0}:=ST_GetWord (ACT_DivisaPais ;1;";")
	ARRAY LONGINT:C221($DA_Return;0)
	AT_SearchArray (->$at_moneda;"#";->$DA_Return)
	If (Size of array:C274($DA_Return)>0)
		$go:=False:C215
	End if 
	SET_ClearSets ("actbol_validaDel2")
End if 
SET_ClearSets ("actbol_validaDel")

  //valida notas de crédito
If ($go)
	C_LONGINT:C283($vl_numT)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_numT)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$vl_idPago;*)
	QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_DctoRelacionado:15#0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$go:=($vl_numT=0)
End if 
If ($go)
	QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4=$vl_idPago)
	KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")
	ACTcfg_LoadCargosEspeciales (9)
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_numT)
	QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Ref_Item:16=vl_idIE)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	$go:=($vl_numT=0)
End if 

$0:=$go