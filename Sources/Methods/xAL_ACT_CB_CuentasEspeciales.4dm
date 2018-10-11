//%attributes = {}
  //xAL_ACT_CB_CuentasEspeciales

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)
  //20121105 RCH
C_BOOLEAN:C305($vb_update)
$vb_update:=True:C214

AL_GetCurrCell (xALP_CtasEspeciales;$col;$row)
$0:=True:C214
If ($2=7)
	$0:=False:C215
Else 
	Case of 
		: ($col=2)
			If (asACT_CtasEspecialesCta{$row}#"")
				$pos:=Find in array:C230(<>asACT_CuentaCta;asACT_CtasEspecialesCta{$row})
				If ($pos>0)
					alACT_idCtasEspeciales{$row}:=<>alACT_idCta{$pos}
				Else 
					asACT_CtasEspecialesCta{$row}:=""
					alACT_idCtasEspeciales{$row}:=0
				End if 
			End if 
			
			
			
		: ($col=3)
			If (asACT_CtasEspecialesCentro{$row}#"")
				$pos:=Find in array:C230(<>asACT_Centro;asACT_CtasEspecialesCentro{$row})
				If ($pos>0)
					alACT_idCentroEspeciales{$row}:=<>alACT_idCentro{$pos}
				Else 
					asACT_CtasEspecialesCentro{$row}:=""
					alACT_idCentroEspeciales{$row}:=0
				End if 
			End if 
			
	End case 
	
	  //20121105 RCH
	xAL_ACT_CB_CuentasEspecialesU ($vb_update;$row)
	
	
End if 