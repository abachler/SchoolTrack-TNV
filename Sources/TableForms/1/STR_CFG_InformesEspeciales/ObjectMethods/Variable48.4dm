C_LONGINT:C283($numeroNivel)
C_TEXT:C284($nombreNivel)
GET LIST ITEM:C378(Self:C308->;*;$numeroNivel;$nombreNivel)
If ($numeroNivel#0)
	$currentModel:=vs_lastRCModel
	vs_lastRCModel:=Substring:C12($currentModel;1;Position:C15("/";$currentModel))+String:C10($numeroNivel)
	NIVrc_GetSettings 
	vs_lastRCModel:=$currentModel
End if 