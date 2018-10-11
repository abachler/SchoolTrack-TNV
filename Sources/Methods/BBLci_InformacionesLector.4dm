//%attributes = {}
  // BBLci_InformacionesLector()
  // Por: Alberto Bachler: 23/10/13, 18:03:04
  //  ---------------------------------------------
  //
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_movimientos;$l_prestamosEnMora;$l_prestamosVigentes;$l_totalPrestamos)
C_TEXT:C284($t_mensaje;$t_nombreObjeto)

If (False:C215)
	C_TEXT:C284(BBLci_InformacionesLector ;$1)
End if 
If (Count parameters:C259=1)
	$t_mensaje:=$1
End if 
Case of 
	: ($t_mensaje="Set")
		  // botones de estado del lector
		If (Record number:C243([BBL_Lectores:72])>No current record:K29:2)
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_totalPrestamos)
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1)
			If ($l_totalPrestamos>0)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_prestamosVigentes)
				QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1;*)
				QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
				If ($l_prestamosVigentes>0)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_prestamosEnMora)
					QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2=[BBL_Lectores:72]ID:1;*)
					QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Hasta:4<Current date:C33(*);*)
					QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
				End if 
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			If ($l_totalPrestamos>0)
				OBJECT SET RGB COLORS:C628(*;"Lector.TotalPrestamos";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Lector.TotalPrestamos";__ ("Prestamos: ")+String:C10($l_totalPrestamos))
			Else 
				OBJECT SET RGB COLORS:C628(*;"Lector.TotalPrestamos";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Lector.TotalPrestamos";__ ("Préstamos: 0"))
			End if 
			OBJECT SET ENABLED:C1123(*;"Lector.TotalPrestamos";$l_totalPrestamos>0)
			
			If ($l_prestamosVigentes>0)
				OBJECT SET RGB COLORS:C628(*;"Lector.PrestamosVigentes";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Lector.PrestamosVigentes";__ ("Vigentes: ")+String:C10($l_prestamosVigentes))
			Else 
				OBJECT SET RGB COLORS:C628(*;"Lector.PrestamosVigentes";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Lector.PrestamosVigentes";__ ("Vigentes: 0"))
			End if 
			OBJECT SET ENABLED:C1123(*;"Lector.PrestamosVigentes";$l_prestamosVigentes>0)
			
			
			If ($l_prestamosEnMora>0)
				OBJECT SET RGB COLORS:C628(*;"Lector.PrestamosEnMora";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Lector.PrestamosEnMora";__ ("En mora: ")+String:C10($l_prestamosEnMora))
			Else 
				OBJECT SET RGB COLORS:C628(*;"Lector.PrestamosEnMora";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Lector.PrestamosEnMora";__ ("En mora: 0"))
			End if 
			OBJECT SET ENABLED:C1123(*;"Lector.PrestamosEnMora";$l_prestamosEnMora>0)
			
			If ([BBL_Lectores:72]Saldo:27=0)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_movimientos)
				QUERY:C277([BBL_Transacciones:59];[BBL_Transacciones:59]ID_User:4=[BBL_Lectores:72]ID:1)
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
			End if 
			Case of 
				: ([BBL_Lectores:72]Saldo:27>0)
					OBJECT SET RGB COLORS:C628(*;"Lector.Cuenta";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
					OBJECT SET TITLE:C194(*;"Lector.Cuenta";__ ("Credito: ")+String:C10([BBL_Lectores:72]Saldo:27))
				: ([BBL_Lectores:72]Saldo:27<0)
					OBJECT SET RGB COLORS:C628(*;"Lector.Cuenta";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
					OBJECT SET TITLE:C194(*;"Lector.Cuenta";__ ("Deuda: ")+String:C10([BBL_Lectores:72]Saldo:27))
				: ($l_movimientos=0)
					OBJECT SET RGB COLORS:C628(*;"Lector.Cuenta";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
					OBJECT SET TITLE:C194(*;"Lector.Cuenta";"")
				: ([BBL_Lectores:72]Saldo:27=0)
					OBJECT SET RGB COLORS:C628(*;"Lector.Cuenta";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
					OBJECT SET TITLE:C194(*;"Lector.Cuenta";__ ("Cuenta en 0"))
			End case 
			
			OBJECT SET ENABLED:C1123(*;"Lector.Cuenta";($l_movimientos#0) | ([BBL_Lectores:72]Saldo:27#0))
			OBJECT SET TITLE:C194(*;"Lector.Editar";__ ("Editar"))
			If (USR_checkRights ("M";->[BBL_Lectores:72]))
				OBJECT SET RGB COLORS:C628(*;"Lector.Editar";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
			Else 
				OBJECT SET RGB COLORS:C628(*;"Lector.Editar";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
			End if 
		Else 
			OBJECT SET TITLE:C194(*;"Lector.TotalPrestamos";"")
			OBJECT SET TITLE:C194(*;"Lector.PrestamosVigentes";"")
			OBJECT SET TITLE:C194(*;"Lector.PrestamosEnMora";"")
			OBJECT SET TITLE:C194(*;"Lector.Cuenta";"")
			OBJECT SET TITLE:C194(*;"Lector.Editar";"")
		End if 
		
		
	: (Form event:C388=On Clicked:K2:4)
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
		Case of 
			: ($t_nombreObjeto="")
				
			: ($t_nombreObjeto="")
				
			: ($t_nombreObjeto="")
				
		End case 
End case 

