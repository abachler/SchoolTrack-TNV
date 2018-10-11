//%attributes = {}
  //CAL_FillMonth

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_clFillMonth
	  //Autor: Andrea Núñez
	  //Creada el 23/5/96 a 06:11 pm
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_LONGINT:C283($numdia;$Pos)
C_LONGINT:C283($currentMonth;$dayscount;$feriados)
C_DATE:C307($vDate;$vDate2)
C_TEXT:C284($textDate)
C_REAL:C285($Punt)
$currentDate:=Current date:C33(*)
$currentMonth:=<>atXS_MonthNames
$vDate:=DT_GetDateFromDayMonthYear (1;$currentMonth;vl_Agno)
$numdia:=Day number:C114($vDate)
$vDate2:=$vDate
If ($numdia=1)
	$Pos:=7
Else 
	$Pos:=$numdia-1
End if 
$firstDay:=$vDate
$lastDay:=DT_EndOfMonth ($vDate)

$daysCount:=$lastDay-$firstDay+1

ARRAY INTEGER:C220(ai2DSTR_CalendarMatrix;0;0)
ARRAY INTEGER:C220(ai2DSTR_CalendarMatrix;6;7)
ARRAY TEXT:C222(at2DSTR_MatrizFeriados;6;7)

For ($i;1;6)  //``filas
	For ($j;$Pos;7)  //```columnas
		ai2DSTR_CalendarMatrix{$i}{$j}:=Day of:C23($vDate)
		$Punt:=Find in array:C230(adSTR_Calendario_Feriados;$vDate)
		  //If ($Punt#-1) | (Day number($vDate)=1)
		If ($Punt#-1)  //domingos no son feriados por defecto
			at2DSTR_MatrizFeriados{$i}{$j}:="²"
		Else 
			at2DSTR_MatrizFeriados{$i}{$j}:=" "
		End if 
		$vDate:=$vDate+1
		If (Month of:C24($vDate)#$currentMonth)
			$j:=7
			$i:=6
		End if 
	End for 
	$Pos:=1
End for 
v_DiasHabiles:=DT_GetWorkingDays ($firstDay;$lastDay;->adSTR_Calendario_Feriados)
CAL_SetCalendarObjects 



  //contabilización de dias
$trapped:=dhCAL_CountDays 
If (Not:C34($trapped))
	$inicioEjercicio:=DT_GetDateFromDayMonthYear (1;1;Year of:C25($currentDate))
	$finEjercicio:=DT_GetDateFromDayMonthYear (31;12;Year of:C25($currentDate))
	If ($currentDate<$inicioEjercicio)
		<>lXS_DiasHabiles_en_el_Mes:=0
	Else 
		$firstDay:=DT_GetDateFromDayMonthYear (1;<>atXS_MonthNames;vl_Agno)
		$lastDay:=DT_EndOfMonth ($firstDay)
		<>lXS_DiasHabiles_en_el_Mes:=DT_GetWorkingDays ($firstDay;$lastDay;->adSTR_Calendario_Feriados)
		viSTR_Periodos_DiasMes:=DT_GetWorkingDays ($firstDay;$lastDay;->adSTR_Calendario_Feriados)
	End if 
	
	If ($currentDate<$inicioEjercicio)
		<>lXS_DiasHabiles_a_la_Fecha:=0
	Else 
		<>lXS_DiasHabiles_a_la_Fecha:=DT_GetWorkingDays ($inicioEjercicio;$currentDate;->adSTR_Calendario_Feriados)
		viSTR_Calendario_DiasAHoy:=DT_GetWorkingDays ($inicioEjercicio;$currentDate;->adSTR_Calendario_Feriados)
	End if 
	
	
	If ($currentDate<$inicioEjercicio)
		<>lXS_DiasHabiles_Agno:=0
	Else 
		<>lXS_DiasHabiles_Agno:=DT_GetWorkingDays ($inicioEjercicio;$finEjercicio;->adSTR_Calendario_Feriados)
		viSTR_Periodos_DiasAgno:=DT_GetWorkingDays ($inicioEjercicio;$finEjercicio;->adSTR_Calendario_Feriados)
	End if 
End if 



