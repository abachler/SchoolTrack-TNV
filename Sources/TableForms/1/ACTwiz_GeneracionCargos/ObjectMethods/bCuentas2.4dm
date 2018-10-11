ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;3)
<>aChoicePtrs{1}:=-><>asACT_CuentaCta
<>aChoicePtrs{2}:=-><>asACT_CodAuxCta
<>aChoicePtrs{3}:=-><>asACT_GlosaCta
TBL_ShowChoiceList (0;"Seleccione la Cuenta";2;->vsACT_CtaContable)
If (ok=1)
	vsACT_CtaContable:=<>asACT_CuentaCta{choiceIdx}
	vsACT_CodAuxCta:=<>asACT_CodAuxCta{choiceIdx}
End if 