  // DLOG_Confirmacion()
  // Por: Alberto Bachler: 20/03/13, 12:12:47
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_alto;$l_Arriba;$l_derecha;$l_izquierda)


Case of 
	: (Form event:C388=On Load:K2:1)
		GET WINDOW RECT:C443($l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		
		Case of 
			: (vt_boton5#"")
				$l_alto:=610
				
			: (vt_boton4#"")
				$l_alto:=509
				
			: (vt_boton3#"")
				$l_alto:=409
				
			: (vt_boton2#"")
				$l_alto:=309
				
		End case 
		SET WINDOW RECT:C444($l_izquierda;$l_Arriba;$l_derecha;$l_Arriba+$l_alto)
		WDW_AjustaPosicionVentana 
		OBJECT SET VISIBLE:C603(bDetalle;vtMSG_Detalle#"")
		
		
	: ((Form event:C388=On Data Change:K2:15) | (Form event:C388=On Clicked:K2:4))
		
	: (Form event:C388=On Close Box:K2:21)
		bCancelar:=1
		CANCEL:C270
		
	: (Form event:C388=On Unload:K2:2)
		
	: (Form event:C388=On Outside Call:K2:11)
		
	: (Form event:C388=On Resize:K2:27)
		
End case 

