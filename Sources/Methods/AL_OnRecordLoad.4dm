//%attributes = {}
  // MÉTODO: AL_OnRecordLoad
  // ----------------------------------------------------
  // Usuario (OS): Alberto Bachler
  // Fecha de creación: 28/12/11, 09:13:12
  // ----------------------------------------------------
  // DESCRIPCIÓN
  // Maneja la carga de registro [Alumnos] y los cambios de página en el formulario [Alumnos].Input
  //
  // PARÁMETROS
  // AL_OnRecordLoad()
  // ----------------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_edicionAutorizada;modNotas)
C_LONGINT:C283(vlSTR_PaginaFormAlumnos;$l_Pagina_a_activar;$l_RegistrosMetaReligion;$l_resultado)

If (False:C215)
	C_LONGINT:C283(AL_OnRecordLoad ;$1)
End if 

C_REAL:C285(vi_LineasPorFila)
vi_LineasPorFila:=3

  //C_BOOLEAN(campopropio)
  //campopropio:=False
  // Modificado por: Saul Ponce (29/01/2018) Ticket Nº 198268, para almacenar los cambios en los registros de campos propios
vb_guardarCambios:=False:C215

  // CODIGO PRINCIPAL
Case of 
	: (Count parameters:C259=1)
		$l_Pagina_a_activar:=$1
	: (Is new record:C668([Alumnos:2]))
		$l_Pagina_a_activar:=1
	: (vlSTR_PaginaFormAlumnos=0)
		$l_Pagina_a_activar:=1
	Else 
		$l_Pagina_a_activar:=vlSTR_PaginaFormAlumnos
End case 

