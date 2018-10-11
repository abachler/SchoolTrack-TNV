$b_indicadoresValidos:=True:C214
If ($b_indicadoresValidos & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) & ((Size of array:C274(aiEVLG_Indicadores_Valor)=0) | (Size of array:C274(atEVLG_Indicadores_Descripcion)=0) | (Size of array:C274(atEVLG_Indicadores_Concepto)=0))))
	$b_indicadoresValidos:=False:C215
	$t_mensaje:=__ ("Los indicadores de logros no han sido correctamente definidos.\r\rDebe registrar el valor numérico, simbólico y la descripción para cada indicador.")
End if 

If ($b_indicadoresValidos & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) & (Find in array:C230(atEVLG_Indicadores_Descripcion;"")>0)))
	$b_indicadoresValidos:=False:C215
	$t_mensaje:=__ ("Hay una o más descripción de niveles de logro sin el texto de descripción.\r\rPor favor registre todas las descripciones de los niveles de logro")
End if 

If ($b_indicadoresValidos & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) & (Find in array:C230(atEVLG_Indicadores_Concepto;"")>0)))
	$b_indicadoresValidos:=False:C215
	$t_mensaje:=__ ("Hay uno o más indicadores de niveles de logro sin equivalencia simbólica especificada.\r\rPor favor defina todas las equivalencias de indicadores de niveles de logro.")
End if 

If ($b_indicadoresValidos & (([MPA_DefinicionCompetencias:187]TipoEvaluacion:12=1) & (Find in array:C230(atEVLG_Indicadores_Concepto;"")>0)))
	$b_indicadoresValidos:=False:C215
	$t_mensaje:=__ ("Hay uno o más indicadores de niveles de logro sin equivalencia simbólica especificada.\r\rPor favor defina todas las equivalencias de indicadores de niveles de logro.")
End if 

If ($b_indicadoresValidos)
	AT_MultiLevelSort ("<<";->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Descripcion;->atEVLG_Indicadores_Concepto)
	BLOB_Variables2Blob (->[MPA_DefinicionCompetencias:187]xIndicadores:14;0;->atEVLG_Indicadores_Descripcion;->aiEVLG_Indicadores_Valor;->atEVLG_Indicadores_Concepto)
	If (Size of array:C274(aiEVLG_Indicadores_Valor)>0)
		[MPA_DefinicionCompetencias:187]Escala_Maximo:21:=aiEVLG_Indicadores_Valor{1}
		[MPA_DefinicionCompetencias:187]Escala_Minimo:20:=aiEVLG_Indicadores_Valor{Size of array:C274(aiEVLG_Indicadores_Valor)}
	End if 
	ACCEPT:C269
Else 
	CD_Dlog (0;$t_mensaje)
End if 