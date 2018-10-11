//%attributes = {}
  //SYS_GetFileMSecs

If (False:C215)
	  //method  SYS_GetFileMSecs
	  //by ABK
	  //30/12/97
	  //convert date & modification time to secs
	  //uses 4D Command
	  //SYS_getFileMsecs(document path {;time zone selector})
	  //$1: document path
	  //$2: time zone selector : 0 for GMT, 1 for local time (default)
	
End if 

C_DATE:C307($date)
C_TIME:C306($time)
C_LONGINT:C283($0)
C_REAL:C285($secs)
C_LONGINT:C283($2;$timezone)
If (Count parameters:C259=2)
	$timeZone:=$2
Else 
	$timezone:=1
End if 


GET DOCUMENT PROPERTIES:C477($1;$Locked;$invisible;$dateCreated;$timeCreated;$dateModified;$timeModified)
$secs:=SYS_DateTime2Secs ($dateModified;$timeModified)
$0:=$secs

$date:=SYS_Secs2Date ($secs)
$time:=SYS_Secs2Time ($secs)