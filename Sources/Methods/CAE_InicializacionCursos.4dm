//%attributes = {}
  //CAE_InicializacionCursos

C_LONGINT:C283($1;$l_nivel)  //MONO 184433
If (Count parameters:C259=1)
	$l_nivel:=$1  //MONO 184433
	QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=$l_nivel)  //MONO 184433
Else 
	ALL RECORDS:C47([Cursos:3])  //MONO 184433
End if 

ARRAY LONGINT:C221($aRecNums;0)
LONGINT ARRAY FROM SELECTION:C647([Cursos:3];$aRecNums;"")
For ($i;1;Size of array:C274($aRecNums))
	READ WRITE:C146([Cursos:3])
	GOTO RECORD:C242([Cursos:3];$aRecNums{$i})
	[Cursos:3]Numero_del_curso:6:=SQ_SeqNumber (->[Cursos:3]Numero_del_curso:6)  //MONO 184433
	[Cursos:3]Nombre_Oficial_Curso:15:=KRL_GetTextFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]Abreviatura_Oficial:35)+"-"+[Cursos:3]Letra_Oficial_del_Curso:18
	[Cursos:3]Promedio_NF:44:=""
	[Cursos:3]Promedio_P1:37:=""
	[Cursos:3]Promedio_P2:38:=""
	[Cursos:3]Promedio_P3:39:=""
	[Cursos:3]Promedio_P4:40:=""
	[Cursos:3]Promedio_PF:43:=""
	SAVE RECORD:C53([Cursos:3])
	
	READ WRITE:C146([Cursos_SintesisAnual:63])
	$key:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Cursos:3]Nivel_Numero:7;->[Cursos:3]Curso:1;->[Cursos:3]Numero_del_curso:6;->[Cursos:3]Numero_del_curso:6)  //MONO 184433
	$recNum:=KRL_FindAndLoadRecordByIndex (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->$key;True:C214)
	If ($recNum<0)
		CREATE RECORD:C68([Cursos_SintesisAnual:63])
		[Cursos_SintesisAnual:63]ID_Institucion:1:=<>gInstitucion
		[Cursos_SintesisAnual:63]NumeroNivel:3:=[Cursos:3]Nivel_Numero:7
		[Cursos_SintesisAnual:63]Año:2:=<>gYear
		[Cursos_SintesisAnual:63]ID_Curso:52:=[Cursos:3]Numero_del_curso:6
		[Cursos_SintesisAnual:63]Curso:5:=[Cursos:3]Curso:1
		[Cursos_SintesisAnual:63]NombreOficialCurso:7:=[Cursos:3]Nombre_Oficial_Curso:15
		[Cursos_SintesisAnual:63]cl_CodigoEspecialidadTP:54:=[Cursos:3]cl_CodigoEspecialidadTP:29
		[Cursos_SintesisAnual:63]cl_EspecialidadTP:55:=[Cursos:3]cl_EspecialidadTP:28
		[Cursos_SintesisAnual:63]cl_SectorEconomicoTP:56:=[Cursos:3]cl_SectorEconomicoTP:27
		SAVE RECORD:C53([Cursos_SintesisAnual:63])
	End if 
	[Cursos_SintesisAnual:63]NombreOficialCurso:7:=[Cursos:3]Nombre_Oficial_Curso:15
	If ([Cursos:3]ActaEspecificaAlCurso:35)
		[Cursos_SintesisAnual:63]Actas_y_Certificados:11:=[Cursos:3]Acta:34
	End if 
	
	SAVE RECORD:C53([Cursos_SintesisAnual:63])
End for 



