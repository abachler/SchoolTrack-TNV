//%attributes = {}
  //CU_SintesisAnualInasistencias

C_REAL:C285($vl_Total;$vr_Total)
C_LONGINT:C283(vi_Total;vi_Inasistencias;$idAlumno)
vi_Inasistencias:=0
vi_Horas:=0
vr_Porcentaje:=0

$arrayPointer:=$1
$size:=Size of array:C274($arrayPointer->)
$months:=12

ARRAY INTEGER:C220(aInt1;$size)
ARRAY REAL:C219(aReel1;$size)
ARRAY REAL:C219(aReel2;$size)
ARRAY INTEGER:C220(amonth1;$size)
ARRAY INTEGER:C220(amonth2;$size)
ARRAY INTEGER:C220(amonth3;$size)
ARRAY INTEGER:C220(amonth4;$size)
ARRAY INTEGER:C220(amonth5;$size)
ARRAY INTEGER:C220(amonth6;$size)
ARRAY INTEGER:C220(amonth7;$size)
ARRAY INTEGER:C220(amonth8;$size)
ARRAY INTEGER:C220(amonth9;$size)
ARRAY INTEGER:C220(amonth10;$size)
ARRAY INTEGER:C220(amonth11;$size)
ARRAY INTEGER:C220(amonth12;$size)
ARRAY TEXT:C222(aText2;$months)

PERIODOS_LoadData ([Cursos:3]Nivel_Numero:7)
$modoRegistroAsistencia:=KRL_GetNumericFieldData (->[xxSTR_Niveles:6]NoNivel:5;->[Cursos:3]Nivel_Numero:7;->[xxSTR_Niveles:6]AttendanceMode:3)

ARRAY INTEGER:C220(ai_NumerosMes;12)
$mes:=Month of:C24(vdSTR_Periodos_InicioEjercicio)
For ($i;1;12)
	ai_NumerosMes{$i}:=$mes+$i-1
End for 

Case of 
	: ($modoRegistroAsistencia=1)
		
		
		For ($i;1;$size)
			$idAlumno:=$arrayPointer->{$i}
			$mes:=Month of:C24(vdSTR_Periodos_InicioEjercicio)
			$year:=<>gYear
			For ($k;1;12)
				$d1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
				$d2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mes;$year);$mes;$year)
				$ptr:=Get pointer:C304("aMonth"+String:C10($k))
				aText2{$k}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
				QUERY:C277([Alumnos_Inasistencias:10];[Alumnos_Inasistencias:10]Alumno_Numero:4=$idAlumno;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1>=$d1;*)
				QUERY:C277([Alumnos_Inasistencias:10]; & [Alumnos_Inasistencias:10]Fecha:1<=$d2)
				$ptr->{$i}:=Records in selection:C76([Alumnos_Inasistencias:10])
				If ($mes=12)
					$mes:=1
					$year:=$year+1
				Else 
					$mes:=$mes+1
				End if 
			End for 
			
			
			$numeroNivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$idAlumno;->[Alumnos:2]nivel_numero:29)
			$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($numeroNivel)+"."+String:C10($idAlumno)
			AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Inasistencias_Dias:30;->$vl_Total)
			aInt1{$i}:=$vl_Total
			aReel1{$i}:=Round:C94(viSTR_Calendario_DiasAHoy-aInt1{$i}/viSTR_Calendario_DiasAHoy*100;1)
			aReel2{$i}:=Round:C94(viSTR_Periodos_DiasAgno-aInt1{$i}/viSTR_Periodos_DiasAgno*100;1)
		End for 
		
		
		
	: ($modoRegistroAsistencia=2)
		
		ARRAY POINTER:C280(ay_Meses;12)
		AT_Inc (0)
		ay_Meses{AT_Inc }:=->aMonth1
		ay_Meses{AT_Inc }:=->aMonth2
		ay_Meses{AT_Inc }:=->aMonth3
		ay_Meses{AT_Inc }:=->aMonth4
		ay_Meses{AT_Inc }:=->aMonth5
		ay_Meses{AT_Inc }:=->aMonth6
		ay_Meses{AT_Inc }:=->aMonth7
		ay_Meses{AT_Inc }:=->aMonth8
		ay_Meses{AT_Inc }:=->aMonth9
		ay_Meses{AT_Inc }:=->aMonth10
		ay_Meses{AT_Inc }:=->aMonth11
		ay_Meses{AT_Inc }:=->aMonth12
		For ($i;1;$size)
			AL_HorasInasistencia ("Mensual";$arrayPointer->{$i};->ay_Meses;->$i)
			vi_total:=0
			vr_porcentaje:=0
			AL_HorasInasistencia ("Total";$arrayPointer->{$i};->vi_Inasistencias;->vr_Porcentaje;->vi_Horas)
			aInt1{$i}:=vi_Inasistencias
			aReel1{$i}:=vi_Horas
			aReel2{$i}:=vr_Porcentaje
		End for 
		
		
		
	: ($modoRegistroAsistencia=4)
		ARRAY POINTER:C280(ay_Meses;12)
		AT_Inc (0)
		AT_Initialize (->aMonth1;->aMonth2;->aMonth3;->aMonth4;->aMonth5;->aMonth6;->aMonth7;->aMonth8;->aMonth9;->aMonth10;->aMonth11;->aMonth12)
		For ($i;1;$size)
			$idAlumno:=$arrayPointer->{$i}
			$numeroNivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$idAlumno;->[Alumnos:2]nivel_numero:29)
			$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($numeroNivel)+"."+String:C10($idAlumno)
			KRL_FindAndLoadRecordByIndex (->[Alumnos_SintesisAnual:210]LlavePrincipal:5;->$key;False:C215)
			aInt1{$i}:=[Alumnos_SintesisAnual:210]Inasistencias_Horas:31
			aReel1{$i}:=[Alumnos_SintesisAnual:210]HorasEfectivas:32
			aReel2{$i}:=[Alumnos_SintesisAnual:210]PorcentajeAsistencia:33
		End for 
		
End case 

