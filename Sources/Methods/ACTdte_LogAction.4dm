//%attributes = {}
  //ACTdte_LogAction

If (False:C215)
	
End if 

  // DECLARATIONS
  // ============================================


  // INITIALIZATION
  // ============================================


  // MAIN CODE
  // ============================================
C_TEXT:C284($event;$eventType)
C_LONGINT:C283($errorCode)
C_BOOLEAN:C305($vb_registrarEnLog;$vb_enviarMail;$vb_mostrarAlert)

$event:=$1
If (Count parameters:C259>=2)
	$vb_registrarEnLog:=$2
End if 
If (Count parameters:C259>=3)
	$vb_mostrarAlert:=$3
End if 
If (Count parameters:C259>=4)
	$vb_enviarMail:=$4
End if 

If ($event#"")
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
	[xxSNT_LOG:93]Modulo:8:=12  // dte net
	[xxSNT_LOG:93]GeneratedBy:7:=Current system user:C484
	[xxSNT_LOG:93]MachineName:6:=Current machine:C483
	SAVE RECORD:C53([xxSNT_LOG:93])
	UNLOAD RECORD:C212([xxSNT_LOG:93])
	If ($vb_registrarEnLog)
		LOG_RegisterEvt ($event)
	End if 
	If ($vb_mostrarAlert)
		CD_Dlog (0;$event)
	End if 
	If ($vb_enviarMail)
		  // por implementar...
	End if 
End if 

  // END OF METHOD