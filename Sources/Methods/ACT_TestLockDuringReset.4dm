//%attributes = {}
  //ACT_TestLockDuringReset

C_TEXT:C284($Text;$0)
$0:=""
$Text:=""
If (Records in set:C195("LockedSet")>0)
	USE SET:C118("LockedSet")
	While (Not:C34(End selection:C36($1->)))
		LOCKED BY:C353($1->;$process;$user;$machine;$processname)
		$Text:=$Text+"Registro Nº"+String:C10(Record number:C243($1->))+" en uso por "+$processname+", "+$user+", "+$machine+"\r"
		NEXT RECORD:C51($1->)
	End while 
	$0:=$text+"\r"
Else 
	If ((Table:C252($1)=Table:C252(->[ACT_CuentasCorrientes:175])) & (Not:C34((command) & (shift))))
		$0:="Valores reconfigurados con éxito!!!"+"\r\r"
	Else 
		$0:="Registros eliminados con éxito!!!"+"\r\r"
		command:=False:C215
		shift:=False:C215
	End if 
End if 