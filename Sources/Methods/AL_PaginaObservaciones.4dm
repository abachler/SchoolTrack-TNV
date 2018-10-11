//%attributes = {}
  // MÉTODO: AL_PaginaObservaciones
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 10:05:31
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AL_PaginaObservaciones
  // ----------------------------------------------------
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_edicionAutorizada)
C_LONGINT:C283($i;$l_area;$l_margenFilas;$l_numeroDeFilas;$l_recNumSintesisAnual)
C_TEXT:C284($t_llaveSintesisAnual)

If (False:C215)
	C_LONGINT:C283(AL_PaginaObservaciones ;$0)
	C_LONGINT:C283(AL_PaginaObservaciones ;$1)
End if 




  // CODIGO PRINCIPAL
AL_CargaEventosPersonales 
ALP_RemoveAllArrays (xALP_ComentariosAlumno)

If (Count parameters:C259=1)
	$l_area:=$1
Else 
	$l_area:=1
End if 

Case of 
	: ($l_area=1)
		LOAD RECORD:C52([Alumnos:2])
		PERIODOS_LoadData ([Alumnos:2]nivel_numero:29)
		
		ARRAY TEXT:C222(aObsPJTerm;0)
		For ($i;1;Size of array:C274(atSTR_Periodos_Nombre))
			APPEND TO ARRAY:C911(aObsPJTerm;atSTR_Periodos_Nombre{$i})
		End for 
		APPEND TO ARRAY:C911(aObsPJTerm;"Finales")
		ARRAY TEXT:C222(aPJobs;Size of array:C274(aObsPJTerm))
		
		$t_llaveSintesisAnual:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10([Alumnos:2]nivel_numero:29)+"."+String:C10([Alumnos:2]numero:1)
		$l_recNumSintesisAnual:=KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$t_llaveSintesisAnual;False:C215)
		If ($l_recNumSintesisAnual>=0)
			Case of 
				: (Size of array:C274(aPJObs)=2)
					aPJObs{1}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					aPJObs{2}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
					$l_numeroDeFilas:=3
					$l_margenFilas:=8
				: (Size of array:C274(aPJObs)=3)
					aPJObs{1}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					aPJObs{2}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					aPJObs{3}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
					$l_numeroDeFilas:=4
					$l_margenFilas:=9
				: (Size of array:C274(aPJObs)=4)
					aPJObs{1}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					aPJObs{2}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					aPJObs{3}:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
					aPJObs{4}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
					$l_numeroDeFilas:=3
					$l_margenFilas:=8
				: (Size of array:C274(aPJObs)=5)
					aPJObs{1}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					aPJObs{2}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					aPJObs{3}:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
					aPJObs{4}:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
					aPJObs{5}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
					$l_numeroDeFilas:=3
					$l_margenFilas:=8
				: (Size of array:C274(aPJObs)=6)
					aPJObs{1}:=[Alumnos_SintesisAnual:210]P01_Observaciones_Academicas:114
					aPJObs{2}:=[Alumnos_SintesisAnual:210]P02_Observaciones_Academicas:143
					aPJObs{3}:=[Alumnos_SintesisAnual:210]P03_Observaciones_Academicas:172
					aPJObs{4}:=[Alumnos_SintesisAnual:210]P04_Observaciones_Academicas:201
					aPJObs{5}:=[Alumnos_SintesisAnual:210]P05_Observaciones_Academicas:230
					aPJObs{6}:=[Alumnos_SintesisAnual:210]Observaciones_Academicas:47
					$l_numeroDeFilas:=3
					$l_margenFilas:=8
			End case 
		Else 
			  //CD_Dlog (0;__ ("No fue posible leer las observaciones generales del alumno."))
		End if 
		
		xALSet_Al_AreasObservaciones (1)
		ALP_SetDefaultAppareance (xALP_ComentariosAlumno;9;$l_numeroDeFilas;$l_margenFilas)
		AL_UpdateArrays (xALP_ComentariosAlumno;Size of array:C274(aObsPJTerm))
		AL_SetLine (xALP_ComentariosAlumno;0)
		SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_alumnosComentarios;1)
		
		
	: ($l_area=2)
		EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
		SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
		Case of 
			: (Size of array:C274(atSTR_Periodos_Nombre)=5)
				SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;aObsFinales;[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;aObsP1;[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;aObsP2;[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29;aObsP3;[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34;aObsP4;[Alumnos_ComplementoEvaluacion:209]P05_Obs_Academicas:39;aObsP5;[Asignaturas:18]Asignatura:3;aAsignatura)
			: (Size of array:C274(atSTR_Periodos_Nombre)=4)
				SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;aObsFinales;[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;aObsP1;[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;aObsP2;[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29;aObsP3;[Alumnos_ComplementoEvaluacion:209]P04_Obs_Academicas:34;aObsP4;[Asignaturas:18]Asignatura:3;aAsignatura)
			: (Size of array:C274(atSTR_Periodos_Nombre)=3)
				SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;aObsFinales;[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;aObsP1;[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;aObsP2;[Alumnos_ComplementoEvaluacion:209]P03_Obs_Academicas:29;aObsP3;[Asignaturas:18]Asignatura:3;aAsignatura)
			: (Size of array:C274(atSTR_Periodos_Nombre)=2)
				SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;aObsFinales;[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;aObsP1;[Alumnos_ComplementoEvaluacion:209]P02_Obs_Academicas:24;aObsP2;[Asignaturas:18]Asignatura:3;aAsignatura)
			: (Size of array:C274(atSTR_Periodos_Nombre)=1)
				SELECTION TO ARRAY:C260([Alumnos_ComplementoEvaluacion:209]Final_ObservacionesAcademicas:46;aObsFinales;[Alumnos_ComplementoEvaluacion:209]P01_Obs_Academicas:19;aObsP1;[Asignaturas:18]Asignatura:3;aAsignatura)
		End case 
		SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)
		
		xALSet_Al_AreasObservaciones (2)
		ALP_SetDefaultAppareance (xALP_ComentariosAlumno;9;3)
		AL_UpdateArrays (xALP_ComentariosAlumno;-2)
		AL_SetLine (xALP_ComentariosAlumno;0)
		SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_alumnosComentarios;2)
End case 

$b_edicionAutorizada:=((<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
IT_SetButtonState (USR_checkRights ("M";->[Alumnos_EventosPersonales:16]) | $b_edicionAutorizada;->bBWR_SaveRecord)
MNU_SetMenuItemState (USR_checkRights ("M";->[Alumnos_EventosPersonales:16]) | $b_edicionAutorizada;1;5)

$0:=1

