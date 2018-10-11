C_LONGINT:C283(vlACT_idFormaDePago)
$line:=AL_GetLine (xALP_FormasdePago)
If ($line>0)
	vlACT_idFormaDePago:=alACT_FormasdePagoID{$line}
	WDW_OpenFormWindow (->[ACT_EstadosFormasdePago:201];"EstadosFormasDePago";-1;4;__ ("Configuración de estados para ")+ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_idFormaDePago))
	DIALOG:C40([ACT_EstadosFormasdePago:201];"EstadosFormasDePago")
	CLOSE WINDOW:C154
End if 