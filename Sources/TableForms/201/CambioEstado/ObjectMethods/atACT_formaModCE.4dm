C_LONGINT:C283($vl_idEstado)
$vl_idEstado:=alACT_formaModCE{Self:C308->}
If (KRL_GetBooleanFieldData (->[ACT_EstadosFormasdePago:201]id:1;->$vl_idEstado;->[ACT_EstadosFormasdePago:201]anula_pago:10))
	Self:C308->:=0
	CD_Dlog (0;__ ("Esta opción no aplica para los pagos con estado ")+__ ("nulo")+".")
End if 