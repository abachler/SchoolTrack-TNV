LOG_RegisterChangeConf (OBJECT Get title:C1068(Self:C308->);Self:C308->)
If (Self:C308->=0)
	C_TEXT:C284($t_texto;$t_conf)
	C_LONGINT:C283($l_ItemRef)
	$t_texto:=Choose:C955(cb_AgruparCargos=1;" matener marcada ";" MARCAR ")
	GET LIST ITEM:C378(vlACT_ConfigGenerales;4;$l_ItemRef;$t_conf)
	CD_Dlog (0;"Al desmarcar esta opción se recomienda"+$t_texto+"la opción "+ST_Qte (OBJECT Get title:C1068(cb_AgruparCargos))+", que aparece en la configuración "+ST_Qte ($t_conf)+".\r\rEsta configuración permitirá que, a pesar que los cargos se vean separados en la ficha del Aviso de Cobranza, al imprimir podrán aparecer como uno solo.")
End if 