//%attributes = {}
  //dhDT_SaveCalendar

C_LONGINT:C283($feriados)
READ WRITE:C146([xxSTR_Niveles:6])
ALL RECORDS:C47([xxSTR_Niveles:6])
While (Not:C34(End selection:C36([xxSTR_Niveles:6])))
	PERIODOS_LoadData ([xxSTR_Niveles:6]NoNivel:5)
	[xxSTR_Niveles:6]Dias_habiles:20:=DT_GetWorkingDays (vdSTR_Periodos_InicioEjercicio;vdSTR_Periodos_FinEjercicio)
	SAVE RECORD:C53([xxSTR_Niveles:6])
	NEXT RECORD:C51([xxSTR_Niveles:6])
End while 

