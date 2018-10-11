//%attributes = {}
  //IN_CreaPeriodos

C_LONGINT:C283($vi_periodos;$1;$feriados)
C_DATE:C307(vd_InicioPeriodo1;vd_InicioPeriodo2;vd_InicioPeriodo3;vd_InicioPeriodo4;vd_InicioPeriodo5)
C_DATE:C307(vd_FinPeriodo1;vd_FinPeriodo2;vd_FinPeriodo3;vd_FinPeriodo4;vd_FinPeriodo5)
C_DATE:C307(vd_periodoFin;vd_PeriodoInicio)
If (Count parameters:C259=0)
	$vi_periodos:=2
Else 
	$vi_periodos:=$1
End if 

If ($vi_Periodos=0)
	$vi_periodos:=2
End if 

PERIODOS_Init 

ARRAY INTEGER:C220(aiSTR_Horario_HoraNo;0)
ARRAY TEXT:C222(atSTR_Horario_HoraAlias;0)  //MONO Ticket 144924
ARRAY LONGINT:C221(alSTR_Horario_Desde;0)
ARRAY LONGINT:C221(alSTR_Horario_Hasta;0)
ARRAY LONGINT:C221(alSTR_Horario_Duracion;0)
ARRAY LONGINT:C221(alSTR_Horario_RefTipoHora;0)


ARRAY DATE:C224(adSTR_Calendario_Feriados;0)

ARRAY INTEGER:C220(aiSTR_Periodos_Numero;0)
ARRAY TEXT:C222(atSTR_Periodos_Nombre;0)
ARRAY DATE:C224(adSTR_Periodos_Desde;0)
ARRAY DATE:C224(adSTR_Periodos_Hasta;0)
ARRAY DATE:C224(adSTR_Periodos_Cierre;0)
ARRAY INTEGER:C220(aiSTR_Periodos_Dias;0)

