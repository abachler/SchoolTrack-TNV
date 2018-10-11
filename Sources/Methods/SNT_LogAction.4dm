//%attributes = {}
  //SNT_LogAction

If (False:C215)
	  // Project method: SNT_Logaction
	  // Module: 
	  // Purpose:
	  // Syntax: SNT_Logaction()
	  // Parameters:
	  // Result: None
	
	  // HISTORY
	  // ============================================
	  // Created on: 9/9/00  09:55, by Alberto Bachler
	  // 
	  // 
End if 

  // DECLARATIONS
  // ============================================


  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
C_TEXT:C284($1;$2;$4;$eventType;$event;$generatedBy;$error;vt_mailText)
C_LONGINT:C283($3;$errorcode)
$eventType:=$1
$event:=$2
Case of 
	: (Count parameters:C259=4)
		$errorCode:=$3
		$generatedBy:=$4
		
	: (Count parameters:C259=3)
		$errorCode:=$3
		$generatedBy:=""
	: (Count parameters:C259=2)
		$errorCode:=0
		$generatedBy:=""
		$error:=""
End case 
If ($errorCode#0)
	$error:="(Error N° "+String:C10($errorCode)+")"
End if 

$t_fechaObsoleta:=Add to date:C393(Current date:C33(*);0;0;-30)
SET QUERY LIMIT:C395(1)
QUERY:C277([xxSNT_LOG:93];[xxSNT_LOG:93]_date:1<=$t_fechaObsoleta)
SET QUERY LIMIT:C395(0)
If (Records in selection:C76([xxSNT_LOG:93])=0)
	CREATE RECORD:C68([xxSNT_LOG:93])
End if 
[xxSNT_LOG:93]Event:3:=$event
[xxSNT_LOG:93]EventType:4:=$eventType
[xxSNT_LOG:93]_error:5:=$errorCode
[xxSNT_LOG:93]_date:1:=Current date:C33(*)
[xxSNT_LOG:93]_Time:2:=Current time:C178(*)
[xxSNT_LOG:93]Modulo:8:=SchoolNet
If ($generatedBy="")
	[xxSNT_LOG:93]GeneratedBy:7:=Current system user:C484
End if 
[xxSNT_LOG:93]MachineName:6:=Current machine:C483

SAVE RECORD:C53([xxSNT_LOG:93])
vt_mailText:=vt_mailText+$eventType+"\t"+String:C10([xxSNT_LOG:93]_date:1;Internal date short:K1:7)+", "+String:C10([xxSNT_LOG:93]_Time:2;HH MM:K7:2)+"\t"+$event+"\t"+$error+"\r"
UNLOAD RECORD:C212([xxSNT_LOG:93])


  // END OF METHOD