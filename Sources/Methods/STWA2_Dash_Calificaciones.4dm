//%attributes = {}
C_POINTER:C301($1)
C_POINTER:C301($2)

C_BOOLEAN:C305($b_multiestilo)
C_POINTER:C301($parameterNames;$parameterValues;$y_AlumCaliFinalLiteral;$y_AlumCaliFinalLiteralP1;$y_AlumCaliFinalLiteralP2;$y_AlumCaliFinalLiteralP3;$y_AlumCaliFinalLiteralP4;$y_AlumCaliFinalLiteralP5;$y_AlumCaliFinalReal;$y_AlumCaliFinalRealP1)
C_POINTER:C301($y_AlumCaliFinalRealP2;$y_AlumCaliFinalRealP3;$y_AlumCaliFinalRealP4;$y_AlumCaliFinalRealP5;$y_AlumSintesisLiteral;$y_AlumSintesisLiteralP1;$y_AlumSintesisLiteralP2;$y_AlumSintesisLiteralP3;$y_AlumSintesisLiteralP4;$y_AlumSintesisLiteralP5)
C_POINTER:C301($y_AlumSintesisReal;$y_AlumSintesisRealP1;$y_AlumSintesisRealP2;$y_AlumSintesisRealP3;$y_AlumSintesisRealP4;$y_AlumSintesisRealP5;$y_AsigSintesisLiteral;$y_AsigSintesisLiteralP1;$y_AsigSintesisLiteralP2;$y_AsigSintesisLiteralP3)
C_POINTER:C301($y_AsigSintesisLiteralP4;$y_AsigSintesisLiteralP5;$y_AsigSintesisReal;$y_AsigSintesisRealP1;$y_AsigSintesisRealP2;$y_AsigSintesisRealP3;$y_AsigSintesisRealP4;$y_AsigSintesisRealP5;$y_CursosSintesisReal)
C_OBJECT:C1216($ob_raiz)

ARRAY LONGINT:C221($aIdsAlumnos;0)
ARRAY LONGINT:C221($aIdsAsignaturas;0)
ARRAY LONGINT:C221($aRNNiveles;0)
ARRAY LONGINT:C221($estilos;0)
ARRAY LONGINT:C221($rnAsig;0)
ARRAY LONGINT:C221($rnCursos;0)
ARRAY REAL:C219($aMinimoNivel;0)
ARRAY REAL:C219($aPromediosAlumnosReal;0)
ARRAY REAL:C219($aPromediosAlumnosRealP1;0)
ARRAY REAL:C219($aPromediosAlumnosRealP2;0)
ARRAY REAL:C219($aPromediosAlumnosRealP3;0)
ARRAY REAL:C219($aPromediosAlumnosRealP4;0)
ARRAY REAL:C219($aPromediosAlumnosRealP5;0)
ARRAY REAL:C219($aPromediosAsigsReal;0)
ARRAY REAL:C219($aPromediosAsigsRealP1;0)
ARRAY REAL:C219($aPromediosAsigsRealP2;0)
ARRAY REAL:C219($aPromediosAsigsRealP3;0)
ARRAY REAL:C219($aPromediosAsigsRealP4;0)
ARRAY REAL:C219($aPromediosAsigsRealP5;0)
ARRAY REAL:C219($aPromediosCursoReal;0)
ARRAY REAL:C219($aPromNivel;0)
ARRAY TEXT:C222($aAbreviaturas;0)
ARRAY TEXT:C222($aCursos;0)
ARRAY TEXT:C222($aEjey;0)
ARRAY TEXT:C222($aMinimoNivelLiteral;0)
ARRAY TEXT:C222($aNombreNivel;0)
ARRAY TEXT:C222($aNombres;0)
ARRAY TEXT:C222($aPromediosAlumnosLiteral;0)
ARRAY TEXT:C222($aPromediosAlumnosLiteralP1;0)
ARRAY TEXT:C222($aPromediosAlumnosLiteralP2;0)
ARRAY TEXT:C222($aPromediosAlumnosLiteralP3;0)
ARRAY TEXT:C222($aPromediosAlumnosLiteralP4;0)
ARRAY TEXT:C222($aPromediosAlumnosLiteralP5;0)
ARRAY TEXT:C222($aPromediosAsigsLiteral;0)
ARRAY TEXT:C222($aPromediosAsigsLiteralP1;0)
ARRAY TEXT:C222($aPromediosAsigsLiteralP2;0)
ARRAY TEXT:C222($aPromediosAsigsLiteralP3;0)
ARRAY TEXT:C222($aPromediosAsigsLiteralP4;0)
ARRAY TEXT:C222($aPromediosAsigsLiteralP5;0)
ARRAY TEXT:C222($aPromediosCursoLiteral;0)
ARRAY TEXT:C222($aPromNivelLiteral;0)
ARRAY TEXT:C222($dNombres;0)

  //MONO 185103
ARRAY REAL:C219($aPromediosAlumnosAnualReal;0)
ARRAY TEXT:C222($aPromediosAlumnosAnualLiteral;0)
ARRAY REAL:C219($aPromediosAsigAnualReal;0)
ARRAY REAL:C219($aPromediosCursoAnualReal;0)

If (False:C215)
	C_POINTER:C301(STWA2_Dash_Calificaciones ;$1)
	C_POINTER:C301(STWA2_Dash_Calificaciones ;$2)
End if 
$parameterNames:=$1
$parameterValues:=$2

If (Count parameters:C259=3)
	$parameterValues:=$3
End if 

$action:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"action")
$parameterOficial:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"tipoprom")

$y_AsigSintesisRealP1:=->[Asignaturas_SintesisAnual:202]P01_Promedio_Real:25
$y_AsigSintesisRealP2:=->[Asignaturas_SintesisAnual:202]P02_Promedio_Real:30
$y_AsigSintesisRealP3:=->[Asignaturas_SintesisAnual:202]P03_Promedio_Real:35
$y_AsigSintesisRealP4:=->[Asignaturas_SintesisAnual:202]P04_Promedio_Real:40
$y_AsigSintesisRealP5:=->[Asignaturas_SintesisAnual:202]P05_Promedio_Real:45
$y_AsigSintesisLiteralP1:=->[Asignaturas_SintesisAnual:202]P01_Promedio_Literal:29
$y_AsigSintesisLiteralP2:=->[Asignaturas_SintesisAnual:202]P02_Promedio_Literal:34
$y_AsigSintesisLiteralP3:=->[Asignaturas_SintesisAnual:202]P03_Promedio_Literal:39
$y_AsigSintesisLiteralP4:=->[Asignaturas_SintesisAnual:202]P04_Promedio_Literal:44
$y_AsigSintesisLiteralP5:=->[Asignaturas_SintesisAnual:202]P05_Promedio_Literal:49
$y_AlumCaliFinalRealP1:=->[Alumnos_Calificaciones:208]P01_Final_Real:112
$y_AlumCaliFinalRealP2:=->[Alumnos_Calificaciones:208]P02_Final_Real:187
$y_AlumCaliFinalRealP3:=->[Alumnos_Calificaciones:208]P03_Final_Real:262
$y_AlumCaliFinalRealP4:=->[Alumnos_Calificaciones:208]P04_Final_Real:337
$y_AlumCaliFinalRealP5:=->[Alumnos_Calificaciones:208]P05_Final_Real:412
$y_AlumCaliFinalLiteralP1:=->[Alumnos_Calificaciones:208]P01_Final_Literal:116
$y_AlumCaliFinalLiteralP2:=->[Alumnos_Calificaciones:208]P02_Final_Literal:191
$y_AlumCaliFinalLiteralP3:=->[Alumnos_Calificaciones:208]P03_Final_Literal:266
$y_AlumCaliFinalLiteralP4:=->[Alumnos_Calificaciones:208]P04_Final_Literal:341
$y_AlumCaliFinalLiteralP5:=->[Alumnos_Calificaciones:208]P05_Final_Literal:416

