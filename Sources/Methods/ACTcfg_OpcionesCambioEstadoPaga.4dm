//%attributes = {}
  //ACTcfg_OpcionesCambioEstadoPaga

C_TEXT:C284($vt_accion;$1;$vt_retorno;$0)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1)
C_LONGINT:C283($vl_idFormaDePagoPagare;$vl_nuevoEstado)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 
$vl_idFormaDePagoPagare:=-16

Case of 
	: ($vt_accion="AsignaNuevoEstadoPagare")
		$vl_nuevoEstado:=$vy_pointer1->
		If ($vl_nuevoEstado#[ACT_Pagares:184]ID_Estado:6)
			[ACT_Pagares:184]ID_Estado:6:=$vl_nuevoEstado
			[ACT_Pagares:184]Estado:24:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->$vl_idFormaDePagoPagare;->[ACT_Pagares:184]ID_Estado:6)
			LOG_RegisterEvt ("Cambio de estado de Pagaré número "+String:C10([ACT_Pagares:184]Numero_Pagare:11)+". Estado cambió de "+Old:C35([ACT_Pagares:184]Estado:24)+" a "+[ACT_Pagares:184]Estado:24+".")
			ACTpagares_fSave 
			$vt_retorno:=vtACTpagares_idMov
		End if 
		
End case 
$0:=$vt_retorno
