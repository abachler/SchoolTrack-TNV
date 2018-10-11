$choice:=IT_PopUpMenu (->alACT_CuotasPagares;->vlACT_CuotasC)
If ($choice>0)
	vlACT_CuotasC:=alACT_CuotasPagares{$choice}
End if 