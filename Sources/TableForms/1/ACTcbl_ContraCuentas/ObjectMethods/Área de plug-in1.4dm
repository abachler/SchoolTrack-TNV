Case of 
	: (alProEvt=-2)
		ARRAY INTEGER:C220($aselected;0)
		$err:=AL_GetSelect (Self:C308->;$aselected)
		ACTwiz_CuentasCblFooters 
	: (alProEvt=1)
		ARRAY INTEGER:C220($aselected;0)
		$err:=AL_GetSelect (Self:C308->;$aselected)
		ACTwiz_CuentasCblFooters 
		IT_SetButtonState ((Size of array:C274($aselected)>0);->bDelLinea)
		AL_SetLine (xALP_ContraCuentasCbl;0)
	: (alProEvt=2)
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		Case of 
			: ($col=1)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>asACT_CuentaCta
				<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
				<>aChoicePtrs{3}:=-><>asACT_GlosaCta
				TBL_ShowChoiceList (0;"Seleccione la Cuenta";2)
				If (ok=1)
					acampo1{$row}:=<>asACT_CuentaCta{choiceidx}
					acampo4{$row}:=<>asACT_GlosaCta{choiceidx}
					acampo19{$row}:=<>asACT_CodAuxCta{choiceidx}
				End if 
			: ($col=16)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;1)
				<>aChoicePtrs{1}:=-><>asACT_Centro
				TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1)
				If (ok=1)
					acampo16{$row}:=<>asACT_Centro{choiceidx}
				End if 
		End case 
		ARRAY INTEGER:C220($aselected;0)
		$err:=AL_GetSelect (Self:C308->;$aselected)
		ACTwiz_CuentasCblFooters 
		IT_SetButtonState ((Size of array:C274($aselected)>0);->bDelLinea)
		AL_SetLine (xALP_ContraCuentasCbl;0)
End case 
