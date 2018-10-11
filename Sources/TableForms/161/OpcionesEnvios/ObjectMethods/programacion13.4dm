$selectedDataRef:=Selected list items:C379(hl_Dato;*)
$selectedLevelRef:=Selected list items:C379(hl_Niveles;*)

$cond:=(($selectedDataRef>10000) & ($selectedLevelRef#0))
IT_SetButtonState (($cond);->SN3_Manual_Todo;->SN3_Manual_Modificados;->bAddEnvio)


IT_SetButtonState (($selectedDataRef<90000);->hl_Niveles)