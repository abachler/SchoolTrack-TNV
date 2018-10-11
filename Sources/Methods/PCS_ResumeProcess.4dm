//%attributes = {}
  //PCS_ResumeProcess 

C_TEXT:C284($1;$vt_process_name)
$vt_proc_name:=$1
$vl_proc_num:=Process number:C372($vt_proc_name)

If ($vl_proc_num#0)
	RESUME PROCESS:C320($vl_proc_num)
End if 