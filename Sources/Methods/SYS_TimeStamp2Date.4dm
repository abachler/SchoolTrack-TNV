//%attributes = {}
  //SYS_TimeStamp2Date

  // Time stamp to date Project Method
  // Time stamp to date ( Long ) -> Date
  // Time stamp to date ( Time stamp ) -> Extracted date

C_DATE:C307($0)
C_LONGINT:C283($1)

$0:=!1995-01-01!+($1\86400)
