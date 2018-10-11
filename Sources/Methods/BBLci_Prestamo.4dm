//%attributes = {}
  // // BBLci_Prestamo()
  // Por: Alberto Bachler: 27/09/13, 20:45:21
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)
C_LONGINT:C283($3)

C_BOOLEAN:C305($b_abortarPrestamo;$b_aplicarReglaUsuarios;$b_MaximoPrestamosAlcanzado;$b_maximoVencidosAlcanzado;$b_solicitarConfirmacion)
C_DATE:C307($d_fechaDevolucion)
C_LONGINT:C283($l_maximoDiasPrestamo;$l_opcionUsuario;$l_recNumItem;$l_recNumLector;$l_recNumPrestamo;$l_recNumRegistro;$l_recNumReserva)
C_TEXT:C284($t_fechaDevolucion;$t_fechaExpiracion;$t_fechaReserva;$t_fechasuspension;$t_glosa;$t_lector;$t_maximoPrestamos;$t_maximoPrestamosVencidos;$t_maximoRenovaciones;$t_mensajeConfirmacion)
C_TEXT:C284($t_MensajeRechazoPrestamo;$t_nombreLector;$t_nombreReglaItems;$t_nombreReglaLectores;$t_registro;$t_ReservadoPor;$t_TextoLog;$t_tituloItem)

If (False:C215)
	C_LONGINT:C283(BBLci_Prestamo ;$1)
	C_LONGINT:C283(BBLci_Prestamo ;$2)
	C_LONGINT:C283(BBLci_Prestamo ;$3)
End if 

$l_recNumRegistro:=$1
$l_recNumItem:=$2
$l_recNumLector:=$3

KRL_GotoRecord (->[BBL_Registros:66];$l_recNumRegistro;True:C214)
KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;True:C214)
KRL_GotoRecord (->[BBL_Items:61];$l_recNumItem;True:C214)

$l_maximoDiasPrestamo:=0

  // leeo las reglas asignadas al item y al usuario para determinar las condiciones de préstamo
KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaItems:69]Codigo_regla:1;->[BBL_Items:61]Regla:20;False:C215)
KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;->[BBL_Lectores:72]Regla:4;False:C215)

  // determino si el lector ya tiene el documento en prestamo. Si es así se trata de una renovación
$l_recNumPrestamo:=No current record:K29:2
QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_registro:1;=;[BBL_Registros:66]ID:3;*)
QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Número_de_lector:2;=;[BBL_Lectores:72]ID:1)
QUERY SELECTION:C341([BBL_Prestamos:60];[BBL_Prestamos:60]Fecha_de_devolución:5;=;!00-00-00!)
If (Records in selection:C76([BBL_Prestamos:60])>No current record:K29:2)
	$l_recNumPrestamo:=Record number:C243([BBL_Prestamos:60])
End if 

  // formateo textos que podrían utilizarse en eventuales mensaje de advertencia o confirmación
