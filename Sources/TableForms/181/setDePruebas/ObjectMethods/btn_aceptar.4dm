C_TEXT:C284($vt_tipo)
$vt_tipo:=ST_GetWord (at_tipoDocumento{at_tipoDocumento};1;":")

If ((vt_referencia="") & (($vt_tipo="61") | ($vt_tipo="56")))
	CD_Dlog (0;"Debe seleccionar el caso de prueba de referencia")
Else 
	$vb_ok:=Num:C11(ACTdte_setPruebasOpcionesGen ("GuardaCaso"))
	If ($vb_ok=1)
		ACCEPT:C269
	End if 
End if 