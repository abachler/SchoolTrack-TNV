//%attributes = {}
  // CU_Calendario()
  // 
  //
  // creado por: Alberto Bachler Klein: 05-08-16, 12:24:04
  // -----------------------------------------------------------
C_BOOLEAN:C305($b_bloqueado;$b_bloqueadoHora;$b_esFeriado)
C_DATE:C307($d_fecha;$d_primeraFecha;$d_ultimaFecha)
C_LONGINT:C283($i;$i_horas;$l_alumnos;$l_añoActual;$l_celda;$l_colorFondo;$l_colorTexto;$l_index;$l_mesActual;$l_ms)
C_LONGINT:C283($l_numeroDia;$l_numeroMes;$l_posHorasBloq;$l_posicion)
C_POINTER:C301($y_Celda;$y_detalleEvento;$y_diaCalendario;$y_mes)
C_TEXT:C284($t_nombreMes;$t_textoCelda)

ARRAY DATE:C224($ad_fechaEvento;0)
ARRAY DATE:C224($ad_fechasBloqueadas;0)
ARRAY DATE:C224($ad_HorasBloqueadasFechas;0)
ARRAY LONGINT:C221($al_HoraDesde;0)
ARRAY LONGINT:C221($al_HoraHasta;0)
ARRAY LONGINT:C221($al_IdAsignaturas;0)
ARRAY LONGINT:C221($al_recNumEvento;0)
ARRAY TEXT:C222($at_abreviacion;0)
ARRAY TEXT:C222($at_eventos;0)
ARRAY TEXT:C222($at_fechasBloqueadasMotivo;0)
ARRAY TEXT:C222($at_HorasBloqueadasMotivo;0)

C_TEXT:C284(vs_month1;vs_month2;vs_month3;vs_month4;vs_month5;vs_month6;vs_month7;vs_month8;vs_month9;vs_month10;vs_month11;vs_month12;vs_month13;vs_month14;vs_month15;vs_month16;vs_month17;vs_month18;vs_month19;vs_month20;vs_month21;vs_month22;vs_month23;vs_month24;vs_month25)
C_TEXT:C284(vs_day1;vs_day2;vs_day3;vs_day4;vs_day5;vs_day6;vs_day7;vs_day8;vs_day9;vs_day10;vs_day11;vs_day12;vs_day13;vs_day14;vs_day15;vs_day16;vs_day17;vs_day18;vs_day19;vs_day20;vs_day21;vs_day22;vs_day23;vs_day24;vs_day25)
C_TEXT:C284(vt_Events1;vt_Events2;vt_Events3;vt_Events4;vt_Events5;vt_Events6;vt_Events7;vt_Events8;vt_Events9;vt_Events10;vt_Events11;vt_Events12;vt_Events13;vt_Events14;vt_Events15;vt_Events16;vt_Events17;vt_Events18;vt_Events19;vt_Events20;vt_Events21;vt_Events22;vt_Events23;vt_Events24;vt_Events25)
ARRAY DATE:C224(ad_date1;0)
ARRAY DATE:C224(ad_date1;25)

READ ONLY:C145([Asignaturas_Eventos:170])
READ ONLY:C145([Cursos:3])
READ ONLY:C145([Asignaturas:18])
READ ONLY:C145([Alumnos_Calificaciones:208])
ARRAY LONGINT:C221(al_asignaturasdelcurso;0)
ARRAY LONGINT:C221(al_eventosdelcurso;0)
ARRAY BOOLEAN:C223(ab_cursocompletopart;0)

vd_CurrentDate:=Current date:C33(*)
Case of 
	: (Count parameters:C259=0)
		$d_fecha:=Current date:C33(*)
		$d_fecha:=DT_GetDateFromDayMonthYear (1;Month of:C24($d_fecha);Year of:C25($d_fecha))
	Else 
		$d_fecha:=$1
End case 

$l_ms:=Milliseconds:C459

  // PASO 1: Construyo el calendario del mes
