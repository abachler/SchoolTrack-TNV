//%attributes = {}
  //EV2_CargaRegistro

C_LONGINT:C283($idAsignatura;$idAlumno;$año;$institucion;$1;$2;$4;$5)
C_BOOLEAN:C305($readWrite;$3)
C_LONGINT:C283($recNum)

$idAsignatura:=$1
$IdAlumno:=$2
$año:=<>gYear
$institucion:=<>gInstitucion
Case of 
	: (Count parameters:C259=5)
		$readWrite:=$3
		$año:=$4
		$institucion:=$5
	: (Count parameters:C259=4)
		$año:=$4
		$readWrite:=$3
	: (Count parameters:C259=3)
		$readWrite:=$3
End case 

If ($año<<>gYear)  //evito que el registro sea cargado en escritura si corresponde a un año anterior
	$readWrite:=False:C215
End if 

$vs_nivel:=String:C10(KRL_GetNumericFieldData (->[Asignaturas:18]Numero:1;->$idAsignatura;->[Asignaturas:18]Numero_del_Nivel:6))
$key:=String:C10($institucion)+"."+String:C10($año)+"."+$vs_nivel+"."+String:C10($idAsignatura)+"."+String:C10($Idalumno)
$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_Calificaciones:208]Llave_principal:1;->$key;$readWrite)

If ($recNum>=0)
	$recNumComplemento:=KRL_FindAndLoadRecordByIndex (->[Alumnos_ComplementoEvaluacion:209]Llave_Principal:1;->$key;$readWrite)
	If (Records in selection:C76([Alumnos_ComplementoEvaluacion:209])=0)
		CREATE RECORD:C68([Alumnos_ComplementoEvaluacion:209])
		[Alumnos_ComplementoEvaluacion:209]ID_Institucion:2:=[Alumnos_Calificaciones:208]ID_institucion:2
		[Alumnos_ComplementoEvaluacion:209]Año:3:=[Alumnos_Calificaciones:208]Año:3
		[Alumnos_ComplementoEvaluacion:209]ID_Alumno:6:=[Alumnos_Calificaciones:208]ID_Alumno:6
		[Alumnos_ComplementoEvaluacion:209]ID_Asignatura:5:=[Alumnos_Calificaciones:208]ID_Asignatura:5
		[Alumnos_ComplementoEvaluacion:209]ID_HistoricoAsignatura:48:=[Alumnos_Calificaciones:208]ID_HistoricoAsignatura:493
		[Alumnos_ComplementoEvaluacion:209]Nivel_Numero:4:=[Alumnos_Calificaciones:208]NIvel_Numero:4
		SAVE RECORD:C53([Alumnos_ComplementoEvaluacion:209])
	End if 
Else 
	OK:=0
	REDUCE SELECTION:C351([Alumnos_ComplementoEvaluacion:209];0)
End if 

$0:=$recNum