//%attributes = {}
  //DT_GetWeekNumber

  //Procedure: GetWeekNumber
  //return the week number(1-52) for the current date.
  //by Michael Cook

C_LONGINT:C283($0)
C_DATE:C307($TestDate;$StartDate)

$Year:=Year of:C25(Current date:C33)

$TestDate:=Date:C102("01/02/03")
Case of 
	: (Day of:C23($TestDate)=1)  //if day =1 format is DD/MM/YY
		$StartDate:=Date:C102("01/01/"+String:C10($Year))  //jan 1st
	: (Month of:C24($TestDate)=1)  //if month =1 format is MM/DD/YY
		$StartDate:=Date:C102("01/01/"+String:C10($Year))
	: (Year of:C25($TestDate)=1901) & (Month of:C24($TestDate)=2)  //if Year=1901 & Month=2 format is YY/MM/DD
		$StartDate:=Date:C102(String:C10($Year)+"/01/01")
	: (Year of:C25($TestDate)=1901) & (Day of:C23($TestDate)=2)  //if Year=1901 & Day=2 format is YY/DD/MM
		$StartDate:=Date:C102(String:C10($Year)+"/01/01")
End case 

$0:=Int:C8((Current date:C33-$StartDate)/7)+1