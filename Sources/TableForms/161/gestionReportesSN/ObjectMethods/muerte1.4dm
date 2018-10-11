$Fechafecha:=DT_PopCalendar 

If ($Fechafecha>=Current date:C33(*))
	vdQR_SNDisponibleDesde:=$Fechafecha
Else 
	vdQR_SNDisponibleDesde:=Current date:C33(*)
End if 

$count:=Count in array:C907(abQR_SNEnviar;True:C214)
$condicionHabilitarBoton:=(vtQR_SNNombre#"") & (vdQR_SNDisponibleDesde#!00-00-00!) & ($count>0)
OBJECT SET ENABLED:C1123(bEnviar;$condicionHabilitarBoton)