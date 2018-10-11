  // [BBL_Prestamos].ListaPrestamos_Lector.Botón invisible()
  // Por: Alberto Bachler: 25/10/13, 10:51:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($l_abajo;$l_abajoV;$l_altoOptimo;$l_anchoOptimo;$l_Arriba;$l_ArribaV;$l_derecha;$l_derechaV;$l_desplazamientoV;$l_izquierda)
C_LONGINT:C283($l_izquierdaV;$l_ProximoBloque_PosicionV)
C_POINTER:C301($y_variable)
C_TEXT:C284($t_diasAtraso;$t_fechaVencimiento;$t_lector;$t_mensaje;$t_solicitud;$t_TextoMail;$t_titulo)


Case of 
	: (Form event:C388=On Clicked:K2:4)
		COPY NAMED SELECTION:C331([BBL_Prestamos:60];"prestamos")
		$t_titulo:=KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->[BBL_Prestamos:60]Número_de_Item:11;->[BBL_Items:61]Primer_título:4)
		
		If ([BBL_Lectores:72]Sexo:23="F")
			$t_TextoMail:=__ ("Estimada ")+[BBL_Lectores:72]Nombre_Comun:35+",\r\r"
		Else 
			$t_TextoMail:=__ ("Estimado ")+[BBL_Lectores:72]Nombre_Comun:35+",\r\r"
		End if 
		
		$t_solicitud:=__ ("¿Enviar correo a ^0 (^1) solicitando la devolución del préstamo de ^2 en mora desde el ^3 (^4)?")
		$t_fechaVencimiento:=DT_fechaAmigable ([BBL_Prestamos:60]Hasta:4;__ ("el");System date long:K1:3)
		
		If ([BBL_Prestamos:60]Días_de_atraso:15>0)
			$t_solicitud:=__ ("¿Enviar correo a ^0 (^1) solicitando la devolución del préstamo de ^2 en mora desde el ^3 (^4)?")
			$t_TextoMail:=$t_TextoMail+__ ("Te recordamos que tienes un ejemplar de ^0 en préstamo.\rDebieras haberlo devuelto ^1\r\rPor favor tráelo de vuelta a la biblioteca cuanto antes, no te expongas al cobro de multas por devolución atrasada.")
			$t_textoMail:=Replace string:C233($t_textoMail;"^0";$t_titulo)
			$t_textoMail:=Replace string:C233($t_textoMail;"^1";$t_fechaVencimiento)
		Else 
			$t_solicitud:=__ ("¿Enviar correo a ^0 (^1) solicitando la devolución anticipada de ^2 (prestado hasta el ^3)?")
			$t_TextoMail:=$t_TextoMail+__ ("Actualmente tienes un ejemplar de ^0 en préstamo hasta ^1.\r\rPuedes devolverlo en esa fecha, pero si no lo estás utilizando te agradeceríamos retornarlo anticipadamente ya que tenemos otras demandas de préstamo sobre este ítem.")
			$t_textoMail:=Replace string:C233($t_textoMail;"^0";$t_titulo)
			$t_textoMail:=Replace string:C233($t_textoMail;"^1";$t_fechaVencimiento)
		End if 
		$t_TextoMail:=$t_TextoMail+"\r\r"+__ ("Saludos, ")+"\r\r"+USR_GetUserName (USR_GetUserID )+"\r"+<>gBBL_NombreBiblioteca
		
		$t_lector:=[BBL_Lectores:72]Nombre_Comun:35
		$t_diasAtraso:=String:C10(Current date:C33(*)-[BBL_Prestamos:60]Hasta:4)+" "+__ ("días de atraso")
		$t_solicitud:=Replace string:C233($t_solicitud;"^0";[BBL_Lectores:72]Nombre_Comun:35)
		$t_solicitud:=Replace string:C233($t_solicitud;"^1";[BBL_Lectores:72]eMail:41)
		$t_solicitud:=Replace string:C233($t_solicitud;"^2";$t_titulo)
		$t_solicitud:=Replace string:C233($t_solicitud;"^3";String:C10([BBL_Prestamos:60]Hasta:4;System date long:K1:3))
		$t_solicitud:=Replace string:C233($t_solicitud;"^4";IT_SetTextColor_Hexa (->$t_diasAtraso;0x00FF0000))
		$y_variable:=OBJECT Get pointer:C1124(Object named:K67:5;"$t_solicitud")
		$y_variable->:=$t_solicitud
		
		$y_variable:=OBJECT Get pointer:C1124(Object named:K67:5;"textomail_texto")
		$y_variable->:=$t_TextoMail
		
		OBJECT GET COORDINATES:C663(*;"$t_solicitud";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		OBJECT GET BEST SIZE:C717(*;"$t_solicitud";$l_anchoOptimo;$l_altoOptimo;IT_Objeto_Ancho ("$t_solicitud"))
		IT_SetNamedObjectRect ("$t_solicitud";$l_izquierda;$l_Arriba;$l_derecha;$l_Arriba+$l_altoOptimo)
		OBJECT GET COORDINATES:C663(*;"$t_solicitud";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		$l_ProximoBloque_PosicionV:=$l_abajo+14
		
		OBJECT GET COORDINATES:C663(*;"textoMail@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba+14
		OBJECT MOVE:C664(*;"textoMail@";0;$l_desplazamientoV)
		OBJECT GET COORDINATES:C663(*;"textoMail@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		$l_ProximoBloque_PosicionV:=$l_abajo+14
		
		OBJECT GET COORDINATES:C663(*;"mail@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba+14
		OBJECT MOVE:C664(*;"mail@";0;$l_desplazamientoV)
		OBJECT GET COORDINATES:C663(*;"mail@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
		
		  //ajuste de la posición de la ventana
		GET WINDOW RECT:C443($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_abajoV)
		SET WINDOW RECT:C444($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_ArribaV+$l_abajo+13)
		WDW_AjustaPosicionVentana 
		
		OBJECT SET VISIBLE:C603(*;"accion@";False:C215)
		FORM GOTO PAGE:C247(2)
		
	: (Form event:C388=On Mouse Enter:K2:33)
		$t_lector:=[BBL_Lectores:72]Nombre_Comun:35
		$t_titulo:=KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->[BBL_Prestamos:60]Número_de_Item:11;->[BBL_Items:61]Primer_título:4)
		$t_mensaje:=__ ("Haga clic para enviar un correo a ^0 solicitando la devolucion de ^1")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_lector)
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_Titulo)
		IT_MuestraTip (ST Get plain text:C1092($t_mensaje);0;True:C214)
		
End case 