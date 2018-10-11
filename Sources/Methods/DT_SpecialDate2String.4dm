//%attributes = {}
  //DT_SpecialDate2String




  //DECLARATIONS
_O_C_STRING:C293(255;$strdate)
C_DATE:C307($1;$date)


  //INITIALIZATION
$date:=$1
$strDate:=""

  //MAIN CODE
If ($date#!00-00-00!)
	Case of 
		: (<>tXS_RS_DateFormat="D@")
			$strDate:=String:C10(Day of:C23($date);"00")+" de "+<>atXS_MonthNames{Month of:C24($date)}+" de "+String:C10(Year of:C25($date);"0000")
		: (<>tXS_RS_DateFormat="M@")
			$strDate:=<>atXS_MonthNames{Month of:C24($date)}+", "+String:C10(Day of:C23($date);"00")+", "+String:C10(Year of:C25($date);"0000")
	End case 
Else 
	$strDate:=""
End if 
$0:=$strDate
  //END OF METHOD 



