$line:=AL_GetLine (xALP_Indicadores)
If ($line>0)
	AL_UpdateArrays (xALP_Indicadores;0)
	AT_Delete ($line;1;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Descripcion;->atEVLG_Indicadores_Concepto)
	AL_UpdateArrays (xALP_Indicadores;-2)
End if 
