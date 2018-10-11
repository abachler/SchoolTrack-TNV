  // ActualizacionVersion.bOpenCSM()
  // Por: Alberto Bachler K.: 04-12-14, 08:51:59
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------


$l_itemSeleccionado:=Pop up menu:C542(__ ("Recontruir la base de datos")+";(-;"+__ ("Abrir Centro de Seguridad y Mantenimiento"))

Case of 
	: ($l_itemSeleccionado=3)
		  // abrir CSM
		vl_OperacionReparacion:=1
		CANCEL:C270
		
		  //: ($l_itemSeleccionado=3)
		  //  //reconstruccion de indexes
		  //vl_OperacionReparacion:=2
		  //CANCEL
		
	: ($l_itemSeleccionado=1)
		  // reconstruir BD
		vl_OperacionReparacion:=3
		CANCEL:C270
		
End case 
