//%attributes = {}
  // UD_v20140417_ProfJefeHistoricos()
  // Por: Alberto Bachler K.: 17-04-14, 20:18:48
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


QUERY:C277([Cursos_SintesisAnual:63];[Cursos_SintesisAnual:63]Año:2<<>gYear;*)
QUERY:C277([Cursos_SintesisAnual:63]; & ;[Cursos_SintesisAnual:63]ProfesorJefe_ID:8=0)

ARRAY LONGINT:C221($al_RecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Cursos_SintesisAnual:63];$al_RecNums;"")
$l_idTermometro:=IT_Progress (1;0;0;"...")
For ($i_registros;1;Size of array:C274($al_RecNums))
	READ WRITE:C146([Cursos_SintesisAnual:63])
	GOTO RECORD:C242([Cursos_SintesisAnual:63];$al_RecNums{$i_registros})
	QUERY:C277([Alumnos_Historico:25];[Alumnos_Historico:25]Curso:3=[Cursos_SintesisAnual:63]Curso:5;*)
	QUERY:C277([Alumnos_Historico:25]; & [Alumnos_Historico:25]Año:2=[Cursos_SintesisAnual:63]Año:2)
	QUERY:C277([Profesores:4];[Profesores:4]Apellidos_y_nombres:28=[Alumnos_Historico:25]ProfesorJefe:33)
	If (([Profesores:4]Apellidos_y_nombres:28#"") & ([Cursos_SintesisAnual:63]ProfesorJefe_ID:8=0))
		[Cursos_SintesisAnual:63]ProfesorJefe_ID:8:=[Profesores:4]Numero:1
		[Cursos_SintesisAnual:63]ProfesorJefe_ApellidosNombres:9:=[Profesores:4]Apellidos_y_nombres:28
	End if 
	SAVE RECORD:C53([Cursos_SintesisAnual:63])
	$l_idTermometro:=IT_Progress (0;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
End for 
$l_idTermometro:=IT_Progress (-1;$l_idTermometro;$i_registros/Size of array:C274($al_RecNums))
KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])


