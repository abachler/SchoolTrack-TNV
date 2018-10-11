
Case of 
	: (Self:C308-><38)
		CAL_SetDayStatus (Self:C308->;False:C215)
		$firstDay:=DT_GetDateFromDayMonthYear (1;<>atXS_MonthNames;vl_Agno)
		$lastDay:=DT_EndOfMonth ($firstDay)
		viSTR_Periodos_DiasMes:=DT_GetWorkingDays ($firstDay;$lastDay)
		If (Current date:C33(*)>=vdSTR_Periodos_InicioEjercicio)
			If (Current date:C33(*)<vdSTR_Periodos_FinEjercicio)
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
			Else 
				viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
			End if 
		End if 
		viSTR_Periodos_DiasAgno:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
		For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
			aiSTR_Periodos_Dias{$i}:=DT_GetWorkingDays (adSTR_Periodos_Desde{$i};adSTR_Periodos_hasta{$i})
		End for 
		  //AL_UpdateArrays (xALP_Periodos;-2)
	Else 
		vdSTR_CurrentDate:=Current date:C33(*)
		vl_Agno:=Year of:C25(vdSTR_CurrentDate)
		<>atXS_MonthNames:=Month of:C24(vdSTR_CurrentDate)
End case 
CAL_FillMonth 
Self:C308->:=0
