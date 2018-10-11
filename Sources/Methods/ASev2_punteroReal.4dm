//%attributes = {}
  // MÉTODO: ASev2_punteroReal
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/03/12, 16:30:40
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_punteroReal()
  // ----------------------------------------------------
C_POINTER:C301($0;$y_campoCalificaciones)
C_TEXT:C284($1)
C_LONGINT:C283($2)


  // CODIGO PRINCIPAL
$t_arrayName:=$1
$l_periodo:=$2


Case of 
	: ($t_arrayName="aNtaP1")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
	: ($t_arrayName="aNtaP2")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
	: ($t_arrayName="aNtaP3")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
	: ($t_arrayName="aNtaP4")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
	: ($t_arrayName="aNtaP5")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
		
		
	: ($t_arrayName="aNtaEXP")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Control_Real:107
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Control_Real:182
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Control_Real:257
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Control_Real:332
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Control_Real:407
		End case 
		
		
	: ($t_arrayName="aNtaPF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]Anual_Real:11
		
		
	: ($t_arrayName="aNtaEX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenAnual_Real:16
		
		
	: ($t_arrayName="aNtaEXX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenExtra_Real:21
		
		
	: ($t_arrayName="aNtaF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
		
	: ($t_arrayName="aNtaEsfuerzo")
		  // no hay campo Real para Esfuerzo, se devuelve un puntero nulo
		
	: ($t_Arrayname="aNtaBX")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Real:510
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Real:515
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Real:520
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Real:525
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Real:530
		End case 
		
	: ($t_Arrayname="alSTR_InasistenciasPeriodo")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P01_Inasistencias:18
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P02_Inasistencias:23
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P03_Inasistencias:28
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P04_Inasistencias:33
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P05_Inasistencias:38
		End case 
		
		
		
	Else 
		
		$l_parcial:=Num:C11(Substring:C12($t_arrayName;5))
		Case of 
			: ($l_periodo=1)
				$l_numeroCampo:=42+(($l_parcial-1)*5)
			: ($l_periodo=2)
				$l_numeroCampo:=117+(($l_parcial-1)*5)
			: ($l_periodo=3)
				$l_numeroCampo:=192+(($l_parcial-1)*5)
			: ($l_periodo=4)
				$l_numeroCampo:=267+(($l_parcial-1)*5)
			: ($l_periodo=5)
				$l_numeroCampo:=342+(($l_parcial-1)*5)
		End case 
		
		$y_campoCalificaciones:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$l_numeroCampo)
End case 

$0:=$y_campoCalificaciones
