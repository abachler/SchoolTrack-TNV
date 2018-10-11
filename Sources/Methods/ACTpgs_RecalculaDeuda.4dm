//%attributes = {}
  //ACTpgs_RecalculaDeuda

$vt_accion:=$1
If (Count parameters:C259>=2)
	$fecha:=$2
Else 
	$fecha:=Current date:C33(*)
End if 

Case of 
	: ($vt_accion="cargaDatos")
		vrACT_MontoAdeudadoExento:=0
		vrACT_MontoAdeudadoAfecto:=0
		For ($i;1;Size of array:C274(alACT_AIDAviso))
			$vrACT_MontoAdeudadoExento:=0
			$vrACT_MontoAdeudadoAfecto:=0
			ACTpgs_RetornaMontoXAviso ("MontoDesdeNoAvisos";False:C215;String:C10(alACT_AIDAviso{$i});$fecha;->$vrACT_MontoAdeudadoAfecto;->$vrACT_MontoAdeudadoExento)
			vrACT_MontoAdeudadoAfecto:=vrACT_MontoAdeudadoAfecto+$vrACT_MontoAdeudadoAfecto
			vrACT_MontoAdeudadoExento:=vrACT_MontoAdeudadoExento+$vrACT_MontoAdeudadoExento
		End for 
		vrACT_MontoPago:=0
		vrACT_MontoAPagarAfecto:=0
		vrACT_MontoAPagarExento:=0
		vrACT_MontoAPagar:=0
		vrACT_SeleccionadoAfecto:=0
		vrACT_SeleccionadoExento:=0
		vrACT_SeleccionadoAPagar:=0
		C_REAL:C285($pagosconSaldo;$saldoApdo;$saldoCtas)
		If (RNTercero=-1)
			If (cb_PermitePorCta=0)
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
				$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
			Else 
				If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
					QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_CtaCte:21=[ACT_CuentasCorrientes:175]ID:1;*)
					QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
					$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
				End if 
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
				$saldoApdo:=Sum:C1([ACT_Pagos:172]Saldo:15)
				QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21#0;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21#[ACT_CuentasCorrientes:175]ID:1;*)
				QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
				$saldoCtas:=Sum:C1([ACT_Pagos:172]Saldo:15)
				vrACT_OtrosSaldosDisp:=$saldoApdo+$saldoCtas
			End if 
		Else 
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Tercero:26=[ACT_Terceros:138]Id:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]Saldo:15>0)
			$pagosconSaldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
		End if 
		
		vrACT_SaldoDisp:=$pagosconSaldo
		vrACT_MontoDesctoAfecto:=0
		vrACT_MontoDesctoExento:=0
		vrACT_MontoDescto:=0
		vrACT_MontoAdeudado:=vrACT_MontoAdeudadoAfecto+vrACT_MontoAdeudadoExento+$pagosconSaldo
		
	: ($vt_accion="recalculoSeleccionado")
		vrACT_SeleccionadoAfecto:=0
		vrACT_SeleccionadoExento:=0
		Case of 
			: (vbACT_CargosDesdeAviso)
				$ptr:=->abACT_ASelectedAvisos
				$ptr2:=->alACT_AIDAviso
				$vt_accion:="MontoDesdeNoAvisos"
				$ptr3:=->arACT_AMontoSeleccionado
			: (vbACT_CargosDesdeItems)
				$ptr:=->abACT_ASelectedItem
				$ptr2:=->alACT_RefItem
				$vt_accion:="MontoDesdeNoItem"
				$ptr3:=->arACT_AMontoSeleccionadoXI
			: (vbACT_CargosDesdeAlumnos)
				$ptr:=->abACT_ASelectedAlumno
				$ptr2:=->alACT_AIdsCtas
				$vt_accion:="MontoDesdeNoCta"
				$ptr3:=->arACT_AMontoSeleccionadoXAl
			: (vbACT_CargosDesdeAgrupado)
				$ptr:=->abACT_ASelectedAgrupado
				$ptr2:=->atACT_YearMonthAgrupado
				$vt_accion:="MontoDesdeAgrupado"
				$ptr3:=->arACT_AMontoSelXAgrup
		End case 
		$ptr->{0}:=True:C214
		ARRAY LONGINT:C221($DA_Return;0)
		AT_SearchArray ($ptr;"=";->$DA_Return)
		If (Size of array:C274($DA_Return)>0)
			For ($i;1;Size of array:C274($DA_Return))
				$vrACT_SeleccionadoAfecto:=0
				$vrACT_SeleccionadoExento:=0
				If (vbACT_CargosDesdeAgrupado)
					ACTpgs_RetornaMontoXAviso ($vt_accion;True:C214;$ptr2->{$DA_Return{$i}};$fecha;->$vrACT_SeleccionadoAfecto;->$vrACT_SeleccionadoExento)
				Else 
					ACTpgs_RetornaMontoXAviso ($vt_accion;True:C214;String:C10($ptr2->{$DA_Return{$i}});$fecha;->$vrACT_SeleccionadoAfecto;->$vrACT_SeleccionadoExento)
				End if 
				vrACT_SeleccionadoAfecto:=vrACT_SeleccionadoAfecto+$vrACT_SeleccionadoAfecto
				vrACT_SeleccionadoExento:=vrACT_SeleccionadoExento+$vrACT_SeleccionadoExento
				$ptr3->{$DA_Return{$i}}:=$vrACT_SeleccionadoAfecto+$vrACT_SeleccionadoExento
			End for 
			
			vrACT_SeleccionadoPago:=vrACT_SeleccionadoAfecto+vrACT_SeleccionadoExento+vrACT_SaldoDisp
			vrACT_SeleccionadoAPagar:=vrACT_SeleccionadoPago
			vrACT_MontoAPagarAfecto:=vrACT_SeleccionadoAfecto-vrACT_MontoDesctoAfecto
			If (vrACT_MontoAPagarAfecto<0)
				vrACT_MontoDesctoAfecto:=0
				vrACT_MontoAPagarAfecto:=vrACT_SeleccionadoAfecto-vrACT_MontoDesctoAfecto
				CD_Dlog (0;__ ("El descuento afecto no puede ser aplicado ya que es superior al monto afecto a pagar. Si lo desea ingrese un nuevo descuento afecto."))
			End if 
			vrACT_MontoAPagarExento:=vrACT_SeleccionadoExento-vrACT_MontoDesctoExento
			If (vrACT_MontoAPagarExento<0)
				vrACT_MontoDesctoExento:=0
				vrACT_MontoAPagarExento:=vrACT_SeleccionadoExento-vrACT_MontoDesctoExento
				CD_Dlog (0;__ ("El descuento exento no puede ser aplicado ya que es superior al monto exento a pagar. Si lo desea ingrese un nuevo descuento exento."))
			End if 
			vrACT_MontoDescto:=vrACT_MontoDesctoAfecto+vrACT_MontoDesctoExento
			vrACT_MontoAPagar:=vrACT_MontoAPagarAfecto+vrACT_MontoAPagarExento-vrACT_SaldoDisp
			vrACT_MontoPago:=vrACT_MontoAPagar
			vrACT_MontoAPagarApdo:=vrACT_MontoAPagar
			_O_ENABLE BUTTON:C192(bIngresarPago)
			
			$ptr->{0}:=False:C215
			ARRAY LONGINT:C221($DA_Return;0)
			AT_SearchArray ($ptr;"=";->$DA_Return)
			For ($i;1;Size of array:C274($DA_Return))
				$ptr3->{$DA_Return{$i}}:=0
			End for 
		Else 
			AT_Populate ($ptr3;->vrACT_SeleccionadoExento)
			vrACT_SeleccionadoPago:=0
			vrACT_SeleccionadoAfecto:=0
			vrACT_SeleccionadoExento:=0
			vrACT_SeleccionadoAPagar:=0
			vrACT_MontoAPagarAfecto:=0
			vrACT_MontoAPagarExento:=0
			vrACT_MontoAPagar:=0
			vrACT_MontoDesctoAfecto:=0
			vrACT_MontoDesctoExento:=0
			vrACT_MontoDescto:=0
			vrACT_MontoPago:=0
			vrACT_MontoAPagarApdo:=0
			  //DISABLE BUTTON(bIngresarPago)
		End if 
End case 