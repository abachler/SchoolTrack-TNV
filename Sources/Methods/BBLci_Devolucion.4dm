//%attributes = {}
  // BBLci_Devolucion()
  // Por: Alberto Bachler: 25/09/13, 18:45:30
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($b_aplicarReglaItems)
C_LONGINT:C283($l_accion;$l_diasAtraso;$l_diasDeGracia;$l_diasSuspension;$l_indiceLugar;$l_opcionUsuario;$l_puerto;$l_recNumItem;$l_recNumLector;$l_recNumPrestamo)
C_LONGINT:C283($l_recNumRegistro;$l_utilizarSSL;$l_validezReserva)
C_REAL:C285($r_multa;$r_multaDiaria;$r_multaMaxima)
C_TEXT:C284($t_asunto;$t_contraseña;$t_cuentaCorreo;$t_error;$t_formatoMoneda;$t_glosa;$t_lector;$t_lugar;$t_mensaje;$t_nombre)
C_TEXT:C284($t_registro;$t_servidorCorreo;$t_texto;$t_titulo)
If (False:C215)
	C_LONGINT:C283(BBLci_Devolucion ;$1)
	C_LONGINT:C283(BBLci_Devolucion ;$2)
	C_LONGINT:C283(BBLci_Devolucion ;$3)
	C_LONGINT:C283(BBLci_Devolucion ;$4)
End if 

$0:=-1
$l_recNumRegistro:=$1
KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro;True:C214)

Case of 
	: (Count parameters:C259=2)
		$l_recNumPrestamo:=$2
		
	: (Count parameters:C259=1)
		  //si no se recibión un recnum de prestamo buscamos el prestamovigente correspondiente al registro
		QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1=[BBL_Registros:66]ID:3;*)
		QUERY:C277([BBL_Prestamos:60]; & [BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
		If (Records in selection:C76([BBL_Prestamos:60])>0)
			$l_recNumPrestamo:=Record number:C243([BBL_Prestamos:60])
		Else 
			$l_recNumPrestamo:=-1
		End if 
End case 

KRL_GotoRecord (->[BBL_Prestamos:60];$l_recNumPrestamo;True:C214)
$l_recNumLector:=KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Prestamos:60]Número_de_lector:2;True:C214)
$l_recNumItem:=KRL_FindAndLoadRecordByIndex (->[BBL_Items:61]Numero:1;->[BBL_Prestamos:60]Número_de_Item:11;True:C214)

  // leeo las reglas asignadas al item y al usuario para determinar las condiciones de préstamo
KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaItems:69]Codigo_regla:1;->[BBL_Items:61]Regla:20;False:C215)
KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;->[BBL_Lectores:72]Regla:4;False:C215)
$l_validezReserva:=Choose:C955([xxBBL_ReglasParaUsuarios:64]Reservas_caducan:10>[xxBBL_ReglasParaItems:69]Reserva_Caducan:8;[xxBBL_ReglasParaItems:69]Reserva_Caducan:8;[xxBBL_ReglasParaUsuarios:64]Reservas_caducan:10)

If ($l_recNumPrestamo<0)
	  //si no hay prestamo vigente iventoriamos el registro
	BBLci_Inventario ($l_recNumRegistro)
	