C_LONGINT:C283(viBWR_RecordWasSaved;vlSTR_PeriodoSeleccionado)
If ((Form event:C388#On Load:K2:1) & (Form event:C388#On Activate:K2:9))
	  //update AllAreas
	AL_ExitCell (xALP_ConductaAlumnos)  //20180711 ASM Ticket 210358
	AL_UpdateArrays (xALP_ConductaAlumnos;0)
	ALP_RemoveAllArrays (xALP_Notas)
	ALP_RemoveAllArrays (xALP_HNotasECursos)
	AL_UpdateArrays (xALP_Aprendizajes)
	AL_UpdateFields (xALP_PsyEvents;2)
	AL_UpdateFields (xALP_PsyObs;2)
	AL_UpdateArrays (xALP_Interview;0)
	AL_UpdateArrays (xALP_ComentariosAlumno;0)  //53871
	AL_UpdateArrays (xALP_Familia;0)
	AL_UpdateArrays (xALP_FamUFields;0)
	AL_UpdateArrays (xALP_Enfermedades;0)
	AL_UpdateArrays (xALP_alergias;0)
	AL_UpdateArrays (xALP_Hospitalizaciones;0)
	AL_UpdateArrays (xALP_vacunas;0)
	AL_UpdateArrays (xALP_ControlesMedicos;0)
	AL_UpdateArrays (xALP_Aparatos;0)
	  //ALP_RemoveAllArrays (xALP_ConsultasEnfermeria)
	AL_UpdateArrays (xALP_EventosPostEgreso;0)
	
	  //AL_RemoveArrays (xALP_ConductaAlumnos;1;10)
	AL_RemoveArrays (xALP_ConductaAlumnos;1;20)
	AL_RemoveArrays (xALP_ActividadesAlumno;1;11)
	
	AL_SetScroll (xALP_ConductaAlumnos;0;0)
	AL_SetScroll (xALP_Notas;0;0)
	AL_SetScroll (xALP_PsyEvents;0;0)
	AL_SetScroll (xALP_PsyObs;0;0)
	AL_SetScroll (xALP_Interview;0;0)
	AL_SetScroll (xALP_ComentariosAlumno;0;0)  //53871
	AL_SetScroll (xALP_Familia;0;0)
	AL_SetScroll (xALP_Hermano;0;0)
	AL_SetScroll (xALP_FamUFields;0;0)
	AL_SetScroll (xALP_Enfermedades;0;0)
	AL_SetScroll (xALP_alergias;0;0)
	AL_SetScroll (xALP_Hospitalizaciones;0;0)
	AL_SetScroll (xALP_vacunas;0;0)
	AL_SetScroll (xALP_ControlesMedicos;0;0)
	AL_SetScroll (xALP_Aparatos;0;0)
	AL_SetScroll (xALP_ConsultasEnfermeria;0;0)
	AL_SetScroll (xALP_EventosPostEgreso;0;0)
	AL_SetScroll (xALP_ActividadesAlumno;0;0)
	AL_SetScroll (xALP_Aprendizajes;0;0)
	
	OBJECT SET VISIBLE:C603(xALP_ConductaAlumnos;False:C215)
	OBJECT SET VISIBLE:C603(xALP_Notas;False:C215)
	OBJECT SET VISIBLE:C603(xALP_PsyEvents;False:C215)
	OBJECT SET VISIBLE:C603(xALP_PsyObs;False:C215)
	OBJECT SET VISIBLE:C603(xALP_Interview;False:C215)
	OBJECT SET VISIBLE:C603(xALP_ComentariosAlumno;False:C215)  //53871
	OBJECT SET VISIBLE:C603(xALP_Familia;False:C215)
	OBJECT SET VISIBLE:C603(xALP_Hermano;False:C215)
	OBJECT SET VISIBLE:C603(xALP_FamUFields;False:C215)
	OBJECT SET VISIBLE:C603(xALP_Enfermedades;False:C215)
	OBJECT SET VISIBLE:C603(xALP_alergias;False:C215)
	OBJECT SET VISIBLE:C603(xALP_Hospitalizaciones;False:C215)
	OBJECT SET VISIBLE:C603(xALP_vacunas;False:C215)
	OBJECT SET VISIBLE:C603(xALP_ControlesMedicos;False:C215)
	OBJECT SET VISIBLE:C603(xALP_Aparatos;False:C215)
	OBJECT SET VISIBLE:C603(xALP_ConsultasEnfermeria;False:C215)
	OBJECT SET VISIBLE:C603(xALP_EventosPostEgreso;False:C215)
	OBJECT SET VISIBLE:C603(xALP_Aprendizajes;False:C215)
	
	viBWR_RecordWasSaved:=0
	EV2_RegistrosDelAlumno ([Alumnos:2]numero:1;[Alumnos:2]nivel_numero:29)
	Case of 
		: (vlSTR_PaginaFormAlumnos=1)
			viBWR_RecordWasSaved:=AL_fSave 
			If (viBWR_RecordWasSaved>=0)
				AT_Initialize (->aUFItmName;->aUFItmVal)
				AL_UpdateArrays (xALP_UFields;0)
				AL_UpdateArrays (xALP_Connexions;0)
				AL_SetScroll (xALP_UFields;0;0)
				OBJECT SET VISIBLE:C603(xALP_UFields;False:C215)
			Else 
				FORM GOTO PAGE:C247(vlSTR_PaginaFormAlumnos)
				SELECT LIST ITEMS BY REFERENCE:C630(hlTab_STR_alumnos;vlSTR_PaginaFormAlumnos)
				_O_REDRAW LIST:C382(hlTab_STR_alumnos)
			End if 
			
		: (vlSTR_PaginaFormAlumnos=2)
			AL_LeeSintesisConducta ([Alumnos:2]numero:1)
			OBJECT SET ENTERABLE:C238(vd_fechaCondicionalidad;(bCondicional=1))
			OBJECT SET ENTERABLE:C238(vt_motivoCondicionalidad;(bCondicional=1))
			
			viBWR_RecordWasSaved:=AL_fSaveCdta 
			AL_InitCdtaArr 
			
			
		: (vlSTR_PaginaFormAlumnos=4)
			AL_PostEdicionCompetencias 
			
			
		: (vlSTR_PaginaFormAlumnos=3)
			EV2_InitArrays 
			
		: (vlSTR_PaginaFormAlumnos=5)
			viBWR_RecordWasSaved:=AL_fSaveSalud 
			  //AT_Initialize (->aProblema;->aPblObs;->aDateCE;->aMotCons;->aCENo) 20140325 ASM. ticket 130900
			AT_Initialize (->aProblema;->aPblObs)
			
			
		: (vlSTR_PaginaFormAlumnos=6)
			REDUCE SELECTION:C351([Alumnos_ObsOrientacion:127];0)
			REDUCE SELECTION:C351([Alumnos_EventosOrientacion:21];0)
			
		: (vlSTR_PaginaFormAlumnos=7)
			viBWR_RecordWasSaved:=AL_fSave 
			AT_Initialize (->aIWDate;->alWEvento;->aIWMotivo;->aIWId;->aObsPJTerm;->aPJObs;->aAsignatura;->aObsP1;->aObsP2;->aObsP3;->aObsP4;->aObsF)
			AT_Initialize (->ad_FechaEvCurso;->at_CategoriaEvCurso;->at_TemaEvCurso)
			
		: (vlSTR_PaginaFormAlumnos=9)
			viBWR_RecordWasSaved:=KRL_SaveRecord (->[Familia:78])
			AT_Initialize (->aUFItmName;->aUFItmVal;->aParentesco;->aRelName;->aApoderado;->aTelDom;->aTelOF;->aPersID;->aBthrName;->aBthrCurso;->aBthrID)
			UFLD_LoadFileTplt (yBWR_currentTable)
			KRL_ReloadAsReadOnly (->[Familia:78])
			
		: (vlSTR_PaginaFormAlumnos=10)
			viBWR_RecordWasSaved:=KRL_SaveRecord (->[Alumnos_Historico:25])
			AT_Initialize (->aHAsig;->aHNota1;->aHnota2;->aHNota3;->aHNota4;->aHPF;->aHEX;->aHNF;->aHNfOficial;->aHOrder;->aHID)
			
		: (vlSTR_PaginaFormAlumnos=11)
			viBWR_RecordWasSaved:=KRL_SaveRecord (->[Alumnos_ResultadosEgreso:130])
			AT_Initialize (->ad_EventosEgreso_Fecha;->at_EventosEgreso_Tipo;->at_EventosEgreso_Tipo;->at_EventosEgreso_Carrera;->al_EventosEgreso_RecNum)
			
			iViewMode:=0
			
	End case 
End if 



SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;vlSTR_PaginaFormAlumnos;True:C214;0;0)

$b_edicionAutorizada:=((<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lSTR_IDTutor_USR=[Alumnos:2]Tutor_numero:36))
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;1;(USR_checkRights ("L";->[Alumnos:2]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;2;(USR_checkRights ("L";->[Alumnos_Conducta:8]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;3;(USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;4;(USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;5;(USR_checkRights ("L";->[Alumnos_FichaMedica:13]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;6;USR_checkRights ("L";->[Alumnos_Orientacion:15]);1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;7;(USR_checkRights ("L";->[Alumnos_EventosPersonales:16]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;8;(USR_checkRights ("L";->[Alumnos_Calificaciones:208]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;9;(USR_checkRights ("L";->[Familia:78]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;10;(USR_checkRights ("L";->[Alumnos:2]) | ($b_edicionAutorizada));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;11;(USR_checkRights ("L";->[Alumnos:2]) & (([Alumnos:2]nivel_numero:29=Nivel_Egresados) | ([Alumnos:2]nivel_numero:29=12)));1;0)
KRL_ReloadInReadWriteMode (->[Alumnos:2])  //JHB 30/5/2005 Al crear alumnos nuevos el registro quedaba cargado en READ ONLY impidiendo cambios adicionales

If (([Alumnos:2]nivel_numero:29<=Nivel_AdmisionDirecta) | ([Alumnos:2]nivel_numero:29=0))
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;2;False:C215;0;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;3;False:C215;0;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;4;False:C215;0;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;7;False:C215;0;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;8;False:C215;0;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;10;False:C215;0;0)
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;11;False:C215;0;0)
End if 


  //ASM 20151106 Verifico licencia condor de orientaciones para deshabilitar la pestaña.
  //
  // Modificado por: Alexis Bustamante (12-06-2017)
  //El Nodo de OrientacionySeguimiento en el JSON viene escrito Orientacion y Seguimiento.
  //agrego espacios en el nombre del modulo a verificar.


If ((LICENCIA_VerificaModCondorAct ("Orientacion y Seguimiento")) & (PREF_fGet (0;"OR_datosOrientacionExportados")="SI"))
	SET LIST ITEM PROPERTIES:C386(hlTab_STR_alumnos;6;False:C215;0;0)
End if 

  //ASM 20151106 si se exportaron los datos personales se lee la preferencia para quitar el botón de creación de eventos
  //en la pestaña Comentarios
$t_preOrientacion:=PREF_fGet (0;"OR_DatosPersonales")
If ($t_preOrientacion="SI")
	OBJECT SET VISIBLE:C603(bAddIW;False:C215)
End if 



If (viBWR_RecordWasSaved>=0)
	vlSTR_PaginaFormAlumnos:=$l_Pagina_a_activar
	Case of 
		: (vlSTR_PaginaFormAlumnos=1)
			OBJECT SET VISIBLE:C603(xALP_UFields;True:C214)
			$l_resultado:=AL_PaginaIdentificacion 
			
		: (vlSTR_PaginaFormAlumnos=2)
			OBJECT SET VISIBLE:C603(xALP_ConductaAlumnos;True:C214)
			$l_resultado:=AL_PaginaConducta_y_Asistencia 
			
		: (vlSTR_PaginaFormAlumnos=3)
			OBJECT SET VISIBLE:C603(xALP_Notas;True:C214)
			$l_resultado:=AL_PaginaCalificaciones 
			
		: (vlSTR_PaginaFormAlumnos=4)
			$l_resultado:=AL_PaginaAprendizajes 
			
		: (vlSTR_PaginaFormAlumnos=5)
			OBJECT SET VISIBLE:C603(xALP_Enfermedades;True:C214)
			OBJECT SET VISIBLE:C603(xALP_alergias;True:C214)
			OBJECT SET VISIBLE:C603(xALP_Hospitalizaciones;True:C214)
			OBJECT SET VISIBLE:C603(xALP_vacunas;True:C214)
			OBJECT SET VISIBLE:C603(xALP_ControlesMedicos;True:C214)
			OBJECT SET VISIBLE:C603(xALP_Aparatos;True:C214)
			OBJECT SET VISIBLE:C603(xALP_ConsultasEnfermeria;True:C214)
			$l_resultado:=AL_PaginaSalud 
			
		: (vlSTR_PaginaFormAlumnos=6)
			OBJECT SET VISIBLE:C603(xALP_PsyEvents;True:C214)
			OBJECT SET VISIBLE:C603(xALP_PsyObs;True:C214)
			$l_resultado:=AL_pgPsy 
			
		: (vlSTR_PaginaFormAlumnos=7)
			OBJECT SET VISIBLE:C603(xALP_Interview;True:C214)
			OBJECT SET VISIBLE:C603(xALP_ComentariosAlumno;True:C214)
			$l_resultado:=AL_PaginaObservaciones 
			
		: (vlSTR_PaginaFormAlumnos=8)
			$l_resultado:=AL_PaginaExtracurriculares 
			
			
		: (vlSTR_PaginaFormAlumnos=9)
			OBJECT SET VISIBLE:C603(xALP_Familia;True:C214)
			OBJECT SET VISIBLE:C603(xALP_Hermano;True:C214)
			OBJECT SET VISIBLE:C603(xALP_FamUFields;True:C214)
			$l_resultado:=AL_PageFamily 
			
			
		: (vlSTR_PaginaFormAlumnos=10)
			$l_resultado:=AL_pgHistorico 
			
		: (vlSTR_PaginaFormAlumnos=11)
			OBJECT SET VISIBLE:C603(xALP_EventosPostEgreso;True:C214)
			$l_resultado:=AL_PageEgreso 
			
	End case 
	
	If ($l_resultado=1)
		FORM GOTO PAGE:C247(vlSTR_PaginaFormAlumnos)
	Else 
		vlSTR_PaginaFormAlumnos:=1
		AL_OnRecordLoad (vlSTR_PaginaFormAlumnos)
	End if 
	
End if 
SELECT LIST ITEMS BY REFERENCE:C630(hlTab_STR_alumnos;vlSTR_PaginaFormAlumnos)


If (<>viSTR_ReligionExtendida=1)
	If ([Alumnos:2]Religion:9#"")
		SET QUERY DESTINATION:C396(Into variable:K19:4;$l_RegistrosMetaReligion)
		QUERY:C277([xxSTR_MetaReligionDef:165];[xxSTR_MetaReligionDef:165]Religion:2=[Alumnos:2]Religion:9)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		If ($l_RegistrosMetaReligion>0)
			OBJECT SET FONT STYLE:C166(*;"religion";Underline:K14:4)
			OBJECT SET COLOR:C271(*;"religion";-6)
			_O_ENABLE BUTTON:C192(bReligionExt)
		Else 
			OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
			OBJECT SET COLOR:C271(*;"religion";-15)
			_O_DISABLE BUTTON:C193(bReligionExt)
		End if 
	Else 
		OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
		OBJECT SET COLOR:C271(*;"religion";-15)
		_O_DISABLE BUTTON:C193(bReligionExt)
	End if 
Else 
	OBJECT SET FONT STYLE:C166(*;"religion";Plain:K14:1)
	OBJECT SET COLOR:C271(*;"religion";-15)
	_O_DISABLE BUTTON:C193(bReligionExt)
End if 

AL_OnActivate 