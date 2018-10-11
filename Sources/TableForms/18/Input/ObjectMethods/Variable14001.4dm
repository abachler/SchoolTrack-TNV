If (vi_CurrentMonth=12)
	vi_CurrentMonth:=1
	vi_CurrentYear:=vi_CurrentYear+1
Else 
	vi_CurrentMonth:=vi_CurrentMonth+1
End if 
$Date:=DT_GetDateFromDayMonthYear (1;vi_CurrentMonth;vi_CurrentYear)
AS_PageCalendar ($Date)