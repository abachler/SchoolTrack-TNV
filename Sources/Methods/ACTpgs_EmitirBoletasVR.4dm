//%attributes = {}
  //ACTpgs_EmitirBoletasVR

ACTcfg_LoadConfigData (8)
$DocCat:=vlACT_CatVR
$ID_ModeloRecibo:=vlACT_ModRecibo
$allow:=ACTcfg_SearchCatDocs ($DocCat)
$RecNumPago:=$1

If (cbImprimirBoletas=1)
	If ($allow)
		CREATE EMPTY SET:C140([ACT_Boletas:181];"AImprimirAfectas")
		CREATE EMPTY SET:C140([ACT_Boletas:181];"AImprimirNoAfectas")
		If (vrACT_TotalAfecto>0)
			READ WRITE:C146([ACT_Pagos:172])
			GOTO RECORD:C242([ACT_Pagos:172];$RecNumPago)
			[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
			[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_RelatedTableUserName
			[ACT_Boletas:181]FechaEmision:3:=Current date:C33(*)
			[ACT_Boletas:181]AfectaIVA:9:=True:C214
			[ACT_Boletas:181]Monto_Total:6:=vrACT_TotalAfecto
			[ACT_Boletas:181]Monto_Afecto:4:=vrACT_MontoAfecto
			[ACT_Boletas:181]Monto_IVA:5:=vrACT_MontoIVA
			[ACT_Boletas:181]ID_Estado:20:=3
			[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
			[ACT_Boletas:181]ID_Pago:8:=[ACT_Pagos:172]ID:1
			[ACT_Boletas:181]ID_Categoria:12:=$DocCat
			[ACT_Boletas:181]ID_Documento:13:=alACT_IDDT{vlACT_IndexAfecta1}
			[ACT_Boletas:181]ID_Apoderado:14:=[ACT_Pagos:172]ID_Apoderado:3
			SAVE RECORD:C53([ACT_Boletas:181])
			ADD TO SET:C119([ACT_Boletas:181];"AImprimirAfectas")
			[ACT_Pagos:172]ID_DocTribAfecto:12:=[ACT_Boletas:181]ID:1
			SAVE RECORD:C53([ACT_Pagos:172])
			UNLOAD RECORD:C212([ACT_Boletas:181])
			READ ONLY:C145([ACT_Boletas:181])
			If (Records in set:C195("AImprimirAfectas")>0)
				ACTbol_PrintBoletasVR ("AImprimirAfectas";False:C215;alACT_IDDT{vlACT_IndexAfecta1})
				CLEAR SET:C117("AImprimirAfectas")
			End if 
		End if 
		If (cb_GenerarBoletaCero=1)
			$cond:=(vrACT_MontoExento>=0)
		Else 
			$cond:=(vrACT_MontoExento>0)
		End if 
		If ($cond)
			READ WRITE:C146([ACT_Pagos:172])
			GOTO RECORD:C242([ACT_Pagos:172];$RecNumPago)
			CREATE RECORD:C68([ACT_Boletas:181])
			[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
			[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_RelatedTableUserName
			[ACT_Boletas:181]FechaEmision:3:=Current date:C33(*)
			[ACT_Boletas:181]AfectaIVA:9:=False:C215
			[ACT_Boletas:181]Monto_Total:6:=vrACT_MontoExento
			[ACT_Boletas:181]Monto_Afecto:4:=0
			[ACT_Boletas:181]Monto_IVA:5:=0
			[ACT_Boletas:181]ID_Estado:20:=3
			[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
			[ACT_Boletas:181]ID_Pago:8:=[ACT_Pagos:172]ID:1
			[ACT_Boletas:181]ID_Categoria:12:=$DocCat
			[ACT_Boletas:181]ID_Documento:13:=alACT_IDDT{vlACT_IndexExenta1}
			[ACT_Boletas:181]ID_Apoderado:14:=[ACT_Pagos:172]ID_Apoderado:3
			SAVE RECORD:C53([ACT_Boletas:181])
			ADD TO SET:C119([ACT_Boletas:181];"AImprimirNoAfectas")
			[ACT_Pagos:172]ID_DocTribExento:11:=[ACT_Boletas:181]ID:1
			SAVE RECORD:C53([ACT_Pagos:172])
			UNLOAD RECORD:C212([ACT_Boletas:181])
			READ ONLY:C145([ACT_Boletas:181])
			If (Records in set:C195("AImprimirNoAfectas")>0)
				ACTbol_PrintBoletasVR ("AImprimirNoAfectas";False:C215;alACT_IDDT{vlACT_IndexExenta1})
				CLEAR SET:C117("AImprimirNoAfectas")
			End if 
		End if 
	Else 
		CD_Dlog (0;__ ("La categoría de documentos tributarios no tiene todas las definiciones de documentos. Se emitirá un recibo."))
		cb_EmitirRecibo:=1
		cbImprimirBoletas:=0
		ACTpgs_EmitirBoletasVR ($RecNumPago)
	End if 
Else 
	If (cb_EmitirRecibo=1)
		If (vrACT_MontoPago>0)
			READ WRITE:C146([ACT_Pagos:172])
			GOTO RECORD:C242([ACT_Pagos:172];$RecNumPago)
			CREATE EMPTY SET:C140([ACT_Boletas:181];"AImprimirRecibos")
			CREATE RECORD:C68([ACT_Boletas:181])
			[ACT_Boletas:181]ID:1:=SQ_SeqNumber (->[ACT_Boletas:181]ID:1)
			[ACT_Boletas:181]EmitidoPor:17:=<>tUSR_RelatedTableUserName
			[ACT_Boletas:181]FechaEmision:3:=Current date:C33(*)
			[ACT_Boletas:181]AfectaIVA:9:=False:C215
			[ACT_Boletas:181]Monto_Total:6:=vrACT_MontoPago
			[ACT_Boletas:181]Monto_Afecto:4:=0
			[ACT_Boletas:181]Monto_IVA:5:=0
			[ACT_Boletas:181]ID_Estado:20:=6
			[ACT_Boletas:181]Estado:2:=ACTbol_RetornaEstado ("RetornaEstadoTexto";->[ACT_Boletas:181]ID_Estado:20)
			[ACT_Boletas:181]ID_Pago:8:=[ACT_Pagos:172]ID:1
			[ACT_Boletas:181]ID_Categoria:12:=-100
			[ACT_Boletas:181]ID_Documento:13:=$ID_ModeloRecibo
			[ACT_Boletas:181]ID_Apoderado:14:=[ACT_Pagos:172]ID_Apoderado:3
			SAVE RECORD:C53([ACT_Boletas:181])
			ADD TO SET:C119([ACT_Boletas:181];"AImprimirRecibos")
			[ACT_Pagos:172]ID_DocTribExento:11:=[ACT_Boletas:181]ID:1
			SAVE RECORD:C53([ACT_Pagos:172])
			UNLOAD RECORD:C212([ACT_Boletas:181])
			READ ONLY:C145([ACT_Boletas:181])
		End if 
		If (Records in set:C195("AImprimirRecibos")>0)
			ACTbol_PrintBoletasVR ("AImprimirRecibos";False:C215;$ID_ModeloRecibo;True:C214)
			CLEAR SET:C117("AImprimirRecibos")
		End if 
	End if 
End if 
UNLOAD RECORD:C212([ACT_Pagos:172])