If ($parameterOficial="oficial")
	$y_AlumCaliFinalReal:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Real:32
	$y_AlumCaliFinalLiteral:=->[Alumnos_Calificaciones:208]EvaluacionFinalOficial_Literal:36
	
	$y_AlumSintesisReal:=->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Real:25
	$y_AlumSintesisLiteral:=->[Alumnos_SintesisAnual:210]PromedioFinalOficial_Literal:29
	
	$y_AlumSintesisRealP1:=->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Real:237
	$y_AlumSintesisRealP2:=->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Real:242
	$y_AlumSintesisRealP3:=->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Real:247
	$y_AlumSintesisRealP4:=->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Real:252
	$y_AlumSintesisRealP5:=->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Real:257
	$y_AlumSintesisLiteralP1:=->[Alumnos_SintesisAnual:210]P01_PromedioOficial_Literal:241
	$y_AlumSintesisLiteralP2:=->[Alumnos_SintesisAnual:210]P02_PromedioOficial_Literal:246
	$y_AlumSintesisLiteralP3:=->[Alumnos_SintesisAnual:210]P03_PromedioOficial_Literal:251
	$y_AlumSintesisLiteralP4:=->[Alumnos_SintesisAnual:210]P04_PromedioOficial_Literal:256
	$y_AlumSintesisLiteralP5:=->[Alumnos_SintesisAnual:210]P05_PromedioOficial_Literal:261
	
	$y_AsigSintesisReal:=->[Asignaturas_SintesisAnual:202]PromedioOficial_Real:20
	$y_AsigSintesisLiteral:=->[Asignaturas_SintesisAnual:202]PromedioOficial_Literal:24
	
	$y_CursosSintesisReal:=->[Cursos_SintesisAnual:63]PromedioOficial_Real:22
Else 
	$y_AlumCaliFinalReal:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Real:26
	$y_AlumCaliFinalLiteral:=->[Alumnos_Calificaciones:208]EvaluacionFinal_Literal:30
	
	$y_AlumSintesisReal:=->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Real:20
	$y_AlumSintesisLiteral:=->[Alumnos_SintesisAnual:210]PromedioFinalInterno_Literal:24
	
	$y_AlumSintesisRealP1:=->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Real:92
	$y_AlumSintesisRealP2:=->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Real:121
	$y_AlumSintesisRealP3:=->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Real:150
	$y_AlumSintesisRealP4:=->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Real:179
	$y_AlumSintesisRealP5:=->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Real:208
	$y_AlumSintesisLiteralP1:=->[Alumnos_SintesisAnual:210]P01_PromedioInterno_Literal:96
	$y_AlumSintesisLiteralP2:=->[Alumnos_SintesisAnual:210]P02_PromedioInterno_Literal:125
	$y_AlumSintesisLiteralP3:=->[Alumnos_SintesisAnual:210]P03_PromedioInterno_Literal:154
	$y_AlumSintesisLiteralP4:=->[Alumnos_SintesisAnual:210]P04_PromedioInterno_Literal:183
	$y_AlumSintesisLiteralP5:=->[Alumnos_SintesisAnual:210]P05_PromedioInterno_Literal:212
	
	$y_AsigSintesisReal:=->[Asignaturas_SintesisAnual:202]PromedioFinal_Real:15
	$y_AsigSintesisLiteral:=->[Asignaturas_SintesisAnual:202]PromedioFinal_Literal:19
	
	$y_CursosSintesisReal:=->[Cursos_SintesisAnual:63]PromedioFinal_Real:17
	
End if 

