$line:=AL_GetLine (xALP_Configs)

If ($line>0)
	$recNum:=alMPA_RecNumMatriz{$line}
	GOTO RECORD:C242([MPA_AsignaturasMatrices:189];$recNum)
	GET LIST ITEM:C378(hl_Periodos2;Selected list items:C379(hl_Periodos);$refPeriodo;$itemText)
	AL_UpdateArrays (xALP_LogrosAsignaturas;0)
	MPAmtx_LeeConfiguracion ($recNum;$refPeriodo;->alEVLG_AdvCFG_TipoObjeto;->alEVLG_AdvCFG_Ids;->atEVLG_AdvCFG_EjesLogros;->atEVLG_AdvCFG_Icons)
	AL_UpdateArrays (xALP_LogrosAsignaturas;-2)
	
	POST KEY:C465(Character code:C91("=");256)
End if 