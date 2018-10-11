//%attributes = {}
  //_Edad

C_DATE:C307($1;$2)
C_TEXT:C284($0)

Case of 
	: (Count parameters:C259=2)
		$0:=DT_ReturnAge ($1;$2)
	Else 
		$0:=DT_ReturnAge ($1)
End case 