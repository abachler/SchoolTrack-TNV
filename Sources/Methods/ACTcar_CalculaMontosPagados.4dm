//%attributes = {}
  //ACTcar_CalculaMontosPagados

C_TEXT:C284($vt_accion;$1)
C_REAL:C285($vr_monto;$0)
ARRAY LONGINT:C221($al_recNumcargos;0)

$vt_accion:=$1

If (Count parameters:C259>=2)
	$ptr1:=$2
End if 

READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
READ ONLY:C145([ACT_Cargos:173])

Case of 
	: ($vt_accion="CalculoDesdeSet")
		USE SET:C118($ptr1->)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumcargos;"")
		For ($i;1;Size of array:C274($al_recNumcargos))
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumcargos{$i})
			If ([ACT_Cargos:173]EmitidoSegúnMonedaCargo:11)
				$vr_monto:=$vr_monto+[ACT_Cargos:173]MontosPagadosMPago:52
			Else 
				$vr_monto:=$vr_monto+[ACT_Cargos:173]MontosPagados:8
			End if 
		End for 
		
End case 

$0:=$vr_monto