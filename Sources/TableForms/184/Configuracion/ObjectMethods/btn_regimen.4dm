$choice:=IT_PopUpMenu (->atACT_RegimenPagares;->vtACTp_Regimen)
If ($choice>0)
	vtACTp_Regimen:=atACT_RegimenPagares{$choice}
End if 