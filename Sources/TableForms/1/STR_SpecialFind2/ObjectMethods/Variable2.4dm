If (Self:C308->>0)
	dDate1:=DT_GetDateFromDayMonthYear (1;Self:C308->;<>gYear)
	dDate2:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 (dDate1);Self:C308->;<>gYear)
	sMonth:=Self:C308->{Self:C308->}
	vt_periodo:=""
	sWeek:=""
	d2Today:=0
	d1LastSevenDays:=0
Else 
	Self:C308->:=Month of:C24(Current date:C33)
End if 