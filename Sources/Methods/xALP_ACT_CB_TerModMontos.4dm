//%attributes = {}
  //xALP_ACT_CB_TerModMontos

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_ACT_Terc_CtasXItems;$col;$line)
	If (abACT_RelativoCXI{$line})
		arACT_MontoFijoCXI{$line}:=0
		arACT_MontoPctCXI{$line}:=0
	Else 
		Case of 
			: ($col=5)
				If (arACT_MontoFijoCXI{$line}<0)
					arACT_MontoFijoCXI{$line}:=0
				End if 
			: ($col=6)
				If ((arACT_MontoPctCXI{$line}>100) | (arACT_MontoPctCXI{$line}<0))
					BEEP:C151
					arACT_MontoPctCXI{$line}:=0
				End if 
				
		End case 
	End if 
	ACTter_Datos_ALP ("Guarda";->$line)
End if 