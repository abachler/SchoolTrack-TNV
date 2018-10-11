//%attributes = {}
  //xALP_ACT_CB_Condonacion

C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$2;$3)

If ($2=8)  //soft deselect
	$0:=False:C215
Else 
	$0:=True:C214
	AL_GetCurrCell (xALP_ACT_Condonacion;$col;$line)
	Case of 
		: ($col=4)
			Case of 
				: (alACT_AvisosMontoCondonacion{$line}>alACT_AvisosSaldo{$line})
					alACT_AvisosMontoCondonacion{$line}:=alACT_AvisosSaldo{$line}
					BEEP:C151
					
				: (alACT_AvisosMontoCondonacion{$line}<0)
					alACT_AvisosMontoCondonacion{$line}:=0
					BEEP:C151
					
			End case 
	End case 
End if 