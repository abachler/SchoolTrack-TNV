C_TEXT:C284($dts;$vt_Text)
C_DATE:C307($vd_dateNextExecution)
C_TIME:C306($vh_NextExecution)

GET LIST ITEM:C378(aHL_schedule;Selected list items:C379(aHL_schedule);$autoUpdate;$vt_Text)
PREF_Set (0;"CommTrack Updates";String:C10($autoUpdate))

OBJECT SET VISIBLE:C603(vh_NextExec;True:C214)
Case of 
	: ($autoUpdate=1)
		vh_NextExec:=String:C10(Current time:C178(*)+?00:15:00?)
		
	: ($autoUpdate=2)
		vh_NextExec:=String:C10(Current time:C178(*)+?00:30:00?)
		
	: ($autoUpdate=3)
		vh_NextExec:=String:C10(Current time:C178(*)+?01:00:00?)
		
	: ($autoUpdate=4)
		vh_NextExec:=String:C10(Current time:C178(*)+?02:00:00?)
		
	: ($autoUpdate=5)
		vh_NextExec:=String:C10(Current time:C178(*)+?04:00:00?)
		
	: ($autoUpdate=6)
		OBJECT SET VISIBLE:C603(vh_NextExec;False:C215)
		
End case 

If (Time:C179(vh_NextExec)>?24:00:00?)
	$vh_NextExecution:=Time:C179(vh_NextExec)-?24:00:00?
	vh_NextExec:=String:C10($vh_NextExecution)
	$vd_dateNextExecution:=Current date:C33(*)+1
Else 
	$vh_NextExecution:=Time:C179(vh_NextExec)
	$vd_dateNextExecution:=Current date:C33(*)
End if 

$dts:=DTS_MakeFromDateTime ($vd_dateNextExecution;$vh_NextExecution)

PREF_Set (0;"CommTrack NextSend";$dts)

vh_NextExec:=vh_NextExec+" estimado..."

  //MONO: chequeo que el proceso de envio automatico este retrasado (delay process) en el servidor
  // si es así lo resumo para que lea la nueva preferencia que le estoy entregando en este selector, esto facilita para hacer pruebas sin tener que esperar.
$status:=PCS_CheckProcessOnServer ("Envío de datos Commtrack")

If ($status=1)  //delayed
	C_TEXT:C284($vt_nameprocess)
	C_LONGINT:C283($processID)
	$vt_nameprocess:="Envío de datos Commtrack"
	$processID:=Execute on server:C373("PCS_ResumeProcess";64000;"PCS_ResumeProcess";$vt_nameprocess)
End if 
