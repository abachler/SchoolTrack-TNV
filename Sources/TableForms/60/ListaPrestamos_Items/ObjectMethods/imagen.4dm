  // [BBL_Prestamos].ListaPrestamos_Items.imagen()
  // Por: Alberto Bachler K.: 19-02-14, 05:42:50
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------

C_DATE:C307($d_fechaActual)
C_LONGINT:C283($l_diasAtraso;$l_diasEnPrestamo)
C_POINTER:C301($y_Registro;$y_Prestamo;$y_variableImagen)
C_TEXT:C284($t_Detalle;$t_infoPrestamo;$t_texto)

OBJECT SET VISIBLE:C603(*;"rectangulo1";False:C215)
OBJECT SET TITLE:C194(*;"l_recNumPrestamo";"-1")
OBJECT SET TITLE:C194(*;"l_selectedRecord";"-1")
OBJECT SET VISIBLE:C603(*;"mail";False:C215)
OBJECT SET VISIBLE:C603(*;"devolver";False:C215)
OBJECT SET TITLE:C194(*;"InfoPrestamo.L1";"")
OBJECT SET TITLE:C194(*;"InfoPrestamo.L2";"")
OBJECT SET TITLE:C194(*;"InfoPrestamo.L3";"")
ModernUI_SetTextAttributes ("InfoPrestamo.L1";Plain:K14:1;12;0)
ModernUI_SetTextAttributes ("InfoPrestamo.L2";Plain:K14:1;12;0)
ModernUI_SetTextAttributes ("InfoPrestamo.L3";Plain:K14:1;12;0)

OBJECT SET TITLE:C194(*;"titulo";"")
OBJECT SET TITLE:C194(*;"copia";"")
ModernUI_SetTextAttributes ("titulo";Plain:K14:1;12;0)
ModernUI_SetTextAttributes ("titulo";Plain:K14:1;12;0)


