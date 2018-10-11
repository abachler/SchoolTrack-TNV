$r:=CD_Dlog (0;__ ("Se reemplazará el modo de pago de todos los apoderados de cuenta.\r¿Desea continuar?");__ ("");__ ("No");__ ("Si"))
If ($r=2)
	ACTcfgfdp_OpcionesGenerales ("aplicaATodosFDPXDef")
	LOG_RegisterEvt ("Aplicación de comando Aplicar forma de pago ahora. Modo de pago asignado: "+ST_Qte (vt_FormadePagoXDef))
End if 