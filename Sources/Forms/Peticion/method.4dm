  // Peticion()
  // Por: Alberto Bachler K.: 02-09-14, 10:23:46
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_abajoFondo;$l_abajoMensaje;$l_abajoObjeto;$l_abajoRespuesta;$l_abajoTitulo;$l_altoBoton;$l_altoMensaje;$l_altoRespuesta;$l_altoTitulo)
C_LONGINT:C283($l_anchoBoton;$l_anchoMensaje;$l_anchoMinimo;$l_anchoRespuesta;$l_anchoTitulo;$l_arriba;$l_arribaMensaje;$l_arribaObjeto;$l_arribaRespuesta;$l_arribaTitulo)
C_LONGINT:C283($l_bottom;$l_derecha;$l_derechaBoton2;$l_derechaBoton3;$l_derechaMensaje;$l_derechaObjeto;$l_derechaRespuesta;$l_derechaTitulo;$l_izquierda;$l_izquierdaMensaje)
C_LONGINT:C283($l_izquierdaObjeto;$l_izquierdaRespuesta;$l_izquierdaTitulo;$l_left;$l_PosicionBotonesY;$l_PosicionMensajeY;$l_PosicionTituloY;$l_right;$l_top;$l_variacionV)

Case of 
	: (Form event:C388=On Load:K2:1)
		If (vt_respuesta="")
			OBJECT SET TITLE:C194(*;"respuestaTextoEjemplo";vt_pregunta)
			OBJECT SET VISIBLE:C603(*;"respuestaTextoEjemplo";vt_Pregunta#"")
		Else 
			OBJECT SET VISIBLE:C603(*;"respuestaTextoEjemplo";False:C215)
		End if 
		If (vt_ListaValores#"")
			$l_anchoMinimo:=420
			OBJECT SET VISIBLE:C603(*;"respuestaListaAsociada";True:C214)
		Else 
			$l_anchoMinimo:=440
			OBJECT SET VISIBLE:C603(*;"respuestaListaAsociada";False:C215)
		End if 
		
		
		If ((vt_titulo="") & (vt_mensaje#""))
			vt_titulo:=vt_mensaje
			vt_mensaje:=""
		End if 
		OBJECT GET COORDINATES:C663(*;"titulo";$l_izquierdaTitulo;$l_arribaTitulo;$l_derechaTitulo;$l_abajoTitulo)
		OBJECT GET BEST SIZE:C717(*;"titulo";$l_anchoTitulo;$l_altoTitulo;462)
		$l_abajoTitulo:=$l_arribaTitulo+$l_altoTitulo
		IT_SetNamedObjectRect ("titulo";$l_izquierdaTitulo;$l_arribaTitulo;$l_derechaTitulo;$l_abajoTitulo)
		OBJECT GET COORDINATES:C663(*;"titulo";$l_izquierdaTitulo;$l_arribaTitulo;$l_derechaTitulo;$l_abajoTitulo)
		$l_PosicionMensajeY:=$l_abajoTitulo+18
		$l_PosicionBotonesY:=$l_abajoTitulo+36
		$l_abajoFondo:=$l_PosicionMensajeY+18
		
		
		If (vt_mensaje#"")
			OBJECT GET COORDINATES:C663(*;"mensaje";$l_izquierdaMensaje;$l_arribaMensaje;$l_derechaMensaje;$l_abajoMensaje)
			OBJECT GET BEST SIZE:C717(*;"mensaje";$l_anchoMensaje;$l_altoMensaje;448)
			IT_SetNamedObjectRect ("mensaje";$l_izquierdaMensaje;$l_PosicionMensajeY;$l_derechaMensaje;$l_PosicionMensajeY+$l_altoMensaje)
			OBJECT GET COORDINATES:C663(*;"mensaje";$l_izquierdaMensaje;$l_arribaMensaje;$l_derechaMensaje;$l_abajoMensaje)
			$l_posicionRespuestaY:=$l_abajoMensaje+18
			$l_PosicionBotonesY:=$l_abajoMensaje+36
			$l_abajoFondo:=$l_abajoMensaje+18
		End if 
		
		OBJECT GET COORDINATES:C663(*;"respuestaVariable";$l_izquierdaRespuesta;$l_arribaRespuesta;$l_derechaRespuesta;$l_abajoRespuesta)
		If ($l_posicionRespuestaY>$l_arribaRespuesta)
			$l_desplazamientoVertical:=$l_posicionRespuestaY-$l_arribaRespuesta
			OBJECT MOVE:C664(*;"respuesta@";0;$l_desplazamientoVertical)
		End if 
		
		
		
		OBJECT GET COORDINATES:C663(*;"respuestaVariable";$l_izquierdaRespuesta;$l_arribaRespuesta;$l_derechaRespuesta;$l_abajoRespuesta)
		OBJECT GET BEST SIZE:C717(*;"respuestaVariable";$l_anchoRespuesta;$l_altoRespuesta;$l_anchoRespuesta)
		$l_abajoRespuesta:=$l_arribaRespuesta+$l_altoRespuesta
		IT_SetNamedObjectRect ("respuestaVariable";$l_izquierdaRespuesta;$l_arribaRespuesta;$l_izquierdaRespuesta+$l_anchoMinimo;$l_abajoRespuesta)
		OBJECT GET COORDINATES:C663(*;"respuestaVariable";$l_izquierdaRespuesta;$l_arribaRespuesta;$l_derechaRespuesta;$l_abajoRespuesta)
		$l_PosicionBotonesY:=$l_abajoRespuesta+36
		$l_abajoFondo:=$l_abajoRespuesta+18
		
		
		IT_SetNamedObjectRect ("fondo";-5;-5;550;$l_abajoFondo)
		
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
			IT_SetNamedObjectRect ("boton1";$l_izquierdaObjeto;$l_PosicionBotonesY;$l_derechaObjeto;$l_abajoObjeto)
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
			IT_SetNamedObjectRect ("boton2";$l_izquierdaObjeto;$l_PosicionBotonesY;$l_derechaObjeto;$l_abajoObjeto)
			
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
			IT_SetNamedObjectRect ("boton3";$l_izquierdaObjeto;$l_PosicionBotonesY;$l_derechaObjeto;$l_abajoObjeto)
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
		
		GOTO OBJECT:C206(vt_respuesta)
		
	: (Form event:C388=On Clicked:K2:4)
		
		
		
End case 