If ([BBL_Prestamos:60]Número_de_registro:1>0)
	OBJECT SET TITLE:C194(*;"l_recNumPrestamo";String:C10(Record number:C243([BBL_Prestamos:60])))
	OBJECT SET TITLE:C194(*;"l_selectedRecord";String:C10(Selected record number:C246([BBL_Prestamos:60])))
	RELATE ONE:C42([BBL_Prestamos:60]Número_de_lector:2)
	  //DOCL_DocumentosAsociados (->[BBL_Items];String([BBL_Items]Numero);"";True)
	$y_variableImagen:=OBJECT Get pointer:C1124(Object current:K67:2)
	$y_variableImagen->:=[BBL_Lectores:72]Fotografia:32
	OBJECT SET VISIBLE:C603(*;"imagen";Picture size:C356($y_variableImagen->)>0)
	
	RELATE ONE:C42([BBL_Prestamos:60]Número_de_registro:1)
	RELATE ONE:C42([BBL_Prestamos:60];[BBL_Prestamos:60]Número_de_lector:2)
	OBJECT SET TITLE:C194(*;"titulo";[BBL_Lectores:72]NombreCompleto:3)
	OBJECT SET TITLE:C194(*;"copia";"Copia Nº <[BBL_Registros]Número_de_copia> (<[BBL_Registros]Barcode_SinFormato>)")
	
	$d_fechaActual:=Current date:C33(*)
	$l_diasEnPrestamo:=$d_fechaActual-[BBL_Prestamos:60]Desde:3
	Case of 
		: (([BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!) & ([BBL_Prestamos:60]Hasta:4>=$d_fechaActual))
			Case of 
				: ($l_diasEnPrestamo=0)
					$t_infoPrestamo:=__ ("En préstamo desde hoy")
				: ($l_diasEnPrestamo=1)
					$t_infoPrestamo:=__ ("En préstamo desde ayer")
				: ($l_diasEnPrestamo=2)
					$t_infoPrestamo:=__ ("En préstamo desde antes de ayer")
				Else 
					$t_infoPrestamo:=__ ("En préstamo desde el ")+String:C10([BBL_Prestamos:60]Desde:3)
			End case 
			OBJECT SET TITLE:C194(*;"InfoPrestamo.L1";$t_infoPrestamo)
			ModernUI_SetTextAttributes ("InfoPrestamo.L1";Bold:K14:2;-Black:K11:16)
			$t_infoPrestamo:=$t_infoPrestamo+"\r"
			Case of 
				: (([BBL_Prestamos:60]Hasta:4-$d_fechaActual)=0)
					$t_infoPrestamo:=__ ("Devolución prevista para hoy")
				: (([BBL_Prestamos:60]Hasta:4-$d_fechaActual)=1)
					$t_infoPrestamo:=__ ("Devolución prevista para mañana")
				: (([BBL_Prestamos:60]Hasta:4-$d_fechaActual)=2)
					$t_infoPrestamo:=__ ("Devolución prevista para pasado mañana")
				Else 
					$t_infoPrestamo:=__ ("Devolución prevista el ")+String:C10([BBL_Prestamos:60]Hasta:4)
			End case 
			OBJECT SET TITLE:C194(*;"InfoPrestamo.L2";$t_infoPrestamo)
			ModernUI_SetTextAttributes ("InfoPrestamo.L2";Plain:K14:1;12;-Black:K11:16)
			
			
		: (([BBL_Prestamos:60]Fecha_de_devolución:5=!00-00-00!) & ([BBL_Prestamos:60]Hasta:4<$d_fechaActual))
			
			C_DATE:C307($d_hasta)
			  //TICKET 185310
			$d_hasta:=Add to date:C393([BBL_Prestamos:60]Hasta:4;0;0;1)
			$l_diasAtraso:=DT_GetWorkingDays ($d_hasta;$d_fechaActual)
			  //$l_diasAtraso:=$d_fechaActual-[BBL_Prestamos]Hasta
			
			
			
			Case of 
				: ($l_diasEnPrestamo=0)
					$t_infoPrestamo:=__ ("En préstamo desde hoy")
				: ($l_diasEnPrestamo=1)
					$t_infoPrestamo:=__ ("En préstamo desde ayer")
				: ($l_diasEnPrestamo=2)
					$t_infoPrestamo:=__ ("En préstamo desde antes de ayer")
				Else 
					$t_infoPrestamo:=__ ("En préstamo desde el ")+String:C10([BBL_Prestamos:60]Desde:3)
			End case 
			$t_infoPrestamo:=__ ("En préstamo desde el ")+String:C10([BBL_Prestamos:60]Desde:3)+__ (" hasta el ")+String:C10([BBL_Prestamos:60]Desde:3)
			OBJECT SET TITLE:C194(*;"InfoPrestamo.L1";$t_infoPrestamo)
			ModernUI_SetTextAttributes ("InfoPrestamo.L1";Plain:K14:1;12;-Black:K11:16)
			
			Case of 
				: (([BBL_Prestamos:60]Hasta:4-$d_fechaActual)=0)
					$t_infoPrestamo:=__ ("Devolución prevista para hoy")
				: (([BBL_Prestamos:60]Hasta:4-$d_fechaActual)=1)
					$t_infoPrestamo:=__ ("Devolución prevista para mañana")
				: (([BBL_Prestamos:60]Hasta:4-$d_fechaActual)=2)
					$t_infoPrestamo:=__ ("Devolución prevista para pasado mañana")
				Else 
					$t_infoPrestamo:=__ ("Devolución prevista el ")+String:C10([BBL_Prestamos:60]Hasta:4)
			End case 
			OBJECT SET TITLE:C194(*;"InfoPrestamo.L2";$t_infoPrestamo)
			ModernUI_SetTextAttributes ("InfoPrestamo.L2";Bold:K14:2;12;-Black:K11:16)
			
			If ($l_diasAtraso>1)
				OBJECT SET TITLE:C194(*;"InfoPrestamo.L3";String:C10($l_diasAtraso)+" "+__ ("días de atraso"))
			Else 
				OBJECT SET TITLE:C194(*;"InfoPrestamo.L3";String:C10($l_diasAtraso)+" "+__ ("día de atraso"))
			End if 
			ModernUI_SetTextAttributes ("InfoPrestamo.L3";Bold:K14:2;0;-Red:K11:4)
			
		: ([BBL_Prestamos:60]Fecha_de_devolución:5>!00-00-00!)
			
			  // Modificado por: Alexis Bustamante (29-05-2017)
			  //182364
			  //$t_infoPrestamo:=__ ("Prestado entre el ")+String([BBL_Prestamos]Desde)+__ (" y el ")+String([BBL_Prestamos]Desde)
			$t_infoPrestamo:=__ ("Prestado entre el ")+String:C10([BBL_Prestamos:60]Desde:3)+__ (" y el ")+String:C10([BBL_Prestamos:60]Hasta:4)
			OBJECT SET TITLE:C194(*;"InfoPrestamo.L1";$t_infoPrestamo)
			$t_infoPrestamo:=__ ("Devuelto el ")+String:C10([BBL_Prestamos:60]Fecha_de_devolución:5)
			OBJECT SET TITLE:C194(*;"InfoPrestamo.L2";$t_infoPrestamo)
			If ([BBL_Prestamos:60]Duración:6>1)
				OBJECT SET TITLE:C194(*;"InfoPrestamo.L3";String:C10([BBL_Prestamos:60]Duración:6)+__ (" días en préstamo"))
			Else 
				OBJECT SET TITLE:C194(*;"InfoPrestamo.L3";String:C10([BBL_Prestamos:60]Duración:6)+__ (" día en préstamo"))
			End if 
			ModernUI_SetTextAttributes ("InfoPrestamo.L2";Plain:K14:1;0;-Green:K11:9)
			ModernUI_SetTextAttributes ("InfoPrestamo.L3";Plain:K14:1;0;-Black:K11:16)
			
			
	End case 
	  //OBJECT SET VISIBLE(*;"accion_mail";([BBL_Prestamos]Fecha_de_devolucion=!00/00/00!))
	  //OBJECT SET VISIBLE(*;"accion_devolver";([BBL_Prestamos]Fecha_de_devolucion=!00/00/00!))
	
Else 
	  //OBJECT SET VISIBLE(*;"accion_mail";False)
	  //OBJECT SET VISIBLE(*;"accion_devolver";False)
End if 