Case of 
	: ($action="promediosasignatura")
		$asignatura:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"asignatura"))
		$asignatura:=$asignatura+1
		$asig:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"asig")
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$nivel;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Incide_en_promedio:27=True:C214;*)
		QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]nivel_jerarquico:107=0)
		If ($asig#"-1")
			QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Asignatura:3=$asig)
		End if 
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Abreviación:26;>;$y_AsigSintesisReal->;>)
		LONGINT ARRAY FROM SELECTION:C647([Asignaturas:18];$rnAsig)
		$rnAsig:=$rnAsig{$asignatura}
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		If ($parameterOficial="oficial")
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		Else 
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_interno:33)
		End if 
		KRL_GotoRecord (->[Asignaturas:18];$rnAsig;False:C215)
		PERIODOS_LoadData ($nivel)
		READ ONLY:C145([Alumnos_Calificaciones:208])
		READ ONLY:C145([Alumnos:2])
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]curso:20;>;[Alumnos:2]apellidos_y_nombres:40;>)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalReal->;$aPromediosAlumnosReal;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalLiteral->;$aPromediosAlumnosLiteral;*)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$aNombres;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP1->;$aPromediosAlumnosRealP1;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP2->;$aPromediosAlumnosRealP2;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP3->;$aPromediosAlumnosRealP3;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP4->;$aPromediosAlumnosRealP4;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP5->;$aPromediosAlumnosRealP5;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$aPromediosAlumnosAnualReal;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Literal:15;$aPromediosAlumnosAnualLiteral;*)
		SELECTION TO ARRAY:C260([Alumnos:2]curso:20;$aCursos;*)
		SELECTION TO ARRAY:C260
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		EVS_ReadStyleData ($estilo)
		Case of 
			: (iPrintMode=Notas)
				$maxescala:=rGradesTo
				$minescala:=rGradesFrom
				$decimales:=iGradesDecNO
			: (iPrintMode=Puntos)
				$maxescala:=rPointsTo
				$minescala:=rPointsFrom
				$decimales:=iPointsDecNO
			: (iPrintMode=Porcentaje)
				$maxescala:=100
				$minescala:=1
				$decimales:=1
			: (iPrintMode=Simbolos)
				COPY ARRAY:C226(aSymbol;$aEjey)
				$maxescala:=Size of array:C274($aEjey)
				$minescala:=0
				$decimales:=1
		End case 
		$minimoReal:=rPctMinimum
		$minimoLiteral:=_ConvierteEvaluacion (rPctMinimum;$estilo)
		
		$ob_raiz:=OB_Create 
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP1;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP2;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP3;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP4;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP5;Size of array:C274($aPromediosAlumnosReal))
		If (iPrintMode=Simbolos)
			OB_SET ($ob_raiz;->$aEjey;"ejey")
			For ($i;1;Size of array:C274($aPromediosAlumnosLiteral))
				If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  //MONO 185103
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
				Else 
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
				End if 
				$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
				$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
				$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
				$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
				$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
				$el:=Find in array:C230($aEjey;$promLit)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteral{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP1)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP1{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP2)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP2{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP3)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP3{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP4)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP4{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP5)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP5{$i}:=String:C10($el)
			End for 
			$minimoLiteral:=String:C10(Find in array:C230($aEjey;$minimoLiteral))
		Else 
			For ($i;1;Size of array:C274($aPromediosAlumnosReal))
				If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  //MONO 185103 
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
				Else 
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
				End if 
				$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
				$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
				$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
				$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
				$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
				$aPromediosAlumnosLiteral{$i}:=$promLit
				$aPromediosAlumnosLiteralP1{$i}:=$promLitP1
				$aPromediosAlumnosLiteralP2{$i}:=$promLitP2
				$aPromediosAlumnosLiteralP3{$i}:=$promLitP3
				$aPromediosAlumnosLiteralP4{$i}:=$promLitP4
				$aPromediosAlumnosLiteralP5{$i}:=$promLitP5
			End for 
		End if 
		OB_SET_Long ($ob_raiz;iPrintMode;"mode")
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"separador")
		OB_SET ($ob_raiz;->$maxescala;"maxescala")
		OB_SET ($ob_raiz;->$minescala;"minescala")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$minimoReal;"minimoreal")
		OB_SET ($ob_raiz;->$minimoLiteral;"minimoliteral")
		OB_SET ($ob_raiz;->$aNombres;"nombres")
		OB_SET ($ob_raiz;->$aCursos;"cursos")
		OB_SET ($ob_raiz;->[Asignaturas:18]Seleccion:17;"seleccion")
		OB_SET ($ob_raiz;->$aAbreviaturas;"abreviaciones")
		OB_SET ($ob_raiz;->$aPromediosAlumnosReal;"promediosreales")
		OB_SET ($ob_raiz;->$aPromediosAlumnosLiteral;"promediosliterales")
		OB_SET ($ob_raiz;->$aPromediosAlumnosRealP1;"promediosrealesP1")
		OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP1;"promediosliteralesP1")
		OB_SET ($ob_raiz;->viSTR_Periodos_NumeroPeriodos;"periodos")
		OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodosnombres")
		
		Case of 
			: (viSTR_Periodos_NumeroPeriodos=2)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				
			: (viSTR_Periodos_NumeroPeriodos=3)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				
			: (viSTR_Periodos_NumeroPeriodos=4)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
				
			: (viSTR_Periodos_NumeroPeriodos=5)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP5;"promediosrealesP5")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP5;"promediosliteralesP5")
				
		End case 
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="promediosasignaturasxalumno")
		$curso:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$indice:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"indice"))
		$uuid:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"uuid")  //20180621 RCH Ticket 207351
		$l_userID:=STWA2_Session_GetUserSTID ($uuid)
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$curso:=$curso+1
		$indice:=$indice+1
		If ($parameterOficial="oficial")
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		Else 
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_interno:33)
		End if 
		PERIODOS_LoadData ($nivel)
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Asignaturas:18])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
		If (($curso>0) & ($curso<=Size of array:C274($aCursos)))  //20180621 RCH Ticket 207351
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$curso};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
			Log_RegisterEvtSTW ("Error STWA2 Calificaciones 1: Problema en índice de búsqueda. Elemento: "+String:C10($curso)+", tamaño arreglo: "+String:C10(Size of array:C274($aCursos))+", nivel: "+String:C10($nivel)+".";$l_userID)
		End if 
		ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdsAlumnos)
		EV2_RegistrosDelAlumno ($aIdsAlumnos{$indice})
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
		ORDER BY:C49([Alumnos_Calificaciones:208];[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalReal->;$aPromediosAlumnosReal;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalLiteral->;$aPromediosAlumnosLiteral;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$aPromediosAlumnosAnualReal;*)  // MONO 185103
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Literal:15;$aPromediosAlumnosAnualLiteral;*)  // MONO 185103
		SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$aNombres;*)
		SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;$aAbreviaturas;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP1->;$aPromediosAlumnosRealP1;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP2->;$aPromediosAlumnosRealP2;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP3->;$aPromediosAlumnosRealP3;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP4->;$aPromediosAlumnosRealP4;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP5->;$aPromediosAlumnosRealP5;*)
		SELECTION TO ARRAY:C260
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		EVS_ReadStyleData ($estilo)
		Case of 
			: (iPrintMode=Notas)
				$maxescala:=rGradesTo
				$minescala:=rGradesFrom
				$decimales:=iGradesDecNO
			: (iPrintMode=Puntos)
				$maxescala:=rPointsTo
				$minescala:=rPointsFrom
				$decimales:=iPointsDecNO
			: (iPrintMode=Porcentaje)
				$maxescala:=100
				$minescala:=1
				$decimales:=1
			: (iPrintMode=Simbolos)
				COPY ARRAY:C226(aSymbol;$aEjey)
				$maxescala:=Size of array:C274($aEjey)
				$minescala:=0
				$decimales:=1
		End case 
		$minimoReal:=rPctMinimum
		$minimoLiteral:=_ConvierteEvaluacion (rPctMinimum;$estilo)
		  //$jsonT:=JSON New
		$ob_raiz:=OB_Create 
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP1;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP2;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP3;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP4;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP5;Size of array:C274($aPromediosAlumnosReal))
		If (iPrintMode=Simbolos)
			  //$node:=JSON Append text array ($jsonT;"ejey";$aEjey)
			OB_SET ($ob_raiz;->$aEjey;"ejey")
			For ($i;1;Size of array:C274($aPromediosAlumnosReal))
				If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
				Else 
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
				End if 
				$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
				$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
				$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
				$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
				$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
				$el:=Find in array:C230($aEjey;$promLit)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteral{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP1)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP1{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP2)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP2{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP3)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP3{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP4)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP4{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP5)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP5{$i}:=String:C10($el)
			End for 
			$minimoLiteral:=String:C10(Find in array:C230($aEjey;$minimoLiteral))
		Else 
			For ($i;1;Size of array:C274($aPromediosAlumnosReal))
				If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
				Else 
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
				End if 
				$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
				$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
				$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
				$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
				$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
				$aPromediosAlumnosLiteral{$i}:=$promLit
				$aPromediosAlumnosLiteralP1{$i}:=$promLitP1
				$aPromediosAlumnosLiteralP2{$i}:=$promLitP2
				$aPromediosAlumnosLiteralP3{$i}:=$promLitP3
				$aPromediosAlumnosLiteralP4{$i}:=$promLitP4
				$aPromediosAlumnosLiteralP5{$i}:=$promLitP5
			End for 
		End if 
		OB_SET ($ob_raiz;->iPrintMode;"mode")
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"separador")
		OB_SET ($ob_raiz;->$maxescala;"maxescala")
		OB_SET ($ob_raiz;->$minescala;"minescala")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$minimoReal;"minimoreal")
		OB_SET ($ob_raiz;->$minimoLiteral;"minimoliteral")
		OB_SET ($ob_raiz;->$aNombres;"nombres")
		OB_SET ($ob_raiz;->$aAbreviaturas;"abreviaciones")
		OB_SET ($ob_raiz;->$aPromediosAlumnosReal;"promediosreales")
		OB_SET ($ob_raiz;->$aPromediosAlumnosLiteral;"promediosliterales")
		OB_SET ($ob_raiz;->$aPromediosAlumnosRealP1;"promediosrealesP1")
		OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP1;"promediosliteralesP1")
		OB_SET ($ob_raiz;->viSTR_Periodos_NumeroPeriodos;"periodos")
		OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodosnombres")
		
		Case of 
			: (viSTR_Periodos_NumeroPeriodos=2)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				
			: (viSTR_Periodos_NumeroPeriodos=3)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				
			: (viSTR_Periodos_NumeroPeriodos=4)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
				
			: (viSTR_Periodos_NumeroPeriodos=5)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP5;"promediosrealesP5")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP5;"promediosliteralesP5")
				
		End case 
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="promediosalumnosxasignatura")
		$curso:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$indice:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"indice"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$curso:=$curso+1
		$indice:=$indice+1
		If ($parameterOficial="oficial")
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		Else 
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_interno:33)
		End if 
		PERIODOS_LoadData ($nivel)
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Asignaturas:18])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
		
		  //20170407 RCH Busca asignaturas de los alumnos del curso
		  //QUERY([Asignaturas];[Asignaturas]Curso=$aCursos{$curso};*)
		  //QUERY([Asignaturas]; & ;[Asignaturas]Incide_en_promedio=True)
		QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$curso})
		QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Status:50#"@Retirado@")
		ARRAY LONGINT:C221($aIdsAlumnos;0)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdsAlumnos)
		QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID_Alumno:6;$aIdsAlumnos)
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]Llave_Asignatura:494;Automatic:K51:4;Do not modify:K51:1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
		KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]Llave_Asignatura:494;Structure configuration:K51:2;Structure configuration:K51:2)
		
		ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
		SELECTION TO ARRAY:C260([Asignaturas:18]Numero:1;$aIdsAsignaturas)
		$idAsig:=$aIdsAsignaturas{$indice}
		QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$idAsig)
		
		  //20170407 RCH FILTRO ALUMNOS DEL CURSO SELECCIONADO
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Automatic:K51:4;Do not modify:K51:1)
		QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]curso:20=$aCursos{$curso})
		ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos:2]apellidos_y_nombres:40;>)
		SET FIELD RELATION:C919([Alumnos_Calificaciones:208]ID_Alumno:6;Structure configuration:K51:2;Structure configuration:K51:2)
		
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalReal->;$aPromediosAlumnosReal;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalLiteral->;$aPromediosAlumnosLiteral;*)
		SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$aNombres;*)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Real:11;$aPromediosAlumnosAnualReal;*)  // MONO 185103
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]Anual_Literal:15;$aPromediosAlumnosAnualLiteral;*)  // MONO 185103
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP1->;$aPromediosAlumnosRealP1;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP2->;$aPromediosAlumnosRealP2;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP3->;$aPromediosAlumnosRealP3;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP4->;$aPromediosAlumnosRealP4;*)
		SELECTION TO ARRAY:C260($y_AlumCaliFinalRealP5->;$aPromediosAlumnosRealP5;*)
		SELECTION TO ARRAY:C260
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		EVS_ReadStyleData ($estilo)
		Case of 
			: (iPrintMode=Notas)
				$maxescala:=rGradesTo
				$minescala:=rGradesFrom
				$decimales:=iGradesDecNO
			: (iPrintMode=Puntos)
				$maxescala:=rPointsTo
				$minescala:=rPointsFrom
				$decimales:=iPointsDecNO
			: (iPrintMode=Porcentaje)
				$maxescala:=100
				$minescala:=1
				$decimales:=1
			: (iPrintMode=Simbolos)
				COPY ARRAY:C226(aSymbol;$aEjey)
				$maxescala:=Size of array:C274($aEjey)
				$minescala:=0
				$decimales:=1
		End case 
		$minimoReal:=rPctMinimum
		$minimoLiteral:=_ConvierteEvaluacion (rPctMinimum;$estilo)
		  //$jsonT:=JSON New
		$ob_raiz:=OB_Create 
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP1;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP2;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP3;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP4;Size of array:C274($aPromediosAlumnosReal))
		ARRAY TEXT:C222($aPromediosAlumnosLiteralP5;Size of array:C274($aPromediosAlumnosReal))
		If (iPrintMode=Simbolos)
			OB_SET ($ob_raiz;->$aEjey;"ejey")
			For ($i;1;Size of array:C274($aPromediosAlumnosLiteral))
				If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
				Else 
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
				End if 
				$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
				$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
				$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
				$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
				$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
				$el:=Find in array:C230($aEjey;$promLit)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteral{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP1)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP1{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP2)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP2{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP3)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP3{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP4)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP4{$i}:=String:C10($el)
				$el:=Find in array:C230($aEjey;$promLitP5)
				If ($el=-1)
					$el:=0
				End if 
				$aPromediosAlumnosLiteralP5{$i}:=String:C10($el)
			End for 
			$minimoLiteral:=String:C10(Find in array:C230($aEjey;$minimoLiteral))
		Else 
			For ($i;1;Size of array:C274($aPromediosAlumnosReal))
				If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
				Else 
					$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
				End if 
				$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
				$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
				$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
				$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
				$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
				$aPromediosAlumnosLiteral{$i}:=$promLit
				$aPromediosAlumnosLiteralP1{$i}:=$promLitP1
				$aPromediosAlumnosLiteralP2{$i}:=$promLitP2
				$aPromediosAlumnosLiteralP3{$i}:=$promLitP3
				$aPromediosAlumnosLiteralP4{$i}:=$promLitP4
				$aPromediosAlumnosLiteralP5{$i}:=$promLitP5
			End for 
		End if 
		OB_SET ($ob_raiz;->iPrintMode;"mode")
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"separador")
		OB_SET ($ob_raiz;->$maxescala;"maxescala")
		OB_SET ($ob_raiz;->$minescala;"minescala")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$minimoReal;"minimoreal")
		OB_SET ($ob_raiz;->$minimoLiteral;"minimoliteral")
		OB_SET ($ob_raiz;->$aNombres;"nombres")
		OB_SET ($ob_raiz;->$aAbreviaturas;"abreviaciones")
		OB_SET ($ob_raiz;->$aPromediosAlumnosReal;"promediosreales")
		OB_SET ($ob_raiz;->$aPromediosAlumnosLiteral;"promediosliterales")
		OB_SET ($ob_raiz;->$aPromediosAlumnosRealP1;"promediosrealesP1")
		OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP1;"promediosliteralesP1")
		OB_SET ($ob_raiz;->viSTR_Periodos_NumeroPeriodos;"periodos")
		OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodosnombres")
		
		Case of 
			: (viSTR_Periodos_NumeroPeriodos=2)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				
			: (viSTR_Periodos_NumeroPeriodos=3)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				
			: (viSTR_Periodos_NumeroPeriodos=4)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
				
			: (viSTR_Periodos_NumeroPeriodos=5)
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
				OB_SET ($ob_raiz;->$aPromediosAlumnosRealP5;"promediosrealesP5")
				OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP5;"promediosliteralesP5")
				
		End case 
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="promedioscurso")
		$curso:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"curso"))
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$tipo:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"tipo")
		$uuid:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"uuid")  //20180621 RCH Ticket 207351
		$l_userID:=STWA2_Session_GetUserSTID ($uuid)
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		If ($parameterOficial="oficial")
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		Else 
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_interno:33)
		End if 
		PERIODOS_LoadData ($nivel)
		$curso:=$curso+1
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([Asignaturas:18])
		QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
		QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
		ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
		EVS_ReadStyleData ($estilo)
		Case of 
			: (iPrintMode=Notas)
				$maxescala:=rGradesTo
				$minescala:=rGradesFrom
				$decimales:=iGradesDecNO
			: (iPrintMode=Puntos)
				$maxescala:=rPointsTo
				$minescala:=rPointsFrom
				$decimales:=iPointsDecNO
			: (iPrintMode=Porcentaje)
				$maxescala:=100
				$minescala:=1
				$decimales:=1
			: (iPrintMode=Simbolos)
				COPY ARRAY:C226(aSymbol;$aEjey)
				$maxescala:=Size of array:C274($aEjey)
				$minescala:=0
				$decimales:=1
		End case 
		$minimoReal:=rPctMinimum
		$minimoLiteral:=_ConvierteEvaluacion (rPctMinimum;$estilo)
		$ob_raiz:=OB_Create 
		OB_SET ($ob_raiz;->iPrintMode;"mode")
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"separador")
		OB_SET ($ob_raiz;->$maxescala;"maxescala")
		OB_SET ($ob_raiz;->$minescala;"minescala")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$minimoReal;"minimoreal")
		
		If ($tipo="alumnos")
			If (($curso>0) & ($curso<=Size of array:C274($aCursos)))  //20180621 RCH Ticket 207351
				QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$curso};*)
				QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
			Else 
				REDUCE SELECTION:C351([Alumnos:2];0)
				Log_RegisterEvtSTW ("Error STWA2 Calificaciones 2: Problema en índice de búsqueda. Elemento: "+String:C10($curso)+", tamaño arreglo: "+String:C10(Size of array:C274($aCursos))+", nivel: "+String:C10($nivel)+".";$l_userID)
			End if 
			ORDER BY:C49([Alumnos:2];[Alumnos:2]apellidos_y_nombres:40;>)
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([Alumnos:2]apellidos_y_nombres:40;$aNombres;*)
			SELECTION TO ARRAY:C260($y_AlumSintesisReal->;$aPromediosAlumnosReal;*)
			SELECTION TO ARRAY:C260([Alumnos_SintesisAnual:210]PromedioAnualInterno_Real:10;$aPromediosAlumnosAnualReal;*)  // MONO 185103
			SELECTION TO ARRAY:C260($y_AlumSintesisRealP1->;$aPromediosAlumnosRealP1;*)
			SELECTION TO ARRAY:C260($y_AlumSintesisRealP2->;$aPromediosAlumnosRealP2;*)
			SELECTION TO ARRAY:C260($y_AlumSintesisRealP3->;$aPromediosAlumnosRealP3;*)
			SELECTION TO ARRAY:C260($y_AlumSintesisRealP4->;$aPromediosAlumnosRealP4;*)
			SELECTION TO ARRAY:C260($y_AlumSintesisRealP5->;$aPromediosAlumnosRealP5;*)
			SELECTION TO ARRAY:C260
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			
			ARRAY TEXT:C222($aPromediosAlumnosLiteral;Size of array:C274($aPromediosAlumnosReal))
			ARRAY TEXT:C222($aPromediosAlumnosLiteralP1;Size of array:C274($aPromediosAlumnosReal))
			ARRAY TEXT:C222($aPromediosAlumnosLiteralP2;Size of array:C274($aPromediosAlumnosReal))
			ARRAY TEXT:C222($aPromediosAlumnosLiteralP3;Size of array:C274($aPromediosAlumnosReal))
			ARRAY TEXT:C222($aPromediosAlumnosLiteralP4;Size of array:C274($aPromediosAlumnosReal))
			ARRAY TEXT:C222($aPromediosAlumnosLiteralP5;Size of array:C274($aPromediosAlumnosReal))
			If (iPrintMode=Simbolos)
				  //$node:=JSON Append text array ($jsonT;"ejey";$aEjey)
				OB_SET ($ob_raiz;->$aEjey;"ejey")
				For ($i;1;Size of array:C274($aPromediosAlumnosLiteral))
					
					If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
						$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
					Else 
						$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
					End if 
					$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
					$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
					$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
					$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
					$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
					$el:=Find in array:C230($aEjey;$promLit)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAlumnosLiteral{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP1)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAlumnosLiteralP1{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP2)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAlumnosLiteralP2{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP3)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAlumnosLiteralP3{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP4)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAlumnosLiteralP4{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP5)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAlumnosLiteralP5{$i}:=String:C10($el)
				End for 
				$minimoLiteral:=String:C10(Find in array:C230($aEjey;$minimoLiteral))
			Else 
				For ($i;1;Size of array:C274($aPromediosAlumnosReal))
					If ((<>vtXS_CountryCode="ar") & ($aPromediosAlumnosReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
						$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosAnualReal{$i};$estilo)
					Else 
						$promLit:=_ConvierteEvaluacion ($aPromediosAlumnosReal{$i};$estilo)
					End if 
					$promLitP1:=_ConvierteEvaluacion ($aPromediosAlumnosRealP1{$i};$estilo)
					$promLitP2:=_ConvierteEvaluacion ($aPromediosAlumnosRealP2{$i};$estilo)
					$promLitP3:=_ConvierteEvaluacion ($aPromediosAlumnosRealP3{$i};$estilo)
					$promLitP4:=_ConvierteEvaluacion ($aPromediosAlumnosRealP4{$i};$estilo)
					$promLitP5:=_ConvierteEvaluacion ($aPromediosAlumnosRealP5{$i};$estilo)
					$aPromediosAlumnosLiteral{$i}:=$promLit
					$aPromediosAlumnosLiteralP1{$i}:=$promLitP1
					$aPromediosAlumnosLiteralP2{$i}:=$promLitP2
					$aPromediosAlumnosLiteralP3{$i}:=$promLitP3
					$aPromediosAlumnosLiteralP4{$i}:=$promLitP4
					$aPromediosAlumnosLiteralP5{$i}:=$promLitP5
				End for 
			End if 
			OB_SET ($ob_raiz;->$aNombres;"nombres")
			OB_SET ($ob_raiz;->$minimoLiteral;"minimoliteral")
			If ((<>vtXS_CountryCode="ar") & ($parameterOficial#"oficial"))  //20170721 ASM Ticket 185761
				OB_SET ($ob_raiz;->$aPromediosAlumnosAnualReal;"promediosreales")
			Else 
				OB_SET ($ob_raiz;->$aPromediosAlumnosReal;"promediosreales")
			End if 
			OB_SET ($ob_raiz;->$aPromediosAlumnosLiteral;"promediosliterales")
			OB_SET ($ob_raiz;->$aPromediosAlumnosRealP1;"promediosrealesP1")
			OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP1;"promediosliteralesP1")
			OB_SET ($ob_raiz;->viSTR_Periodos_NumeroPeriodos;"periodos")
			OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodosnombres")
			
			Case of 
				: (viSTR_Periodos_NumeroPeriodos=2)
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
					
				: (viSTR_Periodos_NumeroPeriodos=3)
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
					
				: (viSTR_Periodos_NumeroPeriodos=4)
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
					
				: (viSTR_Periodos_NumeroPeriodos=5)
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP2;"promediosliteralesP2")
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP3;"promediosrealesP3")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP3;"promediosliteralesP3")
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP4;"promediosrealesP4")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP4;"promediosliteralesP4")
					OB_SET ($ob_raiz;->$aPromediosAlumnosRealP5;"promediosrealesP5")
					OB_SET ($ob_raiz;->$aPromediosAlumnosLiteralP5;"promediosliteralesP5")
					
			End case 
		Else 
			
			  //20170407 RCH Busca asignaturas de los alumnos de los cursos
			  //QUERY([Asignaturas];[Asignaturas]Curso=$aCursos{$curso};*)
			  //QUERY([Asignaturas]; & ;[Asignaturas]Incide_en_promedio=True)
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$aCursos{$curso};*)
			QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"@Retirado@")
			ARRAY LONGINT:C221($aIdsAlumnos;0)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$aIdsAlumnos)
			QUERY WITH ARRAY:C644([Alumnos_Calificaciones:208]ID_Alumno:6;$aIdsAlumnos)
			SET FIELD RELATION:C919([Alumnos_Calificaciones:208]Llave_Asignatura:494;Automatic:K51:4;Do not modify:K51:1)
			QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Asignaturas:18]Incide_en_promedio:27=True:C214)
			KRL_RelateSelection (->[Asignaturas:18]Numero:1;->[Alumnos_Calificaciones:208]ID_Asignatura:5;"")
			SET FIELD RELATION:C919([Alumnos_Calificaciones:208]Llave_Asignatura:494;Structure configuration:K51:2;Structure configuration:K51:2)
			
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]ordenGeneral:105;>)
			
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$aNombres;*)
			SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;$aAbreviaturas;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisReal->;$aPromediosAsigsReal;*)
			SELECTION TO ARRAY:C260([Asignaturas_SintesisAnual:202]PromedioAnual_Real:10;$aPromediosAsigAnualReal;*)  // MONO 185103
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP1->;$aPromediosAsigsRealP1;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP2->;$aPromediosAsigsRealP2;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP3->;$aPromediosAsigsRealP3;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP4->;$aPromediosAsigsRealP4;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP5->;$aPromediosAsigsRealP5;*)
			SELECTION TO ARRAY:C260
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			
			ARRAY TEXT:C222($aPromediosAsigsLiteral;Size of array:C274($aPromediosAsigsReal))
			ARRAY TEXT:C222($aPromediosAsigsLiteralP1;Size of array:C274($aPromediosAsigsReal))
			ARRAY TEXT:C222($aPromediosAsigsLiteralP2;Size of array:C274($aPromediosAsigsReal))
			ARRAY TEXT:C222($aPromediosAsigsLiteralP3;Size of array:C274($aPromediosAsigsReal))
			ARRAY TEXT:C222($aPromediosAsigsLiteralP4;Size of array:C274($aPromediosAsigsReal))
			ARRAY TEXT:C222($aPromediosAsigsLiteralP5;Size of array:C274($aPromediosAsigsReal))
			
			If (iPrintMode=Simbolos)
				OB_SET ($ob_raiz;->$aEjey;"ejey")
				For ($i;1;Size of array:C274($aPromediosAsigsLiteral))
					
					If ((<>vtXS_CountryCode="ar") & ($aPromediosAsigsReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
						$promLit:=_ConvierteEvaluacion ($aPromediosAsigAnualReal{$i};$estilo)
					Else 
						$promLit:=_ConvierteEvaluacion ($aPromediosAsigsReal{$i};$estilo)
					End if 
					$promLitP1:=_ConvierteEvaluacion ($aPromediosAsigsRealP1{$i};$estilo)
					$promLitP2:=_ConvierteEvaluacion ($aPromediosAsigsRealP2{$i};$estilo)
					$promLitP3:=_ConvierteEvaluacion ($aPromediosAsigsRealP3{$i};$estilo)
					$promLitP4:=_ConvierteEvaluacion ($aPromediosAsigsRealP4{$i};$estilo)
					$promLitP5:=_ConvierteEvaluacion ($aPromediosAsigsRealP5{$i};$estilo)
					$el:=Find in array:C230($aEjey;$promLit)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAsigsLiteral{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP1)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAsigsLiteralP1{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP2)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAsigsLiteralP2{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP3)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAsigsLiteralP3{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP4)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAsigsLiteralP4{$i}:=String:C10($el)
					$el:=Find in array:C230($aEjey;$promLitP5)
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAsigsLiteralP5{$i}:=String:C10($el)
				End for 
				$minimoLiteral:=String:C10(Find in array:C230($aEjey;$minimoLiteral))
			Else 
				For ($i;1;Size of array:C274($aPromediosAsigsRealP1))
					
					If ((<>vtXS_CountryCode="ar") & ($aPromediosAsigsReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
						$promLit:=_ConvierteEvaluacion ($aPromediosAsigAnualReal{$i};$estilo)
					Else 
						$promLit:=_ConvierteEvaluacion ($aPromediosAsigsReal{$i};$estilo)
					End if 
					
					$promLitP1:=_ConvierteEvaluacion ($aPromediosAsigsRealP1{$i};$estilo)
					$promLitP2:=_ConvierteEvaluacion ($aPromediosAsigsRealP2{$i};$estilo)
					$promLitP3:=_ConvierteEvaluacion ($aPromediosAsigsRealP3{$i};$estilo)
					$promLitP4:=_ConvierteEvaluacion ($aPromediosAsigsRealP4{$i};$estilo)
					$promLitP5:=_ConvierteEvaluacion ($aPromediosAsigsRealP5{$i};$estilo)
					$aPromediosAsigsLiteral{$i}:=$promLit
					$aPromediosAsigsLiteralP1{$i}:=$promLitP1
					$aPromediosAsigsLiteralP2{$i}:=$promLitP2
					$aPromediosAsigsLiteralP3{$i}:=$promLitP3
					$aPromediosAsigsLiteralP4{$i}:=$promLitP4
					$aPromediosAsigsLiteralP5{$i}:=$promLitP5
				End for 
			End if 
			OB_SET ($ob_raiz;->$aNombres;"nombres")
			OB_SET ($ob_raiz;->$aAbreviaturas;"abreviaciones")
			OB_SET ($ob_raiz;->$aPromediosAsigsReal;"promediosreales")
			OB_SET ($ob_raiz;->$aPromediosAsigsLiteral;"promediosliterales")
			OB_SET ($ob_raiz;->$aPromediosAsigsRealP1;"promediosrealesP1")
			OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP1;"promediosliteralesP1")
			OB_SET ($ob_raiz;->viSTR_Periodos_NumeroPeriodos;"periodos")
			OB_SET ($ob_raiz;->atSTR_Periodos_Nombre;"periodosnombres")
			OB_SET ($ob_raiz;->$minimoLiteral;"minimoliteral")
			
			Case of 
				: (viSTR_Periodos_NumeroPeriodos=2)
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP2;"promediosliteralesP2")
					
				: (viSTR_Periodos_NumeroPeriodos=3)
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP2;"promediosliteralesP2")
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP3;"promediosrealesP3")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP3;"promediosliteralesP3")
					
				: (viSTR_Periodos_NumeroPeriodos=4)
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP2;"promediosliteralesP2")
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP3;"promediosrealesP3")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP3;"promediosliteralesP3")
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP4;"promediosrealesP4")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP4;"promediosliteralesP4")
					
				: (viSTR_Periodos_NumeroPeriodos=5)
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP2;"promediosrealesP2")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP2;"promediosliteralesP2")
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP3;"promediosrealesP3")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP3;"promediosliteralesP3")
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP4;"promediosrealesP4")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP4;"promediosliteralesP4")
					OB_SET ($ob_raiz;->$aPromediosAsigsRealP5;"promediosrealesP5")
					OB_SET ($ob_raiz;->$aPromediosAsigsLiteralP5;"promediosliteralesP5")
					
			End case 
		End if 
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="promediosnivel")
		$nivel:=Num:C11(NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"nivel"))
		$nivel:=<>al_NumeroNivelesActivos{$nivel+1}
		$asig:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"asig")
		If ($parameterOficial="oficial")
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_oficial:23)
		Else 
			$estilo:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$nivel;->[xxSTR_Niveles:6]EvStyle_interno:33)
		End if 
		$asigocurso:=NV_GetValueFromPairedArrays ($parameterNames;$parameterValues;"asigocurso")
		EVS_ReadStyleData ($estilo)
		Case of 
			: (iPrintMode=Notas)
				$maxescala:=rGradesTo
				$minescala:=rGradesFrom
				$decimales:=iGradesDecNO
			: (iPrintMode=Puntos)
				$maxescala:=rPointsTo
				$minescala:=rPointsFrom
				$decimales:=iPointsDecNO
			: (iPrintMode=Porcentaje)
				$maxescala:=100
				$minescala:=1
				$decimales:=1
			: (iPrintMode=Simbolos)
				COPY ARRAY:C226(aSymbol;$aEjey)
				$maxescala:=Size of array:C274($aEjey)
				$minescala:=0
				$decimales:=1
		End case 
		$minimoReal:=rPctMinimum
		$minimoLiteral:=_ConvierteEvaluacion (rPctMinimum;$estilo)
		  //$jsonT:=JSON New
		$ob_raiz:=OB_Create 
		If ($asigocurso="asigoxcursoasigs")
			READ ONLY:C145([Asignaturas:18])
			SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
			QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero_del_Nivel:6=$nivel;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]Incide_en_promedio:27=True:C214;*)
			QUERY:C277([Asignaturas:18]; & ;[Asignaturas:18]nivel_jerarquico:107=0)
			DISTINCT VALUES:C339([Asignaturas:18]Asignatura:3;$dNombres)
			SORT ARRAY:C229($dNombres;>)
			If ($asig#"-1")
				QUERY SELECTION:C341([Asignaturas:18];[Asignaturas:18]Asignatura:3=$asig)
			End if 
			ORDER BY:C49([Asignaturas:18];[Asignaturas:18]Abreviación:26;$y_AsigSintesisReal->;>)
			SELECTION TO ARRAY:C260([Asignaturas:18]Asignatura:3;$aNombres;*)
			SELECTION TO ARRAY:C260([Asignaturas:18]Abreviación:26;$aAbreviaturas;*)
			SELECTION TO ARRAY:C260([Asignaturas:18]Curso:5;$aCursos;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisReal->;$aPromediosAsigsReal;*)
			SELECTION TO ARRAY:C260([Asignaturas_SintesisAnual:202]PromedioAnual_Real:10;$aPromediosAsigAnualReal;*)  // MONO 185103
			SELECTION TO ARRAY:C260($y_AsigSintesisLiteral->;$aPromediosAsigsLiteral;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP1->;$aPromediosAsigsRealP1;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP2->;$aPromediosAsigsRealP2;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP3->;$aPromediosAsigsRealP3;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP4->;$aPromediosAsigsRealP4;*)
			SELECTION TO ARRAY:C260($y_AsigSintesisRealP5->;$aPromediosAsigsRealP5;*)
			SELECTION TO ARRAY:C260
			
			SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
			If (iPrintMode=Simbolos)
				OB_SET ($ob_raiz;->$aEjey;"ejey")
				For ($i;1;Size of array:C274($aPromediosAsigsLiteral))
					$el:=Find in array:C230($aEjey;$aPromediosAsigsLiteral{$i})
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosAsigsLiteral{$i}:=String:C10($el)
				End for 
				$minimoLiteral:=String:C10(Find in array:C230($aEjey;$minimoLiteral))
			Else 
				For ($i;1;Size of array:C274($aPromediosAsigsLiteral))
					If ((<>vtXS_CountryCode="ar") & ($aPromediosAsigsReal{$i}=-10) & ($parameterOficial#"oficial"))  // MONO 185103
						$aPromediosAsigsLiteral{$i}:=_ConvierteEvaluacion ($aPromediosAsigAnualReal{$i};$estilo)
					Else 
						$aPromediosAsigsLiteral{$i}:=_ConvierteEvaluacion ($aPromediosAsigsReal{$i};$estilo)
					End if 
				End for 
			End if 
			OB_SET ($ob_raiz;->$aAbreviaturas;"cursos")
			OB_SET ($ob_raiz;->$aNombres;"nombres")
			OB_SET ($ob_raiz;->$aCursos;"nombrecurso")
			OB_SET ($ob_raiz;->$aPromediosAsigsLiteral;"promediosliterales")
			OB_SET ($ob_raiz;->$aPromediosAsigsReal;"promediosreales")
			OB_SET ($ob_raiz;->$dNombres;"asigsdistintas")
			
		Else 
			READ ONLY:C145([Cursos:3])
			QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$nivel;*)
			QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>=0)
			ORDER BY:C49([Cursos:3];[Cursos:3]Curso:1;>)
			LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$rnCursos)
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;$aCursos)
			For ($i;1;Size of array:C274($aCursos))
				KRL_GotoRecord (->[Cursos:3];$rnCursos{$i};False:C215)
				$promCursoReal:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;$y_CursosSintesisReal)
				If ((<>vtXS_CountryCode="ar") & ($promCursoReal=-10) & ($parameterOficial#"oficial"))  // MONO 185103
					$promCursoReal:=KRL_GetNumericFieldData (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;->[Cursos_SintesisAnual:63]PromedioAnual_Real:12)
				End if 
				
				$promCursoLiteral:=_ConvierteEvaluacion ($promCursoReal;$estilo)
				APPEND TO ARRAY:C911($aPromediosCursoReal;$promCursoReal)
				APPEND TO ARRAY:C911($aPromediosCursoLiteral;$promCursoLiteral)
			End for 
			If (iPrintMode=Simbolos)
				OB_SET ($ob_raiz;->$aEjey;"ejey")
				For ($i;1;Size of array:C274($aPromediosCursoLiteral))
					$el:=Find in array:C230($aEjey;$aPromediosCursoLiteral{$i})
					If ($el=-1)
						$el:=0
					End if 
					$aPromediosCursoLiteral{$i}:=String:C10($el)
				End for 
				$minimoLiteral:=String:C10(Find in array:C230($aEjey;$minimoLiteral))
			End if 
			OB_SET ($ob_raiz;->$aCursos;"cursos")
			OB_SET ($ob_raiz;->$aPromediosCursoLiteral;"promediosliterales")
			OB_SET ($ob_raiz;->$aPromediosCursoReal;"promediosreales")
		End if 
		
		OB_SET_Long ($ob_raiz;iPrintMode;"mode")
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"separador")
		OB_SET ($ob_raiz;->$maxescala;"maxescala")
		OB_SET ($ob_raiz;->$minescala;"minescala")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		OB_SET ($ob_raiz;->$minimoReal;"minimoreal")
		OB_SET ($ob_raiz;->$minimoLiteral;"minimoliteral")
		$json:=OB_Object2Json ($ob_raiz)
		
	: ($action="dashboard")
		NIV_LoadArrays 
		PERIODOS_Init 
		READ ONLY:C145([xxSTR_Niveles:6])
		READ ONLY:C145([Alumnos:2])
		QUERY WITH ARRAY:C644([xxSTR_Niveles:6]NoNivel:5;<>al_NumeroNivelesActivos)
		ORDER BY:C49([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5;>)
		LONGINT ARRAY FROM SELECTION:C647([xxSTR_Niveles:6];$aRNNiveles;"")
		DISTINCT VALUES:C339([xxSTR_Niveles:6]EvStyle_oficial:23;$estilos)
		EVS_initialize 
		
		$ob_raiz:=OB_Create 
		For ($i;1;Size of array:C274($aRNNiveles))
			KRL_GotoRecord (->[xxSTR_Niveles:6];$aRNNiveles{$i};False:C215)
			APPEND TO ARRAY:C911($aNombreNivel;[xxSTR_Niveles:6]Nivel:1)
			PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)
			If ($parameterOficial="oficial")
				$estilo:=[xxSTR_Niveles:6]EvStyle_oficial:23
			Else 
				$estilo:=[xxSTR_Niveles:6]EvStyle_interno:33
			End if 
			  //QUERY([Alumnos];[Alumnos]Nivel_Número=[xxSTR_Niveles]NoNivel;*)
			  //QUERY([Alumnos]; & ;[Alumnos]Status#"@Retirado@")
			  //KRL_RelateSelection (->[Alumnos_SintesisAnual]ID_Alumno;->[Alumnos]Número;"")
			  //QUERY SELECTION([Alumnos_SintesisAnual];[Alumnos_SintesisAnual]Año=<>gYear)
			  //ARRAY REAL($promsAlumnosReal;0)
			  //SELECTION TO ARRAY($y_AlumSintesisReal->;$promsAlumnosReal)
			ARRAY REAL:C219($ar_promsAlumnosReal;0)
			QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]NumeroNivel:3=[xxSTR_Niveles:6]NoNivel:5;*)
			QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Curso:5#"@ADT@";*)
			QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]Año:2=<>gyear)
			SELECTION TO ARRAY:C260($y_CursosSintesisReal->;$ar_promsAlumnosReal;[Cursos_SintesisAnual:63]PromedioAnual_Real:12;$aPromediosCursoAnualReal)  // MONO 185103
			$average:=Round:C94(AT_Mean (->$ar_promsAlumnosReal;1);2)
			
			If ((<>vtXS_CountryCode="ar") & (($average=-10) | ($average=0)) & ($parameterOficial#"oficial"))  // MONO 185103
				$average:=Round:C94(AT_Mean (->$aPromediosCursoAnualReal;1);2)
			End if 
			
			APPEND TO ARRAY:C911($aPromNivel;$average)
			$averageTxt:=_ConvierteEvaluacion ($average;$estilo)
			APPEND TO ARRAY:C911($aPromNivelLiteral;$averageTxt)
			EVS_ReadStyleData ($estilo)
			APPEND TO ARRAY:C911($aMinimoNivel;rPctMinimum)
			APPEND TO ARRAY:C911($aMinimoNivelLiteral;_ConvierteEvaluacion (rPctMinimum;$estilo))
		End for 
		If (Size of array:C274($estilos)=1)
			OB_SET_Long ($ob_raiz;iPrintMode;"mode")
			EVS_ReadStyleData ($estilos{1})
			Case of 
				: (iPrintMode=Notas)
					$maxescala:=rGradesTo
					$minescala:=rGradesFrom
					$decimales:=iGradesDecNO
				: (iPrintMode=Puntos)
					$maxescala:=rPointsTo
					$minescala:=rPointsFrom
					$decimales:=iPointsDecNO
				: (iPrintMode=Porcentaje)
					$maxescala:=100
					$minescala:=1
					$decimales:=1
				: (iPrintMode=Simbolos)
					$maxescala:=Size of array:C274($aEjey)
					$minescala:=0
					$decimales:=1
					COPY ARRAY:C226(aSymbol;$aEjey)
					If (iPrintMode=Simbolos)
						  //$node:=JSON Append text array ($jsonT;"ejey";$aEjey)
						OB_SET ($ob_raiz;->$aEjey;"ejey")
						For ($i;1;Size of array:C274($aPromNivelLiteral))
							$el:=Find in array:C230($aEjey;$aPromNivelLiteral{$i})
							If ($el=-1)
								$el:=0
							End if 
							$aPromNivelLiteral{$i}:=String:C10($el)
							$el:=Find in array:C230($aEjey;$aMinimoNivelLiteral{$i})
							If ($el=-1)
								$el:=0
							End if 
							$aMinimoNivelLiteral{$i}:=String:C10($el)
						End for 
					End if 
			End case 
		Else 
			$maxescala:=100
			$minescala:=1
			$decimales:=1
		End if 
		$b_multiestilo:=(Size of array:C274($estilos)>1)
		OB_SET ($ob_raiz;->$aNombreNivel;"niveles")
		OB_SET ($ob_raiz;->$aPromNivel;"promediosreales")
		OB_SET ($ob_raiz;->$aPromNivelLiteral;"promediosliterales")
		OB_SET ($ob_raiz;->$aMinimoNivel;"minimosreales")
		OB_SET ($ob_raiz;->$aMinimoNivelLiteral;"minimosliterales")
		OB_SET ($ob_raiz;->$b_multiestilo;"multiestilos")
		OB_SET ($ob_raiz;-><>tXS_RS_DecimalSeparator;"separador")
		OB_SET ($ob_raiz;->$maxescala;"maxescala")
		OB_SET ($ob_raiz;->$minescala;"minescala")
		OB_SET ($ob_raiz;->$decimales;"decimales")
		$json:=OB_Object2Json ($ob_raiz)
		
End case 
$0:=$json