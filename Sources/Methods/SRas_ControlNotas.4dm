//%attributes = {}
  //SRas_ControlNotas



  //REGISTRO DE CAMBIOS
  //20080422 RCH El informe mostraba mal la info. Siempre mostraba que todas las columnas tenían notas
  //Se cambio el 0 por -10 en el query selection de las evaluaciones
C_LONGINT:C283($0;$tablaEvaluaciones)
ARRAY LONGINT:C221(along1;0)
ARRAY LONGINT:C221(along1;12)

EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
CREATE SET:C116([Alumnos_Calificaciones:208];"set")
[Asignaturas:18]Numero_de_alumnos:49:=Records in set:C195("set")

$periodo:=vPeriodo
$tablaEvaluaciones:=Table:C252(->[Alumnos_Calificaciones:208])
Case of 
	: ($periodo=1)
		$nextField:=Field:C253(->[Alumnos_Calificaciones:208]P01_Eval01_Real:42)
	: ($periodo=2)
		$nextField:=Field:C253(->[Alumnos_Calificaciones:208]P02_Eval01_Real:117)
	: ($periodo=3)
		$nextField:=Field:C253(->[Alumnos_Calificaciones:208]P03_Eval01_Real:192)
	: ($periodo=4)
		$nextField:=Field:C253(->[Alumnos_Calificaciones:208]P04_Eval01_Real:267)
	: ($periodo=5)
		$nextField:=Field:C253(->[Alumnos_Calificaciones:208]P05_Eval01_Real:342)
End case 



vEvals:=0
For ($i;1;12)
	USE SET:C118("set")
	$field:=Field:C253($tablaEvaluaciones;$nextField)
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];$field->#-10)
	aLong1{$i}:=Records in selection:C76([Alumnos_Calificaciones:208])
	If (aLong1{$i}>0)
		vEvals:=vEvals+1
	End if 
	$nextfield:=$nextField+5
End for 

CLEAR SET:C117("set")
