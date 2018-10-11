//%attributes = {}
  //DT_SetCalendar

C_DATE:C307($1;$2)
ARRAY DATE:C224(adSTR_Calendario_Feriados;0)
$dateFrom:=$1
$dateTo:=$2
$yearFrom:=Year of:C25($dateFrom)
$yearTo:=Year of:C25($dateTo)
$sabadoLaborable:=False:C215

For ($i_Years;$yearFrom;$yearTo)
	$firstDateOfYear:=DT_GetDateFromDayMonthYear (1;1;$i_Years)
	$lastDateOfYear:=DT_GetDateFromDayMonthYear (31;12;$i_Years)
	SORT ARRAY:C229(adSTR_Calendario_Feriados;<)
	
	For ($i;Size of array:C274(adSTR_Calendario_Feriados);1;-1)
		If (adSTR_Calendario_Feriados{$i}<$firstDateOfYear)
			DELETE FROM ARRAY:C228(adSTR_Calendario_Feriados;$i)
		End if 
	End for 
	$date:=$firstDateOfYear
	If (Not:C34($sabadoLaborable))
		Repeat 
			If ((Day number:C114($date)=Sunday:K10:19) | (Day number:C114($date)=Saturday:K10:18))
				$el:=Find in array:C230(adSTR_Calendario_Feriados;$date)
				If ($el<0)
					INSERT IN ARRAY:C227(adSTR_Calendario_Feriados;1;1)
					adSTR_Calendario_Feriados{1}:=$date
				End if 
			End if 
			$Date:=$date+1
		Until ($date>$lastDateOfYear)
	Else 
		Repeat 
			If (Day number:C114($date)=Sunday:K10:19)
				$el:=Find in array:C230(adSTR_Calendario_Feriados;$date)
				If ($el<0)
					INSERT IN ARRAY:C227(adSTR_Calendario_Feriados;1;1)
					adSTR_Calendario_Feriados{1}:=$date
				End if 
			End if 
			$Date:=$date+1
		Until ($date>$lastDateOfYear)
	End if 
	SORT ARRAY:C229(adSTR_Calendario_Feriados;>)
	
	Case of 
		: (<>vtXS_CountryCode="cl")
			LIST TO ARRAY:C288("XS_FeriadosChile";$atextDates)
		Else 
			ARRAY TEXT:C222($atextDates;0)
	End case 
	
	
	For ($i_Feriados;1;Size of array:C274($atextDates))
		$day:=Num:C11(ST_GetWord ($atextDates{$i_Feriados};1;"/"))
		$month:=Num:C11(ST_GetWord ($atextDates{$i_Feriados};2;"/"))
		$date:=DT_GetDateFromDayMonthYear ($day;$month;$i_Years)
		If (Find in array:C230(adSTR_Calendario_Feriados;$date)=-1)
			AT_Insert (0;1;->adSTR_Calendario_Feriados)
			adSTR_Calendario_Feriados{Size of array:C274(adSTR_Calendario_Feriados)}:=$date
		End if 
	End for 
End for 