//%attributes = {}
  // BBLci_InformacionesItem()
  // Por: Alberto Bachler K.: 28-01-14, 15:00:29
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
C_TEXT:C284($1)

C_LONGINT:C283($l_movimientos;$l_prestamosEnMora;$l_prestamosVigentes;$l_totalPrestamos)
C_TEXT:C284($t_mensaje;$t_nombreObjeto)

If (False:C215)
	C_TEXT:C284(BBLci_InformacionesItem ;$1)
End if 
If (Count parameters:C259=1)
	$t_mensaje:=$1
End if 
Case of 
	: ($t_mensaje="Set")
		  // botones de estado del lector
		If (Record number:C243([BBL_Items:61])>No current record:K29:2)
			
			SET QUERY DESTINATION:C396(Into variable:K19:4;$l_totalPrestamos)
			QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_Item:11=[BBL_Items:61]Numero:1;*)
			QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Número_de_lector:2>0)
			If ($l_totalPrestamos>0)
				SET QUERY DESTINATION:C396(Into variable:K19:4;$l_prestamosVigentes)
				QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_Item:11=[BBL_Items:61]Numero:1;*)
				QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Número_de_lector:2>0;*)
				QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
				If ($l_prestamosVigentes>0)
					SET QUERY DESTINATION:C396(Into variable:K19:4;$l_prestamosEnMora)
					QUERY:C277([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_Item:11=[BBL_Items:61]Numero:1;*)
					QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Número_de_lector:2>0;*)
					QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Hasta:4<Current date:C33(*);*)
					QUERY:C277([BBL_Prestamos:60]; & ;[BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!)
				End if 
			End if 
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			
			If ($l_totalPrestamos>0)
				OBJECT SET RGB COLORS:C628(*;"Item.TotalPrestamos";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Item.TotalPrestamos";__ ("Prestamos: ")+String:C10($l_totalPrestamos))
			Else 
				OBJECT SET RGB COLORS:C628(*;"Item.TotalPrestamos";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Item.TotalPrestamos";__ ("Prestamos: 0"))
			End if 
			OBJECT SET ENABLED:C1123(*;"Item.TotalPrestamos";$l_totalPrestamos>0)
			
			If ($l_prestamosVigentes>0)
				OBJECT SET RGB COLORS:C628(*;"Item.PrestamosVigentes";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Item.PrestamosVigentes";__ ("Vigentes: ")+String:C10($l_prestamosVigentes))
			Else 
				OBJECT SET RGB COLORS:C628(*;"Item.PrestamosVigentes";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Item.PrestamosVigentes";__ ("Vigentes: 0"))
			End if 
			OBJECT SET ENABLED:C1123(*;"Item.PrestamosVigentes";$l_prestamosVigentes>0)
			
			If ($l_prestamosEnMora>0)
				OBJECT SET RGB COLORS:C628(*;"Item.PrestamosEnMora";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Item.PrestamosEnMora";__ ("En mora: ")+String:C10($l_prestamosEnMora))
			Else 
				OBJECT SET RGB COLORS:C628(*;"Item.PrestamosEnMora";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
				OBJECT SET TITLE:C194(*;"Item.PrestamosEnMora";__ ("En mora: 0"))
			End if 
			OBJECT SET ENABLED:C1123(*;"Item.PrestamosEnMora";$l_prestamosEnMora>0)
			
			
			
			If ([BBL_Items:61]Copias_disponibles:43>0)
				OBJECT SET RGB COLORS:C628(*;"Item.Disponibles";<>vl_ColorTextoBoton_Normal;<>vl_ColorFondoBoton)
			Else 
				OBJECT SET RGB COLORS:C628(*;"Item.Disponibles";<>vl_ColorTextoBoton_Off;<>vl_ColorFondoBoton)
			End if 
			OBJECT SET TITLE:C194(*;"Item.Disponibles";"Disponibles: "+String:C10([BBL_Items:61]Copias_disponibles:43)+"/"+String:C10([BBL_Items:61]Copias:24))
			OBJECT SET ENABLED:C1123(*;"Item.Disponibles";[BBL_Items:61]Copias_disponibles:43>0)
			
			
			OBJECT SET TITLE:C194(*;"Item.Editar";__ ("Editar"))
		Else 
			OBJECT SET TITLE:C194(*;"Item.TotalPrestamos";"")
			OBJECT SET TITLE:C194(*;"Item.PrestamosVigentes";"")
			OBJECT SET TITLE:C194(*;"Item.Disponibles";"")
			OBJECT SET TITLE:C194(*;"Item.PrestamosEnMora";"")
			OBJECT SET TITLE:C194(*;"Item.Editar";"")
		End if 
		
	: (Form event:C388=On Clicked:K2:4)
		$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
		Case of 
			: ($t_nombreObjeto="")
				
			: ($t_nombreObjeto="")
				
			: ($t_nombreObjeto="")
				
		End case 
End case 




