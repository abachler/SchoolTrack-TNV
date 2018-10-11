//%attributes = {}
  //DIAP_InscribeCargaAlumnos 

C_TEXT:C284($curso;$1;$mensaje;$0)
C_POINTER:C301($y_alumnos;$y_IDalu;$y_inscritas;$2;$3;$4)
C_LONGINT:C283($i;$l_completos)

$curso:=$1
$y_alumnos:=$2
$y_IDalu:=$3
$y_inscritas:=$4

READ ONLY:C145([DIAP_AlumnosAsignaturas:225])
READ ONLY:C145([Alumnos:2])
QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=$curso;*)
QUERY:C277([Alumnos:2]; & ;[Alumnos:2]Status:50#"Retirado@")
ORDER BY:C49([Alumnos:2];[Alumnos:2]no_de_lista:53;>)
SELECTION TO ARRAY:C260([Alumnos:2]numero:1;$y_IDalu->;[Alumnos:2]apellidos_y_nombres:40;$y_alumnos->)

For ($i;1;Size of array:C274($y_IDalu->))
	
	QUERY:C277([DIAP_AlumnosAsignaturas:225];[DIAP_AlumnosAsignaturas:225]ID_Alumno:2=$y_IDalu->{$i};*)
	QUERY:C277([DIAP_AlumnosAsignaturas:225]; & ;[DIAP_AlumnosAsignaturas:225]Año:7=<>gyear)
	
	APPEND TO ARRAY:C911($y_inscritas->;String:C10(Records in selection:C76([DIAP_AlumnosAsignaturas:225]))+" de 5")  // esta cantidad de asignaturas deberia ser configurable
	
	If (Records in selection:C76([DIAP_AlumnosAsignaturas:225])=5)
		$l_completos:=$l_completos+1
	End if 
	
End for 

$mensaje:=String:C10($l_completos)+" de "+String:C10(Size of array:C274($y_IDalu->))+" alumnos con inscripción DIAP completa."
$0:=$mensaje