Case of 
	: ($vi_Periodos=6)
		ARRAY INTEGER:C220(aiSTR_Periodos_Numero;1)
		ARRAY TEXT:C222(atSTR_Periodos_Nombre;1)
		ARRAY DATE:C224(adSTR_Periodos_Desde;1)
		ARRAY DATE:C224(adSTR_Periodos_Hasta;1)
		ARRAY DATE:C224(adSTR_Periodos_Cierre;1)
		ARRAY INTEGER:C220(aiSTR_Periodos_Dias;1)
		aiSTR_Periodos_Numero{1}:=1
		atSTR_Periodos_Nombre{1}:=vs_Periodo1
		adSTR_Periodos_Desde{1}:=vd_InicioPeriodo1
		adSTR_Periodos_Hasta{1}:=vd_FinPeriodo1
		aiSTR_Periodos_Dias{1}:=DT_GetWorkingDays (vd_InicioPeriodo1;vd_FinPeriodo1)
		DT_SetCalendar (vd_InicioPeriodo1;vd_FinPeriodo1)
		
	: ($vi_Periodos=1)
		ARRAY INTEGER:C220(aiSTR_Periodos_Numero;2)
		ARRAY TEXT:C222(atSTR_Periodos_Nombre;2)
		ARRAY DATE:C224(adSTR_Periodos_Desde;2)
		ARRAY DATE:C224(adSTR_Periodos_Hasta;2)
		ARRAY DATE:C224(adSTR_Periodos_Cierre;2)
		ARRAY INTEGER:C220(aiSTR_Periodos_Dias;2)
		aiSTR_Periodos_Numero{1}:=1
		atSTR_Periodos_Nombre{1}:=vs_Periodo1
		adSTR_Periodos_Desde{1}:=vd_InicioPeriodo1
		adSTR_Periodos_Hasta{1}:=vd_FinPeriodo1
		aiSTR_Periodos_Dias{1}:=DT_GetWorkingDays (vd_InicioPeriodo1;vd_FinPeriodo1)
		
		aiSTR_Periodos_Numero{2}:=2
		atSTR_Periodos_Nombre{2}:=vs_Periodo2
		adSTR_Periodos_Desde{2}:=vd_InicioPeriodo2
		adSTR_Periodos_Hasta{2}:=vd_FinPeriodo2
		aiSTR_Periodos_Dias{2}:=DT_GetWorkingDays (vd_InicioPeriodo2;vd_FinPeriodo2)
		DT_SetCalendar (vd_InicioPeriodo1;vd_FinPeriodo2)
		
	: ($vi_Periodos=2)
		ARRAY INTEGER:C220(aiSTR_Periodos_Numero;3)
		ARRAY TEXT:C222(atSTR_Periodos_Nombre;3)
		ARRAY DATE:C224(adSTR_Periodos_Desde;3)
		ARRAY DATE:C224(adSTR_Periodos_Hasta;3)
		ARRAY DATE:C224(adSTR_Periodos_Cierre;3)
		ARRAY INTEGER:C220(aiSTR_Periodos_Dias;3)
		aiSTR_Periodos_Numero{1}:=1
		atSTR_Periodos_Nombre{1}:=vs_Periodo1
		adSTR_Periodos_Desde{1}:=vd_InicioPeriodo1
		adSTR_Periodos_Hasta{1}:=vd_FinPeriodo1
		aiSTR_Periodos_Dias{1}:=DT_GetWorkingDays (vd_InicioPeriodo1;vd_FinPeriodo1)
		
		aiSTR_Periodos_Numero{2}:=2
		atSTR_Periodos_Nombre{2}:=vs_Periodo2
		adSTR_Periodos_Desde{2}:=vd_InicioPeriodo2
		adSTR_Periodos_Hasta{2}:=vd_FinPeriodo2
		aiSTR_Periodos_Dias{2}:=DT_GetWorkingDays (vd_InicioPeriodo2;vd_FinPeriodo2)
		
		aiSTR_Periodos_Numero{3}:=3
		atSTR_Periodos_Nombre{3}:=vs_Periodo3
		adSTR_Periodos_Desde{3}:=vd_InicioPeriodo3
		adSTR_Periodos_Hasta{3}:=vd_FinPeriodo3
		aiSTR_Periodos_Dias{3}:=DT_GetWorkingDays (vd_InicioPeriodo3;vd_FinPeriodo3)
		DT_SetCalendar (vd_InicioPeriodo1;vd_FinPeriodo3)
		
	: ($vi_Periodos=3)
		ARRAY INTEGER:C220(aiSTR_Periodos_Numero;4)
		ARRAY TEXT:C222(atSTR_Periodos_Nombre;4)
		ARRAY DATE:C224(adSTR_Periodos_Desde;4)
		ARRAY DATE:C224(adSTR_Periodos_Hasta;4)
		ARRAY DATE:C224(adSTR_Periodos_Cierre;4)
		ARRAY INTEGER:C220(aiSTR_Periodos_Dias;4)
		aiSTR_Periodos_Numero{1}:=1
		atSTR_Periodos_Nombre{1}:=vs_Periodo1
		adSTR_Periodos_Desde{1}:=vd_InicioPeriodo1
		adSTR_Periodos_Hasta{1}:=vd_FinPeriodo1
		aiSTR_Periodos_Dias{1}:=DT_GetWorkingDays (vd_InicioPeriodo1;vd_FinPeriodo1)
		
		aiSTR_Periodos_Numero{2}:=2
		atSTR_Periodos_Nombre{2}:=vs_Periodo2
		adSTR_Periodos_Desde{2}:=vd_InicioPeriodo2
		adSTR_Periodos_Hasta{2}:=vd_FinPeriodo2
		aiSTR_Periodos_Dias{2}:=DT_GetWorkingDays (vd_InicioPeriodo2;vd_FinPeriodo2)
		
		aiSTR_Periodos_Numero{3}:=3
		atSTR_Periodos_Nombre{3}:=vs_Periodo3
		adSTR_Periodos_Desde{3}:=vd_InicioPeriodo3
		adSTR_Periodos_Hasta{3}:=vd_FinPeriodo3
		aiSTR_Periodos_Dias{3}:=DT_GetWorkingDays (vd_InicioPeriodo3;vd_FinPeriodo3)
		
		aiSTR_Periodos_Numero{4}:=4
		atSTR_Periodos_Nombre{4}:=vs_Periodo4
		adSTR_Periodos_Desde{4}:=vd_InicioPeriodo4
		adSTR_Periodos_Hasta{4}:=vd_FinPeriodo4
		aiSTR_Periodos_Dias{4}:=DT_GetWorkingDays (vd_InicioPeriodo4;vd_FinPeriodo4)
		DT_SetCalendar (vd_InicioPeriodo1;vd_FinPeriodo4)
		
	: ($vi_periodos=5)
		ARRAY INTEGER:C220(aiSTR_Periodos_Numero;5)
		ARRAY TEXT:C222(atSTR_Periodos_Nombre;5)
		ARRAY DATE:C224(adSTR_Periodos_Desde;5)
		ARRAY DATE:C224(adSTR_Periodos_Hasta;5)
		ARRAY DATE:C224(adSTR_Periodos_Cierre;5)
		ARRAY INTEGER:C220(aiSTR_Periodos_Dias;5)
		aiSTR_Periodos_Numero{1}:=1
		atSTR_Periodos_Nombre{1}:=vs_Periodo1
		adSTR_Periodos_Desde{1}:=vd_InicioPeriodo1
		adSTR_Periodos_Hasta{1}:=vd_FinPeriodo1
		aiSTR_Periodos_Dias{1}:=DT_GetWorkingDays (vd_InicioPeriodo1;vd_FinPeriodo1)
		
		aiSTR_Periodos_Numero{2}:=2
		atSTR_Periodos_Nombre{2}:=vs_Periodo2
		adSTR_Periodos_Desde{2}:=vd_InicioPeriodo2
		adSTR_Periodos_Hasta{2}:=vd_FinPeriodo2
		aiSTR_Periodos_Dias{2}:=DT_GetWorkingDays (vd_InicioPeriodo2;vd_FinPeriodo2)
		
		aiSTR_Periodos_Numero{3}:=3
		atSTR_Periodos_Nombre{3}:=vs_Periodo3
		adSTR_Periodos_Desde{3}:=vd_InicioPeriodo3
		adSTR_Periodos_Hasta{3}:=vd_FinPeriodo3
		aiSTR_Periodos_Dias{3}:=DT_GetWorkingDays (vd_InicioPeriodo3;vd_FinPeriodo3)
		
		aiSTR_Periodos_Numero{4}:=4
		atSTR_Periodos_Nombre{4}:=vs_Periodo4
		adSTR_Periodos_Desde{4}:=vd_InicioPeriodo4
		adSTR_Periodos_Hasta{4}:=vd_FinPeriodo4
		aiSTR_Periodos_Dias{4}:=DT_GetWorkingDays (vd_InicioPeriodo4;vd_FinPeriodo4)
		
		aiSTR_Periodos_Numero{5}:=5
		atSTR_Periodos_Nombre{5}:=vs_Periodo5
		adSTR_Periodos_Desde{5}:=vd_InicioPeriodo5
		adSTR_Periodos_Hasta{5}:=vd_FinPeriodo5
		aiSTR_Periodos_Dias{5}:=DT_GetWorkingDays (vd_InicioPeriodo5;vd_FinPeriodo5)
		DT_SetCalendar (vd_InicioPeriodo1;vd_FinPeriodo5)
