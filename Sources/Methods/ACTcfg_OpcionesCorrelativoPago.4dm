//%attributes = {}
  //ACTcfg_OpcionesCorrelativoPago
C_TEXT:C284($1;$t_accion)
C_POINTER:C301($y_puntero1)
C_BLOB:C604($xBlob)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_puntero1:=$2
End if 

Case of 
	: ($t_accion="DeclaraVars")
		C_LONGINT:C283(lACT_correlativoPago)
		C_LONGINT:C283(lACT_correlativoPagoOrg)
		lACT_correlativoPago:=0
		
	: ($t_accion="LeeConf")
		ACTcfg_LeeBlob ("ACT_CorrelativoPago")
		lACT_correlativoPagoOrg:=lACT_correlativoPago
		
	: ($t_accion="GuardaConf")
		ACTcfg_GuardaBlob ("ACT_CorrelativoPago")
		
	: ($t_accion="ArmaBlob")
		BLOB_Variables2Blob ($y_puntero1;0;->lACT_correlativoPago)
		
	: ($t_accion="DesarmaBlob")
		BLOB_Blob2Vars ($y_puntero1;0;->lACT_correlativoPago)
		
	: ($t_accion="VerificaCorrelativo")
		If (lACT_correlativoPago#0)
			C_LONGINT:C283($l_var)
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_var)
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]Numero_Interno:39>=lACT_correlativoPago)
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			If ($l_var>0)
				BEEP:C151
				lACT_correlativoPago:=lACT_correlativoPagoOrg
			Else 
				LOG_RegisterEvt ("Cambio en correlativo de pago. Cambió de "+String:C10(lACT_correlativoPagoOrg)+" a "+String:C10(lACT_correlativoPago)+".")
			End if 
		End if 
End case 