//%attributes = {}
  //BBLio_ConvAlexDate

If ($1#"")
	$text:=$1
	$month:=Substring:C12($text;1;3)
	$text:=Substring:C12($text;5)
	$day:=Substring:C12($text;1;Position:C15(" ";$text)-1)
	$text:=Substring:C12($text;Position:C15(" ";$text)+1)
	$year:=Substring:C12($text;1;2)
	Case of 
		: (($month="JAN") | ($month="ENE"))
			$m:=1
		: (($month="FEB") | ($month="FEB"))
			$m:=2
		: (($month="MAR") | ($month="MAR"))
			$m:=3
		: (($month="APR") | ($month="ABR"))
			$m:=4
		: (($month="MAY") | ($month="MAY"))
			$m:=5
		: (($month="JUN") | ($month="JUN"))
			$m:=6
		: (($month="JUL") | ($month="JUL"))
			$m:=7
		: (($month="AUG") | ($month="AGO"))
			$m:=8
		: (($month="SEP") | ($month="SEP"))
			$m:=9
		: (($month="OCT") | ($month="OCT"))
			$m:=10
		: (($month="NOV") | ($month="NOV"))
			$m:=11
		: (($month="DEC") | ($month="DEC"))
			$m:=12
		Else 
			$m:=0
	End case 
	$0:=DT_GetDateFromDayMonthYear (Num:C11($day);$m;Num:C11($year))
End if 