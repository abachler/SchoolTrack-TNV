//%attributes = {}
  //AS_PageCalendar

C_TEXT:C284(vs_month1;vs_month2;vs_month3;vs_month4;vs_month5;vs_month6;vs_month7;vs_month8;vs_month9;vs_month10;vs_month11;vs_month12;vs_month13;vs_month14;vs_month15;vs_month16;vs_month17;vs_month18;vs_month19;vs_month20;vs_month21;vs_month22;vs_month23;vs_month24;vs_month25)
C_TEXT:C284(vs_day1;vs_day2;vs_day3;vs_day4;vs_day5;vs_day6;vs_day7;vs_day8;vs_day9;vs_day10;vs_day11;vs_day12;vs_day13;vs_day14;vs_day15;vs_day16;vs_day17;vs_day18;vs_day19;vs_day20;vs_day21;vs_day22;vs_day23;vs_day24;vs_day25)
C_TEXT:C284(vt_Events1;vt_Events2;vt_Events3;vt_Events4;vt_Events5;vt_Events6;vt_Events7;vt_Events8;vt_Events9;vt_Events10;vt_Events11;vt_Events12;vt_Events13;vt_Events14;vt_Events15;vt_Events16;vt_Events17;vt_Events18;vt_Events19;vt_Events20;vt_Events21;vt_Events22;vt_Events23;vt_Events24;vt_Events25)
ARRAY DATE:C224(ad_date1;0)
ARRAY LONGINT:C221(al_EventRecNums;0)
ARRAY DATE:C224(ad_date1;25)
ARRAY LONGINT:C221(al_EventRecNums;25*6)
For ($i;1;(25*6))
	al_EventRecNums{$i}:=-1
End for 

vd_CurrentDate:=Current date:C33(*)
Case of 
	: (Count parameters:C259=0)
		$date:=Current date:C33(*)
		$Date:=DT_GetDateFromDayMonthYear (1;Month of:C24($date);Year of:C25($date))
	Else 
		$date:=$1
End case 


$currentmonth:=Month of:C24($date)
$currentYear:=Year of:C25($date)
vi_currentYear:=$currentYear
vi_currentMonth:=$currentmonth
vt_CurrentMonthName:=<>atXS_MonthNames{$currentmonth}+", "+String:C10($currentYear)
$firstDate:=DT_GetDateFromDayMonthYear (1;Month of:C24($date);Year of:C25($date))
$lastDate:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($firstDate);Month of:C24($date);Year of:C25($date))
If ($firstDate<vdSTR_Periodos_InicioEjercicio)
	_O_DISABLE BUTTON:C193(bprevMonth)
Else 
	_O_ENABLE BUTTON:C192(bPrevMonth)
End if 

If ($lastDate>vdSTR_Periodos_FinEjercicio)
	_O_DISABLE BUTTON:C193(bNextMonth)
Else 
	_O_ENABLE BUTTON:C192(bNextMonth)
End if 

$position:=Day number:C114($firstDate)-1
  //While ($position>5)
  //$firstDate:=$firstDate+1
  //$position:=Day number($firstDate)-1
  //End while 
$dayNumber:=Day number:C114($firstDate)-1
  //While ($dayNumber#1)
  //$firstDate:=$firstDate+1
  //$dayNumber:=Day number($firstDate)-1
  //$position:=Day number($firstDate)-1
  //End while 

  // 20110530 AS. se cambia para mostrar todo el mes en el calendario.
