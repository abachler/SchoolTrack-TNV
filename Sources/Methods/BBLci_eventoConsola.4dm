//%attributes = {}
  // BBLci_eventoConsola()
  // Por: Alberto Bachler: 19/10/13, 12:36:02
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($0)

If (False:C215)
	C_TEXT:C284(BBLci_eventoConsola ;$0)
End if 

Case of 
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Prestamo)
		$0:=__ ("Préstamo")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Devolucion)
		$0:=__ ("Devolución")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Renovacion)
		$0:=__ ("Renovación")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Reservas)
		$0:=__ ("Reserva")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Multa)
		$0:=__ ("Multa")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Pago)
		$0:=__ ("Pago")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Inventario)
		$0:=__ ("Inventario")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Suspension_lector)
		$0:=__ ("Suspensión")
	: ([xxBBL_Logs:41]ID_TipoEvento:5=Cambio De Estado)  // cambio de estado
		$0:=__ ("Cambio de estado")
	Else 
		$0:=__ ("?")
End case 

