//%attributes = {}
  // CU_OnRecordLoad()
  // Por: Alberto Bachler K.: 28-02-14, 16:55:14
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)

C_BOOLEAN:C305($b_usuarioAutorizado)
C_LONGINT:C283($l_paginaCursos)


If (False:C215)
	C_LONGINT:C283(CU_OnRecordLoad ;$1)
End if 

C_LONGINT:C283(vlSTR_PaginaFormCursos)


$l_paginaCursos:=vlSTR_PaginaFormCursos
If (Count parameters:C259=1)
	$l_paginaCursos:=$1
End if 

If ((Record number:C243([Cursos:3])=-3) | ($l_paginaCursos=0))
	$l_paginaCursos:=1
End if 


READ ONLY:C145([Profesores:4])
RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)
C_LONGINT:C283(viBWR_RecordWasSaved)
ALP_RemoveAllArrays (xALP_StdList)
ALP_RemoveAllArrays (xALP_Delegados)
ALP_RemoveAllArrays (xALP_Asignaturas)
ALP_RemoveAllArrays (xALP_Notas)
ALP_RemoveAllArrays (xALP_EvaluacionPersonal)
ALP_RemoveAllArrays (xALP_EventosCurso)
REDUCE SELECTION:C351([Alumnos:2];0)
REDUCE SELECTION:C351([Profesores:4];0)

