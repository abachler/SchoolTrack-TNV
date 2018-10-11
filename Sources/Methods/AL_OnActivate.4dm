//%attributes = {}
  //AL_OnActivate


  //REGISTRO DE CAMBIOS
  //20080408 RCH Problema: Cuando un alumnos estaba retirado y se creaba un atraso, al guardar aparecía un mensaje erróneo.
  //Solución: En la página 2 cuando el alumno no tenga estado Activo, Oyente o En Trámite no se habilitará el botón para crear líneas ni para dejar al alumno condicional

READ ONLY:C145([Cursos:3])
RELATE ONE:C42([Alumnos:2]curso:20)

If (Record number:C243([Alumnos:2])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo alumno"))
Else 
	SET WINDOW TITLE:C213(__ ("Alumnos: ")+[Alumnos:2]apellidos_y_nombres:40+", "+[Alumnos:2]curso:20)
End if 

Case of 
	: (vlSTR_PaginaFormAlumnos=1)
		IT_SetButtonState (USR_checkRights ("M";->[Alumnos:2]);->bBWR_SaveRecord)
		MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos:2]);1;5)
	: (vlSTR_PaginaFormAlumnos=2)
		IT_SetButtonState ((USR_checkRights ("A";->[Alumnos_Conducta:8]) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36) & (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite")));->bBWR_SaveRecord;->bCondicional)
		IT_SetButtonState (((USR_checkRights ("A";->[Alumnos_Conducta:8]) | (<>tSTR_CursoProfesor_USR=[Alumnos:2]curso:20) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36) & (([Alumnos:2]Status:50="Activo") | ([Alumnos:2]Status:50="Oyente") | ([Alumnos:2]Status:50="En Trámite")) & (vl_Year=<>gYear)));->bAddLine)
		  //20130829 ASM ticket 124792
		  //$l_modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles]NoNivel;->[Alumnos]Nivel_Número;->[xxSTR_Niveles]AttendanceMode)
		  //If ($l_modoRegistroAsistencia=2)
		  //DISABLE BUTTON(bdelLine)
		  //DISABLE BUTTON(bAddLine)
		  //End if 
		MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_Conducta:8]);1;5;3;7;3;8;3;9;3;10;3;11;3;12;3;13)
	: (vlSTR_PaginaFormAlumnos=3)
		  //nothing    
	: (vlSTR_PaginaFormAlumnos=5)
		IT_SetButtonState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);->bBWR_SaveRecord)
		MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_FichaMedica:13]);1;5)
	: (vlSTR_PaginaFormAlumnos=6)
		IT_SetButtonState (USR_checkRights ("M";->[Alumnos_Orientacion:15]);->bBWR_SaveRecord)
		MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_Orientacion:15]);1;5)
	: (vlSTR_PaginaFormAlumnos=7)
		IT_SetButtonState (((USR_checkRights ("M";->[Alumnos_EventosPersonales:16])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36));->bBWR_SaveRecord)
		MNU_SetMenuItemState (((USR_checkRights ("M";->[Alumnos_EventosPersonales:16])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36));1;5)
	: (vlSTR_PaginaFormAlumnos=8)
		IT_SetButtonState (USR_checkRights ("M";->[Familia:78]);->bBWR_SaveRecord)
		MNU_SetMenuItemState (USR_checkRights ("M";->[Familia:78]);1;5)
	: (vlSTR_PaginaFormAlumnos=9)
		IT_SetButtonState (USR_checkRights ("M";->[Alumnos:2]);->bBWR_SaveRecord)
		MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos:2]);1;5)
	: (vlSTR_PaginaFormAlumnos=10)
		IT_SetButtonState (USR_checkRights ("M";->[Alumnos:2]);->bBWR_SaveRecord)
		MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos:2]);1;5)
End case 

$deleteable:=((vlSTR_PaginaFormAlumnos=1) & (Find in array:C230(alBWR_RecordNumber;Record number:C243([Alumnos:2]))>0) & (USR_checkRights ("D";->[Alumnos:2])))
IT_SetButtonState ($deleteable;->bBWR_Delete)
MNU_SetMenuItemState ($deleteable;2;18)

$con:=AL_GetLine (xALP_Connexions)
IT_SetButtonState (($con>0) & (USR_checkRights ("M";->[Alumnos:2]));->bDelConnexion)


If (<>vb_BloquearModifSituacionFinal)
	OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";False:C215)
End if 

