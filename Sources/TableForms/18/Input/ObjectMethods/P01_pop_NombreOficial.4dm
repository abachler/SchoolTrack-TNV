If (<>aAsign>0)
	  //KRL_GotoRecord ("M";->[Asignaturas];True)
	[Asignaturas:18]Asignatura:3:=<>aAsign{<>aAsign}
	$r:=AS_fExist 
	
	[Asignaturas:18]Asignatura:3:=<>aAsign{<>aAsign}
	READ ONLY:C145([xxSTR_Materias:20])
	QUERY:C277([xxSTR_Materias:20];[xxSTR_Materias:20]Materia:2=[Asignaturas:18]Asignatura:3)
	[Asignaturas:18]Asignatura_No_Oficial:71:=False:C215
	[Asignaturas:18]CHILE_CodigoMineduc:41:=[xxSTR_Materias:20]Codigo:10
	[Asignaturas:18]Abreviación:26:=[xxSTR_Materias:20]Abreviatura:8
	[Asignaturas:18]Sector:9:=[xxSTR_Materias:20]Area:12
	[Asignaturas:18]Materia_UUID:46:=[xxSTR_Materias:20]Auto_UUID:21  //Asignatura, Materia Auto uuid
	[Asignaturas:18]Asignatura:3:=ST_GetCleanString ([Asignaturas:18]Asignatura:3)
	If (([Asignaturas:18]denominacion_interna:16#"") & ([Asignaturas:18]denominacion_interna:16#[xxSTR_Materias:20]Denominación_Interna:18))
		OK:=CD_Dlog (0;__ ("Usted modificó el el nombre oficial de la asignatura\r\r¿Desea conservar el nombre interno actual de la asignatura?");__ ("");__ ("Si, conservar");__ ("No, cambiar"))
		If (OK=2)
			If ([Asignaturas:18]Asignatura:3#Old:C35([Asignaturas:18]Asignatura:3))
				[Asignaturas:18]denominacion_interna:16:=[xxSTR_Materias:20]Denominación_Interna:18
			End if 
		End if 
	Else 
		[Asignaturas:18]denominacion_interna:16:=[xxSTR_Materias:20]Denominación_Interna:18
	End if 
	AS_fSave 
	READ ONLY:C145([Profesores:4])
	QUERY:C277([Profesores:4];[Profesores]Asignaturas'Asignatura=[Asignaturas:18]Asignatura:3;*)
	QUERY:C277([Profesores:4]; | [Profesores:4]AutorizadoTodaAsignatura:9=True:C214)
	ORDER BY:C49([Profesores:4];[Profesores:4]Apellido_paterno:3;>)
	SELECTION TO ARRAY:C260([Profesores:4]Apellidos_y_nombres:28;at_Profesores_Nombres;[Profesores:4]Numero:1;al_Profesores_ID)
	
	  //$pID:=IT_UThermometer (1;0;__ ("Actualizando el nombre de la asignatura…"))
	  //EV2_RegistrosDeLaAsignatura ([Asignaturas]Numero)
	  //ARRAY TEXT($aText1;Records in selection([Alumnos_Calificaciones]))
	  //AT_Populate (->$aText1;->[Asignaturas]Asignatura)
	  //KRL_Array2Selection (->$aText1;->[Alumnos_Calificaciones]NombreOficialAsignatura)
	
	  //IT_UThermometer (-2;$pID)
	AS_AsignaNumeroOrdenamiento 
	
	KRL_ReloadInReadWriteMode (->[Asignaturas:18])
	If (([Asignaturas:18]Asignatura:3#"") & ([Asignaturas:18]Curso:5#"") & (USR_checkRights ("M";->[Asignaturas:18])))
		_O_ENABLE BUTTON:C192(b_inscribir)
	Else 
		_O_DISABLE BUTTON:C193(b_Inscribir)
	End if 
	POST KEY:C465(9;0)
End if 