$t_nombreLector:=[BBL_Lectores:72]NombreCompleto:3
ST SET ATTRIBUTES:C1093($t_nombreLector;0;32000;Attribute bold style:K65:1;1)
$t_nombreReglaLectores:=[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2  //20180406 RCH
ST SET ATTRIBUTES:C1093($t_nombreReglaLectores;0;32000;Attribute bold style:K65:1;1)
$t_nombreReglaItems:=[xxBBL_ReglasParaItems:69]Nombre Regla:2  //20180406 RCH
ST SET ATTRIBUTES:C1093($t_nombreReglaItems;0;32000;Attribute bold style:K65:1;1)
$t_tituloItem:=[BBL_Items:61]Primer_título:4
ST SET ATTRIBUTES:C1093($t_tituloItem;0;32000;Attribute bold style:K65:1;1)
$t_maximoPrestamosVencidos:=String:C10([xxBBL_ReglasParaUsuarios:64]Max_Vencidos:4)
ST SET ATTRIBUTES:C1093($t_maximoPrestamosVencidos;0;32000;Attribute bold style:K65:1;1)
$t_maximoPrestamos:=String:C10([xxBBL_ReglasParaUsuarios:64]Max_Prestamos:3)
ST SET ATTRIBUTES:C1093($t_maximoPrestamos;0;32000;Attribute bold style:K65:1;1)
$t_maximoRenovaciones:=String:C10([xxBBL_ReglasParaItems:69]Max_renovacione:6)
ST SET ATTRIBUTES:C1093($t_maximoPrestamos;0;32000;Attribute bold style:K65:1;1)
$t_prestamosActuales:=String:C10([BBL_Lectores:72]Préstamos_actuales:9)
ST SET ATTRIBUTES:C1093($t_prestamosActuales;0;32000;Attribute bold style:K65:1;1)
$t_atrasosActuales:=String:C10([BBL_Lectores:72]Atrasos:24)
ST SET ATTRIBUTES:C1093($t_atrasosActuales;0;32000;Attribute bold style:K65:1;1)

  //determino la fecha de devolución prevista
$y_fechaDevolucionFija:=OBJECT Get pointer:C1124(Object named:K67:5;"fechaDevolucionFija")
$d_fechaDevolucionFija:=$y_fechaDevolucionFija->

$b_aplicarReglaUsuarios:=[xxBBL_ReglasParaUsuarios:64]ReglaPrimaSobreReglasItems:15
$l_maximoDiasPrestamo:=Choose:C955([xxBBL_ReglasParaUsuarios:64]ReglaPrimaSobreReglasItems:15;[xxBBL_ReglasParaUsuarios:64]Dias_Prestamo:8;[xxBBL_ReglasParaItems:69]DiasPrestamo:3)
$d_fechaDevolucion:=Choose:C955($d_fechaDevolucionFija=!00-00-00!;Current date:C33(*)+$l_maximoDiasPrestamo;$d_fechaDevolucionFija)
$d_fechaDevolucion:=DT_GetWorkingDayDate ($d_fechaDevolucion;-2)

  //determino si el lector ha sobrepasado los limites para aprobar el prestamo
  //$b_MaximoPrestamosAlcanzado:=([xxBBL_ReglasParaUsuarios]Max_Prestamos>0) & ([BBL_Lectores]Préstamos_actuales>=[xxBBL_ReglasParaUsuarios]Max_Prestamos) & Not([xxBBL_ReglasParaUsuarios]OverrideRules)
  //$b_maximoVencidosAlcanzado:=([xxBBL_ReglasParaUsuarios]Max_Vencidos>0) & ([BBL_Lectores]Atrasos>=[xxBBL_ReglasParaUsuarios]Max_Vencidos) & Not([xxBBL_ReglasParaUsuarios]OverrideRules)
  //20150429 ASM Ticket 143726 
$b_MaximoPrestamosAlcanzado:=([xxBBL_ReglasParaUsuarios:64]Max_Prestamos:3>0) & ([BBL_Lectores:72]Préstamos_actuales:9>=[xxBBL_ReglasParaUsuarios:64]Max_Prestamos:3)  //| [xxBBL_ReglasParaUsuarios]OverrideRules
$b_maximoVencidosAlcanzado:=([xxBBL_ReglasParaUsuarios:64]Max_Vencidos:4>0) & ([BBL_Lectores:72]Atrasos:24>=[xxBBL_ReglasParaUsuarios:64]Max_Vencidos:4)  //| [xxBBL_ReglasParaUsuarios]OverrideRules



  // determino si el usuario ha reservado previamente alguna copia del item
$l_recNumReserva:=-1
QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_Item:2=[BBL_Items:61]Numero:1;*)
QUERY:C277([BBL_Reservas:115]; & [BBL_Reservas:115]ID_User:3=[BBL_Lectores:72]ID:1)
$l_recNumReserva:=Record number:C243([BBL_Reservas:115])

  // determino si existen copias disponibles para el registro correspondiente al item solicitado por el lector
  // si hay una reserva anterior a la fecha de devolución prevista mas el número máximo de días de prestamos se solicitará confirmación al operador
QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_Item:2=[BBL_Items:61]Numero:1;*)
QUERY:C277([BBL_Reservas:115]; & ;[BBL_Reservas:115]ID_User:3#[BBL_Lectores:72]ID:1;*)
QUERY:C277([BBL_Reservas:115]; & ;[BBL_Reservas:115]From:5;<=;$d_fechaDevolucion+$l_maximoDiasPrestamo)
If (Records in selection:C76([BBL_Reservas:115])>0)
	If (Records in selection:C76([BBL_Reservas:115])>=[BBL_Items:61]Copias_disponibles:43)
		  // Me posiciono en el registro de reserva con la fecha más reciente para determinar hasta que fecha puede ser prestado el documento y respetar la reserva existente
		ORDER BY:C49([BBL_Reservas:115];[BBL_Reservas:115]From:5;<)
		If ([BBL_Reservas:115]From:5<$d_fechaDevolucion)
			  // si la fecha de inicio de la reserva es anterior a la fecha de devolución prevista para el préstamo
			  // determino cual es la fecha limite para la devolucion antes del inicio de la reserva
			$d_fechaDevolucion:=[BBL_Reservas:115]From:5-1
			While (Find in array:C230(adSTR_Calendario_Feriados;$d_fechaDevolucion)>0)
				$d_fechaDevolucion:=$d_fechaDevolucion-1
			End while 
			If ($d_fechaDevolucion>=Current date:C33(*))
				  // el prestamo es posible al menos por un dia, informo al operador para que decida si da curso al préstamo o no
				$t_ReservadoPor:=[BBL_Reservas:115]UserName:6
				ST SET ATTRIBUTES:C1093($t_ReservadoPor;0;32000;Attribute bold style:K65:1;1)
				$t_fechaReserva:=String:C10([BBL_Reservas:115]From:5;System date long:K1:3)
				ST SET ATTRIBUTES:C1093($t_ReservadoPor;0;32000;Attribute bold style:K65:1;1)
				$t_fechaDevolucion:=String:C10($d_fechaDevolucion;System date long:K1:3)
				ST SET ATTRIBUTES:C1093($t_ReservadoPor;0;32000;Attribute bold style:K65:1;1)
				$t_mensajeConfirmacion:=__ ("Hay una reserva de ^0 para ^1 a contar del ^2.\r¿Autoriza usted el prestamo hasta el ^3?")
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";$t_ReservadoPor)
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_tituloItem)
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^2";$t_fechaReserva)
				$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^3";$t_fechaDevolucion)
				$b_solicitarConfirmacion:=True:C214
			Else 
				$t_MensajeRechazoPrestamo:=__ ("Todas las copias disponibles de ^0 estan reservadas.\r\rNo es posible resgistrar el préstamo.")
				$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^0";$t_tituloItem)
				$b_abortarPrestamo:=True:C214
			End if 
		End if 
	End if 
End if 



