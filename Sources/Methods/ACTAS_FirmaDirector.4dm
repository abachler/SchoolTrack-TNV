//%attributes = {}
  // ACTAS_FirmaDirector()
  // Por: Alberto Bachler K.: 31-03-14, 18:00:15
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_idProfesor)
C_POINTER:C301($y_firmaDirector)


  // firma y nombre del director
$y_firmaDirector:=OBJECT Get pointer:C1124(Object named:K67:5;"firmaDirector")
If (vi_firmaDirectorNivel=1)
	Case of 
		: ((Record number:C243([Alumnos:2])>No current record:K29:2) & ([Alumnos:2]nivel_numero:29>12))
			$l_nivel:=12
		: (Record number:C243([Alumnos:2])>No current record:K29:2)
			$l_nivel:=[Alumnos:2]nivel_numero:29
		: (Record number:C243([Cursos:3])>No current record:K29:2)
			$l_nivel:=12
	End case 
	$l_idProfesor:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->$l_nivel;->[xxSTR_Niveles:6]ID_DirectorNivel:52)
	If ($l_idProfesor>0)
		KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[xxSTR_Niveles:6]ID_DirectorNivel:52)
	Else 
		READ ONLY:C145([Colegio:31])
		QUERY:C277([Colegio:31];[Colegio:31]Director_IdFuncionario:61>0)
		KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Colegio:31]Director_IdFuncionario:61)
	End if 
Else 
	READ ONLY:C145([Colegio:31])
	QUERY:C277([Colegio:31];[Colegio:31]Director_IdFuncionario:61>0)
	KRL_FindAndLoadRecordByIndex (->[Profesores:4]Numero:1;->[Colegio:31]Director_IdFuncionario:61)
End if 
If (([Profesores:4]Inactivo:62=False:C215) | (Records in selection:C76([Profesores:4])>0))
	$y_firmaDirector->:=[Profesores:4]Firma:15
	vt_NombreDirector:=ST_CleanString ([Profesores:4]Nombres:2+" "+[Profesores:4]Apellido_paterno:3+" "+[Profesores:4]Apellido_materno:4;"  ";" ")
	OBJECT SET TITLE:C194(*;"director";[Profesores:4]Cargo:19)
Else 
	READ ONLY:C145([Colegio:31])
	QUERY:C277([Colegio:31];[Colegio:31]Director_NombreCompleto:13#"")
	$y_firmaDirector->:=$y_firmaDirector->*0
	vt_NombreDirector:=[Colegio:31]Director_NombreCompleto:13
End if 

