If (INET_IntranetColegiumDisponible )  //20110817 ABK, para evitar error si no está conectado a Internet
	WDW_OpenFormWindow (->[xShell_Reports:54];"Repositorio";-1;_o_Compositing mode form window:K39:13)
	DIALOG:C40([xShell_Reports:54];"Repositorio")
	CLOSE WINDOW:C154
	HL_ClearList (HlRIN_Informes_Resultado;HlRIN_Informes;hlRIN_Tipo;hlRIN_Modulos;hlRIN_Paneles)
	QR_BuildReportHList 
	QR_LoadSelectedReport 
Else 
	CD_Dlog (0;__ ("Su computador no está conectado a Internet.\r\rNo es posible acceder al repositorio de informes."))
End if 
