//%attributes = {}
  //DT_EndOfMonth

$year:=Year of:C25($1)
$month:=Month of:C24($1)
Case of 
	: ($month=1)
		$day:=31
	: ($month=2)
		If (Mod:C98($year;4)=0)
			$day:=29
		Else 
			$day:=28
		End if 
	: ($month=3)
		$day:=31
	: ($month=4)
		$day:=30
	: ($month=5)
		$day:=31
	: ($month=6)
		$day:=30
	: ($month=7)
		$day:=31
	: ($month=8)
		$day:=31
	: ($month=9)
		$day:=30
	: ($month=10)
		$day:=31
	: ($month=11)
		$day:=30
	: ($month=12)
		$day:=31
End case 
$0:=DT_GetDateFromDayMonthYear ($day;$month;$year)



