$el:=Num:C11(Self:C308->)
If ($el<=Size of array:C274(<>atXS_MonthNames))
	<>atXS_MonthNames:=$el
Else 
	<>atXS_MonthNames:=Month of:C24(Current date:C33)
End if 
dDate1:=DT_GetDateFromDayMonthYear (1;<>atXS_MonthNames;<>gYear)
dDate2:=DT_GetDateFromDayMonthYear (DT_GetLastDay2 (dDate1);<>atXS_MonthNames;<>gYear)
sMonth:=<>atXS_MonthNames{<>atXS_MonthNames}
vt_periodo:=""
sWeek:=""
d2Today:=0
d1LastSevenDays:=0