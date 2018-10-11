//%attributes = {}
  //0xDev_Execute

$string2Execute:=CD_Request (__ ("Instrucciones a ejecutar:");__ ("Ejecutar");__ ("Cancelar"))

If (Application version:C493>="0800")
	$string2Execute:=Replace string:C233($string2Execute;"Automatic Relations";"Set Automatic Relations")
End if 
EXE_Execute ($string2Execute)

