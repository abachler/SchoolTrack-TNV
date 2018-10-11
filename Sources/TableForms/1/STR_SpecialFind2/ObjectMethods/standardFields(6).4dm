If (Self:C308->>0)
	Case of 
		: (Self:C308->=1)
			<>aWeeks:=<>currWeek-1
		: (Self:C308->=2)
			<>aWeeks:=<>currWeek
	End case 
	sWeek:=Self:C308->{Self:C308->}
	dDate1:=Date:C102(Substring:C12(sweek;1;10))
	$date2:=Substring:C12(sweek;Position:C15(" al ";sweek)+3)
	dDate2:=Date:C102($date2)
	sMonth:=""
	vt_periodo:=""
	d2Today:=0
	d1LastSevenDays:=0
Else 
	Self:C308->:=<>currWeek
End if 