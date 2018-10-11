//%attributes = {}
  //ACTeod_RecalculaSaldoAnteriorAC
  //****DOC***
  //este metodo fue creado para recalcular los avisos de cobranza durante la noche.
  //****DOC***

If (ACT_AccountTrackInicializado )
	C_LONGINT:C283($vl_procId;$vl_records;$vl_registrosConSaldo)
	C_TEXT:C284($vt_monedaPais)
	
	READ ONLY:C145([ACT_Cargos:173])
	READ ONLY:C145([ACT_Documentos_de_Cargo:174])
	READ ONLY:C145([ACT_Avisos_de_Cobranza:124])
	
	$vt_monedaPais:=ST_GetWord (ACT_DivisaPais ;1;";")
	ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
	
	  //si hay cargos en moneda variable calculo
	SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_records)
	SET QUERY LIMIT:C395(1)
	QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28#$vt_monedaPais;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
	QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
	SET QUERY LIMIT:C395(0)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	  //si no incluyen los saldos anteriores verifico que no existan avisos con saldo anterior
	If (cb_IncluirSaldosAnteriores=0)
		SET QUERY DESTINATION:C396(Into variable:K19:4;$vl_registrosConSaldo)
		SET QUERY LIMIT:C395(1)
		QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0;*)
		QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12>0)
		SET QUERY LIMIT:C395(0)
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
	End if 
	
	If ((cb_IncluirSaldosAnteriores=1) | ($vl_records>0) | ($vl_registrosConSaldo>0))
		  //cuando se esta en cliente se muestra un mensaje en el metodo que recalcula los avisos.
		If ((Application type:C494#4D Server:K5:6) & (Application type:C494#4D Remote mode:K5:5))
			$vl_procId:=IT_UThermometer (1;0;__ ("Recalculando avisos de cobranza..."))
		End if 
		
		CREATE EMPTY SET:C140([ACT_Avisos_de_Cobranza:124];"setAvisos1")
		CREATE EMPTY SET:C140([ACT_Avisos_de_Cobranza:124];"setAvisos2")
		
		If ($vl_records>0)
			QUERY:C277([ACT_Cargos:173];[ACT_Cargos:173]Moneda:28#$vt_monedaPais;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]EmitidoSegúnMonedaCargo:11=True:C214;*)
			QUERY:C277([ACT_Cargos:173]; & ;[ACT_Cargos:173]Saldo:23#0)
			KRL_RelateSelection (->[ACT_Documentos_de_Cargo:174]ID_Documento:1;->[ACT_Cargos:173]ID_Documento_de_Cargo:3;"")
			KRL_RelateSelection (->[ACT_Avisos_de_Cobranza:124]ID_Aviso:1;->[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15;"")
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisos1")
		End if 
		
		If ($vl_registrosConSaldo>0)
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0;*)
			QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Saldo_anterior:12>0)
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisos2")
			UNION:C120("setAvisos1";"setAvisos2";"setAvisos1")
			USE SET:C118("setAvisos1")
		End if 
		
		If (cb_IncluirSaldosAnteriores=1)
			QUERY:C277([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0;*)
			If (cb_CalcularParaTodosLosAvisos=0)
				QUERY:C277([ACT_Avisos_de_Cobranza:124]; & ;[ACT_Avisos_de_Cobranza:124]Fecha_Vencimiento:5<Current date:C33(*))
			Else 
				QUERY:C277([ACT_Avisos_de_Cobranza:124])
			End if 
			CREATE SET:C116([ACT_Avisos_de_Cobranza:124];"setAvisos2")
			UNION:C120("setAvisos1";"setAvisos2";"setAvisos1")
			USE SET:C118("setAvisos1")
		End if 
		
		SET_ClearSets ("setAvisos1";"setAvisos2")
		
		ARRAY LONGINT:C221(alACT_RecNumsAvisos;0)
		QUERY SELECTION:C341([ACT_Avisos_de_Cobranza:124];[ACT_Avisos_de_Cobranza:124]Monto_a_Pagar:14>0)
		LONGINT ARRAY FROM SELECTION:C647([ACT_Avisos_de_Cobranza:124];alACT_RecNumsAvisos)
		  //20130131 RCH Para no calcular en tareas batch
		  //ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos)
		ACTmnu_RecalcularSaldosAvisos (->alACT_RecNumsAvisos;Current date:C33(*);False:C215;False:C215;True:C214)
		AT_Initialize (->alACT_RecNumsAvisos)
		
		If ($vl_procId#0)
			IT_UThermometer (-2;$vl_procId)
		End if 
		
		POST KEY:C465(-96)
	End if 
	
End if 