  //$choice:=IT_PopUpMenu (->atACT_PItemNombreDcto;->vtACT_Item)
$choice:=ACTKRL_PopUp (->atACT_PItemNombreDcto;"Seleccione...";->vtACT_Item)
If ($choice#0)
	vtACT_Item:=atACT_PItemNombreDcto{$choice}
	vlACT_Item:=alACT_PItemIDDcto{$choice}
End if 