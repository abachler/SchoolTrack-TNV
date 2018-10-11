  // [xxSTR_Constants].STR_InasistenciasSesiones.Separador()
  // Por: Alberto Bachler: 29/06/13, 11:09:14
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

$l_anchoScrollBar:=16
$l_anchoColumna2:=220
  //$l_AnchoArea:=IT_Objeto_Ancho ("areaInasistencias")
  //$l_AltoArea:=IT_Objeto_Alto ("areaInasistencias")
  //$l_anchoDisponibleParaCeldas:=$l_AnchoArea-$l_anchoScrollBar-$l_anchoColumnaAlumnos
  //$l_columnasHoras:=aiSTK_Hora{Size of array(aiSTK_Hora)}
  //$l_AnchoCeldasAsistencia:=Int($l_anchoDisponibleParaCeldas/$l_columnasHoras)
  //$l_anchoColumnaAlumnos:=$l_anchoColumnaAlumnos+$l_anchoDisponibleParaCeldas-($l_AnchoCeldasAsistencia*$l_columnasHoras)
  //AL_SetWidths (xALP_Inasistencias;1;1;$l_anchoColumnaAlumnos)
  //For ($i;1;$l_columnasHoras)
  //AL_SetWidths (xALP_Inasistencias;$i+1;1;$l_AnchoCeldasAsistencia)
  //End for 

$l_AnchoArea:=IT_Objeto_Ancho ("areaSubsectores")
$l_AltoArea:=IT_Objeto_Alto ("areaSubSectores")
$l_AnchoColumna1:=20
$l_columnasRedimensionables:=1
$l_anchoDisponibleParaCeldas:=$l_AnchoArea-$l_anchoScrollBar-$l_AnchoColumna1
$l_anchoColumnaAsignatura:=$l_AnchoArea-$l_anchoScrollBar-$l_AnchoColumna1
$l_AnchoColumnas:=Int:C8($l_anchoDisponibleParaCeldas/$l_columnasRedimensionables)
AL_SetWidths (xALP_Subsectores;2;1;$l_anchoColumnaAsignatura)

