//%attributes = {}
  //ACTpgs_CalculaProtestado 
  //Retorna el monto protestado para los cargos en seleccion.

C_DATE:C307($d_fechaCorte)
READ ONLY:C145([ACT_Documentos_en_Cartera:182])
READ ONLY:C145([ACT_Transacciones:178])
READ ONLY:C145([ACT_Pagos:172])
READ ONLY:C145([ACT_Cargos:173])
C_REAL:C285($MontoProtestado;$0)
$MontoProtestado:=0
  //$1 es el arreglo con recnum de cargos
  //agrego parametro adicional
If (Count parameters:C259>1)
	$d_fechaCorte:=$2
End if 

CREATE SELECTION FROM ARRAY:C640([ACT_Cargos:173];$1->)
If (Records in selection:C76([ACT_Cargos:173])>0)
	KRL_RelateSelection (->[ACT_Transacciones:178]ID_Item:3;->[ACT_Cargos:173]ID:1;"")
	CREATE SET:C116([ACT_Transacciones:178];"transacciones1")
	KRL_RelateSelection (->[ACT_Pagos:172]ID:1;->[ACT_Transacciones:178]ID_Pago:4;"")
	KRL_RelateSelection (->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;->[ACT_Pagos:172]ID_DocumentodePago:6;"")
	If (Records in selection:C76([ACT_Documentos_en_Cartera:182])>0)
		QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]L_Protestadoel:15#!00-00-00!;*)
		QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182]; | ;[ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11#!00-00-00!)
		
		If ($d_fechaCorte#!00-00-00!)  //ABC 20180726//208539 
			SET FIELD RELATION:C919([ACT_Documentos_en_Cartera:182]ID_DocdePago:3;Automatic:K51:4;Do not modify:K51:1)
			QUERY SELECTION:C341([ACT_Documentos_en_Cartera:182];[ACT_Documentos_de_Pago:176]FechaPago:4<=$d_fechaCorte)
			SET FIELD RELATION:C919([ACT_Documentos_en_Cartera:182]ID_DocdePago:3;Structure configuration:K51:2;Structure configuration:K51:2)
		End if 
		
		If (Records in selection:C76([ACT_Documentos_en_Cartera:182])>0)
			KRL_RelateSelection (->[ACT_Pagos:172]ID_DocumentodePago:6;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
			KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
			CREATE SET:C116([ACT_Transacciones:178];"transacciones2")
			INTERSECTION:C121("transacciones1";"transacciones2";"transacciones1")
			USE SET:C118("transacciones1")
			QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Pago:4#0)
			ARRAY LONGINT:C221($al_recNumTransacciones;0)
			LONGINT ARRAY FROM SELECTION:C647([ACT_Transacciones:178];$al_recNumTransacciones;"")
			$MontoProtestado:=ACTtra_CalculaMontos ("calculaFromRecNum";->$al_recNumTransacciones;->[ACT_Transacciones:178]Debito:6)
		End if 
	End if 
	SET_ClearSets ("transacciones1";"transacciones2")
End if 

$0:=$MontoProtestado