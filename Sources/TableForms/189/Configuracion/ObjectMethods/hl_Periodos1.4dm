


If (vlMPA_RecNumMatrizDefecto>=0)
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];vlMPA_RecNumMatrizDefecto)
	AL_UpdateArrays (xALP_Banco;0)
	ARRAY TEXT:C222(atEVLG_EjesLogros;0)
	ARRAY LONGINT:C221(alEVLG_Ids;0)
	ARRAY LONGINT:C221(alEVLG_TipoObjeto;0)
	ARRAY TEXT:C222(atEVLG_Icons;0)
	MPAmtx_LeeConfiguracion (vlMPA_RecNumMatrizDefecto;hl_Periodos2;->alEVLG_TipoObjeto;->alEVLG_Ids;->atEVLG_EjesLogros;->atEVLG_Icons)
	AL_UpdateArrays (xALP_Banco;-2)
	AL_SetLine (xALP_Banco;0)
	For ($i;1;Size of array:C274(alEVLG_Ids))
		If (alEVLG_TipoObjeto{$i}=Eje_Aprendizaje)
			AL_SetRowStyle (xALP_Banco;$i;1)
			AL_SetRowRGBColor (xALP_Banco;$i;0;0;0;237;243;254)
		Else 
			AL_SetRowRGBColor (xALP_Banco;$i;0;0;0;255;255;255)
		End if 
	End for 
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];vlMPA_RecNumMatrizActual)
	POST KEY:C465(Character code:C91("=");256)
End if 