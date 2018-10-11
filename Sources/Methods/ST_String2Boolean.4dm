//%attributes = {}
  //ST_String2Boolean

_O_C_STRING:C293(80;$1)
C_BOOLEAN:C305($0)
Case of 
	: ($1="Si")
		$0:=True:C214
	: ($1="no")
		$0:=False:C215
	Else 
		$0:=False:C215
End case 