If (<>vb_BloquearModifSituacionFinal)
	CD_Dlog (0;__ ("Cualquier acción que afecte la situación académica de los alumnos ha sido bloqueada a contar del ")+String:C10(<>vd_FechaBloqueoSchoolTrack;5)+__ ("."))
Else 
	C_BOOLEAN:C305(vb_AsignaSituacionFinal)
	
	ARRAY LONGINT:C221($al_selectedLines;0)
	$l_error:=AL_GetSelect (xALP_StdList;$al_selectedLines)
	If ((Size of array:C274($al_selectedLines)=1) & ([Asignaturas:18]Eximible:28))
		
		If ([Asignaturas:18]Eximible:28#Old:C35([Asignaturas:18]Eximible:28))
			SAVE RECORD:C53([Asignaturas:18])
		End if 
		
		vb_AsignaSituacionFinal:=False:C215
		$studentID:=aNtaIdAlumno{$al_selectedLines{1}}
		$studentName:=aNtaStdNme{$al_selectedLines{1}}
		EV2_EximeAlumno ($studentID;[Asignaturas:18]Numero:1)
		
	End if 
	AS_LoadStudentList 
End if 
