//%attributes = {}
  //SYS_TimeStamp

  // SYS_Time stamp Project Method
  // SYS_Time stamp (int {;date ; Time})-> Long
  // SYS_Time stamp { ( date ; Time ) } -> Number of seconds since Jan, 1st 1995
  //$1=1 return date & time from server, $1=0 return date & time from client
C_LONGINT:C283($1)
C_DATE:C307($2;$vdDate)
C_TIME:C306($3;$vhTime)
C_LONGINT:C283($0)

Case of 
	: (Count parameters:C259=0)
		$vdDate:=Current date:C33(*)
		$vhTime:=Current time:C178(*)
	Else 
		$vdDate:=$2
		$vhTime:=$3
End case 
$0:=(($vdDate-!1995-01-01!)*86400)+$vhTime