While ($dayNumber#1)
	Case of 
		: ($dayNumber=6)
			$firstDate:=$firstDate+2
			$dayNumber:=Day number:C114($firstDate)
			$position:=Day number:C114($firstDate)
		: ($dayNumber=7)
			$firstDate:=$firstDate+1
			$dayNumber:=Day number:C114($firstDate)
			$position:=Day number:C114($firstDate)
		: (($position=0) | ($dayNumber=0))
			$dayNumber:=1
			$position:=1
		Else 
			$firstDate:=$firstDate-1
			$dayNumber:=Day number:C114($firstDate)-1
			$position:=Day number:C114($firstDate)-1
	End case 
End while 
ad_date1{$position}:=$firstDate
$index:=$position-1
If ($index>0)
	Repeat 
		$date:=$date-1
		$dayNumber:=Day number:C114($date)-1
		If (($dayNumber>=1) & ($dayNumber<=5))
			ad_date1{$index}:=$date
			$index:=$index-1
		End if 
	Until ($index=0)
End if 

$index:=$position
$date:=ad_date1{$position}
Repeat 
	$dayNumber:=Day number:C114($date)-1
	If (($dayNumber>=1) & ($dayNumber<=5))
		ad_date1{$index}:=$date
		$index:=$index+1
	End if 
	$date:=$date+1
Until ($index>25)

  //PONER LAS COLUMNAS DE LOS DÍAS QUE CORRESPONDE A LAS CLASES DE LA ASIGNATURA EN OTRO COLOR
ARRAY INTEGER:C220($aDíasClases;0)
ARRAY DATE:C224($aIniclases;0)
ARRAY DATE:C224($aFinclases;0)
ARRAY INTEGER:C220($aDias_Calendario;0)
ARRAY DATE:C224($aDias_Calendario_Desde;0)
ARRAY DATE:C224($aDias_Calendario_Hasta;0)

C_LONGINT:C283($v;$r)
CREATE SET:C116([Asignaturas:18];"Asig_actual")
QUERY:C277([TMT_Horario:166];[TMT_Horario:166]ID_Asignatura:5=[Asignaturas:18]Numero:1)
SELECTION TO ARRAY:C260([TMT_Horario:166]NumeroDia:1;$aDíasClases;[TMT_Horario:166]SesionesDesde:12;$aIniclases;[TMT_Horario:166]SesionesHasta:13;$aFinclases)

For ($r;1;Size of array:C274($aDíasClases))
	
	$fia:=Find in array:C230($aDias_Calendario;$aDíasClases{$r})
	
	If ($fia=-1)
		APPEND TO ARRAY:C911($aDias_Calendario;$aDíasClases{$r})
		APPEND TO ARRAY:C911($aDias_Calendario_Desde;$aIniclases{$r})
		APPEND TO ARRAY:C911($aDias_Calendario_Hasta;$aFinclases{$r})
	Else 
		If ($aIniclases{$r}<$aDias_Calendario_Desde{$fia})
			$aDias_Calendario_Desde{$fia}:=$aIniclases{$r}
		End if 
		If ($aFinclases{$r}>$aDias_Calendario_Hasta{$fia})
			$aDias_Calendario_Hasta{$fia}:=$aFinclases{$r}
		End if 
		
	End if 
	
End for 

READ ONLY:C145([Asignaturas_Eventos:170])
ARRAY LONGINT:C221($aID_asig;0)

QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
  //  //20140328 RCH Se filtran los eventos de los alumnos activos. Probe sin SET AUTOMATIC RELATIONS(True;False) y funciono... Ticket 130882
QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@")
AT_DistinctsFieldValues (->[Alumnos_Calificaciones:208]ID_Asignatura:5;->$aID_asig)
QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_asignatura:1;$aID_asig)
CREATE SET:C116([Asignaturas_Eventos:170];"Eventos")


  // cargo los días bloqueados
  //157386

  //fechas bloqueadas
ARRAY DATE:C224($ad_fechasBloqueadas;0)
ARRAY DATE:C224($ad_fechasBloqueadasTEMP;0)
ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
  //horas bloqueadas
ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)
ARRAY LONGINT:C221($al_HoraDesde;0)
ARRAY LONGINT:C221($al_HoraHasta;0)

ARRAY DATE:C224($ad_HorasBloqueadasFechasTemp;0)
ARRAY TEXT:C222($at_HorasBloqueadasMotivoTemp;0)
ARRAY LONGINT:C221($al_HoraDesdeTemp;0)
ARRAY LONGINT:C221($al_HoraHastaTemp;0)

ARRAY TEXT:C222($at_cursos_alu_asig;0)
ARRAY TEXT:C222($at_cursos_dia_bloqueado;0)
C_BLOB:C604($vx_Calendario_DiasBloq)
C_TEXT:C284($curso_nombre)

