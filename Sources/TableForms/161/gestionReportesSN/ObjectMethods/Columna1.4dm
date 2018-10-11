C_BOOLEAN:C305($bool)
If ((Macintosh command down:C546) | (Windows Ctrl down:C562))
	$bool:=Self:C308->{Self:C308->}
	AT_Populate (Self:C308;->$bool)
End if 

$count:=Count in array:C907(abQR_SNEnviar;True:C214)
$condicionHabilitarBoton:=(vtQR_SNNombre#"") & (vdQR_SNDisponibleDesde#!00-00-00!) & ($count>0)
OBJECT SET ENABLED:C1123(bEnviar;$condicionHabilitarBoton)