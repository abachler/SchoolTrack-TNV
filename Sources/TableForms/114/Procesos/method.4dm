Case of 
	: (Form event:C388=On Load:K2:1)
		ARRAY LONGINT:C221(aProcessStyles;Size of array:C274(alXSkrl_ProcessNumber))
		For ($i;1;Size of array:C274(aProcessStyles))
			If (alXSkrl_ProcessNumber{$i}<0)
				aProcessStyles{$i}:=Italic:K14:3
			Else 
				aProcessStyles{$i}:=Plain:K14:1
			End if 
		End for 
		SET TIMER:C645(300)
	: (Form event:C388=On Timer:K2:25)
		KRL_GetProcessesInfos 
		ARRAY LONGINT:C221(aProcessStyles;Size of array:C274(alXSkrl_ProcessNumber))
		For ($i;1;Size of array:C274(aProcessStyles))
			If (alXSkrl_ProcessNumber{$i}<0)
				aProcessStyles{$i}:=Italic:K14:3
			Else 
				aProcessStyles{$i}:=Plain:K14:1
			End if 
		End for 
	: (Form event:C388=On Close Box:K2:21)
		If (IT_AltKeyIsDown )
			CANCEL:C270
		Else 
			HIDE PROCESS:C324(Current process:C322)
			PAUSE PROCESS:C319(Current process:C322)
		End if 
End case 