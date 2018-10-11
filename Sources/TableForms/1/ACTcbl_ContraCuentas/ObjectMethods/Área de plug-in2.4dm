Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		If ($line#0)
			If (aCCID{$line}#0)
				aenccuenta{0}:=aCCID{$line}
				ARRAY LONGINT:C221($DA_Return;0)
				AT_SearchArray (->aenccuenta;"=";->$DA_Return)
				ARRAY INTEGER:C220($select;Size of array:C274($DA_Return))
				For ($i;1;Size of array:C274($DA_Return))
					$select{$i}:=$DA_Return{$i}
				End for 
				AL_SetSelect (xALP_CuentasCbl;$select)
			End if 
		End if 
		IT_SetButtonState (($line#0);->bClearCCCbl)
		ACTwiz_CuentasCblFooters 
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
				TBL_ShowChoiceList (0;__ ("Seleccione la Cuenta");2)
				If (ok=1)
					acampocc1{$row}:=<>asACT_CuentaCta{choiceidx}
					acampocc4{$row}:=<>asACT_GlosaCta{choiceidx}
					acampocc19{$row}:=<>asACT_CodAuxCta{choiceidx}
				End if 
			: ($col=16)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;1)
				<>aChoicePtrs{1}:=-><>asACT_Centro
				TBL_ShowChoiceList (0;__ ("Seleccione el Centro de Costos");1)
				If (ok=1)
					acampocc16{$row}:=<>asACT_Centro{choiceidx}
				End if 
		End case 
		IT_SetButtonState (($row#0);->bClearCCCbl)
		ACTwiz_CuentasCblFooters 
End case 