//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda
  // Fecha y hora: 04/11/15, 09:18:07
  // ----------------------------------------------------
  // Método: ACTwp_ActualizaCampoTipoPago
  // Descripción
  //
  //
  // Parámetros
  // ----------------------------------------------------
  //20160525 RCH se hace cambios para soportar cuando se reciba json con datos de pago desde SN, verificación diaria, Ext, Post. Además e corrige defecto...

C_LONGINT:C283($l_idPago)
C_OBJECT:C1216($ob_raiz)
C_TEXT:C284($root;$t_json;$t_nodo;$t_nombre;$t_valor)

ARRAY TEXT:C222($at_propiedadJson;0)
ARRAY LONGINT:C221($al_propiedadJsonref;0)

$t_json:=$1
$l_idPago:=$2
$t_valor:=""

If ($t_json#"")
	KRL_FindAndLoadRecordByIndex (->[ACT_Pagos:172]ID:1;->$l_idPago;True:C214)
	Case of 
		: ([ACT_Pagos:172]id_forma_de_pago:30=-18)  //webPay
			ARRAY TEXT:C222($at_nombres;0)
			APPEND TO ARRAY:C911($at_nombres;"tipo_pago")
			APPEND TO ARRAY:C911($at_nombres;"tbk_tipo_pago")
			$ob_raiz:=OB_JsonToObject ($t_json)
			OB GET PROPERTY NAMES:C1232($ob_raiz;$at_propiedadJson;$al_propiedadJsonref)
			For ($i;1;Size of array:C274($at_nombres))
				$l_pos:=Find in array:C230($at_propiedadJson;$at_nombres{$i})
				If ($l_pos#-1)
					  //$t_valor:=OB Get($ob_json;$at_propiedadJson{$l_pos};OB Get type($ob_nodo;$at_propiedadJson{$l_pos}))
					$t_valor:=OB Get:C1224($ob_raiz;$at_nombres{$i})
					$i:=Size of array:C274($at_nombres)
				End if 
			End for 
			If ($t_valor#"")
				Case of 
					: ($t_valor="VD")
						[ACT_Pagos:172]wp_tipo_pago:37:=$t_valor
						[ACT_Pagos:172]wp_tipo_pago_glosa:38:="Débito"
					Else 
						[ACT_Pagos:172]wp_tipo_pago:37:=$t_valor
						[ACT_Pagos:172]wp_tipo_pago_glosa:38:="Crédito"
				End case 
			End if 
	End case 
	SAVE RECORD:C53([ACT_Pagos:172])
	KRL_ReloadAsReadOnly (->[ACT_Pagos:172])
End if 