If ([Asignaturas:18]Seleccion:17)
	  //Si es grupal debemos buscar todos los cursos de los alumnos inscritos para hacer la validación
	QUERY:C277([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=[Asignaturas:18]Numero:1)
	KRL_RelateSelection (->[Alumnos_Calificaciones:208]ID_Alumno:6;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos:2]Status:50#"Retirado@")
	KRL_RelateSelection (->[Alumnos:2]numero:1;->[Alumnos_Calificaciones:208]ID_Alumno:6;"")
	AT_DistinctsFieldValues (->[Alumnos:2]curso:20;->$at_cursos_alu_asig)
	For ($n_cursos;1;Size of array:C274($at_cursos_alu_asig))
		$curso_nombre:=$at_cursos_alu_asig{$n_cursos}
		SET BLOB SIZE:C606($vx_Calendario_DiasBloq;0)
		$vx_Calendario_DiasBloq:=KRL_GetBlobFieldData (->[Cursos:3]Curso:1;->$curso_nombre;->[Cursos:3]xCalendario_DiasBloq:48)
		BLOB_Blob2Vars (->$vx_Calendario_DiasBloq;0;->$ad_fechasBloqueadasTEMP;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechasTemp;->$at_HorasBloqueadasMotivoTemp;->$al_HoraDesdeTemp;->$al_HoraHastaTemp)
		For ($n_dias;1;Size of array:C274($ad_fechasBloqueadasTEMP))
			$fia:=Find in array:C230($ad_fechasBloqueadas;$ad_fechasBloqueadasTEMP{$n_dias})
			If ($fia=-1)
				APPEND TO ARRAY:C911($ad_fechasBloqueadas;$ad_fechasBloqueadasTEMP{$n_dias})
				APPEND TO ARRAY:C911($at_cursos_dia_bloqueado;$curso_nombre)
			Else 
				$at_cursos_dia_bloqueado{$fia}:=$at_cursos_dia_bloqueado{$fia}+";"+$curso_nombre
			End if 
		End for 
		AT_MergeArrays (->$ad_HorasBloqueadasFechasTemp;->$ad_HorasBloqueadasFechas)
		AT_MergeArrays (->$at_HorasBloqueadasMotivoTemp;->$at_HorasBloqueadasMotivo)
		AT_MergeArrays (->$al_HoraDesdeTemp;->$al_HoraDesde)
		AT_MergeArrays (->$al_HoraHastaTemp;->$al_HoraHasta)
	End for 
	
Else 
	
	READ ONLY:C145([Cursos:3])
	QUERY:C277([Cursos:3];[Cursos:3]Curso:1=[Asignaturas:18]Curso:5)
	BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
	
End if 

AT_MultiLevelSort (">>>>";->$ad_HorasBloqueadasFechas;->$al_HoraDesde;->$al_HoraHasta;->$at_HorasBloqueadasMotivo)  //20170301 RCH. Para orden al desplegar.

For ($i;1;25)
	
	$monthPointer:=Get pointer:C304("vs_month"+String:C10($i))
	$dayPointer:=Get pointer:C304("vs_Day"+String:C10($i))
	$eventPointer:=Get pointer:C304("vt_Events"+String:C10($i))
	$monthPointer->:=""
	$dayPointer->:=String:C10(Day of:C23(ad_date1{$i}))
	$month:=Month of:C24(ad_date1{$i})
	$pos:=Find in array:C230(adSTR_Calendario_Feriados;ad_date1{$i})
	$l_posDiasBloq:=Find in array:C230($ad_fechasBloqueadas;ad_date1{$i})
	OBJECT SET FONT STYLE:C166($monthPointer->;0)
	OBJECT SET FONT STYLE:C166($dayPointer->;0)
	
	  //NUEVO
	C_LONGINT:C283($Eve_fecha)
	USE SET:C118("Eventos")
	
	QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2=ad_date1{$i})
	QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10=<>lUSR_CurrentUserID)
	CREATE SET:C116([Asignaturas_Eventos:170];"EventosUsuario")
	
	USE SET:C118("Eventos")
	If (<>lUSR_CurrentUserID<0)
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2=ad_date1{$i})
	Else 
		  //si es la misma asignatura del profesor
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2=ad_date1{$i})
		QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]UserID:10#<>lUSR_CurrentUserID;*)
		QUERY SELECTION:C341([Asignaturas_Eventos:170]; & ;[Asignaturas_Eventos:170]Privado:9=False:C215)
	End if 
	
	CREATE SET:C116([Asignaturas_Eventos:170];"OtrosEventos")
	
	CREATE EMPTY SET:C140([Asignaturas_Eventos:170];"resultado")
	
	UNION:C120("EventosUsuario";"OtrosEventos";"resultado")
	USE SET:C118("resultado")
	
	$Eve_fecha:=Records in selection:C76([Asignaturas_Eventos:170])
	
	REDUCE SELECTION:C351([Asignaturas_Eventos:170];5)
	
	ARRAY LONGINT:C221($aRecNums;0)
	LONGINT ARRAY FROM SELECTION:C647([Asignaturas_Eventos:170];$aRecNums;"")
	
	$eventPointer->:=""
	C_TEXT:C284($puntos_susp;$evento_text)
	
	  //INFO DE HORAS BLOQUEADAS
	ARRAY LONGINT:C221($DA_Return;0)
	$ad_HorasBloqueadasFechas{0}:=ad_date1{$i}
	AT_SearchArray (->$ad_HorasBloqueadasFechas;"=";->$DA_Return)
	For ($i_horas;1;Size of array:C274($DA_Return))
		$eventPointer->:=$eventPointer->+$at_HorasBloqueadasMotivo{$DA_Return{$i_horas}}+" - "+Time string:C180($al_HoraDesde{$DA_Return{$i_horas}})+" > "+Time string:C180($al_HoraHasta{$DA_Return{$i_horas}})+"\r"
	End for 
	
	  //20170301 DL _ RCH INFO DE DIA BLOQUEADO
	If ($l_posDiasBloq>0)
		$eventPointer->:=$eventPointer->+$at_fechasBloqueadasMotivo{$l_posDiasBloq}
	End if 
	
	For ($recnumIndex;1;Size of array:C274($aRecNums))
		GOTO RECORD:C242([Asignaturas_Eventos:170];$aRecNums{$recNumIndex})
		QUERY:C277([Asignaturas:18];[Asignaturas:18]Numero:1=[Asignaturas_Eventos:170]ID_asignatura:1)
		$puntos_susp:=""
		
		If ([Asignaturas_Eventos:170]Evento:3#"")
			$evento_text:="["+[Asignaturas:18]Curso:5+"]"+"["+[Asignaturas:18]Abreviación:26+"]"+[Asignaturas_Eventos:170]Evento:3
		Else 
			$evento_text:="["+[Asignaturas:18]Curso:5+"]"+"["+[Asignaturas:18]Abreviación:26+"]"+[Asignaturas_Eventos:170]Tipo Evento:7
		End if 
		
		If ((Length:C16($evento_text))>25)
			$puntos_susp:=" ..."
		End if 
		
		$eventPointer->:=$eventPointer->+Substring:C12($evento_text;1;25)+$puntos_susp+"\r"
		
		If ($i=1)
			$eventIndex:=$recnumIndex
		Else 
			$eventIndex:=$i-1*6+$recnumIndex
		End if 
		al_EventRecNums{$eventIndex}:=$aRecNums{$recnumIndex}
	End for 
	
	If ($Eve_fecha>5)
		$eventPointer->:=$eventPointer->+" ..."
	End if 
	
	$eventPointer->:=ST_ClearExtraCR ($eventPointer->)
	Case of 
		: (($month<$currentmonth) | ($month>$currentmonth))
			$monthPointer->:=<>atXS_MonthNames{Month of:C24(ad_date1{$i})}
			If ($pos>0)
				$l_colorFondo:=color RGB whitesmoke
				$l_colorTexto:=color RGB red
			Else 
				$l_colorFondo:=color RGB ivory
				$l_colorTexto:=color RGB darkgray
			End if 
			If ($l_posDiasBloq>0)
				$l_colorFondo:=color RGB whitesmoke
				$l_colorTexto:=color RGB darkorange
			End if 
		Else 
			If ($pos>0)
				$l_colorFondo:=color RGB whitesmoke
				$l_colorTexto:=color RGB red
			Else 
				$l_colorFondo:=color RGB ivory
				$l_colorTexto:=Black:K11:16
			End if 
			If ($l_posDiasBloq>0)
				$l_colorFondo:=color RGB whitesmoke
				$l_colorTexto:=color RGB darkorange
			End if 
			
			If ((Size of array:C274($aDíasClases))>0)
				C_LONGINT:C283($dia_existe)
				$dia_existe:=Find in array:C230($aDias_Calendario;DT_GetDayNumber_ISO8601 (ad_date1{$i}))
				
				If ($dia_existe>0)
					If ((ad_date1{$i}>=$aDias_Calendario_Desde{$dia_existe}) & (ad_date1{$i}<=$aDias_Calendario_Hasta{$dia_existe}))
						$l_colorFondo:=color RGB white  //MONO TICKET 178161
					End if 
				End if 
			End if 
			
			
	End case 
	
	OBJECT SET STYLE SHEET:C1257($monthPointer->;"Plain - 11")
	OBJECT SET STYLE SHEET:C1257($eventPointer->;"Plain - 11")
	OBJECT SET STYLE SHEET:C1257($dayPointer->;"Plain - 11")
	
	If (Current date:C33(*)=ad_date1{$i})
		OBJECT SET FONT STYLE:C166($monthPointer->;1)
		OBJECT SET FONT STYLE:C166($dayPointer->;1)
		$l_colorFondo:=color RGB white
		$l_colorTexto:=color RGB green
	End if 
	
	
	OBJECT SET RGB COLORS:C628($monthPointer->;$l_colorTexto;$l_colorFondo)
	OBJECT SET RGB COLORS:C628($eventPointer->;$l_colorTexto;$l_colorFondo)
	OBJECT SET RGB COLORS:C628($dayPointer->;$l_colorTexto;$l_colorFondo)
End for 
USE SET:C118("Asig_actual")
CLEAR SET:C117("Asig_actual")
CLEAR SET:C117("Eventos")
FORM GOTO PAGE:C247(8)
