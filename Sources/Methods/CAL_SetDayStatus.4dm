//%attributes = {}
  //CAL_SetDayStatus

If (False:C215)
	  //============================== IDENTIFICACION ==============================
	  // Procédure : MT_clSetDay
	  //Autor: Andrea Núñez
	  //Creada el 24/5/96 a 03:25 pm
	  //============================== DESCRIPCION ==============================
	  //Package:
	  //Descripción:
	  //Sintaxis:
	  //============================== MODIFICACIONES ==============================
	  //Fecha: 
	  //Autor:
	  //Descripción:
End if 
C_DATE:C307($date)
C_REAL:C285($ArrayElement)
C_BOOLEAN:C305($executeDevHook)
$executeDevHook:=True:C214
If (Count parameters:C259=2)
	$executeDevHook:=$2
End if 
$date:=DT_GetDateFromDayMonthYear (aySTR_Calendario_DayPointers{$1}->;<>atXS_MonthNames;vl_Agno)
$ArrayElement:=Find in array:C230(adSTR_Calendario_Feriados;$date)
If (vdSTR_Periodos_InicioEjercicio#$date)  //ABC//20180305//REQ199792 
	If (aySTR_Calendario_DayPointers{$1}->#0)
		If ($ArrayElement#-1)
			DELETE FROM ARRAY:C228(adSTR_Calendario_Feriados;$ArrayElement;1)
			OBJECT SET COLOR:C271(aySTR_Calendario_DayPointers{$1}->;-15)
			If ($executeDevHook)
				dhCldr_SetDayStatus (0;$date)
			End if 
		Else 
			If ($executeDevHook)
				$goAhead:=dhCldr_SetDayStatus (1;$date)
			Else 
				$goAhead:=1
			End if 
			If ($goAhead=1)
				AT_Insert (0;1;->adSTR_Calendario_Feriados)
				adSTR_Calendario_Feriados{Size of array:C274(adSTR_Calendario_Feriados)}:=$Date
				SORT ARRAY:C229(adSTR_Calendario_Feriados;>)
				OBJECT SET COLOR:C271(aySTR_Calendario_DayPointers{$1}->;-3)
			End if 
		End if 
	End if 
Else 
	CD_Dlog (0;__ ("No se puede asignar la fecha de incio de periodo como día feriado."))
End if 
READ ONLY:C145([xShell_Feriados:71])