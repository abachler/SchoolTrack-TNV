If (LICENCIA_esModuloAutorizado (1;12))  //20130227 RCH Se valida licencia.
	KRL_FindAndLoadRecordByIndex (->[ACT_RazonesSociales:279]id:1;->alACTcfg_Razones{atACTcfg_Razones};True:C214)
	If (ok=1)
		WDW_OpenFormWindow (->[ACT_RazonesSociales:279];"ConfiguraciónInicialDTE";-1;4;__ ("Configurar"))
		DIALOG:C40([ACT_RazonesSociales:279];"ConfiguraciónInicialDTE")
		CLOSE WINDOW:C154
	Else 
		CD_Dlog (0;__ ("El registro de la Razón Social ")+[ACT_RazonesSociales:279]razon_social:2+__ (" está en uso. En este momento no es posible entrar a la configuración."))
	End if 
	KRL_ReloadAsReadOnly (->[ACT_RazonesSociales:279])
Else 
	CD_Dlog (0;__ ("Para configurar la emisión de los Documentos Tributarios Electrónicos (DTE) debe contactar a Colegium para que el módulo sea activado."+"\r\r"+"Si el módulo ya fue activado registre licencia y vuelva a intentarlo."))
End if 