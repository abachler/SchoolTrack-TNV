//%attributes = {}
  //UD_v20120224_STR_VerificaRegist

If (<>gCountryCode="cl")
	C_LONGINT:C283($proc)
	READ ONLY:C145([Alumnos:2])
	READ ONLY:C145([Alumnos_SintesisAnual:210])
	
	CREATE EMPTY SET:C140([Alumnos_SintesisAnual:210];"malos")
	ALL RECORDS:C47([Alumnos:2])
	$proc:=IT_UThermometer (1;0;"Verificando registros de síntesis anual para el año "+String:C10(<>gYear)+"...")
	While (Not:C34(End selection:C36([Alumnos:2])))
		QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]ID_Alumno:4;=;[Alumnos:2]numero:1;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & [Alumnos_SintesisAnual:210]Año:2=<>gYear;*)
		QUERY:C277([Alumnos_SintesisAnual:210]; & ;[Alumnos_SintesisAnual:210]NumeroNivel:6#[Alumnos:2]nivel_numero:29)
		If (Records in selection:C76([Alumnos_SintesisAnual:210])>0)
			ADD TO SET:C119([Alumnos_SintesisAnual:210];"malos")
		End if 
		NEXT RECORD:C51([Alumnos:2])
	End while 
	
	READ WRITE:C146([Alumnos_SintesisAnual:210])
	USE SET:C118("malos")
	KRL_DeleteSelection (->[Alumnos_SintesisAnual:210])
	
	READ WRITE:C146([Alumnos_SintesisAnual:210])
	QUERY:C277([Alumnos_SintesisAnual:210];[Alumnos_SintesisAnual:210]Año:2=<>gYear)
	While (Not:C34(End selection:C36([Alumnos_SintesisAnual:210])))
		QUERY:C277([Alumnos:2];[Alumnos:2]numero:1;=[Alumnos_SintesisAnual:210]ID_Alumno:4)
		If (Records in selection:C76([Alumnos:2])>0)
			If (([Alumnos_SintesisAnual:210]Curso:7#[Alumnos:2]curso:20) | ([Alumnos_SintesisAnual:210]NumeroNivel:6#[Alumnos:2]nivel_numero:29))
				[Alumnos_SintesisAnual:210]Curso:7:=[Alumnos:2]curso:20
				[Alumnos_SintesisAnual:210]NumeroNivel:6:=[Alumnos:2]nivel_numero:29
				SAVE RECORD:C53([Alumnos_SintesisAnual:210])
			End if 
		End if 
		NEXT RECORD:C51([Alumnos_SintesisAnual:210])
	End while 
	KRL_UnloadReadOnly (->[Alumnos_SintesisAnual:210])
	
	  // >> verifica sintesis anual para todos los alumnos
	READ ONLY:C145([Alumnos:2])
	QUERY:C277([Alumnos:2];[Alumnos:2]nivel_numero:29>Nivel_AdmisionDirecta;*)
	QUERY:C277([Alumnos:2]; & ;[Alumnos:2]nivel_numero:29<Nivel_Egresados)
	C_LONGINT:C283($idAlumno;$recNum)
	C_TEXT:C284($key)
	ARRAY LONGINT:C221(aQR_Longint1;0)
	ARRAY LONGINT:C221(aQR_Longint2;0)
	SELECTION TO ARRAY:C260([Alumnos:2]nivel_numero:29;aQR_Longint1;[Alumnos:2]numero:1;aQR_Longint2)
	For ($idAlumno;1;Size of array:C274(aQR_Longint1))
		$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10(aQR_Longint1{$idAlumno})+"."+String:C10(aQR_Longint2{$idAlumno})
		$recNum:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key)
		If ($recNum<0)
			AL_CreaRegistrosSintesis (aQR_Longint2{$idAlumno};<>gYear;aQR_Longint1{$idAlumno};<>gInstitucion)
		End if 
	End for 
	  // >> verifica sintesis anual para todos los alumnos
	
	dbu_CountClassStudents 
	
	IT_UThermometer (-2;$proc)
	
	SET_ClearSets ("malos")
	AT_Initialize (->aQR_Longint1;->aQR_Longint2)
End if 