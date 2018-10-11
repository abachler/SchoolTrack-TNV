AL_ExitCell (xALP_Aprendizajes)

$text:=Replace string:C233(vtSTR_PeriodosPopupMenu;"; ";";( ")+"(-;Evaluación Final"
$result:=Pop up menu:C542($text;0)

If ($result>0)
	If ($result<=Size of array:C274(atSTR_Periodos_Nombre))
		vt_periodo:=atSTR_Periodos_Nombre{$result}
		vl_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$result}
		vlSTR_PeriodoSeleccionado:=aiSTR_Periodos_Numero{$result}
		atSTR_Periodos_Nombre:=Find in array:C230(aiSTR_Periodos_Numero;vl_PeriodoSeleccionado)
		EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;aNtaIDAlumno{aNtaStdNme};[Asignaturas:18]EVAPR_IdMatriz:91)
		If (vl_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
			vb_AvisaSiCambioPeriodo:=True:C214
			OBJECT SET COLOR:C271(vt_periodo;-3)
		Else 
			OBJECT SET COLOR:C271(vt_periodo;-5)
		End if 
	Else 
		atSTR_Periodos_Nombre:=0
		vlSTR_PeriodoSeleccionado:=0
		vl_PeriodoSeleccionado:=-1
		vt_periodo:="Evaluación final"
		EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;aNtaIDAlumno{aNtaStdNme};[Asignaturas:18]EVAPR_IdMatriz:91)
		OBJECT SET COLOR:C271(vt_periodo;-5)
	End if 
	
End if 

If (vl_PeriodoSeleccionado>0)
	vlSTR_PeriodoSeleccionado:=vl_PeriodoSeleccionado
End if 

$isOpen:=((adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}>Current date:C33(*)) | (adSTR_Periodos_Cierre{atSTR_Periodos_Nombre}=!00-00-00!) | (USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0))
$entryAllowed:=((((<>viSTR_FirmantesAutorizados=1) & (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_firmante_numero:33)) | (<>lUSR_RelatedTableUserID=[Asignaturas:18]profesor_numero:4) | (USR_checkRights ("M";->[Alumnos_Calificaciones:208]))) & ($isOpen))

If (($entryAllowed) | ((USR_IsGroupMember_by_GrpID (-15001)) | (<>lUSR_CurrentUserID<0)))
	$enterableObs:=True:C214
Else 
	$enterableObs:=False:C215
End if 
If (<>vb_BloquearModifSituacionFinal)
	$enterableObs:=False:C215
End if 

OBJECT SET ENTERABLE:C238(*;"vtObservaciones";$enterableObs)
