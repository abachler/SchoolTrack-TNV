//%attributes = {}
  // AS_xALP_EstiloCalificaciones()
  // Por: Alberto Bachler K.: 31-01-14, 18:45:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_error;$l_numeroColumna;$i)

ARRAY LONGINT:C221($al_ColumnasVisibles;0)
ARRAY POINTER:C280($ay_Columnas;0)
ARRAY TEXT:C222($at_Columnas;0)

If (Count parameters:C259=1)
	$l_filaInicio:=$1
	$l_filaTermino:=$1
Else 
	$l_filaInicio:=1
	$l_filaTermino:=Size of array:C274(aNtaIDAlumno)
End if 


  // colores RGB
$l_amarillo:=0x66000000 | (255 << 16) | (255 << 8) | (11)
$l_rojo:=0xFF000000 | (255 << 16)
$l_azul:=0xFF000000 | (255)
$l_verde:=0xFF000000 | (128 << 8)
$l_purpura:=0xFF000000 | (138 << 16) | (43 << 8) | 226
$l_coral:=0xFF000000 | (255 << 16) | (127 << 8) | 80
$l_maroon:=0xFF000000 | (139 << 16)
$l_midnightBlue:=0xFF000000 | (25 << 16) | (25 << 8) | 112
$l_olive:=0xFF000000 | (128 << 16) | (128 << 8)
$l_darkOrange:=0xFF000000 | (255 << 16) | (140 << 8)

$l_modoNotaOficial:=iPrintActa

$b_convertir_a_EstiloOficial:=KRL_GetBooleanFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]ConvertirEval_a_EstiloOficial:37)
$b_convertir_a_EstiloOficial:=$b_convertir_a_EstiloOficial & (Not:C34([Asignaturas:18]NotaOficial_conEstiloAsignatura:95))
$l_idEstiloEvaluacionOficial:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]EvStyle_oficial:23)
If ($b_convertir_a_EstiloOficial)
	EVS_ReadStyleData ($l_idEstiloEvaluacionOficial)
	Case of 
		: ($l_modoNotaOficial=Notas)
			$r_minimoNotaOficial:=EV2_Nota_a_Real (rGradesMinimum)
		: ($l_modoNotaOficial=Puntos)
			$r_minimoNotaOficial:=EV2_Nota_a_Real (rPointsMinimum)
		: ($l_modoNotaOficial=Porcentaje)
			$r_minimoNotaOficial:=rPctMinimum
		: ($l_modoNotaOficial=Simbolos)
			$r_minimoNotaOficial:=rPctMinimum  //EV2_Simbolo_a_Real (EV2_Real_a_Simbolo (rPctMinimum))
	End case 
	EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
Else 
	Case of 
		: ($l_modoNotaOficial=Notas)
			$r_minimoNotaOficial:=EV2_Nota_a_Real (rGradesMinimum)
		: ($l_modoNotaOficial=Puntos)
			$r_minimoNotaOficial:=EV2_Nota_a_Real (rPointsMinimum)
		: ($l_modoNotaOficial=Porcentaje)
			$r_minimoNotaOficial:=rPctMinimum
		: ($l_modoNotaOficial=Simbolos)
			$r_minimoNotaOficial:=rPctMinimum  // EV2_Simbolo_a_Real (EV2_Real_a_Simbolo (rPctMinimum))
	End case 
End if 

$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Columns;$ay_Columnas)
$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Visible;$al_ColumnasVisibles)
$l_error:=AL_GetObjects (xALP_ASNotas;ALP_Object_Source;$at_Columnas)

$minimoRequerido:=Round:C94(rPctMinimum;11)

For ($i_columnas;1;Size of array:C274(aNtaArrNames))
	$l_numeroColumna:=Find in array:C230($at_Columnas;aNtaArrNames{$i_columnas})
	If ($l_numeroColumna>0)
		If ($al_ColumnasVisibles{$l_numeroColumna}=1)
			$y_ArrayReal:=aNtaRealArrPointers{$i_columnas}
			For ($i_filas;$l_filaInicio;$l_filaTermino)
				$r_Evaluacion:=$y_ArrayReal->{$i_filas}
				Case of 
					: (aNtaArrNames{$i_columnas}="aNtaOF")
						Case of 
							: ($r_Evaluacion=-3)
								  // eximido, gris pizarra oscuro
								AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_darkOrange)
								AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_StyleB;1)
							: ($r_Evaluacion=-2)
								  // pendiente, verde
								AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_verde)
								
							: ($r_Evaluacion=-4)
								  // omitido, violeta
								AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_olive)
								AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_StyleB;1)
								
							: ($r_Evaluacion<$r_minimoNotaOficial)
								AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_rojo)
							Else 
								
								AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_azul)
						End case 
						
						
					: ((iEvaluationMode=4) & ($r_Evaluacion<$minimoRequerido))
						  // reprobado, rojo
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_rojo)
						
					: ($r_Evaluacion=-3)
						  // eximido, gris pizarra oscuro
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_darkOrange)
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_StyleB;1)
						
					: ($r_Evaluacion=-2)
						  // pendiente, verde
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_verde)
						
					: ($r_Evaluacion=-4)
						  // omitido, violeta
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_olive)
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_StyleB;1)
						
						
					: (($r_Evaluacion>=vrNTA_MinimoEscalaReferencia) & ($r_Evaluacion<$minimoRequerido))
						  // rojo 0xFFFF0000
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_rojo)
						
					: (($r_Evaluacion>=vrNTA_MinimoEscalaReferencia) & ($r_Evaluacion>=$minimoRequerido))
						  // azul 0xFF0000FF
						AL_SetCellLongProperty (xALP_ASNotas;$i_filas;$l_numeroColumna;ALP_Cell_TextColor;$l_azul)
						
				End case 
				
				If (aNtaReprobada{$i_filas})
					AL_SetCellLongProperty (xALP_ASNotas;$i_filas;1;ALP_Cell_TextColor;0xFFFF0000)
					AL_SetCellLongProperty (xALP_ASNotas;$i_filas;2;ALP_Cell_TextColor;0xFFFF0000)
				Else 
					AL_SetCellLongProperty (xALP_ASNotas;$i_filas;1;ALP_Cell_TextColor;0xFF000000)
					AL_SetCellLongProperty (xALP_ASNotas;$i_filas;2;ALP_Cell_TextColor;0xFF000000)
				End if 
				
				If (vb_ComparacionPromedios)
					If (Is a list:C621(<>hl_avgDiff_Asignaturas))
						If (HL_FindInListByReference (<>hl_avgDiff_Asignaturas;Record number:C243([Asignaturas:18]))#"")
							If (HL_FindInListByReference (<>hl_avgDiff_Alumnos;aNtaRecNum{$i})#"")
								AL_SetRowLongProperty (xALP_ASNotas;$i_filas;ALP_Row_BackColor;$l_amarillo)
							End if 
						End if 
					Else 
						AL_SetRowLongProperty (xALP_ASNotas;$i_filas;ALP_Row_BackColor;0xFFFFFFFF)
					End if 
				End if 
				
				AS_xALP_AtributosCeldaNotaFinal ($i_filas)
			End for 
		End if 
	End if 
End for 
