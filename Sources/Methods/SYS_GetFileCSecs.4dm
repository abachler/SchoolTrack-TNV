//%attributes = {}
  //SYS_GetFileCSecs

If (False:C215)
	  //method  SYS_GetFileMSecs
	  //by ABK
	  //30/12/97  
	  //convert date & creation time to secs
	  //SYS_getFileCsecs(document path {;time zone selector})
	  //$1: document path
	  //$2: time zone selector : 0 for GMT, 1 for local time (default)  
	C_DATE:C307($date)
	C_TIME:C306($time)
	C_LONGINT:C283($0)
	C_LONGINT:C283($2;$timezone)
End if 
If (Count parameters:C259=2)
	$timeZone:=$2
Else 
	$timezone:=1
End if 

$date:=xfGetFileCDate ($1)
$time:=xfGetFileCTime ($1)
$secs:=SYS_DateTime2Secs ($date;$time)