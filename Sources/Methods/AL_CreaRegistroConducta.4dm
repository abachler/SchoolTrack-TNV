//%attributes = {}
  //AL_CreaRegistroConducta

$id:=$1
$recNum:=Find in field:C653([Alumnos_Conducta:8]Número_de_Alumno:1;$id)
If ($recNum<0)
	CREATE RECORD:C68([Alumnos_Conducta:8])
	[Alumnos_Conducta:8]Número_de_Alumno:1:=$id
	[Alumnos_Conducta:8]Porcentaje_de_asistencia:36:=100
	[Alumnos_Conducta:8]ClassAttendance_Percent:55:=100
	SAVE RECORD:C53([Alumnos_Conducta:8])
End if 
KRL_ReloadAsReadOnly (->[Alumnos_Conducta:8])
