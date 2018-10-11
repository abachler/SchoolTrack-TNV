  //Método de Objeto: bpopupPeriodos



AL_ExitCell (xALP_Aprendizajes)

$text:=Replace string:C233(vtSTR_PeriodosPopupMenu;"; ";";( ")
$result:=Pop up menu:C542($text;0)


If ($result<=Size of array:C274(atSTR_Periodos_Nombre))
	$periodo:=aiSTR_Periodos_Numero{$result}
	atSTR_Periodos_Nombre:=$result
	vt_periodo:=Replace string:C233(atSTR_Periodos_Nombre{$result};" ";"")
	vlSTR_PeriodoSeleccionado:=$periodo
	vl_PeriodoSeleccionado:=$periodo
	If (vl_PeriodoSeleccionado#viSTR_PeriodoActual_Numero)
		  //vb_AvisaSiCambioPeriodo:=True
		OBJECT SET COLOR:C271(vt_periodo;-3)
	Else 
		OBJECT SET COLOR:C271(vt_periodo;-5)
	End if 
Else 
	vt_periodo:="Evaluación Final"
	vl_PeriodoSeleccionado:=-1
	atSTR_Periodos_Nombre:=0
	vlSTR_PeriodoSeleccionado:=0
	OBJECT SET COLOR:C271(vt_periodo;-5)
End if 
EVLG_LeeAprendizajesAlumno (xALP_Aprendizajes;aNtaIDAlumno{aNtaStdNme};[Asignaturas:18]EVAPR_IdMatriz:91)
