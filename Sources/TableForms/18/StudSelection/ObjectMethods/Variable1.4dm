  //Método de Objeto: aClsSel



Case of 
	: (Form event:C388=On Load:K2:1)
		_O_ARRAY STRING:C218(10;aClsSel;0)
		If ([Asignaturas:18]Seleccion:17)
			QUERY:C277([Cursos:3];[Cursos:3]Nivel_Numero:7=[Asignaturas:18]Numero_del_Nivel:6;*)
			QUERY:C277([Cursos:3]; & ;[Cursos:3]Numero_del_curso:6>0)  ////ABC /20180313//201139 
			SELECTION TO ARRAY:C260([Cursos:3]Curso:1;aClsSel)
			SORT ARRAY:C229(aClsSel;>)
		Else 
			_O_ARRAY STRING:C218(10;aClsSel;1)
			aClsSel{1}:=[Asignaturas:18]Curso:5
		End if 
		If (Size of array:C274(aClsSel)>0)
			aClsSel:=1
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=aClsSel{aClsSel})
			Case of 
				: ([Asignaturas:18]Seleccion_por_sexo:24=2)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
				: ([Asignaturas:18]Seleccion_por_sexo:24=3)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
			End case 
			If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
			End if 
		Else 
			REDUCE SELECTION:C351([Alumnos:2];0)
		End if 
		_O_ARRAY STRING:C218(1;aSel;0)
		_O_ARRAY STRING:C218(1;aSel;Records in selection:C76([Alumnos:2]))
		ARRAY TEXT:C222(aNombresAlumnos;0)
		ARRAY LONGINT:C221(aIDsAlumnos;0)
		SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aIDsAlumnos;[Alumnos:2]apellidos_y_nombres:40;aNombresAlumnos)
		EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
		SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aIDsAlumnosInscritos)
		For ($i;Size of array:C274(aIDsAlumnos);1;-1)
			If (Find in array:C230($aIDsAlumnosInscritos;aIDsAlumnos{$i})>0)
				AT_Delete ($i;1;->aIDsAlumnos;->aNombresAlumnos)
			End if 
		End for 
		
		
		$err:=AL_SetArraysNam (xALP_List;1;2;"aNombresAlumnos";"aIDsAlumnos")
		AL_SetMiscOpts (xALP_List;1;0;"'";0)
		AL_SetStyle (xALP_List;1;"Tahoma";9;0)
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
	: (Form event:C388=On Clicked:K2:4)
		
		
		If (aClsSel>0)
			_O_DISABLE BUTTON:C193(bInscribe)
			lastSel:=1
			QUERY:C277([Alumnos:2];[Alumnos:2]curso:20=aClsSel{aClsSel})
			Case of 
				: ([Asignaturas:18]Seleccion_por_sexo:24=2)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="F")
				: ([Asignaturas:18]Seleccion_por_sexo:24=3)
					QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]Sexo:49="M")
			End case 
			If (Not:C34(Macintosh option down:C545 | Windows Alt down:C563))
				QUERY SELECTION:C341([Alumnos:2];[Alumnos:2]ocultoEnNominas:89=False:C215)
			End if 
			_O_ARRAY STRING:C218(1;aSel;0)
			_O_ARRAY STRING:C218(1;aSel;Records in selection:C76([Alumnos:2]))
			
			ARRAY TEXT:C222(aNombresAlumnos;0)
			ARRAY LONGINT:C221(aIDsAlumnos;0)
			SELECTION TO ARRAY:C260([Alumnos:2]numero:1;aIDsAlumnos;[Alumnos:2]apellidos_y_nombres:40;aNombresAlumnos)
			EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
			SELECTION TO ARRAY:C260([Alumnos_Calificaciones:208]ID_Alumno:6;$aIDsAlumnosInscritos)
			For ($i;Size of array:C274(aIDsAlumnos);1;-1)
				If (Find in array:C230($aIDsAlumnosInscritos;aIDsAlumnos{$i})>0)
					AT_Delete ($i;1;->aIDsAlumnos;->aNombresAlumnos)
				End if 
			End for 
			
			
			AL_UpdateArrays (xALP_List;Size of array:C274(aNombresAlumnos))
			AL_SetSort (xALP_List;1)
			ARRAY INTEGER:C220(aSelect;0)
			AL_SetSelect (xALP_List;aSelect)
		Else 
			aClsSel:=lastsel
		End if 
End case 