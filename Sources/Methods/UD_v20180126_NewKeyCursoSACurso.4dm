//%attributes = {}
  //UD_v20180126_NewKeyCursoSACurso
  // creado para el ticket 184433 
  //MONO 184433
  //actualiza la nueva llave del curso dentro del trigger 
ARRAY LONGINT:C221($al_Ids;0)
ARRAY LONGINT:C221($al_recnum;0)
C_LONGINT:C283($pID)

$pId:=IT_UThermometer (0;$pID;__ ("Actualizando Llave de Curso..."))
READ WRITE:C146([Cursos:3])
ALL RECORDS:C47([Cursos:3])
SELECTION TO ARRAY:C260([Cursos:3]Numero_del_curso:6;$al_Ids)
ARRAY TO SELECTION:C261($al_Ids;[Cursos:3]Numero_del_curso:6)
KRL_UnloadReadOnly (->[Cursos:3])


$pId:=IT_UThermometer (0;$pID;__ ("Actualizando Llave de Sinstesis Anual Curso..."))
READ WRITE:C146([Cursos_SintesisAnual:63])
QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]ID_Curso:52>0)
SELECTION TO ARRAY:C260([Cursos_SintesisAnual:63]ID_Curso:52;$al_Ids)
ARRAY TO SELECTION:C261($al_Ids;[Cursos_SintesisAnual:63]ID_Curso:52)
KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])

  //agregar una campo para el id del curso en el [Alumnos_Historico]

IT_UThermometer (-2;$pID)
