//%attributes = {}
  //DT_GetDayNameFromDayNumber

If (False:C215)
	  //Method: dt_GetDayName
	  //Written by  Alberto Bachler on 18/2/98
	  //Purpose: returns the name of the day stored in resources
	  //Parameters:
	  // `$
	  //Syntax:  dt_GetDayName()
	  //Copyright 1998 Transeo Chile
	<>ST_v45011:=False:C215
End if 


  //DECLARATIONS
_O_C_STRING:C293(30;$0)
C_LONGINT:C283($1)

  //INITIALIZATION
$day:=$1

  //MAIN CODE
$0:=<>atXS_DayNames{$day}

