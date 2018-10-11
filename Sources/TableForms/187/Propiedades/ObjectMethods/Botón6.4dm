WDW_OpenFormWindow (->[MPA_DefinicionCompetencias:187];"ConfiguracionIndicadores";-1;8;atEVLG_TiposEvaluacion{atEVLG_TiposEvaluacion})
DIALOG:C40([MPA_DefinicionCompetencias:187];"ConfiguracionIndicadores")
CLOSE WINDOW:C154

AT_MultiLevelSort ("<<";->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Descripcion;->atEVLG_Indicadores_Concepto)
BLOB_Variables2Blob (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
If (Size of array:C274(aiEVLG_Indicadores_Valor)>0)
	[MPA_DefinicionCompetencias:187]Escala_Maximo:21:=aiEVLG_Indicadores_Valor{1}
	[MPA_DefinicionCompetencias:187]Escala_Minimo:20:=aiEVLG_Indicadores_Valor{Size of array:C274(aiEVLG_Indicadores_Valor)}
End if 
