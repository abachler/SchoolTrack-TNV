//%attributes = {}
  // Método: DT_GetStartEndWeekDates (refdate:D ; dateSunday:Y ;dateSaturday:Y; weeksOffset)
  // devuelve las fechas de inicio y fin (domingo y sábado) de la semana en relación a la fecha de referencia (date)
  // si se pasa weeksOffset (negativo o positivo) devuelve las fechas de N semanas antes o después de la semana actual
  //
  // creado por Alberto Bachler Klein
  // el 12/03/18, 11:10:59
  // ––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––––

C_DATE:C307($1;$d_refDate)
C_POINTER:C301($2;$y_dateSunday)
C_POINTER:C301($3;$y_dateSaturday)
C_LONGINT:C283($4;$l_weeksOffset)

$d_refDate:=$1
$y_dateSunday:=$2
$y_dateSaturday:=$3

If (Count parameters:C259=4)
	$l_weeksOffset:=$4
End if 

If (Count parameters:C259>=3)
	
	Case of 
		: ($l_weeksOffset<0)
			$y_dateSunday->:=$d_refDate-(7*$l_weeksOffset*(-1))-(Day number:C114($d_refDate)-1)
			
		: ($l_weeksOffset>0)
			$y_dateSunday->:=$d_refDate+(7*$l_weeksOffset)-(Day number:C114($d_refDate)-1)
			
		Else 
			$y_dateSunday->:=$d_refDate-(Day number:C114($d_refDate)-1)
	End case 
	
	$y_dateSaturday->:=$y_dateSunday->+6
	
End if 


