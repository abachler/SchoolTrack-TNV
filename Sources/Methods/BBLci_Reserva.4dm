//%attributes = {}
  // BBLci_Reserva()
  // Por: Alberto Bachler: 30/09/13, 12:33:18
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($b_abortarReserva;$b_confirmarReserva;$b_reservaItemPermitida;$b_reservaLectoresPermitida)
C_DATE:C307($d_disponibilidadEstimada;$d_fechaLimiteReserva;$d_fechaReserva)
C_LONGINT:C283($l_itemReservado;$l_maximoDiasReserva;$l_recNumItem;$l_recNumLector;$l_respuestaUsuario)
C_TEXT:C284($t_disponibilidadEstimada;$t_mensaje;$t_nombreLector;$t_nombreReglaItems;$t_nombreReglaLectores;$t_tituloItem)

If (False:C215)
	C_LONGINT:C283(BBLci_Reserva ;$1)
	C_LONGINT:C283(BBLci_Reserva ;$2)
End if 


$l_recNumLector:=$1
$l_recNumItem:=$2
$d_fechaReserva:=Current date:C33(*)

KRL_GotoRecord (->[BBL_Lectores:72];$l_recNumLector;True:C214)
KRL_GotoRecord (->[BBL_Items:61];$l_recNumItem;True:C214)

$l_maximoDiasReserva:=0

  // leeo las reglas asignadas al item y al usuario para determinar las condiciones de préstamo
KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaItems:69]Codigo_regla:1;->[BBL_Items:61]Regla:20;False:C215)
KRL_FindAndLoadRecordByIndex (->[xxBBL_ReglasParaUsuarios:64]Codigo_regla:1;->[BBL_Lectores:72]Regla:4;False:C215)

$l_maximoDiasReserva:=Choose:C955([xxBBL_ReglasParaUsuarios:64]ReglaPrimaSobreReglasItems:15;[xxBBL_ReglasParaUsuarios:64]Reservas_caducan:10;[xxBBL_ReglasParaItems:69]Reserva_Caducan:8)
$b_reservaLectoresPermitida:=([xxBBL_ReglasParaUsuarios:64]Max_Reservas:5>0)
$b_reservaItemPermitida:=[xxBBL_ReglasParaItems:69]Reserva_Permitida:9
$t_maximoReservas:=String:C10([xxBBL_ReglasParaUsuarios:64]Max_Reservas:5)
IT_SetTextStyle_Bold (->$t_maximoReservas)
$t_nombreReglaLectores:=[xxBBL_ReglasParaUsuarios:64]Nombre Regla:2
IT_SetTextStyle_Bold (->$t_nombreReglaLectores)
$t_nombreReglaItems:=[xxBBL_ReglasParaItems:69]Nombre Regla:2
IT_SetTextStyle_Bold (->$t_nombreReglaItems)
$t_nombreLector:=[BBL_Lectores:72]NombreCompleto:3
IT_SetTextStyle_Bold (->$t_nombreLector)
$t_tituloItem:=[BBL_Items:61]Primer_título:4
IT_SetTextStyle_Bold (->$t_tituloItem)




SET QUERY DESTINATION:C396(Into variable:K19:4;$l_reservasParaItem)
QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_Item:2=[BBL_Items:61]Numero:1)
SET QUERY DESTINATION:C396(Into variable:K19:4;$l_itemReservado)
QUERY:C277([BBL_Reservas:115];[BBL_Reservas:115]ID_User:3=[BBL_Lectores:72]ID:1;*)
QUERY:C277([BBL_Reservas:115]; & [BBL_Reservas:115]ID_Item:2=[BBL_Items:61]Numero:1)
SET QUERY DESTINATION:C396(Into current selection:K19:1)

