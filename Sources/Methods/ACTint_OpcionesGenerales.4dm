//%attributes = {}
  //ACTint_OpcionesGenerales
C_TEXT:C284($1;$t_accion)
C_TEXT:C284($0;$t_retorno)
C_POINTER:C301($2;$y_pointer)
C_BLOB:C604($xBlob)

C_LONGINT:C283(<>b_usarFechaPago;<>b_usarFechaVencimiento)
C_LONGINT:C283(<>bint_CalculaEnMonedaPais;<>bint_CalculaEnMonedaCargo)
C_LONGINT:C283(<>bint_AfectoExentoSegunCargo)

C_LONGINT:C283(b_usarFechaPagoOrg;b_usarFechaVencimientoOrg)
C_LONGINT:C283(bint_CalculaEnMonedaPais;bint_CalculaEnMonedaCargo;bint_AfectoExentoSegunCargo)

If (Count parameters:C259>=1)
	$t_accion:=$1
End if 

If (Count parameters:C259>=2)
	$y_pointer:=$2
End if 



Case of 
	: ($t_accion="")  //lee blob. Está´sin nombre porque se le hace un execute every where
		ACTint_OpcionesGenerales ("DeclaraVars")
		ACTint_OpcionesGenerales ("CreaBlob";->$xBlob)
		ACTint_OpcionesGenerales ("LoadBlob";->$xBlob)
		BLOB_Blob2Vars (->$xBlob;0;-><>b_usarFechaPago;-><>b_usarFechaVencimiento;-><>bint_CalculaEnMonedaPais;-><>bint_CalculaEnMonedaCargo;-><>bint_AfectoExentoSegunCargo)
		
		
		If ((<>b_usarFechaPago=0) & (<>b_usarFechaVencimiento=0))
			<>b_usarFechaPago:=1
		End if 
		
		If ((<>bint_CalculaEnMonedaPais=0) & (<>bint_CalculaEnMonedaCargo=0))
			<>bint_CalculaEnMonedaPais:=1
		End if 
		
		If ((<>b_usarFechaPago=1) & (<>b_usarFechaVencimiento=1))
			<>b_usarFechaPago:=1
			<>b_usarFechaVencimiento:=0
		End if 
		
		If ((<>bint_CalculaEnMonedaPais=1) & (<>bint_CalculaEnMonedaCargo=1))
			<>bint_CalculaEnMonedaPais:=1
			<>bint_CalculaEnMonedaCargo:=0
		End if 
		
		b_usarFechaPagoOrg:=<>b_usarFechaPago
		b_usarFechaVencimientoOrg:=<>b_usarFechaVencimiento
		
		bint_CalculaEnMonedaPais:=<>bint_CalculaEnMonedaPais
		bint_CalculaEnMonedaCargo:=<>bint_CalculaEnMonedaCargo
		
		bint_AfectoExentoSegunCargo:=<>bint_AfectoExentoSegunCargo
		
	: ($t_accion="DeclaraVars")
		
		
	: ($t_accion="CreaPreferenciaXDefecto")
		ACTint_OpcionesGenerales ("DeclaraVars")
		<>b_usarFechaPago:=1
		<>b_usarFechaVencimiento:=0
		
		<>bint_CalculaEnMonedaPais:=1
		<>bint_CalculaEnMonedaCargo:=0
		
		<>bint_AfectoExentoSegunCargo:=0
		
		ACTint_OpcionesGenerales ("CreaBlob";->$xBlob)
		ACTint_OpcionesGenerales ("LoadBlob";->$xBlob)
		ACTint_OpcionesGenerales ("SaveBlob")
		
	: ($t_accion="SaveBlob")
		ACTint_OpcionesGenerales ("CreaBlob";->$xBlob)
		PREF_SetBlob (0;"ACT_CONF_FECHA_CALC_INTERESES";$xBlob)
		
	: ($t_accion="GuardaBlob")
		$b_leeEnConf:=False:C215
		If ((<>b_usarFechaPago#b_usarFechaPagoOrg) | (<>b_usarFechaVencimiento#b_usarFechaVencimientoOrg) | (<>bint_CalculaEnMonedaPais#bint_CalculaEnMonedaPais) | (<>bint_CalculaEnMonedaCargo#bint_CalculaEnMonedaCargo) | (<>bint_AfectoExentoSegunCargo#bint_AfectoExentoSegunCargo))
			$b_leeEnConf:=True:C214
			
			If ((<>b_usarFechaPago#b_usarFechaPagoOrg) | (<>b_usarFechaVencimiento#b_usarFechaVencimientoOrg))
				If (<>b_usarFechaPago=1)
					LOG_RegisterEvt ("Cambio en configuración de fecha de paridad para cálculo de intereses. Variable "+ST_Qte ("Pago")+" cambió de "+String:C10(b_usarFechaPagoOrg)+" a "+String:C10(<>b_usarFechaPago)+".")
				Else 
					LOG_RegisterEvt ("Cambio en configuración de fecha de paridad para cálculo de intereses. Variable "+ST_Qte ("Vencimiento")+" cambió de "+String:C10(b_usarFechaVencimientoOrg)+" a "+String:C10(<>b_usarFechaVencimiento)+".")
				End if 
			Else 
				If (<>bint_CalculaEnMonedaPais=1)
					LOG_RegisterEvt ("Cambio en configuración de moneda para cálculo de intereses. Variable "+ST_Qte ("Moneda país")+" cambió de "+String:C10(bint_CalculaEnMonedaPais)+" a "+String:C10(<>bint_CalculaEnMonedaPais)+".")
				Else 
					LOG_RegisterEvt ("Cambio en configuración de fecha de paridad para cálculo de intereses. Variable "+ST_Qte ("Moneda cargo")+" cambió de "+String:C10(bint_CalculaEnMonedaCargo)+" a "+String:C10(<>bint_CalculaEnMonedaCargo)+".")
				End if 
			End if 
			
			If (<>bint_AfectoExentoSegunCargo#bint_AfectoExentoSegunCargo)
				LOG_RegisterEvt ("Cambio en configuración de generación de intereses afectos o exentos según cargo original. Cambió de "+String:C10(bint_AfectoExentoSegunCargo)+" a "+String:C10(<>bint_AfectoExentoSegunCargo)+".")
			End if 
			
		End if 
		
		ACTint_OpcionesGenerales ("SaveBlob")
		
		If ($b_leeEnConf)  //Si hay cambios se lee en todos lados
			KRL_ExecuteEverywhere ("ACTint_OpcionesGenerales")
		End if 
		
	: ($t_accion="CreaBlob")
		BLOB_Variables2Blob ($y_pointer;0;-><>b_usarFechaPago;-><>b_usarFechaVencimiento;-><>bint_CalculaEnMonedaPais;-><>bint_CalculaEnMonedaCargo;-><>bint_AfectoExentoSegunCargo)
		
	: ($t_accion="LoadBlob")
		$y_pointer->:=PREF_fGetBlob (0;"ACT_CONF_FECHA_CALC_INTERESES";$y_pointer->)
		
End case 

  //$0:=$t_retorno 20160921 RCH Cuando se lee la configuración en todas partes aparece un error en el server compilado. Ticket 168192.