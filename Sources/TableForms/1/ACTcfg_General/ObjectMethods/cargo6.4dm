  //$choice:=IT_PopUpMenu (->atACT_PItemNombreCargo;->vtACT_ItemCargo)
$choice:=ACTKRL_PopUp (->atACT_PItemNombreCargo;"Seleccione...";->vtACT_ItemCargo)
If ($choice#0)
	vtACT_ItemCargo:=atACT_PItemNombreCargo{$choice}
	vlACT_ItemCargo:=alACT_PItemIDCargo{$choice}
End if 