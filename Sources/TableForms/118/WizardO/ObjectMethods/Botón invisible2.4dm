$choice:=IT_PopUpMenu (->at_IIdentificador;->vIIdentificador)
If ($choice#0)
	vIIdentificador:=at_IIdentificador{$choice}
End if 