Case of 
	: ($l_itemReservado>0)
		$t_mensaje:=__ ("^0 ya tiene una reserva sobre una copia de ^1.\r\rSolo se permite ^2 reserva(s) por lector para el mismo ítem.\r\rNo es posible registrar la reserva.")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreReglaLectores)
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_tituloItem)
		$t_mensaje:=Replace string:C233($t_mensaje;"^2";$t_maximoReservas)
		$b_abortarReserva:=True:C214
		
	: (Not:C34($b_reservaItemPermitida))
		$t_mensaje:=__ ("La regla ^0 asignada al ítem ^1 no permite reservas.\r\rNo es posible registrar la reserva.")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreReglaItems)
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_tituloItem)
		$b_abortarReserva:=True:C214
		
	: (Not:C34($b_reservaLectoresPermitida))
		$t_mensaje:=__ ("La regla ^0 asignada al lector ^1 no permite reservas.\r\rNo es posible registrar la reserva.")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_nombreReglaLectores)
		$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_nombreLector)
		$b_abortarReserva:=True:C214
		
	: ([BBL_Items:61]Copias:24=0)
		$t_mensaje:=__ ("Actualmente no existe ninguna copia del ítem ^0.\r\rNo es posible registrar la reserva.")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_tituloItem)
		$b_abortarReserva:=True:C214
		
	: ([BBL_Items:61]Copias_disponibles:43=0)
		  // no hay ninguna copia disponible, determino a contar de que fecha teórica se puede registrar la reserva
		QUERY:C277([BBL_Registros:66];[BBL_Registros:66]Número_de_item:1;=;[BBL_Items:61]Numero:1;*)
		QUERY:C277([BBL_Registros:66]; & ;[BBL_Registros:66]StatusID:34;=;Prestado)
		If (Records in selection:C76([BBL_Registros:66])>[BBL_Items:61]Copias_reservadas:44)
			ORDER BY:C49([BBL_Registros:66];[BBL_Registros:66]Prestado_hasta:14;<)
			If ([BBL_Registros:66]Prestado_hasta:14<Current date:C33(*))
				  // si la fecha de devolución prevista es anterior a hoy damos tres días de holgura para la devolución del préstamo previo
				$d_disponibilidadEstimada:=DT_GetWorkingDayDate (Current date:C33(*)+3)
				$t_disponibilidadEstimada:=String:C10($d_disponibilidadEstimada;System date long:K1:3)
				$d_fechaReserva:=DT_GetWorkingDayDate (Current date:C33(*)+3)
			Else 
				$d_disponibilidadEstimada:=DT_GetWorkingDayDate ([BBL_Registros:66]Prestado_hasta:14+1)
				$t_disponibilidadEstimada:=String:C10($d_disponibilidadEstimada;System date long:K1:3)
				$d_fechaReserva:=DT_GetWorkingDayDate (Current date:C33(*)+1)
			End if 
			IT_SetTextStyle_Bold (->$t_disponibilidadEstimada)
			$t_mensaje:=__ ("Todas las copias de ^0 están actualmente prestadas a otros lectores.\r\r¿Desea registrar una reserva a contar del ^1, fecha estimada de devolución?")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_tituloItem)
			$t_mensaje:=Replace string:C233($t_mensaje;"^1";$t_disponibilidadEstimada)
			$b_confirmarReserva:=True:C214
		Else 
			$t_mensaje:=__ ("Todas las copias de ^0 están actualmente prestadas y con reservas de otros lectores.\r\rNo es posible registrar la reserva")
			$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_tituloItem)
			$b_abortarReserva:=True:C214
		End if 
		
	: ($l_reservasParaItem>=[BBL_Items:61]Copias_disponibles:43)
		$t_mensaje:=__ ("Las copias disponibles del ítem ^0 están reservadas.\r\rNo es posible registrar la reserva.")
		$t_mensaje:=Replace string:C233($t_mensaje;"^0";$t_tituloItem)
		$b_abortarReserva:=True:C214
		
End case 

Case of 
	: ($b_abortarReserva)
		CD_Dlog (0;$t_mensaje)
		
	: ($b_confirmarReserva)
		$l_respuestaUsuario:=CD_Dlog (0;$t_mensaje;"";__ ("Registrar Reserva");__ ("Cancelar"))
		If ($l_respuestaUsuario=2)
			$b_abortarReserva:=True:C214
		End if 
End case 

If (Not:C34($b_abortarReserva))
	[BBL_Items:61]Copias_reservadas:44:=[BBL_Items:61]Copias_reservadas:44+1
	SAVE RECORD:C53([BBL_Items:61])
	CREATE RECORD:C68([BBL_Reservas:115])
	[BBL_Reservas:115]ID:1:=SQ_SeqNumber (->[BBL_Reservas:115]ID:1)
	[BBL_Reservas:115]ID_User:3:=[BBL_Lectores:72]ID:1
	[BBL_Reservas:115]ID_Item:2:=[BBL_Items:61]Numero:1
	[BBL_Reservas:115]From:5:=$d_fechaReserva
	[BBL_Reservas:115]Until:4:=DT_GetWorkingDayDate ([BBL_Reservas:115]From:5+$l_maximoDiasReserva)
	[BBL_Reservas:115]UserName:6:=[BBL_Lectores:72]NombreCompleto:3
	SAVE RECORD:C53([BBL_Reservas:115])
	BBLci_registroEnLog (Reservas;Record number:C243([BBL_Lectores:72]);No current record:K29:2;Record number:C243([BBL_Items:61]);__ ("Reservado hasta el ")+String:C10([BBL_Reservas:115]Until:4;Internal date short special:K1:4))
End if 

KRL_UnloadReadOnly (->[BBL_Reservas:115])
KRL_UnloadReadOnly (->[BBL_Items:61])
KRL_UnloadReadOnly (->[BBL_Registros:66])
KRL_ReloadAsReadOnly (->[BBL_Lectores:72])
$y_variableImagen:=OBJECT Get pointer:C1124(Object named:K67:5;"item_imagen")
$y_variableImagen->:=$y_variableImagen->*0