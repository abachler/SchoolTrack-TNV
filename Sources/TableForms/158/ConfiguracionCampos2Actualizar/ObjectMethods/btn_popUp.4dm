$choice:=IT_PopUpMenu (->atCM_PopUp;->vtCM_Aplicacion)
If ($choice#0)
	vtCM_Aplicacion:=atCM_PopUp{$choice}
	atCM_PopUp:=$choice
End if 
CMT_Transferencia ("CargaRegistrosExistentes";->atCM_PopUp)