Case of 
	: (Locked:C147([BBL_Registros:66]))
		$t_MensajeRechazoPrestamo:=__ ("Otro usuario utiliza en este momento la ficha del registro.\rEl préstamo no puede ser registrado ahora. \rIntente nuevamente más tarde.")
		$b_abortarPrestamo:=True:C214
		
	: (Locked:C147([BBL_Items:61]))
		$t_MensajeRechazoPrestamo:=__ ("Otro usuario utiliza en este momento la ficha del ítem.\rEl préstamo no puede ser registrado ahora. \rIntente nuevamente más tarde.")
		$b_abortarPrestamo:=True:C214
		
	: (Locked:C147([BBL_Lectores:72]))
		$t_MensajeRechazoPrestamo:=__ ("Otro usuario utiliza en este momento la ficha del lector.\rEl préstamo no puede ser registrado ahora. \rIntente nuevamente más tarde.")
		$b_abortarPrestamo:=True:C214
		
	: (Records in selection:C76([xxBBL_ReglasParaUsuarios:64])=0)
		$t_MensajeRechazoPrestamo:=__ ("La regla ^0 asignada el lector ^1 no existe.\r\rNo es posible registrar el préstamo")
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^0";$t_nombreReglaLectores)
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^1";$t_nombreLector)
		$b_abortarPrestamo:=True:C214
		
	: (Records in selection:C76([xxBBL_ReglasParaItems:69])=0)
		$t_MensajeRechazoPrestamo:=__ ("La regla ^0 asignada el item ^1 no existe.\r\rNo es posible registrar el préstamo")
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^0";$t_nombreReglaLectores)
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^1";$t_tituloItem)
		$b_abortarPrestamo:=True:C214
		
	: ([xxBBL_ReglasParaItems:69]DiasPrestamo:3=0)
		$t_MensajeRechazoPrestamo:=$t_tituloItem+" "+__ (" tiene asignada la regla ^0.\rEsta regla no permite el préstamo.\r\rNo es posible registrar el préstamo")
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^0";$t_nombreReglaItems)
		$b_abortarPrestamo:=True:C214
		
	: (($b_MaximoPrestamosAlcanzado) & ($l_recNumPrestamo=No current record:K29:2))
		$t_MensajeRechazoPrestamo:=$t_nombreLector+" "+__ ("tiene actualmente ^0 documentos en préstamo.\rEl máximo de préstamos para los usuarios con esta regla es ^1\r\rNo es posible registrar el préstamo.")
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^0";$t_prestamosActuales)
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^1";$t_maximoPrestamos)
		$b_abortarPrestamo:=True:C214
		
	: (([BBL_Lectores:72]Expira:25#!00-00-00!) & ([BBL_Lectores:72]Expira:25<Current date:C33(*)))
		$t_fechaExpiracion:=String:C10([BBL_Lectores:72]Expira:25;System date long:K1:3)
		ST SET ATTRIBUTES:C1093($t_fechaExpiracion;0;32000;Attribute bold style:K65:1;1)
		$t_mensajeConfirmacion:=__ ("La cuenta de ^0 expiró el ^1.\r\r¿Autoriza usted el préstamo?")
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";$t_nombreLector)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_fechaExpiracion)
		
	: (([BBL_Lectores:72]Fecha_Suspención:45=!1900-01-01!) & ([xxBBL_ReglasParaUsuarios:64]Suspención:16=True:C214))
		$t_mensajeConfirmacion:=__ ("^0 esta suspendido de forma indefinida por préstamos vencidos.\r\r¿Autoriza usted el préstamo?")
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";$t_nombreLector)
		
	: (([BBL_Lectores:72]Fecha_Suspención:45>Current date:C33(*)) & ([xxBBL_ReglasParaUsuarios:64]Suspención:16=True:C214))
		$t_fechasuspension:=String:C10([BBL_Lectores:72]Fecha_Suspención:45;System date long:K1:3)
		ST SET ATTRIBUTES:C1093($t_fechasuspension;0;32000;Attribute bold style:K65:1;1)
		$t_mensajeConfirmacion:=__ ("^0 esta suspendido hasta el ^1 por préstamos vencidos.\r\r¿Autoriza usted el préstamo?")
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";$t_nombreLector)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_fechasuspension)
		$b_solicitarConfirmacion:=True:C214
		
	: (([BBL_Lectores:72]Atrasos:24>=[xxBBL_ReglasParaUsuarios:64]Max_Vencidos:4) & ([BBL_Lectores:72]ID:1>0) & ([xxBBL_ReglasParaUsuarios:64]OverrideRules:11))
		$t_mensajeConfirmacion:=__ ("^0 ha sobrepasado ^1 préstamos vencidos, el máximo autorizado para la regla ^2.\r\r¿Autoriza usted el préstamo?")
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";$t_nombreLector)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_maximoPrestamosVencidos)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^2";$t_nombreReglaLectores)
		$b_solicitarConfirmacion:=True:C214
		
	: (([BBL_Lectores:72]Préstamos_actuales:9>[xxBBL_ReglasParaUsuarios:64]Max_Prestamos:3) & ([BBL_Lectores:72]ID:1>0))
		$t_mensajeConfirmacion:=__ ("^0 ha sobrepasado ^1 préstamos vigentes, el máximo autorizado para la regla ^2.\r\r¿Autoriza usted el préstamo?")
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";$t_nombreLector)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_maximoPrestamos)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^2";$t_nombreReglaLectores)
		$b_solicitarConfirmacion:=True:C214
		
	: (($l_recNumPrestamo>=0) & ([BBL_Prestamos:60]Renovaciones:12>[xxBBL_ReglasParaItems:69]Max_renovacione:6))
		$t_maximoRenovaciones:=String:C10([xxBBL_ReglasParaItems:69]Max_renovacione:6)
		ST SET ATTRIBUTES:C1093($t_fechasuspension;0;32000;Attribute bold style:K65:1;1)
		$t_mensajeConfirmacion:=__ ("El préstamo de ^0 a ^1 ha sido renovado ^2, alcanzando el límite establecido en la regla ^3.\r\r¿Autoriza usted el préstamo?")
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^0";$t_tituloItem)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^1";$t_nombreLector)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^2";$t_maximoRenovaciones)
		$t_mensajeConfirmacion:=Replace string:C233($t_mensajeConfirmacion;"^3";$t_nombreReglaItems)
		$b_solicitarConfirmacion:=True:C214
		
	: ($b_maximoVencidosAlcanzado)
		$t_MensajeRechazoPrestamo:=$t_nombreLector+" "+__ ("tiene actualmente ^0 préstamos vencidos.\rEl máximo de préstamos vencidos para los usuarios con esta regla es ^1\r\rNo es posible registrar el préstamo.")
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^0";String:C10([BBL_Lectores:72]Atrasos:24))
		$t_MensajeRechazoPrestamo:=Replace string:C233($t_MensajeRechazoPrestamo;"^1";$t_maximoPrestamosVencidos)
		$b_abortarPrestamo:=True:C214
		
