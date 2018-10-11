$count:=Count in array:C907(abQR_SNEnviar;True:C214)
$condicionHabilitarBoton:=(Get edited text:C655#"") & (vdQR_SNDisponibleDesde#!00-00-00!) & ($count>0)
OBJECT SET ENABLED:C1123(bEnviar;$condicionHabilitarBoton)