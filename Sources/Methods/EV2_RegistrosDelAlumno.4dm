//%attributes = {}
  //EV2_RegistrosDelAlumno

C_LONGINT:C283($l_IdAlumno;$año;$nivel;$institucion;$1;$2;$3;$4)
$l_IdAlumno:=$1
$nivel:=0
$año:=<>gYear
$institucion:=<>gInstitucion
Case of 
	: (Count parameters:C259=4)
		$nivel:=$2
		$año:=$3
		$institucion:=$4
	: (Count parameters:C259=3)
		$nivel:=$2
		$año:=$3
	: (Count parameters:C259=2)
		$nivel:=$2
End case 

If ($nivel=0)
	$nivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$l_IdAlumno;->[Alumnos:2]nivel_numero:29)
End if 


If ($año<<>gYear)  //evito que los registros sean cargados en escritura si corresponde a un año anterior
	$readWrite:=False:C215
End if 



READ ONLY:C145([Alumnos_Calificaciones:208])
READ ONLY:C145([Alumnos_ComplementoEvaluacion:209])
READ ONLY:C145([Alumnos_SintesisAnual:210])
READ ONLY:C145([Alumnos_EvaluacionAprendizajes:203])
READ ONLY:C145([Alumnos_Historico:25])



$l_idalumno:=Abs:C99($l_idalumno)
$key:=KRL_MakeStringAccesKey (->$institucion;->$año;->$nivel;->$l_IdAlumno)
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]Llave_Alumno:495;=;$key)
QUERY:C277([Alumnos_ComplementoEvaluacion:209];[Alumnos_ComplementoEvaluacion:209]LLave_Alumno:55;=;$key)
QUERY:C277([Alumnos_EvaluacionAprendizajes:203];[Alumnos_EvaluacionAprendizajes:203]LlaveAlumno:92;=;$key)


$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key)
If ($recNum<0)
	If (($nivel>Nivel_AdmisionDirecta) & ($nivel<Nivel_Egresados))
		AL_CreaRegistrosSintesis ($l_IdAlumno;$año;$nivel;$institucion)
	End if 
End if 


If ($año<<>gYear)
	$key:=String:C10($l_IdAlumno)+"."+String:C10($año)
	KRL_FindAndLoadRecordByIndex (->[Alumnos_Historico:25]Llave:42;->$key)
End if 