End case 

  // si el prestamo no es posible mostramos el mensaje



  //  // Modificado por: Alexis Bustamante (13-07-2017)
  //TICKET 183893 
  //  //Agrego esta validación para que se realice el "prestamo mas allá de limites permitidos" (configuración)
  //  //Pero si el alumno Tiene Mora no se prestra el libro.
If (([xxBBL_ReglasParaUsuarios:64]OverrideRules:11) & ($b_MaximoPrestamosAlcanzado) & Not:C34($b_maximoVencidosAlcanzado))
	  //configuración Prestar libros aunque
	$b_abortarPrestamo:=False:C215
	  //$b_maximoVencidosAlcanzado:=True
	  //$b_solicitarConfirmacion:=True
End if 




Case of 
	: ($b_abortarPrestamo)
		CD_Dlog (0;$t_MensajeRechazoPrestamo)
		KRL_UnloadReadOnly (->[BBL_Items:61])
		KRL_UnloadReadOnly (->[BBL_Registros:66])
		
	: ($b_solicitarConfirmacion)
		$l_opcionUsuario:=CD_Dlog (0;$t_mensajeConfirmacion;"";__ ("Autorizar préstamo");__ ("RechazarPrestamo"))
		If ($l_opcionUsuario=1)
			$t_TextoLog:=__ ("El usuario autorizó el préstamo de ^0 a ^1 después de ser informado la siguiente condición: ")+$t_mensajeConfirmacion
			$t_TextoLog:=Replace string:C233($t_TextoLog;"^0";$t_tituloItem)
			$t_TextoLog:=Replace string:C233($t_TextoLog;"^1";$t_nombreLector)
			LOG_RegisterEvt ($t_TextoLog)
		Else 
			$b_abortarPrestamo:=True:C214
		End if 
End case 

