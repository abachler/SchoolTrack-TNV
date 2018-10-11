  // [xShell_MensajesAplicacion].Editor.hl_modulos()
  // Por: Alberto Bachler: 25/03/13, 15:17:10
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

Case of 
	: (Form event:C388=On Selection Change:K2:29)
		vl_tipoSeleccion:=2
		MSG_ProcesaEventos ("ListaAcciones")
		
	: (Form event:C388=On Clicked:K2:4)
		vl_tipoSeleccion:=2
		MSG_ProcesaEventos ("ListaAcciones")
		
	: (Form event:C388=On Data Change:K2:15)
		MSG_ProcesaEventos ("EdicionComponente")
		
End case 
