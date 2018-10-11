//%attributes = {}
  //PCS_CheckProcess

  //Process State Respuestas
  //Does not exist -100
  //Aborted -1
  //Executing 0
  //Delayed 1
  //Waiting for user event 2
  //Waiting for input output 3
  //Waiting for internal flag 4
  //Paused 5
  //Hidden modal dialog 6

C_BOOLEAN:C305(<>vb_check_process_state)
<>vb_check_process_state:=False:C215
C_TEXT:C284($1;$vt_proc_name)
C_LONGINT:C283($vl_proc_num;<>vl_check_process_state;$0)

<>vl_check_process_state:=-100
$vt_proc_name:=$1
$vl_proc_num:=Process number:C372($vt_proc_name)
If ($vl_proc_num#0)
	<>vl_check_process_state:=Process state:C330($vl_proc_num)
End if 

<>vb_check_process_state:=True:C214
$0:=<>vl_check_process_state