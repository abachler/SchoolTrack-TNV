//%attributes = {}

READ ONLY:C145([Alumnos_ObservacionesEvaluacion:30])
ARRAY TEXT:C222($atSTR_ObsEval_Categoria;0)
ARRAY TEXT:C222($atSTR_ObsEval_Observacion;0)
ARRAY LONGINT:C221($alSTR_ObsEval_RefObs;0)
ARRAY TEXT:C222($uniqueCats;0)

C_OBJECT:C1216($ob_raiz)
C_OBJECT:C1216($ob_categoria;$ob_childrenCategoria;$ob_children)

$periodo:=$1
$ob_raiz:=OB_Create 

PERIODOS_LoadData ([Alumnos_Calificaciones:208]NIvel_Numero:4)

If ($periodo=0)
	$periodo:=PERIODOS_PeriodosActuales (Current date:C33(*);True:C214)
End if 

$idAsignatura:=[Alumnos_Calificaciones:208]ID_Asignatura:5
$idAlumno:=[Alumnos_Calificaciones:208]ID_Alumno:6

QUERY:C277([Alumnos_ObservacionesEvaluacion:30];[Alumnos_ObservacionesEvaluacion:30]ID_Asignatura:2;=;$idAsignatura;*)
QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]ID_Alumno:1;=;$idAlumno;*)
QUERY:C277([Alumnos_ObservacionesEvaluacion:30]; & ;[Alumnos_ObservacionesEvaluacion:30]Periodo:3;=;$periodo)

SELECTION TO ARRAY:C260([Alumnos_ObservacionesEvaluacion:30]Categoría:4;$atSTR_ObsEval_Categoria;[Alumnos_ObservacionesEvaluacion:30]Observacion:5;$atSTR_ObsEval_Observacion;[Alumnos_ObservacionesEvaluacion:30]Ref_Observacion:10;$alSTR_ObsEval_RefObs)
AT_MultiLevelSort (">>";->$atSTR_ObsEval_Categoria;->$atSTR_ObsEval_Observacion;->$alSTR_ObsEval_RefObs)

COPY ARRAY:C226($atSTR_ObsEval_Categoria;$uniqueCats)
AT_DistinctsArrayValues (->$uniqueCats)

$refCat:=-1
For ($i;1;Size of array:C274($uniqueCats))
	If ($uniqueCats{$i}#"")
		
		ARRAY OBJECT:C1221($ao_children;0)
		ARRAY LONGINT:C221($DA_Return;0)
		
		OB SET:C1220($ob_categoria;"title";$uniqueCats{$i})
		OB SET:C1220($ob_categoria;"id";String:C10($refCat))
		OB SET:C1220($ob_categoria;"isFolder";True:C214)
		OB SET:C1220($ob_categoria;"expand";True:C214)
		
		$atSTR_ObsEval_Categoria{0}:=$uniqueCats{$i}
		AT_SearchArray (->$atSTR_ObsEval_Categoria;"=";->$DA_Return)
		
		For ($j;1;Size of array:C274($DA_Return))
			OB SET:C1220($ob_children;"title";$atSTR_ObsEval_Observacion{$DA_Return{$j}})
			OB SET:C1220($ob_children;"id";String:C10($alSTR_ObsEval_RefObs{$DA_Return{$j}}))
			APPEND TO ARRAY:C911($ao_children;$ob_children)
			CLEAR VARIABLE:C89($ob_children)
		End for 
		
		OB SET ARRAY:C1227($ob_categoria;"children";$ao_children)
		OB SET:C1220($ob_raiz;"categoria_"+String:C10($i);$ob_categoria)
		CLEAR VARIABLE:C89($ob_categoria)
		CLEAR VARIABLE:C89($ob_childrenCategoria)
	Else 
		ARRAY LONGINT:C221($DA_Return;0)
		$atSTR_ObsEval_Categoria{0}:=""
		AT_SearchArray (->$atSTR_ObsEval_Categoria;"=";->$DA_Return)
		For ($j;1;Size of array:C274($DA_Return))
			OB SET:C1220($ob_raiz;"title";$atSTR_ObsEval_Observacion{$DA_Return{$j}})
			OB SET:C1220($ob_raiz;"id";String:C10($alSTR_ObsEval_RefObs{$DA_Return{$j}}))
		End for 
	End if 
End for 

$0:=JSON Stringify:C1217($ob_raiz)
