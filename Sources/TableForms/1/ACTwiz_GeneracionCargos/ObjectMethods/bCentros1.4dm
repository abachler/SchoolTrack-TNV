ARRAY POINTER:C280(<>aChoicePtrs;0)
ARRAY POINTER:C280(<>aChoicePtrs;1)
<>aChoicePtrs{1}:=-><>asACT_Centro
TBL_ShowChoiceList (0;"Seleccione el Centro de Costos";1;->vsACT_CCentroContable)
If (ok=1)
	vsACT_CCentroContable:=<>asACT_Centro{choiceIdx}
End if 