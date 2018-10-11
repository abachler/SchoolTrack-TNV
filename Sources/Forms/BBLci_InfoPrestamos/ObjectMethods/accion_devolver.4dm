  // [BBL_Prestamos].ListaPrestamos_Lector.Botón invisible()
  // Por: Alberto Bachler: 25/10/13, 10:51:41
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_BOOLEAN:C305($b_aplicarReglaItems)
C_LONGINT:C283($l_abajo;$l_AltoOptimo;$l_anchoMaximo;$l_anchoOptimo;$l_Arriba;$l_derecha;$l_diasAtraso;$l_diasDeGracia;$l_izquierda;$l_recNumLector)
C_LONGINT:C283($l_recNumPrestamo;$l_seleccionPrestamo)
C_POINTER:C301($y_encabezado;$y_mensaje1;$y_mensaje2)
C_REAL:C285($r_multa;$r_multaDiaria;$r_multaMaxima)
C_TEXT:C284($t_asunto;$t_copia;$t_encabezado;$t_fecha;$t_formatoMoneda;$t_lector;$t_mensaje;$t_mensaje1;$t_mensaje2;$t_nombre)
C_TEXT:C284($t_titulo;$t_reserva)

Case of 
	: (Form event:C388=On Clicked:K2:4)
		  //OBJECT SET VISIBLE(*;"encabezado@";False)
		
		KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;True:C214)
		KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]ID:3;->[BBL_Prestamos:60]Número_de_registro:1;True:C214)
		KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Prestamos:60]Número_de_Item:11;True:C214)
		COPY NAMED SELECTION:C331([BBL_Prestamos:60];"prestamos")
		$l_seleccionPrestamo:=Selected record number:C246([BBL_Prestamos:60])
		$l_recNumLector:=Record number:C243([BBL_Lectores:72])
		$l_recNumPrestamo:=Record number:C243([BBL_Prestamos:60])
		KRL_GotoRecord (->[BBL_Prestamos:60];$l_recNumPrestamo)
		If (OK=1)
			KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;True:C214)
		End if 
		If (OK=1)
			KRL_FindAndLoadRecordByIndex (->[BBL_Registros:66]ID:3;->[BBL_Prestamos:60]Número_de_registro:1;True:C214)
		End if 
		If (OK=1)
			KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Prestamos:60]Número_de_Item:11;True:C214)
		End if 
		
		If (OK=1)  // todos los registros que requieren ser actualizados fueron cargados en escritura
			$t_encabezado:="¿Registrar la devolución de la copia Nº^2 de ^1 prestado a ^0 hasta el ^3?"
			  //$t_encabezado:=IT_SetTextColor_Hexa (->$t_encabezado;0x007F7F7F)
			$t_nombre:=[BBL_Lectores:72]Nombre_Comun:35
			$t_titulo:=[BBL_Items:61]Primer_título:4
			$t_copia:=String:C10([BBL_Registros:66]Número_de_copia:2)
			$t_fecha:=String:C10([BBL_Prestamos:60]Hasta:4;System date long:K1:3)
			$t_encabezado:=Replace string:C233($t_encabezado;"^0";$t_nombre)
			$t_encabezado:=Replace string:C233($t_encabezado;"^1";$t_titulo)
			$t_encabezado:=Replace string:C233($t_encabezado;"^2";$t_copia)
			$t_encabezado:=Replace string:C233($t_encabezado;"^3";$t_Fecha)
			$y_encabezado:=OBJECT Get pointer:C1124(Object named:K67:5;"$t_encabezado")
			$y_encabezado->:=$t_encabezado
			
			If ((Current date:C33(*)-[BBL_Prestamos:60]Hasta:4)>0)
				  // si corresponde una multa solicito al usuario confirmación para aplicar la multa y pago
				KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaItems:69]Codigo_regla:1;->[BBL_Items:61]Regla:20;False:C215)
				KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;->[BBL_Lectores:72]Regla:4;False:C215)
				$r_multaMaxima:=[xxBBL_ReglasParaUsuarios:64]Multa_maxima:7
				$b_aplicarReglaItems:=([xxBBL_ReglasParaItems:69]Multa_diaria:5>[xxBBL_ReglasParaUsuarios:64]MultaDiaria:13) & ([xxBBL_ReglasParaUsuarios:64]ReglaPrimaSobreReglasItems:15=False:C215)
				$r_multaDiaria:=Choose:C955($b_aplicarReglaItems;[xxBBL_ReglasParaItems:69]Multa_diaria:5;[xxBBL_ReglasParaUsuarios:64]MultaDiaria:13)
				$b_aplicarReglaItems:=([xxBBL_ReglasParaUsuarios:64]Gracia_multa:14>[xxBBL_ReglasParaItems:69]Dias_gracia:4) & ([xxBBL_ReglasParaUsuarios:64]ReglaPrimaSobreReglasItems:15=False:C215)
				$l_diasAtraso:=Current date:C33(*)-[BBL_Prestamos:60]Hasta:4
				$l_diasDeGracia:=Choose:C955($b_aplicarReglaItems;[xxBBL_ReglasParaItems:69]Dias_gracia:4;[xxBBL_ReglasParaUsuarios:64]Gracia_multa:14)
				If ($l_diasAtraso>[xxBBL_ReglasParaItems:69]Dias_gracia:4)
					$r_multa:=$r_multaDiaria*($l_diasAtraso-$l_diasDeGracia)
				End if 
			End if 
			
			$y_montoMulta:=OBJECT Get pointer:C1124(Object named:K67:5;"montoMulta")
			$y_montoMulta->:=$r_multa
			
			$y_recNumPrestamo:=OBJECT Get pointer:C1124(Object named:K67:5;"recNumPrestamo")
			$y_recNumPrestamo->:=$l_recNumPrestamo
			
			QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_Item:2=[BBL_Registros:66]Número_de_item:1)
			ORDER BY:C49([BBL_Reservas:115];[BBL_Reservas:115]From:5;<;[BBL_Reservas:115]ID:1;<)
			REDUCE SELECTION:C351([BBL_Reservas:115];1)
			KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Reservas:115]ID_User:3;False:C215)
			If ([BBL_Lectores:72]eMail:41#"")
				$t_asunto:=__ ("Notificacion de MediaTrack: Tu reserva está disponible.")
				$t_Reserva:=__ ("^0 tiene una reserva sobre un ejemplar de ^1\rSi desea puede puede enviar un correo electrónico notificando la disponibilidad de una copia de este ítem.")
				$t_nombre:=[BBL_Lectores:72]Nombre_Comun:35
				$t_titulo:=[BBL_Items:61]Primer_título:4
				$t_Reserva:=Replace string:C233($t_Reserva;"^0";IT_SetTextStyle_Bold (->$t_nombre))
				$t_Reserva:=Replace string:C233($t_Reserva;"^1";IT_SetTextStyle_Bold (->$t_titulo))
			End if 
			
			OBJECT GET COORDINATES:C663(*;"$t_encabezado";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
			OBJECT GET BEST SIZE:C717(*;"$t_encabezado";$l_anchoOptimo;$l_altoOptimo;IT_Objeto_Ancho ("$t_encabezado"))
			IT_SetNamedObjectRect ("$t_encabezado";$l_izquierda;$l_Arriba;$l_derecha;$l_Arriba+$l_altoOptimo)
			OBJECT GET COORDINATES:C663(*;"$t_encabezado";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
			$l_ProximoBloque_PosicionV:=$l_abajo+14
			If ($l_diasAtraso>0)
				o2_Multa:=1
				$t_formatoMoneda:="|Pesos"
				OBJECT SET VISIBLE:C603(*;"$t_opcionMulta@";True:C214)
				$t_opcionMulta:="La devolución de este item se efectua con ^0 día(s) de retraso. Se debiera aplicar una multa de ^1\rPor favor seleccione una de las opciones siguientes:"
				$t_opcionMulta:=Replace string:C233($t_opcionMulta;"^0";String:C10($l_diasAtraso))
				$t_opcionMulta:=Replace string:C233($t_opcionMulta;"^1";String:C10($r_multa;$t_formatoMoneda))
				$y_OpcionMulta:=OBJECT Get pointer:C1124(Object named:K67:5;"$t_opcionMulta")
				$y_OpcionMulta->:=$t_opcionMulta
				OBJECT GET COORDINATES:C663(*;"$t_opcionMulta";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba
				OBJECT MOVE:C664(*;"$t_opcionMulta";0;$l_desplazamientoV)
				OBJECT GET COORDINATES:C663(*;"$t_opcionMulta";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				OBJECT GET BEST SIZE:C717(*;"$t_opcionMulta";$l_anchoOptimo;$l_altoOptimo;IT_Objeto_Ancho ("$t_opcionMulta"))
				IT_SetNamedObjectRect ("$t_opcionMulta";$l_izquierda;$l_Arriba;$l_derecha;$l_Arriba+$l_altoOptimo)
				OBJECT GET COORDINATES:C663(*;"$t_opcionMulta";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_ProximoBloque_PosicionV:=$l_abajo+14
				
				OBJECT SET VISIBLE:C603(*;"opcionMulta@";True:C214)
				OBJECT GET COORDINATES:C663(*;"opcionMulta@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba
				OBJECT MOVE:C664(*;"opcionMulta@";0;$l_desplazamientoV)
				OBJECT GET COORDINATES:C663(*;"opcionMulta@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_ProximoBloque_PosicionV:=$l_abajo+14
			Else 
				OBJECT SET VISIBLE:C603(*;"$t_opcionMulta@";False:C215)
				OBJECT SET VISIBLE:C603(*;"opcionMulta@";False:C215)
			End if 
			
			
			If ($t_reserva#"")
				$y_Reserva:=OBJECT Get pointer:C1124(Object named:K67:5;"$t_reserva")
				$y_Reserva->:=$t_reserva
				OBJECT SET VISIBLE:C603(*;"$t_reserva";True:C214)
				If ($l_diasAtraso=0)
					OBJECT SET VISIBLE:C603(*;"$t_opcionMulta@";False:C215)
					OBJECT SET VISIBLE:C603(*;"opcionMulta@";False:C215)
					OBJECT SET VISIBLE:C603(*;"$t_reservaSeparador";False:C215)
				Else 
					OBJECT SET VISIBLE:C603(*;"$t_reservaSeparador";True:C214)
					OBJECT GET COORDINATES:C663(*;"$t_reservaSeparador";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
					$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba
					OBJECT MOVE:C664(*;"$t_reservaSeparador";0;$l_desplazamientoV)
					OBJECT GET COORDINATES:C663(*;"$t_reservaSeparador";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
					$l_ProximoBloque_PosicionV:=$l_abajo+14
				End if 
				OBJECT GET COORDINATES:C663(*;"$t_reserva";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba
				OBJECT MOVE:C664(*;"$t_reserva";0;$l_desplazamientoV)
				OBJECT GET COORDINATES:C663(*;"$t_reserva";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				OBJECT GET BEST SIZE:C717(*;"$t_reserva";$l_anchoOptimo;$l_altoOptimo;IT_Objeto_Ancho ("$t_reserva"))
				IT_SetNamedObjectRect ("$t_reserva";$l_izquierda;$l_Arriba;$l_derecha;$l_Arriba+$l_altoOptimo)
				OBJECT GET COORDINATES:C663(*;"$t_reserva";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_ProximoBloque_PosicionV:=$l_abajo+14
				
				OBJECT SET VISIBLE:C603(*;"$t_reservaNotificacion";True:C214)
				OBJECT GET COORDINATES:C663(*;"$t_reservaNotificacion";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba
				OBJECT MOVE:C664(*;"$t_reservaNotificacion";0;$l_desplazamientoV)
				OBJECT GET COORDINATES:C663(*;"$t_reservaNotificacion";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
				$l_ProximoBloque_PosicionV:=$l_abajo+14
				
			Else 
				OBJECT SET VISIBLE:C603(*;"$t_reserva@";False:C215)
			End if 
			OBJECT GET COORDINATES:C663(*;"boton@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
			$l_desplazamientoV:=$l_ProximoBloque_PosicionV-$l_Arriba+14
			OBJECT MOVE:C664(*;"boton@";0;$l_desplazamientoV)
			OBJECT GET COORDINATES:C663(*;"boton@";$l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
			
			  //ajuste de la posición de la ventana
			GET WINDOW RECT:C443($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_abajoV)
			$l_abajoV:=$l_ArribaV+$l_abajo+13
			SET WINDOW RECT:C444($l_izquierdaV;$l_ArribaV;$l_derechaV;$l_abajoV)
			WDW_AjustaPosicionVentana 
			OBJECT SET VISIBLE:C603(*;"accion@";False:C215)
			FORM GOTO PAGE:C247(3)
		Else 
			GET WINDOW RECT:C443($l_izquierda;$l_Arriba;$l_derecha;$l_abajo)
			SET WINDOW RECT:C444($l_izquierda;$l_Arriba;$l_derecha;$l_abajo+51)
			OBJECT SET VISIBLE:C603(*;"mensaje";True:C214)
		End if 
		
	: (Form event:C388=On Mouse Enter:K2:33)
		$t_lector:=[BBL_Lectores:72]Nombre_Comun:35
		$t_titulo:=KRL_GetTextFieldData (->[BBL_Items:61]Numero:1;->[BBL_Prestamos:60]Número_de_Item:11;->[BBL_Items:61]Primer_título:4)
		IT_SetTextStyle_Bold (->$t_lector)
		IT_SetTextStyle_Bold (->$t_titulo)
		$t_mensaje:=__ ("Haga clic para registrar la devolución de ^1 actualmente prestado a ^0")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_lector)
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_Titulo)
		IT_MuestraTip (ST Get plain text:C1092($t_mensaje);0;True:C214)
		
	: (Form event:C388=On Mouse Leave:K2:34)
		CALL SUBFORM CONTAINER:C1086(-5)  //ocultar tip 
End case 
