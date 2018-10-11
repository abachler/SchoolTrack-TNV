//%attributes = {}
  //AL_CreaRegistroSalud

$id:=$1
$recNum:=Find in field:C653([Alumnos_FichaMedica:13]Alumno_Numero:1;$id)
If ($recNum<0)
	CREATE RECORD:C68([Alumnos_FichaMedica:13])
	[Alumnos_FichaMedica:13]Alumno_Numero:1:=$id
	[Alumnos_FichaMedica:13]OB_tratamiento:23:=OB_Create 
	SAVE RECORD:C53([Alumnos_FichaMedica:13])
End if 
KRL_ReloadAsReadOnly (->[Alumnos_FichaMedica:13])
AL_CreaRegistrosVacunacion ($id)