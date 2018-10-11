//%attributes = {}
  //SYS_TimeStamp2Time

  // Time stamp to time Project Method
  // Time stamp to time ( Long ) -> Date
  // Time stamp to time ( Time stamp ) -> Extracted time

C_TIME:C306($0)
C_LONGINT:C283($1)

$0:=Time:C179(Time string:C180(0+($1%86400)))
