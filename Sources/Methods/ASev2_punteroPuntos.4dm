//%attributes = {}
  // MÉTODO: ASev2_punteroPuntos
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/03/12, 16:41:35
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_punteroPuntos()
  // ----------------------------------------------------
C_POINTER:C301($0;$y_campoCalificaciones)
C_TEXT:C284($1)
C_LONGINT:C283($2)



  // CODIGO PRINCIPAL
$t_arrayName:=$1
$l_periodo:=$2


Case of 
	: ($t_arrayName="aNtaP1")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Final_Puntos:114
	: ($t_arrayName="aNtaP2")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Final_Puntos:189
	: ($t_arrayName="aNtaP3")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Final_Puntos:264
	: ($t_arrayName="aNtaP4")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Final_Puntos:339
	: ($t_arrayName="aNtaP5")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Final_Puntos:414
	: ($t_arrayName="aNtaEXP")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Control_Puntos:109
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Control_Puntos:184
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Control_Puntos:259
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Control_Puntos:334
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Control_Puntos:409
		End case 
		
	: ($t_arrayName="aNtaPF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]Anual_Puntos:13
		
	: ($t_arrayName="aNtaEX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenAnual_Puntos:18
		
		
	: ($t_arrayName="aNtaEXX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenExtra_Puntos:23
		
	: ($t_arrayName="aNtaF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28
		
	: ($t_arrayName="aNtaEsfuerzo")
		  // no hay campo Puntos para Esfuerzo, se devuelve un puntero nulo
		
	: ($t_Arrayname="aNtaBX")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Puntos:512
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Puntos:517
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Puntos:522
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Puntos:527
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Puntos:532
		End case 
		
	: ($t_arrayName="alSTR_InasistenciasPeriodo")
		  // no hay campo Puntos para Inasistencia, se devuelve un puntero nulo
		
	Else 
		
		$l_parcial:=Num:C11(Substring:C12($t_arrayName;5))
		Case of 
			: ($l_periodo=1)
				$l_numeroCampo:=42+(($l_parcial-1)*5)+2
			: ($l_periodo=2)
				$l_numeroCampo:=117+(($l_parcial-1)*5)+2
			: ($l_periodo=3)
				$l_numeroCampo:=192+(($l_parcial-1)*5)+2
			: ($l_periodo=4)
				$l_numeroCampo:=267+(($l_parcial-1)*5)+2
			: ($l_periodo=5)
				$l_numeroCampo:=342+(($l_parcial-1)*5)+2
		End case 
		
		$y_campoCalificaciones:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$l_numeroCampo)
End case 

$0:=$y_campoCalificaciones