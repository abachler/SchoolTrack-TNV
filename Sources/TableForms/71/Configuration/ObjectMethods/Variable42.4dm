  //`TRACE
C_TEXT:C284(varmes)
varmes:=""
If (<>atXS_MonthNames=0)
	<>atXS_MonthNames:=Month of:C24(Current date:C33)
End if 
varmes:=<>atXS_MonthNames{<>atXS_MonthNames}
CAL_FillMonth 