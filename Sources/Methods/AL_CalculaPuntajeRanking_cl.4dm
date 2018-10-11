//%attributes = {}
  // AL_CalculaPuntajeRanking_cl()
  //
  //
  //
  // ---------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha: 15/08/12, 12:15:50
  // ---------------------------------------------
C_BOOLEAN:C305($b_calculoValido)
C_LONGINT:C283($i;$l_añoActual;$l_codigoEnseñanza;$l_puntajeAlumno;$l_puntajePromedioColegio;$l_PuntajeRankingAlumno;$l_recNumAlumno)
C_REAL:C285($r_maximoColegio;$r_promedioColegio;$r_PromedioNEM_Alumno)

ARRAY LONGINT:C221($al_alumnosEgresados;0)
ARRAY LONGINT:C221($al_años;0)
ARRAY REAL:C219($ar_promedioAnual;0)
ARRAY REAL:C219($ar_promedioMaximo;0)
ARRAY REAL:C219($ar_promediosFinales;0)

  // CÓDIGO
$l_recNumAlumno:=$1
$l_añoActual:=<>gYear
KRL_GotoRecord (->[Alumnos:2];$l_recNumAlumno)
$r_PromedioNEM_Alumno:=Round:C94([Alumnos:2]Chile_PromedioEMedia:73;1)
$l_codigoEnseñanza:=KRL_GetNumericFieldData (->[Cursos:3]Curso:1;->[Alumnos:2]curso:20;->[Cursos:3]cl_CodigoTipoEnseñanza:21)
$l_puntajeAlumno:=AL_PuntajeNEM_cl ($r_PromedioNEM_Alumno;$l_codigoEnseñanza)

For ($i;3;1;-1)
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2;=;$l_añoActual-$i;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6=12;*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]SituacionFinal:8="P";*)
	QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26>=1)
	SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]PromedioFinalOficial_Nota:26;$ar_promediosFinales)
	SORT ARRAY:C229($ar_promediosFinales;<)
	APPEND TO ARRAY:C911($al_años;$l_añoActual-$i)
	APPEND TO ARRAY:C911($al_alumnosEgresados;Size of array:C274($ar_promediosFinales))
	APPEND TO ARRAY:C911($ar_promedioAnual;AT_Mean (->$ar_promediosFinales;1))
	If (Size of array:C274($ar_promediosFinales)>0)
		APPEND TO ARRAY:C911($ar_promedioMaximo;$ar_promediosFinales{1})
	Else 
		APPEND TO ARRAY:C911($ar_promedioMaximo;0)
	End if 
End for 

$b_calculoValido:=False:C215
Case of 
	: (($al_alumnosEgresados{1}>0) & ($al_alumnosEgresados{2}>0) & ($al_alumnosEgresados{3}>0))
		If (AT_GetSumArray (->$al_alumnosEgresados)>=30)
			$b_calculoValido:=True:C214
		End if 
		
	: (($al_alumnosEgresados{2}>0) & ($al_alumnosEgresados{3}>0))
		If (AT_GetSumArray (->$al_alumnosEgresados)>=30)
			$b_calculoValido:=True:C214
		End if 
		
	: ($al_alumnosEgresados{3}>=30)
		$b_calculoValido:=True:C214
End case 

If ($b_calculoValido)
	$r_promedioColegio:=Round:C94(AT_Mean (->$ar_promedioAnual;1);1)
	$r_maximoColegio:=Round:C94(AT_Mean (->$ar_promedioMaximo;1);1)
	
	$l_puntajePromedioColegio:=AL_PuntajeNEM_cl ($r_promedioColegio;$l_codigoEnseñanza)
	$l_puntajeMaximoColegio:=AL_PuntajeNEM_cl ($r_maximoColegio;$l_codigoEnseñanza)
	Case of 
		: ($r_PromedioNEM_Alumno<=$r_promedioColegio)
			$l_PuntajeRankingAlumno:=$l_puntajeAlumno
		: (($r_PromedioNEM_Alumno>$r_promedioColegio) & ($r_PromedioNEM_Alumno<$r_maximoColegio))
			$l_PuntajeRankingAlumno:=$l_puntajeAlumno+($l_puntajeMaximoColegio-$l_puntajePromedioColegio)
	End case 
	
End if 

$0:=$l_PuntajeRankingAlumno