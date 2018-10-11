//%attributes = {}
  // Método: ACTut_fFechaValida2
  //----------------------------------------------
  // Usuario (OS): roberto
  // Fecha: 11-09-10, 15:59:28
  // ---------------------------------------------
  // Descripción: 
  // 
  // Parámetros:
  // 
  //----------------------------------------------
  // Declaraciones e inicializaciones


  // Código principal

  // ----------------------------------------------------
C_DATE:C307($0;$1;$date)
C_LONGINT:C283($day;$month;$year)
$date:=$1
$day:=Day of:C23($Date)
$month:=Month of:C24($Date)
$year:=Year of:C25($Date)

$lastDay:=DT_GetLastDay2 ($date)
If ($Day>$lastDay)
	$day:=$lastDay
End if 
$date:=DT_GetDateFromDayMonthYear ($day;$month;$year)

While ((Month of:C24($Date)>$month) | (Year of:C25($Date)>$year))
	$Date:=$date-1
End while 

$0:=$date