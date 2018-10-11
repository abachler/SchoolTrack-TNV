//%attributes = {}
  //PCS_CheckProcessOnServer

C_TEXT:C284($1;$vt_process_name)
C_LONGINT:C283($processID;$process_state;<>vl_check_process_state)
C_BOOLEAN:C305($ok;<>vb_check_process_state)

$vt_process_name:=$1
$processID:=Execute on server:C373("PCS_CheckProcess";Pila_256K;"Check_Process_On_Server";$vt_process_name)
DELAY PROCESS:C323(Current process:C322;60)  //permitir que el proceso se inicie
$ok:=False:C215
While (Not:C34($ok))
	GET PROCESS VARIABLE:C371(-1;<>vb_check_process_state;$ok)
End while 
GET PROCESS VARIABLE:C371(-1;<>vl_check_process_state;$process_state)

$0:=$process_state