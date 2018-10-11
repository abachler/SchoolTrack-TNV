  // [xShell_MensajesAplicacion].Editor.hl_modulos()
  // Por: Alberto Bachler: 25/03/13, 15:17:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


Case of 
	: (Form event:C388=On Selection Change:K2:29)
		vl_tipoSeleccion:=0
		
	: (Form event:C388=On Double Clicked:K2:5)
		MSG_ProcesaEventos ("cargaMensaje")
		PROCESS PROPERTIES:C336(Current process:C322;$t_nombreProceso;$l_estadoProceso;$l_tiempo)
		If ($t_nombreProceso#"Editor de Mensajes")
			ACCEPT:C269
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		vl_tipoSeleccion:=0
		MSG_ProcesaEventos ("cargaMensaje")
		
	: (Form event:C388=On Data Change:K2:15)
		MSG_ProcesaEventos ("EdicionMensaje")
		
End case 



