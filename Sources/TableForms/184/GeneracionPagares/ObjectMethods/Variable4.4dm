$choice:=IT_PopUpMenu (->alACT_DiasPagares;->vlACT_DiaVencimiento)
If ($choice>0)
	vlACT_DiaVencimiento:=alACT_DiasPagares{$choice}
End if 