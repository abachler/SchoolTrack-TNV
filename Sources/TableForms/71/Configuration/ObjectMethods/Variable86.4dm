
Case of 
	: (Self:C308-><38)
		CAL_SetDayStatus (Self:C308->)
		$firstDay:=DT_GetDateFromDayMonthYear (1;<>atXS_MonthNames;vl_Agno)
		$lastDay:=DT_EndOfMonth ($firstDay)
		<>lXS_DiasHabiles_en_el_Mes:=DT_GetWorkingDays ($firstDay;$lastDay)
		<>lXS_DiasHabiles_a_la_Fecha:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;Current date:C33(*))
		<>lXS_DiasHabiles_Agno:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
	Else 
		vdSTR_CurrentDate:=Current date:C33(*)
		vl_Agno:=Year of:C25(vdSTR_CurrentDate)
		<>atXS_MonthNames:=Month of:C24(vdSTR_CurrentDate)
End case 
CAL_FillMonth 
Self:C308->:=0
