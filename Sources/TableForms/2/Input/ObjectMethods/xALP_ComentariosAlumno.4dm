ARRAY LONGINT:C221($aLines;0)
$page:=Selected list items:C379(hlTab_STR_alumnosComentarios)


Case of 
	: ($page=1)  //mono 148569 
		Case of 
			: (alProEvt=1)
				$isAut:=((<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
				If (($isAut) & (Not:C34(<>vb_BloquearModifSituacionFinal)))
					$line:=AL_GetLine (xALP_ComentariosAlumno)
					$col:=AL_GetColumn (xALP_ComentariosAlumno)
					If (($col=2) & ($line>=1))
						
						$obs:=ST_TextArea (aPJObs{$line};"Observaciones del Profesor "+aObsPJTerm{$line})
						aPJObs{$line}:=$obs
						If (Size of array:C274(aObsPJTerm)=$line)
							$fieldPointer:=->[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
						Else 
							$fieldPointer:=KRL_GetFieldPointerByName ("[Alumnos_SintesisAnual]P0"+String:C10($line)+"_Observaciones_Academicas")
						End if 
						$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
						AL_EscribeSintesisAnual ($key;$fieldPointer;->$obs;True:C214)
						AL_UpdateArrays (xALP_ComentariosAlumno;-1)
					End if 
				End if 
		End case 
		
	: ($page=3)
		Case of 
			: (alProEvt=1)
				$line:=AL_GetLine (xALP_ComentariosAlumno)
				GOTO SELECTED RECORD:C245([Cursos_Eventos:128];$line)
			: (alProEvt=2)
				If ((USR_checkRights ("M";->[Cursos_Eventos:128])) | (USR_checkRights ("L";->[Cursos_Eventos:128])) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
					$line:=AL_GetLine (xALP_ComentariosAlumno)
					GOTO SELECTED RECORD:C245([Cursos_Eventos:128];$line)
					WDW_OpenFormWindow (->[Cursos_Eventos:128];"Input";-1;5)
					SET WINDOW TITLE:C213(__ ("Detalle de Evento para ")+[Alumnos:2]curso:20+__ (", año ")+String:C10(Year of:C25([Cursos_Eventos:128]Fecha_Observación:2)))
					KRL_ModifyRecord (->[Cursos_Eventos:128];"Input")
					CLOSE WINDOW:C154
					READ ONLY:C145([Alumnos:2])
					CREATE SET:C116([Alumnos:2];"AlumnoActual")
					QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Alumnos:2]curso:20)
					CU_LoadEventosCurso (<>gYear;[Cursos:3]Numero_del_curso:6;xALP_ComentariosAlumno)
					USE SET:C118("AlumnoActual")
					CLEAR SET:C117("AlumnoActual")
				Else 
					BEEP:C151
				End if 
		End case 
End case 
  //REDRAW WINDOW