//%attributes = {}
  //xAL_ACT_CB_CuentasEspecialesU

C_BOOLEAN:C305($vb_update;$1)
C_LONGINT:C283($vl_id;$2)
$vb_update:=$1
$line:=$2

  //20121105 RCH
If ($vb_update)
	READ WRITE:C146([ACT_Cuentas_Contables:286])
	QUERY:C277([ACT_Cuentas_Contables:286];[ACT_Cuentas_Contables:286]id:1=alACT_idCtaEspecial{$line})
	If (Records in selection:C76([ACT_Cuentas_Contables:286])=1)
		[ACT_Cuentas_Contables:286]glosa:3:=atACT_CtasEspecialesGlosa{$line}
		[ACT_Cuentas_Contables:286]id_cta_asociada:6:=alACT_idCtasEspeciales{$line}
		[ACT_Cuentas_Contables:286]id_centro_asociado:7:=alACT_idCentroEspeciales{$line}
		SAVE RECORD:C53([ACT_Cuentas_Contables:286])
	End if 
	KRL_UnloadReadOnly (->[ACT_Cuentas_Contables:286])
End if 