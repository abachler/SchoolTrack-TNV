//%attributes = {}
  //AS_PaginaEvaluacion


C_LONGINT:C283(xALP_ASNotas)
C_LONGINT:C283(vlSTR_PeriodoSeleccionado)
C_LONGINT:C283($i;$rubOfst)
C_LONGINT:C283(crtPeriodo)
C_BOOLEAN:C305(modNotas)

READ ONLY:C145([Alumnos:2])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Profesores:4])



  //20150313 ASM Ticket 142353 
  //modNotas:=False
  //modSubEvals:=False

PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
EVS_ReadStyleData ([Asignaturas:18]Numero_de_EstiloEvaluacion:39)
If (vlSTR_PeriodoSeleccionado=0)
	vlSTR_PeriodoSeleccionado:=viSTR_PeriodoActual_Numero
End if 

If (Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)<0)
	vlSTR_PeriodoSeleccionado:=viSTR_PeriodoActual_Numero
End if 
atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vlSTR_PeriodoSeleccionado)
sPeriodo:=Replace string:C233(atSTR_Periodos_Nombre{atSTR_Periodos_Nombre};" ";"")
AS_PropEval_Lectura ("";vlSTR_PeriodoSeleccionado)


  //========

If ([Asignaturas:18]Numero_de_evaluaciones:38=0)
	[Asignaturas:18]Numero_de_evaluaciones:38:=12
End if 

vb_calificacionesEditables:=Not:C34(<>vb_BloquearModifSituacionFinal)
vb_calificacionesEditables:=vb_calificacionesEditables & (((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208])))
vb_calificacionesEditables:=vb_calificacionesEditables & ((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!))
vb_calificacionesEditables:=vb_calificacionesEditables | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))

  //modNotas:=False
  //modSubEvals:=False

sP1:=String:C10([Asignaturas:18]Promedio_P1:23)
sP2:=String:C10([Asignaturas:18]Promedio_P2:22)
sP3:=String:C10([Asignaturas:18]Promedio_P3:21)
sP4:=String:C10([Asignaturas:18]Promedio_P4:59)
sPF:=String:C10([Asignaturas:18]Promedio_final:20)
sEX:=String:C10([Asignaturas:18]Examen:19)
sNF:=String:C10([Asignaturas:18]Nota_final:18)

vi_lastGradeView:=iViewMode


EV2_InitArrays 
PERIODOS_LoadData ([Asignaturas:18]Numero_del_Nivel:6)
  //AS_LeeOpcionesExamenes 
EV2_Examenes_LeeConfigExamenes (vlSTR_PeriodoSeleccionado)

EV2_RegistrosDeLaAsignatura ([Asignaturas:18]Numero:1)
ORDER BY:C49([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Alumno:6;>)
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)

AS_ListboxCalificaciones (vlSTR_PeriodoSeleccionado)


OBJECT SET TITLE:C194(*;"seleccionPeriodo";sPeriodo)
If (vlSTR_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
	vb_AvisaSiCambioPeriodo:=True:C214
	OBJECT SET COLOR:C271(*;"seleccionPeriodo";-Grey:K11:15)
Else 
	OBJECT SET COLOR:C271(*;"seleccionPeriodo";-Black:K11:16)
	vb_AvisaSiCambioPeriodo:=False:C215
End if 




OBJECT SET ENABLED:C1123(atSTR_Periodos_Nombre;True:C214)  // reactivación de lista desplegavble de períodos si se había pasado a los logros c  `on menú períodos deshabilitado.
  //AS_SetNotasMenuBar 
FORM GOTO PAGE:C247(12)
