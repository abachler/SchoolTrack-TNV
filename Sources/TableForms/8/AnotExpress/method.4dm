  // [Alumnos_Conducta].AnotExpress()
  // Por: Alberto Bachler K.: 28-04-14, 19:42:37
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Spell_CheckSpelling 

Case of 
	: (Form event:C388=On Load:K2:1)
		COPY ARRAY:C226(<>atSTR_Anotaciones_motivo;aMotAnot)
		$err:=AL_SetArraysNam (xALP_Anot;1;10;"atSTRal_NombreAlumno";"adSTRal_FechaAnotacion";"atSTRal_NombreProfesorAnot";"atSTRal_MotivoAnotacion";"atSTRal_CategoriaAnotacion";"alSTRal_PuntosAnotacion";"atSTRal_TipoAnotacion";"alSTRal_NoProfesorAnot";"atSTRal_NotasAnotacion";"alSTRal_NumeroAlumno")
		AL_SetWidths (xALP_Anot;1;7;150;60;130;185;110;45;15)
		AL_SetFormat (xALP_Anot;6;"####")
		AL_SetFormat (xALP_Anot;7;"";2)
		ALP_SetDefaultAppareance (xALP_Anot;9)
		AL_SetRowOpts (xALP_Anot;1;1;1;0;0)
		AL_SetColOpts (xALP_Anot;0;0;0;3;0;0;0)
		AL_SetMiscOpts (xALP_Anot;1;0;"\\";0;3)
		AL_SetStyle (xALP_Anot;0;"Tahoma";9;0)
		
		
		(OBJECT Get pointer:C1124(Object named:K67:5;"idAlumno"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"curso"))->:=<>tSTR_CursoProfesor_USR
		(OBJECT Get pointer:C1124(Object named:K67:5;"fecha"))->:=Current date:C33(*)
		(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.alumno"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.motivo"))->:=""
		If (<>lUSR_RelatedTableUserID>0)
			(OBJECT Get pointer:C1124(Object named:K67:5;"idProfesor"))->:=<>lUSR_RelatedTableUserID
			(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.profesor"))->:=<>tUSR_CurrentUser
			(OBJECT Get pointer:C1124(Object named:K67:5;"curso"))->:=<>tSTR_CursoProfesor_USR
		End if 
		(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.observaciones"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"puntos.anotacion"))->:=0
		(OBJECT Get pointer:C1124(Object named:K67:5;"categoria.anotacion"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"tipo.anotacion"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.asignatura"))->:=""  //MONO Ticket 180570
		
		$el:=Find in array:C230(<>aCursos;(OBJECT Get pointer:C1124(Object named:K67:5;"curso"))->)
		If ($el>0)
			$nivelCurso:=<>aCUNivNo{$el}
			PERIODOS_LoadData ($nivelCurso)
			  //$r:=DateIsValid ((OBJECT Get pointer(Object named;"fecha.anotacion"))->;0)
			$r:=DateIsValid ((OBJECT Get pointer:C1124(Object named:K67:5;"fecha"))->;0)
			If (Not:C34($r))
				  //(OBJECT Get pointer(Object named;"fecha.anotacion"))->:=!00-00-0000!
				(OBJECT Get pointer:C1124(Object named:K67:5;"fecha"))->:=!00-00-00!
			End if 
		End if 
		
		ARRAY TEXT:C222(at_AsigSelProfe;0)
		  //MONO TICKET 203823
		$y_profesor:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.profesor")
		$y_idProfesor:=OBJECT Get pointer:C1124(Object named:K67:5;"idProfesor")
		$y_asignatura:=OBJECT Get pointer:C1124(Object named:K67:5;"anotacion.asignatura")
		
		QUERY:C277([Asignaturas:18];[Asignaturas:18]profesor_firmante_numero:33;=;$y_idProfesor->;*)
		QUERY:C277([Asignaturas:18]; | ;[Asignaturas:18]profesor_numero:4=$y_idProfesor->)
		AT_DistinctsFieldValues (->[Asignaturas:18]denominacion_interna:16;->at_AsigSelProfe)
		
		  //FORM GOTO PAGE(2)
		
	: (Form event:C388=On Unload:K2:2)
		SET_ClearSets ("$alumnosDelCurso")
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
		
End case 