//%attributes = {}
  // MÉTODO: `ASev2_punteroLiteral
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/03/12, 15:52:54
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // AS_CampoCalificacionesEditado()
  // ----------------------------------------------------
C_POINTER:C301($0;$y_campoCalificaciones)
C_TEXT:C284($1)
C_LONGINT:C283($2)



  // CODIGO PRINCIPAL
$t_arrayName:=$1
$l_periodo:=$2


Case of 
	: ($t_arrayName="aNtaP1")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
	: ($t_arrayName="aNtaP2")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
	: ($t_arrayName="aNtaP3")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
	: ($t_arrayName="aNtaP4")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
	: ($t_arrayName="aNtaP5")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416
	: ($t_arrayName="aNtaEXP")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Control_Literal:111
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Control_Literal:186
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Control_Literal:261
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Control_Literal:336
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Control_Literal:411
		End case 
		
	: ($t_arrayName="aNtaPF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]Anual_Literal:15
		
	: ($t_arrayName="aNtaEX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenAnual_Literal:20
		
	: ($t_arrayName="aNtaEXX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenExtra_Literal:25
		
	: ($t_arrayName="aNtaF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
		
	: ($t_arrayName="aNtaEsfuerzo")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P01_Esfuerzo:16
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P02_Esfuerzo:21
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P03_Esfuerzo:26
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P04_Esfuerzo:31
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_ComplementoEvaluacion:209]P05_Esfuerzo:36
		End case 
		
	: ($t_Arrayname="aNtaBX")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Literal:514
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Literal:519
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Literal:524
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Literal:529
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Literal:534
		End case 
		
	: ($t_arrayName="alSTR_InasistenciasPeriodo")
		  // no hay campo Literal para Inasistencia, se devuelve un puntero nulo
		
		
	Else 
		
		$l_parcial:=Num:C11(Substring:C12($t_arrayName;5))
		Case of 
			: ($l_periodo=1)
				$l_numeroCampo:=42+(($l_parcial-1)*5)+4
			: ($l_periodo=2)
				$l_numeroCampo:=117+(($l_parcial-1)*5)+4
			: ($l_periodo=3)
				$l_numeroCampo:=192+(($l_parcial-1)*5)+4
			: ($l_periodo=4)
				$l_numeroCampo:=267+(($l_parcial-1)*5)+4
			: ($l_periodo=5)
				$l_numeroCampo:=342+(($l_parcial-1)*5)+4
		End case 
		
		$y_campoCalificaciones:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$l_numeroCampo)
End case 

$0:=$y_campoCalificaciones

