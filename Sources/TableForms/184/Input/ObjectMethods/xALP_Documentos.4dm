Case of 
	: ((alProEvt=1) | (alProEvt=2))
		$line:=AL_GetLine (xALP_Documentos)
		AL_UpdateArrays (ALP_CargosXPagar;0)
		ACTac_CargaCargosAviso ("";aACT_ApdosDCID{$line};"";0)
		AL_UpdateArrays (ALP_CargosXPagar;-2)
End case 
