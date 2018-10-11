If (Size of array:C274(aText1)>1)
	ARRAY POINTER:C280(<>aChoicePtrs;1)
	<>aChoicePtrs{1}:=->aText1
	choiceIdx:=1
	hidecol:=0
	TBL_ShowChoiceList (1)
	If ((ok=1) & (choiceIdx>0))
		at_CUNameDelegado{vRow}:=<>aChoicePtrs{1}->{choiceIdx}
		$el:=Find in array:C230(at_CUApoderados;at_CUNameDelegado{vRow})
		GOTO RECORD:C242([Personas:7];al_CURecNumApoderados{$el})
		al_CUIDDelegado{vRow}:=[Personas:7]No:1
		at_CUHomePhoneDelegado{vRow}:=[Personas:7]Telefono_domicilio:19
		at_CUWorkPhoneDelegado{vRow}:=[Personas:7]Telefono_profesional:29
		at_CUeMailDelegado{vRow}:=[Personas:7]eMail:34
		AL_UpdateArrays (xALP_Delegados;-1)
	Else 
		at_CUNameDelegado{vRow}:=""
		al_CUIDDelegado{vRow}:=0
		at_CUHomePhoneDelegado{vRow}:=""
		at_CUWorkPhoneDelegado{vRow}:=""
		at_CUeMailDelegado{vRow}:=""
		AL_UpdateArrays (xALP_Delegados;-1)
	End if 
Else 
	at_CUNameDelegado{vRow}:=aText1{1}
	$el:=Find in array:C230(at_CUApoderados;at_CUNameDelegado{vRow})
	GOTO RECORD:C242([Personas:7];al_CURecNumApoderados{$el})
	al_CUIDDelegado{vRow}:=[Personas:7]No:1
	at_CUHomePhoneDelegado{vRow}:=[Personas:7]Telefono_domicilio:19
	at_CUWorkPhoneDelegado{vRow}:=[Personas:7]Telefono_profesional:29
	at_CUeMailDelegado{vRow}:=[Personas:7]eMail:34
	AL_UpdateArrays (xALP_Delegados;-1)
End if 


