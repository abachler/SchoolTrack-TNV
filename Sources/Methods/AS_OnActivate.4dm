//%attributes = {}
  // MÉTODO: AS_OnActivate
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 06/04/12, 15:40:01
  // ----------------------------------------------------
  // DESCRIPCIÓN
  //
  //
  // PARÁMETROS
  // AS_OnActivate()
  // ----------------------------------------------------
C_LONGINT:C283($l_modoRegistroAsistencia)

ARRAY LONGINT:C221($al_SelectedLines;0)




  // CODIGO PRINCIPAL
If (Record number:C243([Asignaturas:18])=-3)
	SET WINDOW TITLE:C213(__ ("Nueva asignatura"))
Else 
	RELATE ONE:C42([Asignaturas:18]profesor_numero:4)
	SET WINDOW TITLE:C213(__ ("Asignaturas: ")+[Asignaturas:18]denominacion_interna:16+", "+[Asignaturas:18]Curso:5+", "+[Profesores:4]Nombre_comun:21)
End if 

OBJECT SET VISIBLE:C603(bBWR_CloseRecord;False:C215)
OBJECT SET VISIBLE:C603(bBWR_SaveRecord;True:C214)
OBJECT SET VISIBLE:C603(bBWR_Cancel;True:C214)
Case of 
	: (vlSTR_PaginaFormAsignaturas=1)  // propiedades
		OBJECT SET VISIBLE:C603(*;"P01_img_edicionBloquada";False:C215)
		OBJECT SET ENTERABLE:C238(*;"P01@";True:C214)
		_O_ENABLE BUTTON:C192(*;"P01@")
		
		OBJECT SET VISIBLE:C603([Asignaturas:18]Ingresa_Esfuerzo:40;(cb_EvaluaEsfuerzo=1))
		OBJECT SET VISIBLE:C603([Asignaturas:18]Pondera_Esfuerzo:61;(([Asignaturas:18]Ingresa_Esfuerzo:40) & (AT_GetSumArray (->aFactorEsfuerzo)>0)))
		OBJECT SET VISIBLE:C603(*;"asig_creditos@";(<>viSTR_CreditoAsignatura=1))
		IT_SetVisible (Not:C34([Asignaturas:18]Asignatura_No_Oficial:71);->[Asignaturas:18]Incide_en_promedio:27;->[Asignaturas:18]Incluida_en_Actas:44;->[Asignaturas:18]Eximible:28;->[Asignaturas:18]Es_Optativa:70;->[Asignaturas:18]CHILE_CodigoMineduc:41)
		
		
		  //If ((Not(Read only state([Asignaturas]))) | (Is new record([Asignaturas])))
		  // 20120514 ASM Se realiza modificación porque se producía un problema  en la validación. Siempre se bloqueaban los botones de nivel y curso.
		If ((Not:C34(Read only state:C362([Asignaturas:18]))) | (vbBWR_IsNewRecord))
			AL_GetSelect (xALP_StdList;$al_SelectedLines)
			$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Asignaturas:18]Numero_del_Nivel:6;->[xxSTR_Niveles:6]AttendanceMode:3)
			IT_SetEnterable (USR_checkRights ("M";->[Asignaturas:18]) & (($modoRegistroAsistencia=2) | ($modoRegistroAsistencia=4));0;->[Asignaturas:18]Incide_en_Asistencia:45)
			IT_SetButtonState (USR_checkRights ("M";->[Asignaturas:18]) & ([Asignaturas:18]Asignatura:3#"") & ([Asignaturas:18]Curso:5#"") & ([Asignaturas:18]Nivel:30#"");->aEvStyleName)
			IT_SetButtonState (USR_checkRights ("M";->[Asignaturas:18]) & ([Asignaturas:18]Asignatura:3#"") & ([Asignaturas:18]Curso:5#"") & (Size of array:C274($al_SelectedLines)>0);->b_Retirar)
			IT_SetButtonState (USR_checkRights ("M";->[Asignaturas:18]) & ([Asignaturas:18]Asignatura:3#"") & ([Asignaturas:18]Curso:5#"");->b_inscribir)
			IT_SetButtonState (USR_checkRights ("M";->[Asignaturas:18]) & ([Asignaturas:18]Asignatura:3#"") & ([Asignaturas:18]Curso:5#"") & ([Asignaturas:18]Eximible:28) & (Size of array:C274($al_SelectedLines)=1);->b_eximir)
			IT_SetEnterable ((AT_GetSumArray (->aFactorEsfuerzo)>0);0;->[Asignaturas:18]Pondera_Esfuerzo:61)
			OBJECT SET ENTERABLE:C238([Asignaturas:18]Pondera_Esfuerzo:61;(AT_GetSumArray (->aFactorEsfuerzo)>0))
			
			
			$b_promediosBasadosEnAprendizaje:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
			If ($b_promediosBasadosEnAprendizaje)
				vtEvalProperties:="Los resultados en calificaciones de esta asignatura son calculados sobre la base "+"de la evaluación de competencias.\rNo es posible registrar calificaciones parciale"+"s ni configurar propiedades de evaluación."
				OBJECT SET ENTERABLE:C238([Asignaturas:18]Resultado_no_calculado:47;False:C215)
				[Asignaturas:18]Ingresa_Esfuerzo:40:=False:C215
				[Asignaturas:18]Pondera_Esfuerzo:61:=False:C215
				OBJECT SET ENTERABLE:C238([Asignaturas:18]Ingresa_Esfuerzo:40;False:C215)
				OBJECT SET ENTERABLE:C238([Asignaturas:18]Pondera_Esfuerzo:61;False:C215)
			Else 
				OBJECT SET ENTERABLE:C238([Asignaturas:18]Resultado_no_calculado:47;True:C214)
			End if 
			IT_SetButtonStateByName ((Not:C34($b_promediosBasadosEnAprendizaje)) & (Not:C34([Asignaturas:18]Resultado_no_calculado:47));"P01_btn_PropiedadesAvanzadas")
			
			
		Else 
			OBJECT SET ENTERABLE:C238(*;"P01@";False:C215)
			_O_DISABLE BUTTON:C193(*;"P01@")
			OBJECT SET VISIBLE:C603(*;"P1_img_edicionBloquada";True:C214)
		End if 
		
		
		
	: ((vlSTR_PaginaFormAsignaturas=3) | (vlSTR_PaginaFormAsignaturas=4) | (vlSTR_PaginaFormAsignaturas=10) | (vlSTR_PaginaFormAsignaturas=11))
		OBJECT SET VISIBLE:C603(bBWR_CloseRecord;True:C214)
		OBJECT SET VISIBLE:C603(bBWR_SaveRecord;False:C215)
		OBJECT SET VISIBLE:C603(bBWR_Cancel;False:C215)
		$b_promediosBasadosEnAprendizaje:=KRL_GetBooleanFieldData (->[MPA_AsignaturasMatrices:189]ID_Matriz:1;->[Asignaturas:18]EVAPR_IdMatriz:91;->[MPA_AsignaturasMatrices:189]Convertir_a_Notas:9)
		IT_SetButtonStateByName ((Not:C34($b_promediosBasadosEnAprendizaje)) & (Not:C34([Asignaturas:18]Resultado_no_calculado:47));"P01_btn_PropiedadesAvanzadas")
		
		
		
	: (vlSTR_PaginaFormAsignaturas=6)
		IT_SetButtonState (USR_checkRights ("M";->[Asignaturas:18]) | USR_checkRights ("M";->[Alumnos_Calificaciones:208]) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (USR_checkRights ("M";->[Asignaturas_RegistroSesiones:168]));->bBWR_SaveRecord)
		
		
		
		
	: (vlSTR_PaginaFormAsignaturas=7)
		IT_SetButtonState (USR_checkRights ("M";->[Asignaturas:18]) | USR_checkRights ("M";->[Alumnos_Calificaciones:208]) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (USR_checkRights ("M";->[Asignaturas_PlanesDeClases:169]));->bBWR_SaveRecord)
		
		
		
		
		
		
	Else 
		IT_SetButtonState (USR_checkRights ("M";->[Asignaturas:18]) | USR_checkRights ("M";->[Alumnos_Calificaciones:208]) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | ((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33));->bBWR_SaveRecord)
End case 
MNU_SetMenuItemState ((USR_checkRights ("M";->[Asignaturas:18])) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4);1;5)


If (<>vb_BloquearModifSituacionFinal)
	OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";True:C214)
Else 
	OBJECT SET VISIBLE:C603(*;"bloqueoRegistro@";False:C215)
End if 

  //[Asignaturas]NotaOficial_conEstiloAsignatura:=Choose([Asignaturas]Incide_en_promedio | [Asignaturas]Incluida_en_Actas;[Asignaturas]NotaOficial_conEstiloAsignatura;True)
OBJECT SET ENABLED:C1123([Asignaturas:18]NotaOficial_conEstiloAsignatura:95;([Asignaturas:18]Incide_en_promedio:27 | [Asignaturas:18]Incluida_en_Actas:44))