Else 
	Case of 
		: (Locked:C147([BBL_Prestamos:60]))
			CD_Dlog (0;__ ("Otro usuario utiliza en este momento la ficha de prestamo.\rLa devolución no puede ser registrada ahora. \rIntente nuevamente más tarde."))
		: (Locked:C147([BBL_Registros:66]))
			CD_Dlog (0;__ ("Otro usuario utiliza en este momento la ficha del registro.\rEl préstamo no puede ser registrado ahora. \rIntente nuevamente más tarde."))
		: (Locked:C147([BBL_Items:61]))
			CD_Dlog (0;__ ("Otro usuario utiliza en este momento la ficha del ítem.\rEl préstamo no puede ser registrado ahora. \rIntente nuevamente más tarde."))
		: (Locked:C147([BBL_Lectores:72]))
			CD_Dlog (0;__ ("Otro usuario utiliza en este momento la ficha del usuario.\rEl préstamo no puede ser registrado ahora. \rIntente nuevamente más tarde."))
		Else 
			
			BBLci_RegistraDevolucion 
			
			
			If ([BBL_Prestamos:60]Días_de_atraso:15>0)
				KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaItems:69]Codigo_regla:1;->[BBL_Items:61]Regla:20;False:C215)
				KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;->[BBL_Lectores:72]Regla:4;False:C215)
				$r_multaMaxima:=[xxBBL_ReglasParaUsuarios:64]Multa_maxima:7
				$b_aplicarReglaItems:=([xxBBL_ReglasParaItems:69]Multa_diaria:5>[xxBBL_ReglasParaUsuarios:64]MultaDiaria:13) & ([xxBBL_ReglasParaUsuarios:64]ReglaPrimaSobreReglasItems:15=False:C215)
				$r_multaDiaria:=Choose:C955($b_aplicarReglaItems;[xxBBL_ReglasParaItems:69]Multa_diaria:5;[xxBBL_ReglasParaUsuarios:64]MultaDiaria:13)
				$b_aplicarReglaItems:=([xxBBL_ReglasParaUsuarios:64]Gracia_multa:14>[xxBBL_ReglasParaItems:69]Dias_gracia:4) & ([xxBBL_ReglasParaUsuarios:64]ReglaPrimaSobreReglasItems:15=False:C215)
				$l_diasAtraso:=[BBL_Prestamos:60]Días_de_atraso:15
				$l_diasDeGracia:=Choose:C955($b_aplicarReglaItems;[xxBBL_ReglasParaItems:69]Dias_gracia:4;[xxBBL_ReglasParaUsuarios:64]Gracia_multa:14)
				If ($l_diasAtraso>[xxBBL_ReglasParaItems:69]Dias_gracia:4)
					$r_multa:=$r_multaDiaria*($l_diasAtraso-$l_diasDeGracia)
				End if 
				
				If ([xxBBL_ReglasParaUsuarios:64]Suspención:16=True:C214)
					$l_diasSuspension:=(($l_diasAtraso-$l_diasDeGracia)*[xxBBL_ReglasParaUsuarios:64]Multa_en_días:18)
					BBLci_CambiaEstadoSuspensión ($l_recNumLector;$l_diasSuspension)
					If ([xxBBL_ReglasParaUsuarios:64]Multa_y_Suspensión:17=False:C215)
						$r_multa:=0
					End if 
				End if 
			End if 
			
			If ($r_multa>0)
				$t_formatoMoneda:="|Pesos"
				$t_titulo:=__ ("La devolución de este item se efectua con ^0 día(s) de retraso. \rSe debiera aplicar una multa de ^1")
				$t_titulo:=Replace string:C233($t_titulo;"^0";String:C10($l_diasAtraso))
				$t_titulo:=Replace string:C233($t_titulo;"^1";String:C10($r_multa;$t_formatoMoneda))
				$t_Mensaje:=__ ("Puede registrar la multa, la multa y el pago o condonar la multa.\r¿Que desea hacer?")
				$l_opcionUsuario:=ModernUI_Notificacion ($t_titulo;$t_mensaje;__ ("Registrar Multa");__ ("Registrar Multa y Pago");__ ("Condonar multa"))
				  //$l_opcionUsuario:=CD_Dlog (0;$t_mensaje;"";__ ("Solo multa");__ ("Multa y pago");__ ("Condonar multa"))
				Case of 
					: ($l_opcionUsuario=3)
						  // nada, la multa es omitida
					: ($l_opcionUsuario=2)
						BBLci_MultaPorDevolucionTardia (Record number:C243([BBL_Prestamos:60]);$r_multa)
						BBLci_RegistraPago ([BBL_Lectores:72]ID:1;$r_multa)
						
					: ($l_opcionUsuario>=1)
						BBLci_MultaPorDevolucionTardia (Record number:C243([BBL_Prestamos:60]);$r_multa)
				End case 
			End if 
			
			
			QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_Item:2=[BBL_Registros:66]Número_de_item:1)
			ORDER BY:C49([BBL_Reservas:115];[BBL_Reservas:115]From:5;<;[BBL_Reservas:115]ID:1;<)
			REDUCE SELECTION:C351([BBL_Reservas:115];1)
			KRL_FindAndLoadRecordByIndex (->[BBL_Lectores:72]ID:1;->[BBL_Reservas:115]ID_User:3;False:C215)
			If ([BBL_Lectores:72]eMail:41#"")
				$t_asunto:=__ ("Notificacion de MediaTrack: Tu reserva está disponible.")
				$t_mensaje:=__ ("^0 tiene una reserva sobre un ejemplar de ^1\r\r¿Desea enviarle un correo electrónico para informarle que su reserva está disponible?")
				$t_nombre:=[BBL_Lectores:72]Nombre_Comun:35
				$t_titulo:=[BBL_Items:61]Primer_título:4
				$t_mensaje:=Replace string:C233($t_mensaje;"^0";IT_SetTextStyle_Bold (->$t_nombre))
				$t_mensaje:=Replace string:C233($t_mensaje;"^1";IT_SetTextStyle_Bold (->$t_titulo))
				$l_opcionUsuario:=CD_Dlog (0;$t_mensaje;"";"Notificar por email";"No")
				If ($l_opcionUsuario=1)
					$t_texto:=Choose:C955([BBL_Lectores:72]Sexo:23="F";__ ("Estimada ");__ ("Estimado "))+[BBL_Lectores:72]Nombres:11+", \r\r"
					$t_texto:=$t_texto+__ ("Tu reserva de ^0 está disponible\rPuedes retirarla hasta el ^1 en ^2.\r\r\r")
					$t_lugar:=__ ("la bilbioteca")
					If ([BBL_Registros:66]Lugar:13#"")
						$l_indiceLugar:=Find in array:C230(<>aPlaceCode;[BBL_Registros:66]Lugar:13)
						If ($l_indiceLugar>0)
							$t_lugar:=<>aPlace{$l_indiceLugar}
						End if 
					End if 
					$t_texto:=$t_texto+__ ("Saludos")+", \r\r"+USR_GetUserName (USR_GetUserID )
					$t_texto:=$t_texto+"\r"+<>gBBL_BibliotecaPrincipal
					$t_Texto:=Replace string:C233($t_Texto;"^0";$t_titulo)
					$t_Texto:=Replace string:C233($t_Texto;"^1";String:C10([BBL_Reservas:115]From:5+$l_validezReserva;System date long:K1:3))
					$t_Texto:=Replace string:C233($t_Texto;"^2";$t_lugar)
					$t_Texto:=ST Get plain text:C1092($t_Texto)
					$t_destinatario:=[BBL_Lectores:72]eMail:41
					$t_error:=BBLci_EnviaCorreo ($t_destinatario;$t_asunto;ST Get plain text:C1092($t_texto))
					If ($t_error#"")
						ModernUI_Notificacion ("No fue posible enviar el correo a causa de un error:\r\r"+$t_error)
					Else 
						Notificacion_Mostrar ("Correo enviado";"Notificación de disponibilidad de reserva enviada a "+$t_nombre)
					End if 
				End if 
			End if 
			KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector)
	End case 
	
End if 
KRL_UnloadReadOnly (->[BBL_Prestamos:60])
KRL_ReloadAsReadOnly (->[BBL_Registros:66])
KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
KRL_ReloadAsReadOnly (->[BBL_Items:61])
