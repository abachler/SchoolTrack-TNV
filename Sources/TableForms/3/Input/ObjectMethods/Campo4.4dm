SAVE RECORD:C53([Cursos:3])
If (Self:C308->)
	If (BLOB size:C605([Cursos:3]Acta:34)=0)
		READ ONLY:C145([xxSTR_Niveles:6])
		QUERY:C277([xxSTR_Niveles:6];[xxSTR_Niveles:6]NoNivel:5=[Cursos:3]Nivel_Numero:7)
		If (Records in selection:C76([xxSTR_Niveles:6])>0)
			$actas:=[xxSTR_Niveles:6]Actas_y_Certificados:43
			[Cursos:3]Acta:34:=$actas
			SAVE RECORD:C53([Cursos:3])
			  //$key:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Cursos]Nivel_Numero;->[Cursos]Curso)
			KRL_FindAndLoadRecordByIndex (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;True:C214)  //MONO 184433
			[Cursos_SintesisAnual:63]Actas_y_Certificados:11:=$actas
			SAVE RECORD:C53([Cursos_SintesisAnual:63])
			KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
		End if 
	End if 
Else 
	SET BLOB SIZE:C606([Cursos:3]Acta:34;0)
	  //$key:=KRL_MakeStringAccesKey (-><>gInstitucion;-><>gYear;->[Cursos]Nivel_Numero;->[Cursos]Curso)
	KRL_FindAndLoadRecordByIndex (->[Cursos_SintesisAnual:63]LLavePrimaria:6;->[Cursos:3]LLaveSintesisAnual:4;True:C214)  //MONO 184433
	SET BLOB SIZE:C606([Cursos_SintesisAnual:63]Actas_y_Certificados:11;0)
	SAVE RECORD:C53([Cursos_SintesisAnual:63])
	KRL_UnloadReadOnly (->[Cursos_SintesisAnual:63])
End if 
CU_PgActas 