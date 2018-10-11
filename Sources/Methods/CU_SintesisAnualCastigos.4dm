//%attributes = {}
  //CU_SintesisAnualCastigos

  //CU_SintesisAnualAtrasos

C_BOOLEAN:C305($AtrasosInterSesion;$2)
$arrayPointer:=$1
If (Count parameters:C259=2)
	$AtrasosInterSesion:=$2
End if 
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
If (Count parameters:C259=2)
	For ($i;1;$size)
		aInt1{$i}:=0
		$mes:=Month of:C24(vdSTR_Periodos_InicioEjercicio)
		$year:=<>gYear
		For ($k;1;12)
			$d1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
			$d2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mes;$year);$mes;$year)
			$ptr:=Get pointer:C304("aMonth"+String:C10($k))
			aText2{$k}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$arrayPointer->{$i};*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2>=$d1;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2<=$d2;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]EsAtrasoInterSesiones:4=$AtrasosInterSesion)
			$ptr->{$i}:=Records in selection:C76([Alumnos_Atrasos:55])
			aInt1{$i}:=aInt1{$i}+Records in selection:C76([Alumnos_Atrasos:55])
			If ($mes=12)
				$mes:=1
				$year:=$year+1
			Else 
				$mes:=$mes+1
			End if 
		End for 
		
	End for 
	If ($AtrasosInterSesion)
		sCount:="A sesiones de clases"
	Else 
		sCount:="Al inicio de la Jornada"
	End if 
Else 
	For ($i;1;$size)
		aInt1{$i}:=0
		$mes:=Month of:C24(vdSTR_Periodos_InicioEjercicio)
		$year:=<>gYear
		For ($k;1;12)
			$d1:=DT_GetDateFromDayMonthYear (1;$mes;$year)
			$d2:=DT_GetDateFromDayMonthYear (DT_GetLastDay ($mes;$year);$mes;$year)
			$ptr:=Get pointer:C304("aMonth"+String:C10($k))
			aText2{$k}:=Substring:C12(<>atXS_MonthNames{$mes};1;3)
			QUERY:C277([Alumnos_Atrasos:55];[Alumnos_Atrasos:55]Alumno_numero:1=$arrayPointer->{$i};*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2>=$d1;*)
			QUERY:C277([Alumnos_Atrasos:55]; & [Alumnos_Atrasos:55]Fecha:2<=$d2)
			$ptr->{$i}:=Records in selection:C76([Alumnos_Atrasos:55])
			aInt1{$i}:=aInt1{$i}+Records in selection:C76([Alumnos_Atrasos:55])
			If ($mes=12)
				$mes:=1
				$year:=$year+1
			Else 
				$mes:=$mes+1
			End if 
		End for 
		sCount:=""
	End for 
End if 

