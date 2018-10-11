  // Notificacion()
  // Por: Alberto Bachler: 06/11/13, 13:03:28
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajoMensaje;$l_abajoObjeto;$l_abajoTitulo;$l_altoBoton;$l_altoMensaje;$l_altoTitulo;$l_anchoBoton;$l_anchoMensaje;$l_anchoTitulo;$l_arribaMensaje)
C_LONGINT:C283($l_arribaObjeto;$l_arribaTitulo;$l_bottom;$l_derechaBoton2;$l_derechaBoton3;$l_derechaMensaje;$l_derechaObjeto;$l_derechaTitulo;$l_izquierdaMensaje;$l_izquierdaObjeto)
C_LONGINT:C283($l_izquierdaTitulo;$l_left;$l_PosicionBotonesY;$l_PosicionMensajeY;$l_PosicionTituloY;$l_right;$l_top;$l_variacionV)



Case of 
	: (Form event:C388=On Load:K2:1)
		OBJECT GET COORDINATES:C663(*;"fondo";$l_ignorar;$l_ignorar;$l_derechaFondo;$l_ignorar)
		If (vt_titulo#"")
			OBJECT GET COORDINATES:C663(*;"titulo";$l_izquierdaTitulo;$l_arribaTitulo;$l_derechaTitulo;$l_abajoTitulo)
			OBJECT GET BEST SIZE:C717(*;"titulo";$l_anchoTitulo;$l_altoTitulo;$l_derechaFondo-20)  //;462)
			$l_abajoTitulo:=$l_arribaTitulo+$l_altoTitulo
			IT_SetNamedObjectRect ("titulo";$l_izquierdaTitulo;$l_arribaTitulo;$l_derechaTitulo;$l_abajoTitulo)
			OBJECT GET COORDINATES:C663(*;"titulo";$l_izquierdaTitulo;$l_arribaTitulo;$l_derechaTitulo;$l_abajoTitulo)
			$l_PosicionMensajeY:=$l_abajoTitulo+18
			$l_PosicionBotonesY:=$l_abajoTitulo+36
			$l_abajoFondo:=$l_PosicionMensajeY+18
		Else 
			OBJECT GET COORDINATES:C663(*;"titulo";$l_izquierdaTitulo;$l_arribaTitulo;$l_derechaTitulo;$l_abajoTitulo)
			OBJECT GET COORDINATES:C663(*;"mensaje";$l_izquierdaMensaje;$l_arribaMensaje;$l_derechaMensaje;$l_abajoMensaje)
			IT_SetNamedObjectRect ("mensaje";$l_izquierdaMensaje;$l_arribaTitulo;$l_derechaMensaje;$l_abajoMensaje)
			$l_PosicionMensajeY:=$l_arribaTitulo
		End if 
		
		
		If (vt_mensaje#"")
			OBJECT GET COORDINATES:C663(*;"mensaje";$l_izquierdaMensaje;$l_arribaMensaje;$l_derechaMensaje;$l_abajoMensaje)
			$l_maxAncho:=$l_derechaFondo-20-$l_izquierdaMensaje
			OBJECT GET BEST SIZE:C717(*;"mensaje";$l_anchoMensaje;$l_altoMensaje;$l_maxAncho)  //;448)
			IT_SetNamedObjectRect ("mensaje";$l_izquierdaMensaje;$l_PosicionMensajeY;$l_derechaMensaje;$l_PosicionMensajeY+$l_altoMensaje)
			OBJECT GET COORDINATES:C663(*;"mensaje";$l_izquierdaMensaje;$l_arribaMensaje;$l_derechaMensaje;$l_abajoMensaje)
			$l_PosicionBotonesY:=$l_abajoMensaje+36
			$l_abajoFondo:=$l_abajoMensaje+18
		End if 
		IT_SetNamedObjectRect ("fondo";-5;-5;$l_derechaFondo+10;$l_abajoFondo)
		
		
		If (vb_OpcionNoRepetir)
			OBJECT GET COORDINATES:C663(vl_NoRepetirNotificacion;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
			$l_abajoObjeto:=$l_PosicionBotonesY+IT_Objeto_Alto ("noPreguntar")
			IT_SetNamedObjectRect ("noPreguntar";$l_izquierdaObjeto;$l_PosicionBotonesY;$l_derechaObjeto;$l_abajoObjeto)
			$l_PosicionBotonesY:=$l_abajoObjeto+20
			vl_NoRepetirNotificacion:=0
		Else 
			OBJECT SET VISIBLE:C603(vl_NoRepetirNotificacion;False:C215)
		End if 
		vl_NoRepetirNotificacion:=0
		
		
		If (cdS_Btn1#"")
			OBJECT SET VISIBLE:C603(cdB_btn1;True:C214)
			OBJECT SET TITLE:C194(cdB_btn1;cdS_Btn1)
			OBJECT GET BEST SIZE:C717(cdB_btn1;$l_anchoBoton;$l_altoBoton)
			If ($l_anchoBoton<80)
				$l_anchoBoton:=80
			End if 
			OBJECT GET COORDINATES:C663(cdB_btn1;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
			$l_izquierdaObjeto:=$l_derechaObjeto-$l_anchoBoton
			$l_abajoObjeto:=$l_PosicionBotonesY+$l_altoBoton
			IT_SetNamedObjectRect ("boton1";$l_izquierdaObjeto-20;$l_PosicionBotonesY;$l_derechaObjeto;$l_abajoObjeto)
		End if 
		
		If (cdS_Btn2#"")
			OBJECT SET VISIBLE:C603(cdB_btn2;True:C214)
			OBJECT SET TITLE:C194(cdB_btn2;cdS_Btn2)
			OBJECT GET BEST SIZE:C717(cdB_btn2;$l_anchoBoton;$l_altoBoton)
			If ($l_anchoBoton<80)
				$l_anchoBoton:=80
			End if 
			OBJECT GET COORDINATES:C663(cdB_btn1;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
			$l_derechaBoton2:=$l_izquierdaObjeto-13
			$l_izquierdaObjeto:=$l_derechaBoton2-$l_anchoBoton
			$l_derechaObjeto:=$l_izquierdaObjeto+$l_anchoBoton
			$l_abajoObjeto:=$l_PosicionBotonesY+$l_altoBoton
			IT_SetNamedObjectRect ("boton2";$l_izquierdaObjeto-20;$l_PosicionBotonesY;$l_derechaObjeto;$l_abajoObjeto)
			
		End if 
		
		If (cdS_Btn3#"")
			OBJECT SET VISIBLE:C603(cdB_btn3;True:C214)
			OBJECT SET TITLE:C194(cdB_btn3;cdS_Btn3)
			OBJECT GET BEST SIZE:C717(cdB_btn3;$l_anchoBoton;$l_altoBoton)
			If ($l_anchoBoton<80)
				$l_anchoBoton:=80
			End if 
			OBJECT GET COORDINATES:C663(cdB_btn2;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
			$l_derechaBoton3:=$l_izquierdaObjeto-13
			OBJECT GET COORDINATES:C663(cdB_btn3;$l_izquierdaObjeto;$l_arribaObjeto;$l_derechaObjeto;$l_abajoObjeto)
			$l_derechaObjeto:=$l_izquierdaObjeto+$l_anchoBoton
			If ($l_derechaObjeto>$l_derechaBoton3)
				$l_derechaObjeto:=$l_derechaBoton3
			End if 
			$l_abajoObjeto:=$l_PosicionBotonesY+$l_altoBoton
			IT_SetNamedObjectRect ("boton3";$l_izquierdaObjeto-20;$l_PosicionBotonesY;$l_derechaObjeto;$l_abajoObjeto)
		End if 
		
		
		
		
		GET WINDOW RECT:C443($l_left;$l_top;$l_right;$l_bottom)
		If ((cdS_Btn1+cdS_Btn2+cdS_Btn3)="")
			OBJECT SET VISIBLE:C603(*;"cerrar_invisible";True:C214)
			OBJECT SET ENABLED:C1123(*;"cerrar_invisible";True:C214)
			OBJECT GET COORDINATES:C663(*;"fondo";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
			SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_top+$l_abajoFondo)
			IT_SetNamedObjectRect ("cerrar_invisible";$l_izquierda;$l_arriba;$l_derecha;$l_abajo)
		Else 
			OBJECT SET VISIBLE:C603(*;"cerrar_invisible";False:C215)
			OBJECT SET ENABLED:C1123(*;"cerrar_invisible";False:C215)
			SET WINDOW RECT:C444($l_left;$l_top;$l_right;$l_top+$l_PosicionBotonesY+36)
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		
		
		
End case 

