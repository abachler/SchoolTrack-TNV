//%attributes = {}
  //CFG_ExecuteMethod

$item:=1
$method:=atXS_ConfigMethods{$item}
If (API Does Method Exist ($method)=1)
	$error:=KRL_ExecuteMethod ($method)
	If ($error=-3)
		EXECUTE FORMULA:C63($method)
	End if 
Else 
	$ignore:=CD_Dlog (0;__ ("No se ha definido ninguna acción ejecutable para este item."))
End if 
