$ok:=CD_Dlog (0;__ ("¿Esta Ud. seguro de querer reestablecer el calendario por defecto para el año ")+String:C10(vl_Agno)+__ ("?");__ ("");__ ("Sí");__ ("No"))
If ($ok=1)
	DT_SetCalendar (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
	  //  `QUERY([xShell_Feriados];[xShell_Feriados]Fecha>=vdSTR_Periodos_InicioEjercicio;*)
	  //  `
	  //  `If (Current date>vdSTR_Periodos_FinEjercicio)
	  //  `QUERY([xShell_Feriados]; & [xShell_Feriados]Fecha<=vdSTR_Periodos_FinEjercicio)
	  //  `<>lXS_DiasHabiles_a_la_Fecha:=(vdSTR_Periodos_FinEjercicio-vdSTR_Periodos_InicioEjercicio)+1-Records in selection([xShell_Feriados])
	  //  `Else 
	  //  `QUERY([xShell_Feriados]; & [xShell_Feriados]Fecha<=Current date)
	  //  `<>lXS_DiasHabiles_a_la_Fecha:=(Current date-vdSTR_Periodos_InicioEjercicio)+1-Records in selection([xShell_Feriados])
	  //`End if 
End if 
CAL_FillMonth 