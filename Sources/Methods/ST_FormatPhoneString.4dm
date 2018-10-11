//%attributes = {}
  //ST_FormatPhoneString

$1:=Replace string:C233($1;" ";"")
Case of 
	: (Length:C16($1)=4)
		$0:=String:C10(Num:C11($1);"## ##")
	: (Length:C16($1)=5)
		$0:=String:C10(Num:C11($1);"### ##")
	: (Length:C16($1)=6)
		$0:=String:C10(Num:C11($1);"## ## ##")
	: (Length:C16($1)=7)
		$0:=String:C10(Num:C11($1);"### ## ##")
	: (Length:C16($1)=8)
		$0:=String:C10(Num:C11($1);"#### ####")
	: (Length:C16($1)=9)
		$0:=String:C10(Num:C11($1);"### ## ## ##")
	: (Length:C16($1)=10)
		$0:=String:C10(Num:C11($1);"### ### ####")
	: (Length:C16($1)=11)
		$0:=String:C10(Num:C11($1);"### ## ## ## ##")
	: (Length:C16($1)=12)
		$0:=String:C10(Num:C11($1);"### ## ### ## ##")
	Else 
		$0:=$1
End case 