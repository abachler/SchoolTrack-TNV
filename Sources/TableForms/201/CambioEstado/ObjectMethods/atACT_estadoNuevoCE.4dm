C_LONGINT:C283($vl_idEstado)
$vl_idEstado:=alACT_estadoNuevoCE{Self:C308->}
If (KRL_GetBooleanFieldData (->[ACT_EstadosFormasdePago:201]id:1;->$vl_idEstado;->[ACT_EstadosFormasdePago:201]anula_pago:10))
	Self:C308->:=0
	CD_Dlog (0;__ ("El estado del pago ")+__ ("nulo")+__ (" debe ser asignado desde la opción ")+__ ("Anular Pagos"))
End if 