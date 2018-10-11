//%attributes = {}
  //UD_v20110713_EstadosFdPago 
If (ACT_AccountTrackInicializado )
	
	ACTfdp_EstadosXDefecto 
	
	  // asignacion IDS documentos en cartera
	READ WRITE:C146([ACT_Documentos_en_Cartera:182])
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Protestado y Reemplazado")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-7)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Reemplazado")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-6)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Nulo, Protestado y Reemplazado")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-10)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Nulo y Reemplazado")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-9)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Protestado")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-2)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Nulo y Protestado")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-8)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="A fecha@")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-4)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Vencido@")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=-5)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19=-4;*)
	QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]Estado:9="Al día@")
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]id_estado:21:=0)
	APPLY TO SELECTION:C70([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21))
	
	  // paso de cheque a fecha a estado
	READ WRITE:C146([ACT_Formas_de_Pago:287])
	READ WRITE:C146([ACT_EstadosFormasdePago:201])
	QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]glosa_forma_de_pago:9="Cheque a fecha")
	If (Records in selection:C76([ACT_Formas_de_Pago:287])=1)
		QUERY:C277([ACT_EstadosFormasdePago:201]; & ;[ACT_EstadosFormasdePago:201]id:1=-4)
		If (Records in selection:C76([ACT_EstadosFormasdePago:201])=0)
			ACTfdp_EstadosXDefecto 
			QUERY:C277([ACT_EstadosFormasdePago:201]; & ;[ACT_EstadosFormasdePago:201]id:1=-4)
		End if 
		If (Records in selection:C76([ACT_EstadosFormasdePago:201])=1)
			If ([ACT_Formas_de_Pago:287]codigo_interno:8#"")
				[ACT_EstadosFormasdePago:201]Codigo_interno:4:=[ACT_Formas_de_Pago:287]codigo_interno:8
			End if 
			[ACT_EstadosFormasdePago:201]id_cuenta_contable:5:=[ACT_Formas_de_Pago:287]id_cuenta_plan:4
			[ACT_EstadosFormasdePago:201]id_cuenta_contable_contra:7:=[ACT_Formas_de_Pago:287]id_cuenta_contra:6
			[ACT_EstadosFormasdePago:201]id_centro_costo:6:=[ACT_Formas_de_Pago:287]id_centro_plan:5
			[ACT_EstadosFormasdePago:201]id_centro_costo_contra:8:=[ACT_Formas_de_Pago:287]id_centro_contra:7
			SAVE RECORD:C53([ACT_EstadosFormasdePago:201])
			DELETE RECORD:C58([ACT_Formas_de_Pago:287])
		End if 
	End if 
	
	  //valida estado nulos para todas las formas de pago
	QUERY:C277([ACT_Formas_de_Pago:287];[ACT_Formas_de_Pago:287]id:1>0)
	While (Not:C34(End selection:C36([ACT_Formas_de_Pago:287])))
		ACTcfg_OpcionesFormasDePago ("ValidaEstadoNulo";->[ACT_Formas_de_Pago:287]id:1)
		NEXT RECORD:C51([ACT_Formas_de_Pago:287])
	End while 
	
	KRL_UnloadReadOnly (->[ACT_EstadosFormasdePago:201])
	KRL_UnloadReadOnly (->[ACT_Formas_de_Pago:287])
End if 