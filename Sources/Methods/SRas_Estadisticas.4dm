//%attributes = {}
  //SRas_Estadisticas

$periodo:=$1

AS_InitStats 
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
EV2_LeeCalificaciones ([Asignaturas:18]Numero:1;$periodo)

For ($columns;1;21)
	fStatistiques3 (aNtaRealArrPointers{$columns})
	AT_ResizeArrays (aStatsRealArrPointers{$columns};Size of array:C274(<>aStatR))
	For ($statLines;1;Size of array:C274(aStatsRealArrPointers{$columns}->)-1)
		aStatsRealArrPointers{$columns}->{$statLines}:=<>aStatR{$statLines}
	End for 
	aStatsRealArrPointers{$columns}->{7}:=<>aStatR{7}
End for 