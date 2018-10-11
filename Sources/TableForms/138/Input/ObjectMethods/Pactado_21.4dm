ARRAY INTEGER:C220($ai_lines;0)
$line:=AL_GetSelect (xAL_ACT_Terc_Items;$ai_lines)
If (Size of array:C274($ai_lines)>0)
	$resp:=CD_Dlog (0;__ ("¿Está seguro de que desea quitar el(los) ítem(s) asociado(s)?");__ ("");__ ("Si");__ ("No");__ ("Cancelar"))
	If ($resp=1)
		AL_UpdateArrays (xAL_ACT_Terc_Items;0)
		AL_UpdateArrays (xALP_ACT_Terc_CtasXItems;0)
		For ($i;Size of array:C274($ai_lines);1;-1)
			$vl_idItem:=alACT_TerIdItem{$ai_lines{$i}}
			ACTter_Datos_ALP ("EliminaRegistrosItems";->$vl_idItem)
		End for 
		ACTter_PagePactado 
		AL_SetLine (xAL_ACT_Terc_Items;0)
	End if 
End if 
ACTter_SetObjects 
