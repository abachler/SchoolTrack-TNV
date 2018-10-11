Case of 
	: (alProEvt=1)
		$line:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($line>0);->bDelLinea)
		vt_Motivo:=ST_Boolean2Text (($line>0);aMotivo{$line};"")
	: (alProEvt=2)
		$col:=AL_GetColumn (Self:C308->)
		$row:=AL_GetLine (Self:C308->)
		IT_SetButtonState (($row>0);->bDelLinea)
		vt_Motivo:=ST_Boolean2Text (($row>0);aMotivo{$row};"")
		Case of 
			: ($col=12)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>asACT_CuentaCta
				<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
				<>aChoicePtrs{3}:=-><>asACT_GlosaCta
				TBL_ShowChoiceList (0;"Seleccione la Cuenta";2)
				If (ok=1)
					aCtaContable{$row}:=<>asACT_CuentaCta{choiceIdx}
					aCodAux{$row}:=<>asACT_CodAuxCta{choiceIdx}
				End if 
			: ($col=14)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;1)
				<>aChoicePtrs{1}:=-><>asACT_Centro
				TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1)
				If (ok=1)
					aCentro{$row}:=<>asACT_Centro{choiceIdx}
				End if 
			: ($col=15)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;3)
				<>aChoicePtrs{1}:=-><>asACT_CuentaCta
				<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
				<>aChoicePtrs{3}:=-><>asACT_GlosaCta
				TBL_ShowChoiceList (0;"Seleccione la Cuenta";2)
				If (ok=1)
					aCCtaContable{$row}:=<>asACT_CuentaCta{choiceIdx}
					aCCodAux{$row}:=<>asACT_CodAuxCta{choiceIdx}
				End if 
			: ($col=17)
				ARRAY POINTER:C280(<>aChoicePtrs;0)
				ARRAY POINTER:C280(<>aChoicePtrs;1)
				<>aChoicePtrs{1}:=-><>asACT_Centro
				TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1)
				If (ok=1)
					aCCentro{$row}:=<>asACT_Centro{choiceIdx}
				End if 
		End case 
End case 