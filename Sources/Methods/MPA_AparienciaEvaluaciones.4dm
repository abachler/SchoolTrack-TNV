//%attributes = {}
  // MPA_AparienciaEvaluaciones()
  // Por: Alberto Bachler K.: 06-03-15, 18:32:09
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($i;$l_referenciaArea)

ARRAY LONGINT:C221($al_arregloD2Celdas;0)

$l_referenciaArea:=$1
$t_refTabla:=String:C10(Table:C252(->[Alumnos_EvaluacionAprendizajes:203]))
$t_refPeriodo:=String:C10(vl_periodoSeleccionado)

For ($i;1;Size of array:C274(arEVLG_Indicador))
	If (alEVLG_RefEstiloEvaluacion{$i}#0)
		EVS_ReadStyleData (alEVLG_RefEstiloEvaluacion{$i})
		$t_llaveAnotacion:=$t_refTabla+"."+atMPA_uuidRegistro{$i}+"."+$t_refPeriodo
		$b_conAnotacion:=(Find in field:C653([xShell_RecordNotes:283]Llave:4;$t_llaveAnotacion)>No current record:K29:2)
		If ($b_conAnotacion)
			AL_SetCellStyle ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;Bold:K14:2+Underline:K14:4)
		Else 
			AL_SetCellStyle ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;Bold:K14:2)
		End if 
		Case of 
			: (adEVLG_FechaLogro{$i}#!00-00-00!)
				AL_SetCellColor ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;"Green";0;"";0)
				
			: ((arEVLG_Indicador{$i}<rPctMinimum) & (arEVLG_Indicador{$i}>=vrNTA_MinimoEscalaReferencia))
				AL_SetCellColor ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;"Red";0;"";0)
				
			: (arEVLG_Indicador{$i}>=rPctMinimum)
				AL_SetCellColor ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;"Blue";0;"";0)
				
			: (arEVLG_Indicador{$i}=-2)
				AL_SetCellColor ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;"";3;"";0)
				AL_SetCellStyle ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;Italic:K14:3+Bold:K14:2)
				
			: (arEVLG_Indicador{$i}=-4)
				AL_SetCellColor ($l_referenciaArea;2;$i;2;$i;$al_arregloD2Celdas;"Black";0;"";0)
		End case 
	End if 
End for 