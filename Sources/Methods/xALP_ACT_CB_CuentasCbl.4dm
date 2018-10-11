//%attributes = {}
  //xALP_ACT_CB_CuentasCbl

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_CuentasCbl;$col;$line)
	Case of 
		: ($col=2)
			If ((acampo3{$line}#0) & (acampo2{$line}#0))
				BEEP:C151
				acampo2{$line}:=0
			End if 
		: ($col=3)
			If ((acampo2{$line}#0) & (acampo3{$line}#0))
				BEEP:C151
				acampo3{$line}:=0
			End if 
		: ($col=4)
			$ctaEsp:=Find in array:C230(atACT_CtasEspecialesGlosa;acampo4{$line})
			If ($ctaEsp#-1)
				acampo1{$line}:=asACT_CtasEspecialesCta{$ctaEsp}
				acampo16{$line}:=asACT_CtasEspecialesCentro{$ctaEsp}
			End if 
	End case 
	ACTwiz_CuentasCblFooters 
	AL_UpdateArrays (xALP_CuentasCbl;-1)
	AL_UpdateArrays (xALP_ContraCuentasCbl;-1)
End if 