$selectedDataRef:=Selected list items:C379(hl_Dato;*)
$selectedLevelRef:=Selected list items:C379(hl_Niveles;*)

$cond:=(($selectedDataRef>10000) & ($selectedLevelRef#0))
IT_SetButtonState (($cond);->bAddEnvio)