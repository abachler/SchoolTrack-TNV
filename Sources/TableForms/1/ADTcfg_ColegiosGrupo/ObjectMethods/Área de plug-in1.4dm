If (alProEvt=-5)
	AL_GetDrgArea (xALP_ColegiosAnteriores;$destinationArea)
	AL_GetDrgSrcRow (xALP_ColegiosAnteriores;$selectedItemLine)
	AL_GetDrgDstRow (xALP_ColegiosGrupo;$DestRow)
	If ($destinationArea=xALP_ColegiosGrupo)
		AL_UpdateArrays (xALP_ColegiosGrupo;0)
		INSERT IN ARRAY:C227(aColegiosGrupo;$DestRow;1)
		aColegiosGrupo{$DestRow}:=aColegiosAnteriores{$selectedItemLine}
		SORT ARRAY:C229(aColegiosGrupo)
		AL_UpdateArrays (xALP_ColegiosGrupo;-2)
		AL_SetLine (xALP_ColegiosGrupo;0)
		AL_UpdateArrays (xALP_ColegiosAnteriores;0)
		DELETE FROM ARRAY:C228(aColegiosAnteriores;$selectedItemLine;1)
		AL_UpdateArrays (xALP_ColegiosAnteriores;-2)
		AL_SetLine (xALP_ColegiosAnteriores;0)
	End if 
End if 