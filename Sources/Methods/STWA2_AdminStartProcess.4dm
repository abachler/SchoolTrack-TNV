//%attributes = {}
$p:=New process:C317("STWA2_Administracion";128000;"STWA2 Administracion";*)
If ($p#0)
	SHOW PROCESS:C325($p)
	BRING TO FRONT:C326($p)
End if 
