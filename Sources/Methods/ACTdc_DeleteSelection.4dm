//%attributes = {}
  //ACTdc_DeleteSelection

CREATE SET:C116([ACT_Documentos_en_Cartera:182];"todos")
QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_DocdePago:3<0)
CREATE SET:C116([ACT_Documentos_en_Cartera:182];"protestados")
DIFFERENCE:C122("todos";"protestados";"todos")
USE SET:C118("todos")
KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_de_Pago:176]ID:1;"")
If (Records in selection:C76([ACT_Pagos:172])>0)
	$ok1:=ACTpgs_DeleteSelection 
	USE SET:C118("protestados")
	KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
	$ok2:=KRL_DeleteSelection (->[ACT_Documentos_en_Cartera:182];False:C215)
	$ok3:=KRL_DeleteSelection (->[ACT_Documentos_de_Pago:176];False:C215)
Else 
	$r:=CD_Dlog (0;__ ("Los registros serán eliminados definitivamente sin ninguna verificación adicional.\r¿Desea realmente eliminar los registros seleccionados?");__ ("");__ ("No");__ ("Si"))
	If ($r=2)
		USE SET:C118("protestados")
		KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
		$ok2:=KRL_DeleteSelection (->[ACT_Documentos_en_Cartera:182];False:C215)
		$ok3:=KRL_DeleteSelection (->[ACT_Documentos_de_Pago:176];False:C215)
		$ok1:=1
	End if 
End if 
SET_ClearSets ("todos";"protestados")
If (($ok1=1) & ($ok2=1) & ($ok3=1))
	$0:=1
Else 
	$0:=0
End if 