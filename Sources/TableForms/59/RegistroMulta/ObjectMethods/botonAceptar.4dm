  // [BBL_Transacciones].RegistroMulta.pie_Boton1()
  // Por: Alberto Bachler: 22/10/13, 17:54:31
  //  ---------------------------------------------
  // 
  //
  //  ---------------------------------------------
$t_nombreObjeto:=OBJECT Get name:C1087(Object current:K67:2)
$y_multa:=OBJECT Get pointer:C1124(Object named:K67:5;"montoMulta")
Case of 
	: (Form event:C388=On Mouse Enter:K2:33)
		OBJECT SET FONT STYLE:C166(*;$t_nombreObjeto;Bold:K14:2)
		  //OBJECT SET RGB COLORS(*;$t_nombreObjeto;<>vl_ColorTextoBoton_mouseOn;<>vl_ColorBarra_Fondo)
		
	: (Form event:C388=On Mouse Leave:K2:34)
		OBJECT SET FONT STYLE:C166(*;$t_nombreObjeto;Plain:K14:1)
		  //OBJECT SET RGB COLORS(*;$t_nombreObjeto;<>vl_ColorTextoBoton_normal;<>vl_ColorBarra_Fondo)
		
	: (Form event:C388=On Clicked:K2:4)
		
		Case of 
			: (vl_modoConsola=Multa)
				$y_multa:=OBJECT Get pointer:C1124(Object named:K67:5;"montoMulta")
				$y_detalles:=OBJECT Get pointer:C1124(Object named:K67:5;"detallesmulta")
				$y_pago:=OBJECT Get pointer:C1124(Object named:K67:5;"montopagado")
				If ($y_multa->#0)
					CREATE RECORD:C68([BBL_Transacciones:59])
					[BBL_Transacciones:59]ID_Mvt:1:=0
					[BBL_Transacciones:59]Monto:2:=$y_multa->
					[BBL_Transacciones:59]Fecha:3:=Current date:C33(*)
					[BBL_Transacciones:59]ID_User:4:=[BBL_Lectores:72]ID:1
					[BBL_Transacciones:59]Glosa:6:=$y_detalles->
					
					Case of 
						: ($y_detalles->#"")
							[BBL_Transacciones:59]Glosa:6:=$y_detalles->
						: (([BBL_Transacciones:59]Glosa:6="") & ([BBL_Transacciones:59]Monto:2<0))
							[BBL_Transacciones:59]Glosa:6:=__ ("Anulación de multa")
						: (([BBL_Transacciones:59]Glosa:6="") & ([BBL_Transacciones:59]Monto:2>0))
							[BBL_Transacciones:59]Glosa:6:=__ ("Multa")
					End case 
					$t_glosa:=String:C10($y_multa->)+": "+[BBL_Transacciones:59]Glosa:6
					SAVE RECORD:C53([BBL_Transacciones:59])
					BBLci_registroEnLog (Multa;Record number:C243([BBL_Lectores:72]);No current record:K29:2;No current record:K29:2;$t_glosa)
					
					If (($y_pago->>0) & ($y_multa->>0))
						CREATE RECORD:C68([BBL_Transacciones:59])
						[BBL_Transacciones:59]ID_Mvt:1:=0
						[BBL_Transacciones:59]Monto:2:=$y_Pago->
						[BBL_Transacciones:59]Fecha:3:=Current date:C33(*)
						[BBL_Transacciones:59]ID_User:4:=[BBL_Lectores:72]ID:1
						Case of 
							: ($y_detalles->#"")
								[BBL_Transacciones:59]Glosa:6:=$y_detalles->
							: (([BBL_Transacciones:59]Glosa:6=""))
								[BBL_Transacciones:59]Glosa:6:=__ ("Pago")
						End case 
						[BBL_Transacciones:59]is_Paiement:5:=True:C214
						$t_glosa:=String:C10($y_Pago->)+": "+[BBL_Transacciones:59]Glosa:6
						SAVE RECORD:C53([BBL_Transacciones:59])
						BBLci_registroEnLog (Pago;Record number:C243([BBL_Lectores:72]);No current record:K29:2;No current record:K29:2;$t_glosa)
					End if 
					ACCEPT:C269
				End if 
				
			: (vl_modoConsola=Pago)
				$y_detalles:=OBJECT Get pointer:C1124(Object named:K67:5;"detallesPago")
				$y_pago:=OBJECT Get pointer:C1124(Object named:K67:5;"montopago")
				If ($y_pago->#0)
					CREATE RECORD:C68([BBL_Transacciones:59])
					[BBL_Transacciones:59]ID_Mvt:1:=0
					[BBL_Transacciones:59]Monto:2:=$y_Pago->
					[BBL_Transacciones:59]Fecha:3:=Current date:C33(*)
					[BBL_Transacciones:59]ID_User:4:=[BBL_Lectores:72]ID:1
					[BBL_Transacciones:59]Glosa:6:=$y_detalles->
					[BBL_Transacciones:59]is_Paiement:5:=True:C214
					Case of 
						: ($y_detalles->#"")
							[BBL_Transacciones:59]Glosa:6:=$y_detalles->
						: (([BBL_Transacciones:59]Glosa:6="") & ([BBL_Transacciones:59]Monto:2<0))
							[BBL_Transacciones:59]Glosa:6:=__ ("Anulación de pago")
						: (([BBL_Transacciones:59]Glosa:6="") & ([BBL_Transacciones:59]Monto:2>0))
							[BBL_Transacciones:59]Glosa:6:=__ ("Pago")
					End case 
					$t_glosa:=String:C10($y_Pago->)+": "+[BBL_Transacciones:59]Glosa:6
					SAVE RECORD:C53([BBL_Transacciones:59])
					BBLci_registroEnLog (Pago;Record number:C243([BBL_Lectores:72]);No current record:K29:2;No current record:K29:2;$t_glosa)
					ACCEPT:C269
				End if 
		End case 
		UNLOAD RECORD:C212([BBL_Transacciones:59])
		
End case 