End case 


If ((vd_finPeriodo1#!00-00-00!) & (vd_InicioPeriodo2#!00-00-00!))
	$date1:=vd_finPeriodo1+1
	$date2:=vd_InicioPeriodo2-1
	While ($date1<$date2)
		If (Find in array:C230(adSTR_Calendario_Feriados;$date1)=-1)
			AT_Insert (0;1;->adSTR_Calendario_Feriados)
			adSTR_Calendario_Feriados{Size of array:C274(adSTR_Calendario_Feriados)}:=$date1
		End if 
		$date1:=$date1+1
	End while 
End if 

If ((vd_finPeriodo2#!00-00-00!) & (vd_InicioPeriodo3#!00-00-00!))
	$date1:=vd_finPeriodo2+1
	$date2:=vd_InicioPeriodo3-1
	While ($date1<$date2)
		If (Find in array:C230(adSTR_Calendario_Feriados;$date1)=-1)
			AT_Insert (0;1;->adSTR_Calendario_Feriados)
			adSTR_Calendario_Feriados{Size of array:C274(adSTR_Calendario_Feriados)}:=$date1
		End if 
		$date1:=$date1+1
	End while 
End if 

If ((vd_finPeriodo3#!00-00-00!) & (vd_InicioPeriodo4#!00-00-00!))
	$date1:=vd_finPeriodo3+1
	$date2:=vd_InicioPeriodo4-1
	While ($date1<$date2)
		If (Find in array:C230(adSTR_Calendario_Feriados;$date1)=-1)
			AT_Insert (0;1;->adSTR_Calendario_Feriados)
			adSTR_Calendario_Feriados{Size of array:C274(adSTR_Calendario_Feriados)}:=$date1
		End if 
		$date1:=$date1+1
	End while 
End if 

If ((vd_finPeriodo4#!00-00-00!) & (vd_InicioPeriodo5#!00-00-00!))
	$date1:=vd_finPeriodo4+1
	$date2:=vd_InicioPeriodo5-1
	While ($date1<$date2)
		If (Find in array:C230(adSTR_Calendario_Feriados;$date1)=-1)
			AT_Insert (0;1;->adSTR_Calendario_Feriados)
			adSTR_Calendario_Feriados{Size of array:C274(adSTR_Calendario_Feriados)}:=$date1
		End if 
		$date1:=$date1+1
	End while 
End if 

QUERY:C277([xxSTR_Periodos:100];[xxSTR_Periodos:100]ID:1=-1)
If (Records in selection:C76([xxSTR_Periodos:100])=0)
	CREATE RECORD:C68([xxSTR_Periodos:100])
End if 
[xxSTR_Periodos:100]Nombre_Configuracion:2:=__ ("Configuración Principal")
[xxSTR_Periodos:100]ID:1:=-1
[xxSTR_Periodos:100]Tipo_de_Periodos:3:=$vi_Periodos
[xxSTR_Periodos:100]Horas_Jornada:9:=Size of array:C274(aiSTR_Horario_HoraNo)
[xxSTR_Periodos:100]Inicio_Ejercicio:4:=adSTR_Periodos_Desde{1}
[xxSTR_Periodos:100]Fin_Ejercicio:5:=adSTR_Periodos_Hasta{Size of array:C274(aiSTR_Periodos_Numero)}
[xxSTR_Periodos:100]Dias_Habiles:10:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;[xxSTR_Periodos:100]Fin_Ejercicio:5;->adSTR_Calendario_Feriados)
SAVE RECORD:C53([xxSTR_Periodos:100])
vlSTR_Periodos_CurrentConfigRef:=Record number:C243([xxSTR_Periodos:100])
vt_NombreConfig:=[xxSTR_Periodos:100]Nombre_Configuracion:2


  //20110809 ABK: el arreglo alSTR_Horario_Duracion_temp no estaba definido al llamar a CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
ARRAY LONGINT:C221(alSTR_Horario_Duracion_temp;0)
COPY ARRAY:C226(alSTR_Horario_Duracion;alSTR_Horario_Duracion_temp)

CFG_STR_PeriodosEscolares_NEW ("SaveConfig")
KRL_ReloadAsReadOnly (->[xxSTR_Periodos:100])

  //actualización del nombre de año escolar
  // ABK 21/12/2010
READ WRITE:C146([xxSTR_Constants:1])
ALL RECORDS:C47([xxSTR_Constants:1])
FIRST RECORD:C50([xxSTR_Constants:1])
If ([xxSTR_Periodos:100]Inicio_Ejercicio:4=!00-00-00!)
	[xxSTR_Constants:1]Año:8:=Year of:C25(Current date:C33(*))
	[xxSTR_Constants:1]NombreEjercicio:29:=String:C10(Year of:C25(Current date:C33(*)))
Else 
	[xxSTR_Constants:1]Año:8:=Year of:C25([xxSTR_Periodos:100]Inicio_Ejercicio:4)
	If ((Year of:C25([xxSTR_Periodos:100]Fin_Ejercicio:5)=[xxSTR_Constants:1]Año:8) | ([xxSTR_Periodos:100]Fin_Ejercicio:5=!00-00-00!))
		[xxSTR_Constants:1]NombreEjercicio:29:=String:C10(Year of:C25([xxSTR_Periodos:100]Inicio_Ejercicio:4))
	Else 
		[xxSTR_Constants:1]NombreEjercicio:29:=String:C10(Year of:C25([xxSTR_Periodos:100]Inicio_Ejercicio:4))+"-"+String:C10(Year of:C25([xxSTR_Periodos:100]Fin_Ejercicio:5))
	End if 
End if 
SAVE RECORD:C53([xxSTR_Constants:1])
UNLOAD RECORD:C212([xxSTR_Constants:1])


For ($i;1;Size of array:C274(aiSTR_Periodos_Numero))
	CREATE RECORD:C68([xxSTR_DatosPeriodos:132])
	[xxSTR_DatosPeriodos:132]ID_Configuracion:9:=-1
	[xxSTR_DatosPeriodos:132]NumeroPeriodo:1:=aiSTR_Periodos_Numero{$i}
	[xxSTR_DatosPeriodos:132]FechaInicio:3:=adSTR_Periodos_Desde{$i}
	[xxSTR_DatosPeriodos:132]FechaTermino:4:=adSTR_Periodos_Hasta{$i}
	[xxSTR_DatosPeriodos:132]DiasHabiles:6:=aiSTR_Periodos_Dias{$i}
	[xxSTR_DatosPeriodos:132]Nombre:8:=atSTR_Periodos_Nombre{$i}
	SAVE RECORD:C53([xxSTR_DatosPeriodos:132])
End for 
UNLOAD RECORD:C212([xxSTR_DatosPeriodos:132])

READ WRITE:C146([xxSTR_Niveles:6])
ALL RECORDS:C47([xxSTR_Niveles:6])
APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]ID_ConfiguracionPeriodos:44:=-1)
APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]FechaTermino:34:=adSTR_Periodos_Hasta{Size of array:C274(aiSTR_Periodos_Numero)})
APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]FechaInicio:29:=adSTR_Periodos_Desde{1})
APPLY TO SELECTION:C70([xxSTR_Niveles:6];[xxSTR_Niveles:6]Dias_habiles:20:=DT_GetWorkingDays ([xxSTR_Periodos:100]Inicio_Ejercicio:4;[xxSTR_Periodos:100]Fin_Ejercicio:5;->adSTR_Calendario_Feriados))
UNLOAD RECORD:C212([xxSTR_Niveles:6])
READ ONLY:C145([xxSTR_Niveles:6])



