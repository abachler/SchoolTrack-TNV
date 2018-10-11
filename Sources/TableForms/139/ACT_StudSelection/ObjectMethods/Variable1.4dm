Case of 
	: (Form event:C388=On Load:K2:1)
		_O_ARRAY STRING:C218(10;aClsSel;0)
		ACTter_Datos_ALP ("DeclaraArraysAreaInscAlumnos")
		
		vt_nombre:=""
		READ ONLY:C145([Cursos:3])
		READ ONLY:C145([Alumnos:2])
		READ ONLY:C145([ACT_CuentasCorrientes:175])
		ALL RECORDS:C47([Cursos:3])
		ORDER BY:C49([Cursos:3];[Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1;>)
		SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aClsSel)
		
		If (Size of array:C274(aClsSel)>0)
			aClsSel:=1
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=aClsSel{aClsSel})
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
		End if 
		C_LONGINT:C283($Error)
		  //$err:=AL_SetArraysNam (xALP_List;1;3;"atACT_CCAlumno";"atACT_CCCurso";"aIDsAlumnos")
		  //AL_SetMiscOpts (xALP_List;1;0;"'";0)
		  //AL_SetStyle (xALP_List;1;"Tahoma";9;0)
		  //AL_SetSort (xALP_List;1)
		  //AL_SetSortOpts (xALP_List;1;0;0;"";0)
		  //AL_SetRowOpts (xALP_List;1;1;0;0;0)
		  //AL_SetColOpts (xALP_List;0;0;0;1;0;0;0)
		  //AL_SetScroll (xALP_List;0;-3)
		  //ARRAY INTEGER(aSelect;0)
		  //AL_SetSelect (xALP_List;aSelect)
		  //ALP_SetDefaultAppareance (xALP_List)
		  //AL_SetMiscOpts (xALP_List;1;0;"'";0)
		$error:=ALP_DefaultColSettings (xALP_List;1;"atACT_CCAlumno";"";200)
		$error:=ALP_DefaultColSettings (xALP_List;2;"atACT_CCCurso";"";67)
		$error:=ALP_DefaultColSettings (xALP_List;3;"aIDsAlumnos";"";0)
		
		  //general options
		ALP_SetDefaultAppareance (xALP_List;9;1;2;1)
		AL_SetMiscOpts (xALP_List;1;0;"'";0)
		AL_SetSort (xALP_List;1)
		AL_SetSortOpts (xALP_List;1;0;0;"";0)
		AL_SetRowOpts (xALP_List;1;1;0;0;0)
		AL_SetColOpts (xALP_List;0;0;0;1;0;0;0)
		AL_SetScroll (xALP_List;0;-3)
		ARRAY INTEGER:C220(aSelect;0)
		AL_SetSelect (xALP_List;aSelect)
		ALP_SetDefaultAppareance (xALP_List)
		AL_SetMiscOpts (xALP_List;1;0;"'";0)
		
		  //ALP_SetAlternateLigneColor (areaSel;Size of array(aNombresAlumnos))
		_O_DISABLE BUTTON:C193(bInscribe)
		lastSel:=1
		
		ACTter_ProcesaBusquedaCtas 
		
	: (Form event:C388=On Clicked:K2:4)
		
		
		If (aClsSel>0)
			lastSel:=1
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=aClsSel{aClsSel})
			ACTter_ProcesaBusquedaCtas 
		Else 
			aClsSel:=lastsel
		End if 
End case 