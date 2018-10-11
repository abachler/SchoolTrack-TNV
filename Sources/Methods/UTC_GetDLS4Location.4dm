//%attributes = {}
  //UTC_GetDLS4Location

C_DATE:C307($1;$fechaActual)
C_BOOLEAN:C305($0;$DLS)

$fechaActual:=$1
$countryCode:=$2
$city:=$3

Case of 
	: ($countryCode="ie")
		$fecha:=DT_GetDateFromDayMonthYear (1;3;Year of:C25($fechaActual))
		While (Month of:C24($fecha)=3)
			$day:=DT_GetDayNumber_ISO8601 ($fecha)
			If ($day=7)
				$fechaMarzo:=$fecha
			End if 
			$fecha:=$fecha+1
		End while 
		$fecha:=DT_GetDateFromDayMonthYear (1;10;Year of:C25($fechaActual))
		While (Month of:C24($fecha)=10)
			$day:=DT_GetDayNumber_ISO8601 ($fecha)
			If ($day=7)
				$fechaOctubre:=$fecha
			End if 
			$fecha:=$fecha+1
		End while 
		$DLS:=False:C215
		If ($fechaActual<$fechaOctubre)
			If ($fechaActual>$fechaMarzo)
				$DLS:=True:C214
			End if 
		End if 
		$0:=$DLS
	: ($countryCode="cl")
		$fecha:=DT_GetDateFromDayMonthYear (1;10;Year of:C25($fechaActual))
		$dom:=0
		While ($dom<2)
			$day:=DT_GetDayNumber_ISO8601 ($fecha)
			If ($day=7)
				$dom:=$dom+1
			End if 
			$fecha:=$fecha+1
		End while 
		$fechaOctubre:=$fecha-1
		$fecha:=DT_GetDateFromDayMonthYear (1;3;Year of:C25($fechaActual))
		$dom:=0
		While ($dom<2)
			$day:=DT_GetDayNumber_ISO8601 ($fecha)
			If ($day=7)
				$dom:=$dom+1
			End if 
			$fecha:=$fecha+1
		End while 
		$fechaMarzo:=$fecha-1
		$DLS:=False:C215
		If ($fechaActual<$fechaOctubre)
			If ($fechaActual<$fechaMarzo)
				$DLS:=True:C214
			End if 
		Else 
			$DLS:=True:C214
		End if 
		$0:=$DLS
	: ($countryCode="mx")
		If ($city#"Sonora")
			$fecha:=DT_GetDateFromDayMonthYear (1;4;Year of:C25($fechaActual))
			$dom:=0
			While ($dom<1)
				$day:=DT_GetDayNumber_ISO8601 ($fecha)
				If ($day=7)
					$dom:=$dom+1
				End if 
				$fecha:=$fecha+1
			End while 
			$fechaAbril:=$fecha-1
			$fecha:=DT_GetDateFromDayMonthYear (1;10;Year of:C25($fechaActual))
			While (Month of:C24($fecha)=10)
				$day:=DT_GetDayNumber_ISO8601 ($fecha)
				If ($day=7)
					$fechaOctubre:=$fecha
				End if 
				$fecha:=$fecha+1
			End while 
			$DLS:=False:C215
			If ($fechaActual<$fechaOctubre)
				If ($fechaActual>$fechaAbril)
					$DLS:=True:C214
				End if 
			End if 
			$0:=$DLS
		Else 
			$0:=False:C215
		End if 
	Else 
		$0:=False:C215
End case 