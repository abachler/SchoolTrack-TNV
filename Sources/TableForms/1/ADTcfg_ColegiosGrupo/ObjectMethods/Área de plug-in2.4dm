If (alProEvt=-5)
	AL_GetDrgArea (xALP_ColegiosGrupo;$destinationArea)
	AL_GetDrgSrcRow (xALP_ColegiosGrupo;$selectedItemLine)
	AL_GetDrgDstRow (xALP_ColegiosAnteriores;$DestRow)
	If ($destinationArea=xALP_ColegiosAnteriores)
		AL_UpdateArrays (xALP_ColegiosAnteriores;0)
		INSERT IN ARRAY:C227(aColegiosAnteriores;$DestRow;1)
		aColegiosAnteriores{$DestRow}:=aColegiosGrupo{$selectedItemLine}
		SORT ARRAY:C229(aColegiosAnteriores)
		AL_UpdateArrays (xALP_ColegiosAnteriores;-2)
		AL_SetLine (xALP_ColegiosAnteriores;0)
		AL_UpdateArrays (xALP_ColegiosGrupo;0)
		DELETE FROM ARRAY:C228(aColegiosGrupo;$selectedItemLine;1)
		AL_UpdateArrays (xALP_ColegiosGrupo;-2)
		AL_SetLine (xALP_ColegiosGrupo;0)
	End if 
End if 