vi_CurrentMonth:=Month of:C24($d_fecha)
vi_currentYear:=Year of:C25($d_fecha)
$l_mesActual:=Month of:C24($d_fecha)
$t_nombreMes:=<>atXS_MonthNames{$l_mesActual}
vt_CurrentMonthName:=$t_nombreMes+", "+String:C10(Year of:C25($d_fecha))
$l_añoActual:=Year of:C25($d_fecha)
$d_primeraFecha:=DT_GetDateFromDayMonthYear (1;Month of:C24($d_fecha);Year of:C25($d_fecha))
$d_ultimaFecha:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 ($d_primeraFecha);Month of:C24($d_fecha);Year of:C25($d_fecha))
$l_posicion:=Day number:C114($d_primeraFecha)-1
$l_numeroDia:=Day number:C114($d_primeraFecha)-1
While ($l_numeroDia#1)
	Case of 
		: ($l_numeroDia=6)
			$d_primeraFecha:=$d_primeraFecha+2
			$l_numeroDia:=Day number:C114($d_primeraFecha)
			$l_posicion:=Day number:C114($d_primeraFecha)
		: ($l_numeroDia=7)
			$d_primeraFecha:=$d_primeraFecha+1
			$l_numeroDia:=Day number:C114($d_primeraFecha)
			$l_posicion:=Day number:C114($d_primeraFecha)
		: (($l_posicion=0) | ($l_numeroDia=0))
			$l_numeroDia:=1
			$l_posicion:=1
		Else 
			$d_primeraFecha:=$d_primeraFecha-1
			$l_numeroDia:=Day number:C114($d_primeraFecha)-1
			$l_posicion:=Day number:C114($d_primeraFecha)-1
	End case 
End while 


ad_date1{$l_posicion}:=$d_primeraFecha
$l_index:=$l_posicion-1
If ($l_index>0)
	Repeat 
		$d_fecha:=$d_fecha-1
		$l_numeroDia:=Day number:C114($d_fecha)-1
		If (($l_numeroDia>=1) & ($l_numeroDia<=5))
			ad_date1{$l_index}:=$d_fecha
			$l_index:=$l_index-1
		End if 
	Until ($l_index=0)
End if 

$l_index:=$l_posicion
$d_fecha:=ad_date1{$l_posicion}
Repeat 
	$l_numeroDia:=Day number:C114($d_fecha)-1
	If (($l_numeroDia>=1) & ($l_numeroDia<=5))
		ad_date1{$l_index}:=$d_fecha
		$l_index:=$l_index+1
	End if 
	$d_fecha:=$d_fecha+1
Until ($l_index>25)

BLOB_Blob2Vars (->[Cursos:3]xCalendario_DiasBloq:48;0;->$ad_fechasBloqueadas;->$at_fechasBloqueadasMotivo;->$ad_HorasBloqueadasFechas;->$at_HorasBloqueadasMotivo;->$al_HoraDesde;->$al_HoraHasta)
AT_MultiLevelSort (">>>>";->$ad_HorasBloqueadasFechas;->$al_HoraDesde;->$al_HoraHasta;->$at_HorasBloqueadasMotivo)  //20170301 RCH Se ordena para despliegue.

For ($i;1;25)
	$l_numeroMes:=Month of:C24(ad_date1{$i})
	$t_nombreMes:=<>atXS_MonthNames{$l_numeroMes}
	$y_mes:=OBJECT Get pointer:C1124(Object named:K67:5;"vs_month"+String:C10($i))
	$y_diaCalendario:=OBJECT Get pointer:C1124(Object named:K67:5;"vs_Day"+String:C10($i))
	$y_detalleEvento:=OBJECT Get pointer:C1124(Object named:K67:5;"vt_Events"+String:C10($i))
	$y_detalleEvento->:=""
	$y_mes->:=""
	$y_diaCalendario->:=String:C10(Day of:C23(ad_date1{$i}))
	$b_esFeriado:=(Find in array:C230(adSTR_Calendario_Feriados;ad_date1{$i})>0)
	$b_bloqueado:=(Find in array:C230($ad_fechasBloqueadas;ad_date1{$i})>0)
	$b_bloqueadoHora:=(Find in array:C230($ad_HorasBloqueadasFechas;ad_date1{$i})>0)
	OBJECT SET FONT STYLE:C166($y_mes->;Bold:K14:2)
	OBJECT SET FONT STYLE:C166($y_diaCalendario->;Plain:K14:1)
	Case of 
		: ($b_esFeriado)
			$l_colorFondo:=color RGB whitesmoke
			$l_colorTexto:=color RGB red
			
		: (($b_bloqueado) | ($b_bloqueadoHora))
			$l_colorFondo:=color RGB whitesmoke
			$l_colorTexto:=color RGB darkorange
			
			If ($b_bloqueado)
				$y_detalleEvento->:=$at_fechasBloqueadasMotivo{Find in array:C230($ad_fechasBloqueadas;ad_date1{$i})}  //20170301 171873
			Else   //bloqueo hora
				$y_detalleEvento->:=""
				ARRAY LONGINT:C221($DA_Return;0)
				$ad_HorasBloqueadasFechas{0}:=ad_date1{$i}
				AT_SearchArray (->$ad_HorasBloqueadasFechas;"=";->$DA_Return)
				For ($i_horas;1;Size of array:C274($DA_Return))
					$y_detalleEvento->:=$y_detalleEvento->+$at_HorasBloqueadasMotivo{$DA_Return{$i_horas}}+" - "+Time string:C180($al_HoraDesde{$DA_Return{$i_horas}})+" > "+Time string:C180($al_HoraHasta{$DA_Return{$i_horas}})+"\r"
				End for 
			End if 
			
		: (Current date:C33(*)=ad_date1{$i})
			$l_colorFondo:=color RGB white
			$l_colorTexto:=color RGB green
			OBJECT SET FONT STYLE:C166($y_diaCalendario->;Bold:K14:2)
			
		: (($l_numeroMes<$l_mesActual) | ($l_numeroMes>$l_mesActual))
			$y_mes->:=$t_nombreMes
			$l_colorFondo:=color RGB ivory
			$l_colorTexto:=color RGB darkgray
			
			
		: ($l_numeroMes=$l_mesActual)
			$y_mes->:=""
			$l_colorFondo:=color RGB ivory
			$l_colorTexto:=Black:K11:16
	End case 
	
	OBJECT SET RGB COLORS:C628($y_mes->;$l_colorTexto;$l_colorFondo)
	OBJECT SET RGB COLORS:C628($y_detalleEvento->;$l_colorTexto;$l_colorFondo)
	OBJECT SET RGB COLORS:C628($y_diaCalendario->;$l_colorTexto;$l_colorFondo)
End for 
  //OBJECT SET ENABLED(bprevMonth;$d_primeraFecha>=vdSTR_Periodos_InicioEjercicio)
  //OBJECT SET ENABLED(bNextMonth;$d_ultimaFecha<=vdSTR_Periodos_FinEjercicio)
If ($d_primeraFecha>=vdSTR_Periodos_InicioEjercicio)
	_O_ENABLE BUTTON:C192(bprevMonth)
Else 
	_O_DISABLE BUTTON:C193(bprevMonth)
End if 

If ($d_ultimaFecha<=vdSTR_Periodos_FinEjercicio)
	_O_ENABLE BUTTON:C192(bNextMonth)
Else 
	_O_DISABLE BUTTON:C193(bNextMonth)
End if 


  // PASO 2: busco los eventos a visualizar y los cargo en arreglos
QUERY:C277([Alumnos_Calificaciones:208];[Alumnos:2]curso:20=[Cursos:3]Curso:1;*)
QUERY:C277([Alumnos_Calificaciones:208]; & ;[Alumnos_Calificaciones:208]Año:3=<>gYear)
CREATE SET:C116([Alumnos_Calificaciones:208];"Calificaciones")  //20170301 171873
  // obtengo los eventos relacionados con las asignaturas
DISTINCT VALUES:C339([Alumnos_Calificaciones:208]ID_Asignatura:5;$al_IdAsignaturas)
QUERY WITH ARRAY:C644([Asignaturas_Eventos:170]ID_asignatura:1;$al_IdAsignaturas)
QUERY SELECTION:C341([Asignaturas_Eventos:170];[Asignaturas_Eventos:170]Fecha:2>=ad_date1{1};*)
QUERY SELECTION:C341([Asignaturas_Eventos:170]; & [Asignaturas_Eventos:170]Fecha:2<=ad_date1{Size of array:C274(ad_date1)})
  //QUERY SELECTION([Asignaturas_Eventos];[Asignaturas_Eventos]UserID=<>lUSR_CurrentUserID;*)
  //QUERY SELECTION([Asignaturas_Eventos]; | [Asignaturas_Eventos]Privado=False)//20170301 171873
SET AUTOMATIC RELATIONS:C310(True:C214;False:C215)
SELECTION TO ARRAY:C260([Asignaturas_Eventos:170];$al_recNumEvento;[Asignaturas_Eventos:170]Fecha:2;$ad_fechaEvento;[Asignaturas_Eventos:170]Fecha:2;$ad_fechaEvento;[Asignaturas_Eventos:170]Evento:3;$at_eventos;[Asignaturas:18]Abreviación:26;$at_abreviacion;[Asignaturas:18]Numero:1;$al_IdAsignaturas)
SET AUTOMATIC RELATIONS:C310(False:C215;False:C215)

USE SET:C118("Calificaciones")  //20170301 171873
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_alumnos)
For ($i;1;Size of array:C274($al_recNumEvento))
	
	QUERY SELECTION:C341([Alumnos_Calificaciones:208];[Alumnos_Calificaciones:208]ID_Asignatura:5=$al_IdAsignaturas{$i})  //20170301 171873
	  //QUERY([Alumnos_Calificaciones];[Alumnos_Calificaciones]ID_Asignatura=$al_IdAsignaturas{$i};*)
	  //QUERY([Alumnos_Calificaciones]; & ;[Alumnos]Curso=[Cursos]Curso;*)
	  //QUERY([Alumnos_Calificaciones]; & ;[Alumnos_Calificaciones]Año=<>gYear)
	$l_celda:=Find in array:C230(ad_date1;$ad_fechaEvento{$i})
	$y_Celda:=OBJECT Get pointer:C1124(Object named:K67:5;"vt_Events"+String:C10($l_celda))
	$t_textoCelda:=Substring:C12($at_abreviacion{$i}+" - "+$at_eventos{$i};1;25)+"\r"
	If ($l_alumnos<[Cursos:3]Numero_de_Alumnos:11)
		$y_Celda->:=$y_Celda->+IT_SetTextStyle_Italic (->$t_textoCelda)
	Else 
		$y_Celda->:=$y_Celda->+$t_textoCelda
	End if 
End for 
SET QUERY DESTINATION:C396(Into current selection:K19:1)
  //20170301 171873
CLEAR SET:C117("Calificaciones")
UNLOAD RECORD:C212([Alumnos_Calificaciones:208])
REDUCE SELECTION:C351([Alumnos_Calificaciones:208];0)  //20170301 171873
$l_ms:=Milliseconds:C459-$l_ms
FORM GOTO PAGE:C247(8)