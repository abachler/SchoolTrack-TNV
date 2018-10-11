//%attributes = {}
  //ACTcc_CreateUpdateTransaction

READ WRITE:C146([ACT_Transacciones:178])
QUERY:C277([ACT_Transacciones:178];[ACT_Transacciones:178]ID_Item:3=[ACT_Cargos:173]ID:1;*)
QUERY:C277([ACT_Transacciones:178]; & ;[ACT_Transacciones:178]ID_Pago:4=0)
If (Records in selection:C76([ACT_Transacciones:178])=0)
	CREATE RECORD:C68([ACT_Transacciones:178])
	[ACT_Transacciones:178]ID_Transaccion:1:=SQ_SeqNumber (->[ACT_Transacciones:178]ID_Transaccion:1)
	[ACT_Transacciones:178]ID_Item:3:=[ACT_Cargos:173]ID:1
	[ACT_Transacciones:178]ID_CuentaCorriente:2:=[ACT_Cargos:173]ID_CuentaCorriente:2
	[ACT_Transacciones:178]ID_Apoderado:11:=[ACT_Cargos:173]ID_Apoderado:18
	[ACT_Transacciones:178]ID_Tercero:16:=[ACT_Cargos:173]ID_Tercero:54
	[ACT_Transacciones:178]RefPeriodo:12:=String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000")
	If ([ACT_Cargos:173]Monto_Neto:5>0)
		  //[ACT_Transacciones]Credito:=Abs([ACT_Cargos]Monto_Neto)+[ACT_Cargos]Intereses
		[ACT_Transacciones:178]Credito:7:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
		[ACT_Transacciones:178]Debito:6:=0
	Else 
		[ACT_Transacciones:178]Debito:6:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
		[ACT_Transacciones:178]Credito:7:=0
	End if 
	[ACT_Transacciones:178]Glosa:8:=[ACT_Cargos:173]Glosa:12
	If ([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
		[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]FechaEmision:22
		If ([ACT_Transacciones:178]No_Comprobante:10=0)
			READ ONLY:C145([ACT_Documentos_de_Cargo:174])
			QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
			[ACT_Transacciones:178]No_Comprobante:10:=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15
		End if 
	Else 
		[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]Fecha_de_generacion:4
	End if 
	SAVE RECORD:C53([ACT_Transacciones:178])
Else 
	If (Records in selection:C76([ACT_Transacciones:178])>1)
		QUERY SELECTION:C341([ACT_Transacciones:178];[ACT_Transacciones:178]Glosa:8=[ACT_Cargos:173]Glosa:12)
		If (Records in selection:C76([ACT_Transacciones:178])=1)
			[ACT_Transacciones:178]ID_Item:3:=[ACT_Cargos:173]ID:1
			[ACT_Transacciones:178]ID_CuentaCorriente:2:=[ACT_Cargos:173]ID_CuentaCorriente:2
			[ACT_Transacciones:178]ID_Apoderado:11:=[ACT_Cargos:173]ID_Apoderado:18
			[ACT_Transacciones:178]ID_Tercero:16:=[ACT_Cargos:173]ID_Tercero:54
			[ACT_Transacciones:178]RefPeriodo:12:=String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000")
			If ([ACT_Cargos:173]Monto_Neto:5>0)
				  //[ACT_Transacciones]Credito:=Abs([ACT_Cargos]Monto_Neto)+[ACT_Cargos]Intereses
				[ACT_Transacciones:178]Credito:7:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
				[ACT_Transacciones:178]Debito:6:=0
			Else 
				[ACT_Transacciones:178]Debito:6:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
				[ACT_Transacciones:178]Credito:7:=0
			End if 
			[ACT_Transacciones:178]Glosa:8:=[ACT_Cargos:173]Glosa:12
			If ([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
				[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]FechaEmision:22
				If ([ACT_Transacciones:178]No_Comprobante:10=0)
					READ ONLY:C145([ACT_Documentos_de_Cargo:174])
					QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
					[ACT_Transacciones:178]No_Comprobante:10:=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15
				End if 
			Else 
				[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]Fecha_de_generacion:4
			End if 
			SAVE RECORD:C53([ACT_Transacciones:178])
		End if 
	Else 
		[ACT_Transacciones:178]ID_Item:3:=[ACT_Cargos:173]ID:1
		[ACT_Transacciones:178]ID_CuentaCorriente:2:=[ACT_Cargos:173]ID_CuentaCorriente:2
		[ACT_Transacciones:178]ID_Apoderado:11:=[ACT_Cargos:173]ID_Apoderado:18
		[ACT_Transacciones:178]ID_Tercero:16:=[ACT_Cargos:173]ID_Tercero:54
		[ACT_Transacciones:178]RefPeriodo:12:=String:C10([ACT_Cargos:173]Mes:13;"00")+String:C10([ACT_Cargos:173]Año:14;"0000")
		If ([ACT_Cargos:173]Monto_Neto:5>0)
			  //[ACT_Transacciones]Credito:=Abs([ACT_Cargos]Monto_Neto)+[ACT_Cargos]Intereses
			[ACT_Transacciones:178]Credito:7:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
			[ACT_Transacciones:178]Debito:6:=0
		Else 
			[ACT_Transacciones:178]Debito:6:=Abs:C99([ACT_Cargos:173]Monto_Neto:5)
			[ACT_Transacciones:178]Credito:7:=0
		End if 
		[ACT_Transacciones:178]Glosa:8:=[ACT_Cargos:173]Glosa:12
		If ([ACT_Cargos:173]FechaEmision:22#!00-00-00!)
			[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]FechaEmision:22
			If ([ACT_Transacciones:178]No_Comprobante:10=0)
				READ ONLY:C145([ACT_Documentos_de_Cargo:174])
				QUERY:C277([ACT_Documentos_de_Cargo:174];[ACT_Documentos_de_Cargo:174]ID_Documento:1=[ACT_Cargos:173]ID_Documento_de_Cargo:3)
				[ACT_Transacciones:178]No_Comprobante:10:=[ACT_Documentos_de_Cargo:174]No_ComprobanteInterno:15
			End if 
		Else 
			[ACT_Transacciones:178]Fecha:5:=[ACT_Cargos:173]Fecha_de_generacion:4
		End if 
		SAVE RECORD:C53([ACT_Transacciones:178])
	End if 
End if 
KRL_UnloadReadOnly (->[ACT_Transacciones:178])