//%attributes = {}
  //ACTpp_RecalculaSaldoApdo

C_BOOLEAN:C305($done;$0)
C_REAL:C285($saldo)
C_LONGINT:C283($i;$vl_recNumPP)

READ ONLY:C145([Personas:7])
READ ONLY:C145([ACT_CuentasCorrientes:175])

$vl_recNumPP:=$1
$done:=True:C214

If ($vl_recNumPP#-1)
	KRL_GotoRecord (->[Personas:7];$vl_recNumPP;True:C214)
	If (ok=1)
		QUERY:C277([ACT_CuentasCorrientes:175];[ACT_CuentasCorrientes:175]ID_Apoderado:9=[Personas:7]No:1)
		If (Records in selection:C76([ACT_CuentasCorrientes:175])>0)
			
			ARRAY REAL:C219(arACT_MontoProyectado;0)
			ARRAY REAL:C219(arACT_MontoEmitido;0)
			ARRAY REAL:C219(arACT_MontoPagado;0)
			ARRAY REAL:C219(arACT_MontoVencido;0)
			
			ARRAY LONGINT:C221($al_idsCtas;0)
			SELECTION TO ARRAY:C260([ACT_CuentasCorrientes:175]ID:1;$al_idsCtas)
			ARRAY REAL:C219($arACT_MontoProyectado;0)
			ARRAY REAL:C219($arACT_MontoEmitido;0)
			ARRAY REAL:C219($arACT_MontoPagado;0)
			ARRAY REAL:C219($arACT_MontoVencido;0)
			For ($j;1;Size of array:C274($al_idsCtas))
				ACTcc_CalculaMontos ($al_idsCtas{$j};False:C215)
				For ($i;1;Size of array:C274(arACT_MontoProyectado))
					APPEND TO ARRAY:C911($arACT_MontoProyectado;arACT_MontoProyectado{$i})
					APPEND TO ARRAY:C911($arACT_MontoEmitido;arACT_MontoEmitido{$i})
					APPEND TO ARRAY:C911($arACT_MontoPagado;arACT_MontoPagado{$i})
					APPEND TO ARRAY:C911($arACT_MontoVencido;arACT_MontoVencido{$i})
				End for 
			End for 
			COPY ARRAY:C226($arACT_MontoProyectado;arACT_MontoProyectado)
			COPY ARRAY:C226($arACT_MontoEmitido;arACT_MontoEmitido)
			COPY ARRAY:C226($arACT_MontoPagado;arACT_MontoPagado)
			COPY ARRAY:C226($arACT_MontoVencido;arACT_MontoVencido)
			ACTpp_ActualizaValores ($vl_recNumPP)
		Else 
			  //20161026 RCH
			READ ONLY:C145([ACT_Pagos:172])
			READ WRITE:C146([ACT_Cargos:173])
			KRL_ReloadInReadWriteMode (->[Personas:7])
			QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_Apoderado:3=[Personas:7]No:1;*)
			QUERY:C277([ACT_Pagos:172]; & ;[ACT_Pagos:172]ID_CtaCte:21=0)
			$saldo:=Sum:C1([ACT_Pagos:172]Saldo:15)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22#!00-00-00!)
			  //[Personas]MontosEmitidos_Ejercicio:=Sum([ACT_Cargos]Monto_Neto)
			[Personas:7]MontosEmitidos_Ejercicio:82:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Monto_Neto:5;->[ACT_Cargos:173]Monto_Neto:5;Current date:C33(*))
			  //[Personas]MontosPagados_Ejercicio:=Sum([ACT_Cargos]MontosPagados)+$saldo
			[Personas:7]MontosPagados_Ejercicio:84:=Sum:C1([ACT_Cargos:173]MontosPagadosMPago:52)+$saldo
			[Personas:7]MontosProyectados_Ejercicio:81:=0
			  //[Personas]DeudaVencida_Ejercicio:=Sum([ACT_Cargos]Monto_Vencido)
			
			  // Saúl Ponce Ticket 183233, el monto de deuda vencida no se calculaba correctamente.
			  //[Personas]DeudaVencida_Ejercicio:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos]Monto_Vencido;->[ACT_Cargos]Monto_Vencido;Current date(*))
			CREATE SET:C116([ACT_Cargos:173];"$crgsTodos")
			QUERY SELECTION:C341([ACT_Cargos:173];[ACT_Cargos:173]Saldo:23>0;*)
			QUERY SELECTION:C341([ACT_Cargos:173]; & ;[ACT_Cargos:173]Fecha_de_Vencimiento:7<Current date:C33(*))
			[Personas:7]DeudaVencida_Ejercicio:83:=ACTcar_CalculaMontos ("redondeadoFromCurrentRecordsMPago";->[ACT_Cargos:173]Saldo:23;->[ACT_Cargos:173]Saldo:23;Current date:C33(*))
			USE SET:C118("$crgsTodos")
			CLEAR SET:C117("$crgsTodos")
			
			[Personas:7]Saldo_Ejercicio:85:=[Personas:7]MontosPagados_Ejercicio:84-[Personas:7]MontosEmitidos_Ejercicio:82
			[Personas:7]ES_Apoderado_de_Cuentas:42:=False:C215
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Apoderado:18=[Personas:7]No:1;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]FechaEmision:22=!00-00-00!)
			ACTcc_EliminaCargosLoop 
			SAVE RECORD:C53([Personas:7])
			KRL_UnloadReadOnly (->[ACT_Cargos:173])
		End if 
		
		  //20141117 RCH calcula  montos protestados y a fecha
		KRL_GotoRecord (->[Personas:7];$vl_recNumPP;True:C214)
		$vb_done:=ACTpp_OpcionesCalculoMontos ("CalculaMontoDocumentos";->[ACT_Pagos:172]ID_Apoderado:3;->[Personas:7]No:1;->[Personas:7]ACT_monto_a_fecha:97;->[Personas:7]ACT_mon_prot_no_reemp:96)
		
		KRL_UnloadReadOnly (->[Personas:7])
	Else 
		If (Records in selection:C76([Personas:7])=0)
			$done:=True:C214
		Else 
			$done:=False:C215
		End if 
	End if 
Else 
	$done:=True:C214
End if 
$0:=$done