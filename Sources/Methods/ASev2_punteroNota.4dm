//%attributes = {}
  // MÉTODO: ASev2_punteroNota
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/03/12, 16:41:01
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // ASev2_punteroNota()
  // ----------------------------------------------------
C_POINTER:C301($0;$y_campoCalificaciones)
C_TEXT:C284($1)
C_LONGINT:C283($2)

  // CODIGO PRINCIPAL
$t_arrayName:=$1
$l_periodo:=$2


Case of 
	: ($t_arrayName="aNtaP1")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Final_Nota:113
	: ($t_arrayName="aNtaP2")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Final_Nota:188
	: ($t_arrayName="aNtaP3")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Final_Nota:263
	: ($t_arrayName="aNtaP4")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Final_Nota:338
	: ($t_arrayName="aNtaP5")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Final_Nota:413
	: ($t_arrayName="aNtaEXP")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Control_Nota:108
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Control_Nota:183
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Control_Nota:258
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Control_Nota:333
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Control_Nota:408
		End case 
		
	: ($t_arrayName="aNtaPF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]Anual_Nota:12
		
	: ($t_arrayName="aNtaEX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenAnual_Nota:17
		
	: ($t_arrayName="aNtaEXX")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]ExamenExtra_Nota:22
		
	: ($t_arrayName="aNtaF")
		$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27
		
	: ($t_arrayName="aNtaEsfuerzo")
		  // no hay campo Nota para Esfuerzo, se devuelve un puntero nulo
		
	: ($t_Arrayname="aNtaBX")
		Case of 
			: ($l_periodo=1)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P01_Bonificacion_Nota:511
			: ($l_periodo=2)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P02_Bonificacion_Nota:516
			: ($l_periodo=3)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P03_Bonificacion_Nota:521
			: ($l_periodo=4)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P04_Bonificacion_Nota:526
			: ($l_periodo=5)
				$y_campoCalificaciones:=->[Alumnos_Calificaciones:208]P05_Bonificacion_Nota:531
		End case 
		
		
	: ($t_arrayName="alSTR_InasistenciasPeriodo")
		  // no hay campo Nota para Inasistencia, se devuelve un puntero nulo
		
	Else 
		
		$l_parcial:=Num:C11(Substring:C12($t_arrayName;5))
		Case of 
			: ($l_periodo=1)
				$l_numeroCampo:=42+(($l_parcial-1)*5)+1
			: ($l_periodo=2)
				$l_numeroCampo:=117+(($l_parcial-1)*5)+1
			: ($l_periodo=3)
				$l_numeroCampo:=192+(($l_parcial-1)*5)+1
			: ($l_periodo=4)
				$l_numeroCampo:=267+(($l_parcial-1)*5)+1
			: ($l_periodo=5)
				$l_numeroCampo:=342+(($l_parcial-1)*5)+1
		End case 
		
		$y_campoCalificaciones:=Field:C253(Table:C252(->[Alumnos_Calificaciones:208]);$l_numeroCampo)
End case 

$0:=$y_campoCalificaciones
