//%attributes = {}
  //SRdh_ExecuteScript

  //20110816 RCH Se hace llamado a EXE_Execute y no al plug in directo...
  //20170509 RCH Se restaura método SR_ExecuteScript para que se ejecute el script con 4D process tags...

C_TEXT:C284($1;$t_string2Execute)
C_TEXT:C284($0)

$t_string2Execute:=$1
$0:=EXE_Execute ($t_string2Execute;False:C215)

