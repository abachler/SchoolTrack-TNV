//%attributes = {}

  // ----------------------------------------------------
  // Usuario (SO): Adrian Sepulveda 
  // Fecha y hora: 14-07-18, 16:06:22
  // ----------------------------------------------------
  // Método: UD_v20180714_InitColorGraficosE
  // Descripción
  // 
  //
  // Parámetros
  // ----------------------------------------------------



C_LONGINT:C283($i;$l_color;$l_End;$l_indice;$l_Start;$l_progress)
C_TEXT:C284($t_color)
C_OBJECT:C1216($o_color)

ARRAY LONGINT:C221($al_recNumEstilos;0)

ALL RECORDS:C47([xxSTR_EstilosEvaluacion:44])
SELECTION TO ARRAY:C260([xxSTR_EstilosEvaluacion:44];$al_recNumEstilos)


$l_progress:=IT_Progress (1;0;0;"Inicializando colores para gráficos STWA")
For ($l_indice;1;Size of array:C274($al_recNumEstilos))
	$l_progress:=IT_Progress (0;$l_progress;$l_indice/Size of array:C274($al_recNumEstilos);"Inicializando colores para gráficos STWA")
	GOTO RECORD:C242([xxSTR_EstilosEvaluacion:44];$al_recNumEstilos{$l_indice})
	EVS_ReadStyleData 
	ARRAY LONGINT:C221(aSTWAColorRGB;0)
	ARRAY TEXT:C222(aSTWAColorHexa;0)
	AT_RedimArrays (Size of array:C274(aSymbol);->aSTWAColorRGB;->aSTWAColorHexa)
	
	For ($i;1;Size of array:C274(aSTWAColorRGB))
		$o_color:=ST_ObtieneColorHexaRGB ("colorRandom")
		aSTWAColorRGB{$i}:=OB Get:C1224($o_color;"RGB")
		aSTWAColorHexa{$i}:=OB Get:C1224($o_color;"Hexa")
	End for 
	
	EVS_WriteStyleData 
End for 

$l_progress:=IT_Progress (-1;$l_progress)