If ((Form event:C388#On Load:K2:1) & (Form event:C388#On Activate:K2:9))
	Case of 
		: (vlSTR_PaginaFormCursos=1)
			viBWR_RecordWasSaved:=CU_fSave 
			
		: (vlSTR_PaginaFormCursos=2)
			viBWR_RecordWasSaved:=CU_fSaveCdta 
			
		: (vlSTR_PaginaFormCursos=3)
			viBWR_RecordWasSaved:=CU_fSaveEvVal 
			
		: (vlSTR_PaginaFormCursos=7)
			If ([Cursos:3]ActaEspecificaAlCurso:35)
				vi_PrintCodes:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.imprimirAbreviaturas"))->
				vi_UppercaseNames:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.apellidosEnAltas"))->
				vi_EtiquetasEnAltas:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.etiquetasEnAltas"))->
				vi_FirmaDirectorNivel:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorNivel"))->
				vi_FirmaDirectorColegio:=(OBJECT Get pointer:C1124(Object named:K67:5;"acta.firmaDirectorColegio"))->
				ACTAS_GuardaConfiguracion ([Cursos:3]Nivel_Numero:7;[Cursos:3]Curso:1)
			End if 
			
		: (vlSTR_PaginaFormCursos=6)
			
			
		: (vlSTR_PaginaFormCursos=8)
			
	End case 
Else 
	viBWR_RecordWasSaved:=0
End if 
RELATE ONE:C42([Cursos:3]Numero_del_profesor_jefe:2)


CU_CiclosEscolares 
PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)

  //desactivación de todos lo objetos (botones, listas, popups, campos y variable ingresables etc)
BWR_DisableAllObjects 

Case of 
	: ($l_paginaCursos=1)
		If ((USR_checkRights ("L";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
			CU_pgDefinition 
		Else 
			CANCEL:C270
		End if 
	: ($l_paginaCursos=2)
		If ((USR_checkRights ("L";->[Alumnos_Conducta:8])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
			CU_PgConducta 
		Else 
			BEEP:C151
			CU_OnRecordLoad (1)
		End if 
	: ($l_paginaCursos=3)
		If ((USR_checkRights ("L";->[Alumnos_EvaluacionValorica:23])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
			CU_PgEvValores (viSTR_PeriodoActual_Numero)
		Else 
			BEEP:C151
			CU_OnRecordLoad (1)
		End if 
	: ($l_paginaCursos=4)  //eventos curso
		If ((USR_checkRights ("L";->[Cursos_Eventos:128])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))  //RCH
			CU_LoadEventosCurso (vl_Year;[Cursos:3]Numero_del_curso:6;xALP_EventosCurso)
			FORM GOTO PAGE:C247(4)
			IT_SetButtonState (USR_checkRights ("M";->[Cursos_Eventos:128]);->bBWR_SaveRecord)
			MNU_SetMenuItemState (USR_checkRights ("M";->[Cursos_Eventos:128]);1;5)
		Else 
			BEEP:C151
			CU_OnRecordLoad (1)
		End if 
	: ($l_paginaCursos=5)
		  //debe tener permiso lectura para ingresar a la pestaña 188553 ABC 08/09/2017
		If ((USR_checkRights ("L";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
			CU_Calendario 
		Else 
			BEEP:C151
			CU_OnRecordLoad (1)
		End if 
	: ($l_paginaCursos=6)
		If ((USR_checkRights ("M";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
			CU_PgSituacion 
		Else 
			BEEP:C151
			CU_OnRecordLoad (1)
		End if 
		
	: ($l_paginaCursos=7)
		If ((USR_checkRights ("M";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
			CU_PgActas 
		Else 
			BEEP:C151
			CU_OnRecordLoad (1)
		End if 
		
	: ($l_paginaCursos=8)
		If ((USR_checkRights ("M";->[Cursos:3])) | (<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2))
			CU_Firmas_ActivarPagina 
		Else 
			BEEP:C151
			CU_OnRecordLoad (1)
		End if 
End case 

BWR_EnableSpecificObjects (->hlTab_STR_cursos)  //se restablece el atributo "cliqueable" del objeto pestaña que permite el cambio de página
$b_usuarioAutorizado:=((<>lUSR_RelatedTableUserID=[Cursos:3]Numero_del_profesor_jefe:2) | (<>lUSR_CurrentUserID<0) | (USR_IsGroupMember_by_GrpID (-15001)))
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;1;(USR_checkRights ("L";->[Cursos:3]) | ($b_usuarioAutorizado));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;2;(USR_checkRights ("L";->[Alumnos_Conducta:8]) | ($b_usuarioAutorizado));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;3;(USR_checkRights ("L";->[Alumnos_EvaluacionValorica:23]) | ($b_usuarioAutorizado));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;4;(USR_checkRights ("M";->[Cursos_Eventos:128]) | ($b_usuarioAutorizado));1;0)  //RCH
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;5;(USR_checkRights ("L";->[Cursos:3]) | ($b_usuarioAutorizado));1;0)  //pestaña de consultas debe tener Lectura par ingresar 188553ABC 07/09/2017
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;6;(USR_checkRights ("M";->[Cursos:3]) | ($b_usuarioAutorizado));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;7;(USR_checkRights ("M";->[Cursos:3]) | ($b_usuarioAutorizado));1;0)
SET LIST ITEM PROPERTIES:C386(hlTab_STR_cursos;8;(USR_checkRights ("M";->[Cursos:3]) | ($b_usuarioAutorizado));1;0)
SELECT LIST ITEMS BY POSITION:C381(hlTab_STR_cursos;$l_paginaCursos)
_O_REDRAW LIST:C382(hlTab_STR_cursos)

vlSTR_PaginaFormCursos:=$l_paginaCursos


If (USR_IsGroupMember_by_GrpID (-15001))
	OBJECT SET VISIBLE:C603(bLock2Admin;False:C215)
Else 
	OBJECT SET VISIBLE:C603(bLock2Admin;True:C214)
End if 

If (Record number:C243([Cursos:3])=-3)
	SET WINDOW TITLE:C213(__ ("Nuevo curso"))
Else 
	SET WINDOW TITLE:C213(__ ("Cursos: ")+[Cursos:3]Nivel_Nombre:10+", "+[Cursos:3]Curso:1+", "+[Profesores:4]Nombre_comun:21)
End if 