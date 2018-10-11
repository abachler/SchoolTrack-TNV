//%attributes = {}
  // MÉTODO: ASev2_punteroSimbolo
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/03/12, 16:40:56
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_punteroSimbolo()
  // ----------------------------------------------------
C_POINTER:C301($0;$y_campoCalificaciones)
C_TEXT:C284($1)
C_LONGINT:C283($2)



  // CODIGO PRINCIPAL
$t_arrayName:=$1
$l_periodo:=$2


Case of 
	: ($t_arrayName="aNtaP1")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Final_Simbolo:115
	: ($t_arrayName="aNtaP2")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Final_Simbolo:190
	: ($t_arrayName="aNtaP3")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Final_Simbolo:265
	: ($t_arrayName="aNtaP4")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Final_Simbolo:340
	: ($t_arrayName="aNtaP5")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Final_Simbolo:415
	: ($t_arrayName="aNtaEXP")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Control_Simbolo:110
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Control_Simbolo:185
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Control_Simbolo:260
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Control_Simbolo:335
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Control_Simbolo:410
		End case 
		
	: ($t_arrayName="aNtaPF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]Anual_Simbolo:14
		
	: ($t_arrayName="aNtaEX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenAnual_Simbolo:19
		
	: ($t_arrayName="aNtaEXX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenExtra_Simbolo:24
		
	: ($t_arrayName="aNtaF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29
		
	: ($t_arrayName="aNtaEsfuerzo")
		  // no hay campo Simbolo para Esfuerzo, se devuelve un puntero nulo
		
	: ($t_Arrayname="aNtaBX")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Simbolo:513
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Simbolo:518
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Simbolo:523
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Simbolo:528
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Simbolo:533
		End case 
		
	: ($t_arrayName="alSTR_InasistenciasPeriodo")
		  // no hay campo Simbolo para Inasistencia, se devuelve un puntero nulo
		
	Else 
		
		$l_parcial:=Num:C11(Substring:C12($t_arrayName;5))
		Case of 
			: ($l_periodo=1)
				$l_numeroCampo:=42+(($l_parcial-1)*5)+3
			: ($l_periodo=2)
				$l_numeroCampo:=117+(($l_parcial-1)*5)+3
			: ($l_periodo=3)
				$l_numeroCampo:=192+(($l_parcial-1)*5)+3
			: ($l_periodo=4)
				$l_numeroCampo:=267+(($l_parcial-1)*5)+3
			: ($l_periodo=5)
				$l_numeroCampo:=342+(($l_parcial-1)*5)+3
		End case 
		
		$y_campoCalificaciones:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$l_numeroCampo)
End case 

$0:=$y_campoCalificaciones