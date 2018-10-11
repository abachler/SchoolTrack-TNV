//%attributes = {}
  //ACTbol_GetMontoLinea2

  //Un aviso puede estar asociado a más de una boleta pero a sólo algunas transacciones de la boleta, por este motivo fue necesario crear este método para que sume sólo las transacciones asociadas a boletas pero también asociadas a un cierto aviso de cobanza
C_TEXT:C284($set)
C_LONGINT:C283($idAviso;$i;$j;$idCargo)
C_REAL:C285($monto)
ARRAY LONGINT:C221($al_recNumBoletas;0)
ARRAY LONGINT:C221($al_idCargo;0)
$set:=$1
$idAviso:=$2
USE SET:C118($set)
SELECTION TO ARRAY:C260([ACT_Boletas:181];$al_recNumBoletas)
For ($i;1;Size of array:C274($al_recNumBoletas))
	KRL_GotoRecord (->[ACT_Boletas:181];$al_recNumBoletas{$i})
	ACTbol_EstadoBoleta ([ACT_Boletas:181]ID:1)
	KRL_GotoRecord (->[ACT_Boletas:181];$al_recNumBoletas{$i})
	If ([ACT_Boletas:181]ID_Categoria:12#-4)
		QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]No_Boleta:9=[ACT_Boletas:181]ID:1;*)
		QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]No_Comprobante:10=$idAviso)
		CREATE SET:C116([ACT_Transacciones:178];"transacciones")
		AT_DistinctsFieldValues (->[ACT_Transacciones:178]ID_Item:3;->$al_idCargo)
		For ($j;1;Size of array:C274($al_idCargo))
			$idCargo:=$al_idCargo{$j}
			KRL_FindAndLoadRecordByIndex (->[ACT_Cargos:173]ID:1;->$idCargo)
			$monto:=$monto+ACTbol_GetMontoLinea ("transacciones")
		End for 
		CLEAR SET:C117("transacciones")
	End if 
End for 
$0:=$monto