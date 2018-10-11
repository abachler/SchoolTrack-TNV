//%attributes = {}
  //DT_GetDayNameFromDate

If (False:C215)
	  //Method: dt_DayNameFromDate
	  //Written by  Administrateur on 07/09/98
	  //Module: 
	  //Purpose: 
	  //Syntax:  dt_DayNameFromDate()
	  //Parameters:
	  //Copyright 1998 Transeo Chile
	<>ST_v5003:=False:C215
End if 


  //DECLARATIONS
_O_C_STRING:C293(30;$0)
C_DATE:C307($1)
C_LONGINT:C283($day)


  //INITIALIZATION
$day:=Day number:C114($1)

  //MAIN CODE
$0:=<>atXS_DayNames{$day}