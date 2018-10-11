//%attributes = {}
  //DT_Date2SpanishString



If (False:C215)
	  //Method: dt_GetSpainDate
	  //Written by  Alberto Bachler on 01/01/92
	  //Purpose: returns the date in spanish format
	  //Parameters: $1=date
	  //Syntax:  dt_GetSpainDate(date)
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215  //18/2/98 at 12:53:56 by: Alberto Bachler
	  //Programming style conventions applied
	  //local text variable retype as strings
	  //day is formated as OO and year as 0000
End if 


  //DECLARATIONS
_O_C_STRING:C293(255;$strdate;$month)
C_DATE:C307($1;$date)


  //INITIALIZATION
$date:=$1
$strDate:=""
$day:=String:C10(Day of:C23($date))

ARRAY TEXT:C222($months;12)
ARRAY TEXT:C222($days;7)
$months{1}:="Enero"
$months{2}:="Febrero"
$months{3}:="Marzo"
$months{4}:="Abril"
$months{5}:="Mayo"
$months{6}:="Junio"
$months{7}:="Julio"
$months{8}:="Agosto"
$months{9}:="Septiembre"
$months{10}:="Octubre"
$months{11}:="Noviembre"
$months{12}:="Diciembre"

$days{1}:="Domingo"
$days{2}:="Lunes"
$days{3}:="Martes"
$days{4}:="Miércoles"
$days{5}:="Jueves"
$days{6}:="Viernes"
$days{7}:="Sábado"

$dayName:=$days{Day number:C114($date)}
$month:=$months{Month of:C24($date)}
$year:=String:C10(Year of:C25($date);"0000")

  //MAIN CODE
If ($date#!00-00-00!)
	$strDate:=$dayname+" "+$day+" de "+$month+" de "+$year
Else 
	$strDate:=""
End if 
$0:=$strDate
  //END OF METHOD 



