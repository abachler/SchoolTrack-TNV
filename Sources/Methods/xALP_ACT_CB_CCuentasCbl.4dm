//%attributes = {}
  //xALP_ACT_CB_CCuentasCbl

C_LONGINT:C283($1;$2)
C_BOOLEAN:C305($0)
If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_ContraCuentasCbl;$col;$line)
	Case of 
		: ($col=2)
			If ((acampocc3{$line}#0) & (acampocc2{$line}#0))
				BEEP:C151
				acampocc2{$line}:=0
			End if 
		: ($col=3)
			If ((acampocc2{$line}#0) & (acampocc3{$line}#0))
				BEEP:C151
				acampocc3{$line}:=0
			End if 
		: ($col=4)
			$ctaEsp:=Find in array:C230(atACT_CtasEspecialesGlosa;acampocc4{$line})
			If ($ctaEsp#-1)
				acampocc1{$line}:=asACT_CtasEspecialesCta{$ctaEsp}
				acampocc16{$line}:=asACT_CtasEspecialesCentro{$ctaEsp}
			End if 
	End case 
	ACTwiz_CuentasCblFooters 
	AL_UpdateArrays (xALP_CuentasCbl;-1)
	AL_UpdateArrays (xALP_ContraCuentasCbl;-1)
End if 