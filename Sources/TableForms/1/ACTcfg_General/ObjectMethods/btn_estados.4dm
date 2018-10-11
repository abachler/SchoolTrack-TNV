vlACT_idFormaDePago:=-16
vbACT_mostrarEstadoXDef:=True:C214
WDW_OpenFormWindow (->[ACT_EstadosFormasdePago:201];"EstadosFormasDePago";-1;4;__ ("Configuración de estados para ")+ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->vlACT_idFormaDePago))
DIALOG:C40([ACT_EstadosFormasdePago:201];"EstadosFormasDePago")
CLOSE WINDOW:C154
vbACT_mostrarEstadoXDef:=False:C215