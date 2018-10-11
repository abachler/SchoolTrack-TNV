//%attributes = {}
  //UD_20130108_VerificaPagosTercer
C_LONGINT:C283($l_locked;$p)

START TRANSACTION:C239

READ ONLY:C145([ACT_Pagos:172])
READ WRITE:C146([ACT_Transacciones:178])
READ WRITE:C146([ACT_Cargos:173])

$p:=IT_UThermometer (1;0;"Verificando pagos de Terceros...")
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Tercero:16#0;*)
QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4#0)
KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
QUERY SELECTION:C341([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26=0)
KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
KRL_RelateSelection (->[ACT_Cargos:173]ID:1;->[ACT_Transacciones:178]ID_Item:3;"")

CREATE SET:C116([ACT_Transacciones:178];"Tran")
CREATE SET:C116([ACT_Cargos:173];"Cargos")

USE SET:C118("Tran")
APPLY TO SELECTION:C70([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Tercero:16:=0)
$l_locked:=Records in set:C195("LockedSet")
USE SET:C118("Cargos")
APPLY TO SELECTION:C70([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54:=0)
$l_locked:=$l_locked+Records in set:C195("LockedSet")

IT_UThermometer (-2;$p)
If ($l_locked=0)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 

SET_ClearSets ("Tran";"Cargos")
KRL_UnloadReadOnly (->[ACT_Transacciones:178])
KRL_UnloadReadOnly (->[ACT_Cargos:173])
KRL_UnloadReadOnly (->[ACT_Pagos:172])

