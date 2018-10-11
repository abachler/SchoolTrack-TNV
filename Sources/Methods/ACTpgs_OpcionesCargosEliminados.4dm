//%attributes = {}
  //ACTpgs_OpcionesCargosEliminados

C_TEXT:C284($1;$vt_accion;$vt_retorno;$0;$vt_ref)
C_LONGINT:C283($vl_recNumCargo)
C_POINTER:C301(${2})
C_POINTER:C301($vy_pointer1)

$vt_accion:=$1
If (Count parameters:C259>=2)
	$vy_pointer1:=$2
End if 

Case of 
	: ($vt_accion="DeclaraVar")
		C_BOOLEAN:C305(vbACT_IPCargoEliminado)
		
	: ($vt_accion="InitVars")
		ACTpgs_OpcionesCargosEliminados ("DeclaraVar")
		ARRAY TEXT:C222(atACT_recargosAEliminados;0)
		ARRAY TEXT:C222(atACT_recargosTEliminados;0)
		ARRAY TEXT:C222(atACT_recargosDectosEliminados;0)
		ARRAY TEXT:C222(atACT_recargosTablaEliminados;0)
		vbACT_IPCargoEliminado:=False:C215
		
	: ($vt_accion="SetBooleanVar")
		vbACT_IPCargoEliminado:=True:C214
		
	: ($vt_accion="LlenaArreglos")
		ACTpgs_OpcionesCargosEliminados ("DeclaraVar")
		If (vbACT_IPCargoEliminado)
			$vl_recNumCargo:=$vy_pointer1->
			KRL_GotoRecord (->[ACT_Cargos:173];$vl_recNumCargo)
			If ([ACT_Cargos:173]Ref_AvisoMulta:53#"")
				APPEND TO ARRAY:C911(atACT_recargosAEliminados;[ACT_Cargos:173]Ref_AvisoMulta:53)
			End if 
			If ([ACT_Cargos:173]Ref_RecargoTramo:63#"")
				APPEND TO ARRAY:C911(atACT_recargosTEliminados;[ACT_Cargos:173]Ref_RecargoTramo:63)
			End if 
			If ([ACT_Cargos:173]Ref_RecargoDcto:64#"")
				APPEND TO ARRAY:C911(atACT_recargosDectosEliminados;[ACT_Cargos:173]Ref_RecargoDcto:64)
			End if 
			If ([ACT_Cargos:173]Ref_AvisoMultaTabla:67#"")
				APPEND TO ARRAY:C911(atACT_recargosTablaEliminados;[ACT_Cargos:173]Ref_AvisoMultaTabla:67)
			End if 
			
		End if 
		
	: ($vt_accion="VerificaRecargoAutomatico")
		ACTpgs_OpcionesCargosEliminados ("DeclaraVar")
		If (vbACT_IPCargoEliminado)
			$vt_ref:=$vy_pointer1->
			If (Find in array:C230(atACT_recargosAEliminados;$vt_ref)>0)
				$vt_retorno:="0"
			Else 
				$vt_retorno:="1"
			End if 
		Else 
			$vt_retorno:="1"
		End if 
		
	: ($vt_accion="VerificaRecargoTramo")
		ACTpgs_OpcionesCargosEliminados ("DeclaraVar")
		If (vbACT_IPCargoEliminado)
			$vt_ref:=$vy_pointer1->
			If (Find in array:C230(atACT_recargosTEliminados;$vt_ref)>0)
				$vt_retorno:="0"
			Else 
				$vt_retorno:="1"
			End if 
		Else 
			$vt_retorno:="1"
		End if 
		
	: ($vt_accion="VerificaEliminacionDctos")
		  //20121231 RCH
		ACTpgs_OpcionesCargosEliminados ("DeclaraVar")
		If (vbACT_IPCargoEliminado)
			$vt_ref:=$vy_pointer1->
			If (Find in array:C230(atACT_recargosDectosEliminados;$vt_ref)>0)
				$vt_retorno:="0"
			Else 
				$vt_retorno:="1"
			End if 
		Else 
			$vt_retorno:="1"
		End if 
		
	: ($vt_accion="VerificaRecargoAutomaticoXTabla")
		ACTpgs_OpcionesCargosEliminados ("DeclaraVar")
		If (vbACT_IPCargoEliminado)
			$vt_ref:=$vy_pointer1->
			If (Find in array:C230(atACT_recargosTablaEliminados;$vt_ref)>0)
				$vt_retorno:="0"
			Else 
				$vt_retorno:="1"
			End if 
		Else 
			$vt_retorno:="1"
		End if 
		
End case 

$0:=$vt_retorno