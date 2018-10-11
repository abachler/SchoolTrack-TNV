//%attributes = {}
  //CU_SintesisAnualPositivas

C_LONGINT:C283($idAlumno)

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
For ($i;1;$size)
	$idAlumno:=$arrayPointer->{$i}
	$mes:=Month of:C24(vdSTR_Periodos_InicioEjercicio)
	$year:=<>gYear
	For ($k;1;12)
		$d1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
		$d2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mes;$year);$mes;$year)
		$ptr:=Get pointer:C304("aMonth"+String:C10($k))
		aText2{$k}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
		QUERY:C277([Alumnos_Anotaciones:11];[Alumnos_Anotaciones:11]Alumno_Numero:6=$idAlumno;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Signo:7="+";*)
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Fecha:1>=$d1;*)
		QUERY:C277([Alumnos_Anotaciones:11]; & [Alumnos_Anotaciones:11]Fecha:1<=$d2)
		$ptr->{$i}:=Records in selection:C76([Alumnos_Anotaciones:11])
		If ($mes=12)
			$mes:=1
			$year:=$year+1
		Else 
			$mes:=$mes+1
		End if 
	End for 
	$vl_Total:=0
	$numeroNivel:=KRL_GetNumericFieldData (->[Alumnos:2]numero:1;->$idAlumno;->[Alumnos:2]nivel_numero:29)
	$key:=String:C10(<>gInstitucion)+"."+String:C10(<>gYear)+"."+String:C10($numeroNivel)+"."+String:C10($idAlumno)
	AL_LeeSintesisAnual ($key;->[Alumnos_SintesisAnual:210]Anotaciones_Positivas:34;->$vl_Total)
	aInt1{$i}:=$vl_Total
End for 


