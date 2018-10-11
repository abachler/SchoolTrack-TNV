//%attributes = {}
  //ACTcfg_OpcionesGenRecibo

C_TEXT:C284($t_accion;$1)
C_OBJECT:C1216($0;$ob_retorno)
C_POINTER:C301(${2})
C_POINTER:C301($y_pointer)

$t_accion:=$1
If (Count parameters:C259>=2)
	$y_pointer:=$2
End if 
If (Count parameters:C259>=3)
	$y_pointer2:=$3
End if 

Case of 
	: ($t_accion="LeeConf")
		ACTcfg_LeeBlob ("ACT_OpcionesImpresion")
		
	: ($t_accion="DeclaraVars")
		C_LONGINT:C283(cb_generarRcibosDesdeAC)
		
	: ($t_accion="ArmaObjeto")
		OB SET:C1220($ob_retorno;"recibo_dede_avisos";cb_generarRcibosDesdeAC)
		
	: ($t_accion="DesarmaObjeto")
		cb_generarRcibosDesdeAC:=OB Get:C1224($y_pointer->;"recibo_dede_avisos")
		
	: ($t_accion="GuardaConf")
		ACTcfg_GuardaBlob ("ACT_OpcionesImpresion")
		
	: ($t_accion="CreaTrabajoImpresion")
		C_BOOLEAN:C305($b_mostrarAlerta)
		$b_mostrarAlerta:=True:C214
		SET QUERY LIMIT:C395(1)  //20151005 RCH Hay bases que tienen duplicado el reporte...
		
		  //QUERY([xShell_Reports];[xShell_Reports]MainTable;=;Table(->[ACT_Pagos]);*)
		  //If (cb_generarRcibosDesdeAC=0)  //20170711 RCH se carga en ACTcfg_LoadConfigData/ACTcfg_OpcionesGenRecibo
		If ((cb_generarRcibosDesdeAC=0) | (vrACT_SeleccionadoAPagar=0))  //20170802 RCH Se verifica monto a pagar
			QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_Pagos:172]);*)
		Else 
			QUERY:C277([xShell_Reports:54];[xShell_Reports:54]MainTable:3;=;Table:C252(->[ACT_Avisos_de_Cobranza:124]);*)
		End if 
		
		QUERY:C277([xShell_Reports:54]; & ;[xShell_Reports:54]ReportName:26=$y_pointer->)
		SET QUERY LIMIT:C395(0)
		If (Records in selection:C76([xShell_Reports:54])=1)
			If ($b_mostrarAlerta)
				$r:=CD_Dlog (0;__ ("Por favor haga clic en el botón Lista cuando la impresora esté lista para imprimir ")+atACT_Recibos{atACT_Recibos}+__ (".");__ ("");__ ("Lista");__ ("Terminar sin imprimir"))
				If ($r=1)
					  //creo la seleccion de los pagos que se realizaron
					  //ticket 165439 JVP
					
					READ ONLY:C145([ACT_Pagos:172])
					QUERY WITH ARRAY:C644([ACT_Pagos:172]ID:1;$y_pointer2->)
					  //If (cb_generarRcibosDesdeAC=0)  //20170711 RCH se carga en ACTcfg_LoadConfigData/ACTcfg_OpcionesGenRecibo
					If ((cb_generarRcibosDesdeAC=0) | (vrACT_SeleccionadoAPagar=0))  //201708025 RCH
						CUT NAMED SELECTION:C334([ACT_Pagos:172];"◊Editions")  //20170315 RCH La selección se crea con CUT
					Else 
						READ ONLY:C145([ACT_Transacciones:178])
						READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
						KRL_RelateSelection (->[ACT_Transacciones:178]ID_Pago:4;->[ACT_Pagos:172]ID:1;"")
						KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Transacciones:178]No_Comprobante:10;"")
						CUT NAMED SELECTION:C334([ACT_Avisos_de_Cobranza:124];"◊Editions")  //20170315 RCH La selección se crea con CUT
					End if 
					
					QR_ImprimeInformeSRP (Record number:C243([xShell_Reports:54]))
					
				End if 
			End if 
		Else 
			If ($b_mostrarAlerta)
				CD_Dlog (0;__ ("El modelo seleccionado ha sido eliminado por otro usuario. Intente la impresión más tarde."))
			End if 
		End if 
		
End case 

$0:=$ob_retorno