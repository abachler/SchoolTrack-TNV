//%attributes = {}
  //ACTcfg_AsignaCorrelativoPago

While (Semaphore:C143("CorrelativoPago"))
	DELAY PROCESS:C323(Current process:C322;20)
End while 

ACTcfg_OpcionesCorrelativoPago ("LeeConf")
If (lACT_correlativoPago#0)
	[ACT_Pagos:172]Numero_Interno:39:=lACT_correlativoPago
	lACT_correlativoPago:=lACT_correlativoPago+1
	ACTcfg_OpcionesCorrelativoPago ("GuardaConf")
End if 

CLEAR SEMAPHORE:C144("CorrelativoPago")