Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$line:=AL_GetLine (xALP_Documentos)
		AL_UpdateArrays (ALP_CargosXPagar;0)
		ACTac_CargaCargosAviso (aYearsACT{aYearsACT};aACT_ApdosDCID{$line};"terceros";[ACT_Terceros:138]Id:1)
		AL_UpdateArrays (ALP_CargosXPagar;-2)
End case 
