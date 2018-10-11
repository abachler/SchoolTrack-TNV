$l_posEtapa:=Find in array:C230(atMPA_EtapasArea;vt_nivel)
If ($l_posEtapa>0)
	Case of 
		: ((Form event:C388=On Clicked:K2:4) | (Form event:C388=On Selection Change:K2:29))
			MPA_CargaDatosColorCeldas ("Eje";->lb_ejesaprendizajes;alMPA_NivelDesde{$l_posEtapa};alMPA_NivelHasta{$l_posEtapa})
	End case 
End if 