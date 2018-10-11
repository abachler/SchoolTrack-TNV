$el:=Num:C11(Self:C308->)+3
If ($el<=Size of array:C274(<>aWeeks))
	<>aWeeks:=$el
Else 
	<>aWeeks:=<>currWeek
End if 
sWeek:=<>aWeeks{<>aWeeks}
dDate1:=Date:C102(Substring:C12(sweek;1;10))
dDate2:=Date:C102(Substring:C12(sweek;14;10))
sMonth:=""
vt_periodo:=""
bToday:=0