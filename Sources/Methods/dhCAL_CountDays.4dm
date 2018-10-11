//%attributes = {}
  //dhCAL_CountDays

C_BOOLEAN:C305($trapped)

If (Current date:C33(*)<[xxSTR_Periodos:100]Inicio_Ejercicio:4)
	<>lXS_DiasHabiles_en_el_Mes:=0
Else 
	$firstDay:=DT_GetDateFromDayMonthYear (1;<>atXS_MonthNames;vl_Agno)
	$lastDay:=DT_EndOfMonth ($firstDay)
	<>lXS_DiasHabiles_en_el_Mes:=DT_GetWorkingDays ($firstDay;$lastDay;->adSTR_Calendario_Feriados)
	viSTR_Periodos_DiasMes:=DT_GetWorkingDays ($firstDay;$lastDay;->adSTR_Calendario_Feriados)
End if 

If (Current date:C33(*)<[xxSTR_Periodos:100]Inicio_Ejercicio:4)
	<>lXS_DiasHabiles_a_la_Fecha:=0
Else 
	<>lXS_DiasHabiles_a_la_Fecha:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;Current date:C33(*);->adSTR_Calendario_Feriados)
	viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;Current date:C33(*);->adSTR_Calendario_Feriados)
End if 


If (Current date:C33(*)<[xxSTR_Periodos:100]Inicio_Ejercicio:4)
	<>lXS_DiasHabiles_Agno:=0
Else 
	<>lXS_DiasHabiles_Agno:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;[xxSTR_Periodos:100]Fin_Ejercicio:5;->adSTR_Calendario_Feriados)
	viSTR_Periodos_DiasAgno:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;[xxSTR_Periodos:100]Fin_Ejercicio:5;->adSTR_Calendario_Feriados)
End if 

$trapped:=True:C214
$0:=$trapped

