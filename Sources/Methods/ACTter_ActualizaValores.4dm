//%attributes = {}
  //ACTter_ActualizaValores

ARRAY LONGINT:C221($al_recNumCargos;0)
C_BOOLEAN:C305($0)
C_LONGINT:C283($1;$vl_idTercero)

$vl_idTercero:=$1
$vl_index:=Find in field:C653([ACT_Terceros:138]Id:1;$vl_idTercero)
If ($vl_index#-1)
	READ WRITE:C146([ACT_Terceros:138])
	GOTO RECORD:C242([ACT_Terceros:138];$vl_index)
	If (Not:C34(Locked:C147([ACT_Terceros:138])))
		
		[ACT_Terceros:138]Montos_Emitidos:50:=0
		[ACT_Terceros:138]Montos_Pagados:53:=0
		[ACT_Terceros:138]Montos_Proyectados:51:=0
		[ACT_Terceros:138]Deuda_Vencida:52:=0
		[ACT_Terceros:138]Saldo:54:=0
		SAVE RECORD:C53([ACT_Terceros:138])
		
		READ ONLY:C145([ACT_Cargos:173])
		QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]ID_Tercero:54=$vl_idTercero)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Cargos:173];$al_recNumCargos;"")
		ARRAY REAL:C219(arACT_MontoProyectado;0)
		ARRAY REAL:C219(arACT_MontoEmitido;0)
		ARRAY REAL:C219(arACT_MontoPagado;0)
		ARRAY REAL:C219(arACT_MontoVencido;0)
		For ($i;1;Size of array:C274($al_recNumCargos))
			REDUCE SELECTION:C351([ACT_Cargos:173];0)
			KRL_GotoRecord (->[ACT_Cargos:173];$al_recNumCargos{$i})
			READ ONLY:C145([ACT_CuentasCorrientes:175])
			CREATE RECORD:C68([ACT_CuentasCorrientes:175])  //para que el método siguiente no altere registros actuales. No guardar cuentas corrientes
			ACTcc_CalculaMontosCtasCtes 
		End for 
		
		[ACT_Terceros:138]Montos_Emitidos:50:=AT_GetSumArray (->arACT_MontoEmitido)
		[ACT_Terceros:138]Montos_Pagados:53:=AT_GetSumArray (->arACT_MontoPagado)
		[ACT_Terceros:138]Montos_Proyectados:51:=AT_GetSumArray (->arACT_MontoProyectado)
		[ACT_Terceros:138]Deuda_Vencida:52:=Abs:C99(AT_GetSumArray (->arACT_MontoVencido))*-1
		[ACT_Terceros:138]Saldo:54:=[ACT_Terceros:138]Montos_Pagados:53-[ACT_Terceros:138]Montos_Emitidos:50
		SAVE RECORD:C53([ACT_Terceros:138])
		AT_Initialize (->arACT_MontoProyectado;->arACT_MontoEmitido;->arACT_MontoPagado;->arACT_MontoVencido)
		
		  //20141117 RCH Calcula montos a fecha y protestados
		GOTO RECORD:C242([ACT_Terceros:138];$vl_index)
		$vb_done:=ACTpp_OpcionesCalculoMontos ("CalculaMontoDocumentos";->[ACT_Pagos:172]ID_Tercero:26;->[ACT_Terceros:138]Id:1;->[ACT_Terceros:138]Monto_a_fecha:60;->[ACT_Terceros:138]Monto_prot_no_reemp:59)
		
		
		$0:=True:C214
	End if 
	KRL_UnloadReadOnly (->[ACT_Terceros:138])
Else 
	$0:=True:C214
End if 