If (Not:C34($b_abortarPrestamo))
	If ($l_recNumReserva>No current record:K29:2)
		READ WRITE:C146([BBL_Reservas:115])
		GOTO RECORD:C242([BBL_Reservas:115];$l_recNumReserva)
		DELETE RECORD:C58([BBL_Reservas:115])
		KRL_ReloadInReadWriteMode (->[BBL_Items:61])
		[BBL_Items:61]Copias_disponibles:43:=[BBL_Items:61]Copias_disponibles:43-1
		SAVE RECORD:C53([BBL_Items:61])
		KRL_ReloadAsReadOnly (->[BBL_Items:61])
	End if 
	
	If (($l_recNumPrestamo>No current record:K29:2) & (vl_ModoConsola=Renovacion))
		KRL_GotoRecord (->[BBL_Prestamos:60];$l_recNumPrestamo;True:C214)
		[BBL_Prestamos:60]Hasta:4:=$d_fechaDevolucion
		[BBL_Prestamos:60]Renovaciones:12:=[BBL_Prestamos:60]Renovaciones:12+1
		SAVE RECORD:C53([BBL_Prestamos:60])
		$t_glosa:="renovado hasta "+String:C10([BBL_Prestamos:60]Hasta:4;Internal date abbreviated:K1:6)
		BBLci_registroEnLog (Renovacion;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)
		
	Else 
		CREATE RECORD:C68([BBL_Prestamos:60])
		[BBL_Prestamos:60]Número_de_Transacción:8:=SQ_SeqNumber (->[BBL_Prestamos:60]Número_de_Transacción:8)
		[BBL_Prestamos:60]Número_de_registro:1:=[BBL_Registros:66]ID:3
		[BBL_Prestamos:60]Número_de_lector:2:=[BBL_Lectores:72]ID:1
		[BBL_Prestamos:60]Número_de_Item:11:=[BBL_Items:61]Numero:1
		[BBL_Prestamos:60]Desde:3:=Current date:C33(*)
		[BBL_Prestamos:60]Hasta:4:=$d_fechaDevolucion
		[BBL_Prestamos:60]Fecha_de_Transacción:13:=Current date:C33(*)
		[BBL_Prestamos:60]Hora_de_transacción:14:=Current time:C178(*)
		SAVE RECORD:C53([BBL_Prestamos:60])
		
		  // actualizo el registro con la información del prestamo
		Case of 
			: ([BBL_Prestamos:60]Número_de_lector:2=-1)
				[BBL_Registros:66]StatusID:34:=Perdido
				[BBL_Prestamos:60]Hasta:4:=!00-00-00!
			: ([BBL_Prestamos:60]Número_de_lector:2=-2)
				[BBL_Registros:66]StatusID:34:=Dado de baja
				[BBL_Prestamos:60]Hasta:4:=!00-00-00!
			: ([BBL_Prestamos:60]Número_de_lector:2=-3)
				[BBL_Registros:66]StatusID:34:=Uso Interno
			: ([BBL_Prestamos:60]Número_de_lector:2=-4)
				[BBL_Registros:66]StatusID:34:=En Reparacion
			: ([BBL_Prestamos:60]Número_de_lector:2=-5)
				[BBL_Registros:66]StatusID:34:=Pedido
			: ([BBL_Prestamos:60]Número_de_lector:2=-6)
				[BBL_Registros:66]StatusID:34:=Archivado
				[BBL_Prestamos:60]Hasta:4:=!00-00-00!
			Else 
				[BBL_Registros:66]StatusID:34:=Prestado
		End case 
		[BBL_Registros:66]Ultimo_lector:18:=[BBL_Lectores:72]NombreCompleto:3
		[BBL_Registros:66]Número_de_préstamos:22:=[BBL_Registros:66]Número_de_préstamos:22+1
		[BBL_Registros:66]Ultimo_préstamo:21:=[BBL_Prestamos:60]Desde:3
		[BBL_Registros:66]Prestado_hasta:14:=[BBL_Prestamos:60]Hasta:4
		SAVE RECORD:C53([BBL_Registros:66])
		
		  // actualizo el item con la informacion del prestamo
		[BBL_Items:61]Use_number:40:=[BBL_Items:61]Use_number:40+1
		[BBL_Items:61]Fecha_ultimo_prestamo:42:=[BBL_Prestamos:60]Desde:3
		[BBL_Items:61]Copias_disponibles:43:=[BBL_Items:61]Copias_disponibles:43-1
		SAVE RECORD:C53([BBL_Items:61])
		
		  // actualizo el lector con la informacion del prestamo 
		RELATE ONE:C42([BBL_Prestamos:60]Número_de_lector:2)
		[BBL_Lectores:72]Total_de_préstamos:8:=[BBL_Lectores:72]Total_de_préstamos:8+1
		[BBL_Lectores:72]Préstamos_actuales:9:=[BBL_Lectores:72]Préstamos_actuales:9+1
		[BBL_Lectores:72]Ultimo_préstamo:20:=[BBL_Prestamos:60]Desde:3
		If ((Current date:C33(*)>[BBL_Lectores:72]Fecha_Suspención:45) & ([BBL_Lectores:72]Fecha_Suspención:45#!00-00-00!))  //20170512 RCH
			[BBL_Lectores:72]Fecha_Suspención:45:=!00-00-00!
		End if 
		SAVE RECORD:C53([BBL_Lectores:72])
		Case of 
			: ([BBL_Lectores:72]ID:1>0)
				$t_glosa:="prestado hasta "+String:C10([BBL_Prestamos:60]Hasta:4;Internal date abbreviated:K1:6)
				BBLci_registroEnLog (Prestamo;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)
				
			: ([BBL_Lectores:72]ID:1<0)
				$t_glosa:=""
				BBLci_registroEnLog (Cambio De Estado;Record number:C243([BBL_Lectores:72]);Record number:C243([BBL_Registros:66]);Record number:C243([BBL_Items:61]);$t_glosa)
		End case 
	End if 
	
End if 

KRL_UnloadReadOnly (->[BBL_Prestamos:60])
KRL_ReloadAsReadOnly (->[BBL_Registros:66])
KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
KRL_ReloadAsReadOnly (->[BBL_Items:61])