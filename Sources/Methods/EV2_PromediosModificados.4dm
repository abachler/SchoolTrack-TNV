//%attributes = {}
  // MÉTODO: EV2_PromediosModificados
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 30/12/11, 18:04:11
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // 
  //
  // PARÁMETROS
  // EV2_ConEvaluacionesPeriodo()
  // ----------------------------------------------------


  // DECLARACIONES E INICIALIZACIONES



  // CODIGO PRINCIPAL
$l_Periodo:=$1


Case of 
	: ($l_Periodo=0)
		$b_PromedioAnualModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]Anual_Real:11;->[Alumnos_Calificaciones:208]Anual_Nota:12;->[Alumnos_Calificaciones:208]Anual_Puntos:13;->[Alumnos_Calificaciones:208]Anual_Simbolo:14;->[Alumnos_Calificaciones:208]Anual_Literal:15)
		$b_PromedioFinalModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26;->[Alumnos_Calificaciones:208]EvaluacionFinal_Nota:27;->[Alumnos_Calificaciones:208]EvaluacionFinal_Puntos:28;->[Alumnos_Calificaciones:208]EvaluacionFinal_Simbolo:29;->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30)
		$b_PromedioOficialModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Nota:33;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Puntos:34;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Simbolo:35;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36;->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Palabras:492)
		$0:=($b_PromedioAnualModificado | $b_PromedioFinalModificado | $b_PromedioOficialModificado)
		
	: ($l_Periodo=1)
		$b_PromedioModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]P01_Final_Real:112;->[Alumnos_Calificaciones:208]P01_Final_Nota:113;->[Alumnos_Calificaciones:208]P01_Final_Puntos:114;->[Alumnos_Calificaciones:208]P01_Final_Simbolo:115;->[Alumnos_Calificaciones:208]P01_Final_Literal:116)
		$0:=$b_PromedioModificado
		
	: ($l_Periodo=2)
		$b_PromedioModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]P02_Final_Real:187;->[Alumnos_Calificaciones:208]P02_Final_Nota:188;->[Alumnos_Calificaciones:208]P02_Final_Puntos:189;->[Alumnos_Calificaciones:208]P02_Final_Simbolo:190;->[Alumnos_Calificaciones:208]P02_Final_Literal:191)
		$0:=$b_PromedioModificado
		
	: ($l_Periodo=3)
		$b_PromedioModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]P03_Final_Real:262;->[Alumnos_Calificaciones:208]P03_Final_Nota:263;->[Alumnos_Calificaciones:208]P03_Final_Puntos:264;->[Alumnos_Calificaciones:208]P03_Final_Simbolo:265;->[Alumnos_Calificaciones:208]P03_Final_Literal:266)
		$0:=$b_PromedioModificado
		
	: ($l_Periodo=4)
		$b_PromedioModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]P04_Final_Real:337;->[Alumnos_Calificaciones:208]P04_Final_Nota:338;->[Alumnos_Calificaciones:208]P04_Final_Puntos:339;->[Alumnos_Calificaciones:208]P04_Final_Simbolo:340;->[Alumnos_Calificaciones:208]P04_Final_Literal:341)
		$0:=$b_PromedioModificado
		
	: ($l_Periodo=5)
		$b_PromedioModificado:=KRL_FieldChanges (->[Alumnos_Calificaciones:208]P05_Final_Real:412;->[Alumnos_Calificaciones:208]P05_Final_Nota:413;->[Alumnos_Calificaciones:208]P05_Final_Puntos:414;->[Alumnos_Calificaciones:208]P05_Final_Simbolo:415;->[Alumnos_Calificaciones:208]P05_Final_Literal:416)
		$0:=$b_PromedioModificado
		
End case 

