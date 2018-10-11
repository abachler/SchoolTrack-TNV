C_LONGINT:C283($vl_numDecimales)
$vl_numDecimales:=Num:C11(ACTcar_OpcionesGenerales ("NumeroDecimales";->vtACT_moneda))
vrACT_recargoMulta1:=Round:C94(vrACT_recargoMulta1;$vl_numDecimales)