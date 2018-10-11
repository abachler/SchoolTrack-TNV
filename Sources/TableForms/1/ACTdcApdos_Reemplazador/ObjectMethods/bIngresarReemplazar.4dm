$Reemplazar:=False:C215

If (Not:C34(Reemplazado))
	If ((vlACT_ReempPor=2) | (vlACT_ReempPor=3))
		If ((vACT_BancoNombre="") | (vACT_Cuenta="") | (vACT_Serie="") | (vACT_FechaDoc=!00-00-00!))
			CD_Dlog (0;__ ("Faltan datos del cheque."))
		Else 
			If (vlACT_ReempPor=3)
				  //SET QUERY DESTINATION(Into variable ;$duplicados)
				  //QUERY([ACT_Documentos_de_Pago];[ACT_Documentos_de_Pago]Ch_BancoCodigo=vACT_BancoCodigo;*)
				  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]Ch_Cuenta=vACT_Cuenta;*)
				  //QUERY([ACT_Documentos_de_Pago]; & ;[ACT_Documentos_de_Pago]NoSerie=vACT_Serie)
				  //SET QUERY DESTINATION(Into current selection )
				
				C_LONGINT:C283($duplicados)
				$duplicados:=ACTdc_BuscaDuplicados (2;vACT_Serie;vACT_Cuenta;vACT_BancoCodigo)
				
				If ($duplicados>0)
					CD_Dlog (0;__ ("Para este banco y esta cuenta ya existe un cheque con este número de serie."))
					GOTO OBJECT:C206(vACT_Serie)
				Else 
					$Reemplazar:=True:C214
				End if 
			Else 
				$Reemplazar:=True:C214
			End if 
		End if 
	Else 
		$Reemplazar:=True:C214
	End if 
	
	If ($Reemplazar)
		$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
		$lockedDPagos:=Locked:C147([ACT_Documentos_de_Pago:176])
		$lockedPagos:=Locked:C147([ACT_Pagos:172])
		If (Not:C34(($lockedCartera) | ($lockedPagos) | ($lockedPagos)))
			Case of 
				: (vlACT_ReempPor=1)  //Efectivo
					DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
					READ ONLY:C145([ACT_Documentos_en_Cartera:182])
					[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=""
					[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=""
					[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=""
					[ACT_Documentos_de_Pago:176]Fecha:13:=!00-00-00!
					[ACT_Documentos_de_Pago:176]NoSerie:12:=""
					[ACT_Documentos_de_Pago:176]RUTTitular:10:=""
					[ACT_Documentos_de_Pago:176]Titular:9:=""
					[ACT_Documentos_de_Pago:176]En_cartera:34:=False:C215
					[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
					  //[ACT_Documentos_de_Pago]Estado:=""
					[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-3
					[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
					[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
					
					[ACT_Documentos_de_Pago:176]id_estado:53:=0
					[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
					
					  //SAVE RECORD([ACT_Documentos_de_Pago])
					ACTdp_fSave 
					READ WRITE:C146([ACT_Pagos:172])
					QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
					[ACT_Pagos:172]FormaDePago:7:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
					[ACT_Pagos:172]forma_de_pago_new:31:=[ACT_Documentos_de_Pago:176]forma_de_pago_new:52
					SAVE RECORD:C53([ACT_Pagos:172])
					UNLOAD RECORD:C212([ACT_Pagos:172])
					READ ONLY:C145([ACT_Pagos:172])
					UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
					READ ONLY:C145([ACT_Documentos_de_Pago:176])
				: (vlACT_ReempPor=2)  //Mismo cheque
					[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=vACT_BancoCodigo
					[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=vACT_BancoNombre
					[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=vACT_Cuenta
					[ACT_Documentos_de_Pago:176]Fecha:13:=vACT_FechaDoc
					[ACT_Documentos_de_Pago:176]FechaProtesto:15:=!00-00-00!
					[ACT_Documentos_de_Pago:176]NoSerie:12:=vACT_Serie
					[ACT_Documentos_de_Pago:176]RUTTitular:10:=vACT_RUTTitular
					[ACT_Documentos_de_Pago:176]Titular:9:=vACT_Titular
					[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
					[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-4
					[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
					[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
					  //SAVE RECORD([ACT_Documentos_de_Pago])
					ACTdp_fSave 
					[ACT_Documentos_en_Cartera:182]Reemplazado:14:=False:C215
					[ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11:=!00-00-00!
					[ACT_Documentos_en_Cartera:182]Estado:9:=[ACT_Documentos_de_Pago:176]Estado:14
					[ACT_Documentos_en_Cartera:182]Fecha_Doc:5:=[ACT_Documentos_de_Pago:176]FechaPago:4
					  //[ACT_Documentos_en_Cartera]Fecha_Vencimiento:=[ACT_Documentos_en_Cartera]Fecha_Doc+60
					Case of   //20140522 RCH Cambios según ticket 132961
						: (<>gCountryCode="ar")
							[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30
						: (<>gCountryCode="co")
							[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+30
						Else 
							[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5+60
					End case 
					[ACT_Documentos_en_Cartera:182]ID:1:=SQ_SeqNumber (->[ACT_Documentos_en_Cartera:182]ID:1)
					[ACT_Documentos_en_Cartera:182]ID_Apoderado:2:=[ACT_Documentos_de_Pago:176]ID_Apoderado:2
					[ACT_Documentos_en_Cartera:182]ID_DocdePago:3:=[ACT_Documentos_de_Pago:176]ID:1
					[ACT_Documentos_en_Cartera:182]Monto_Doc:7:=[ACT_Documentos_de_Pago:176]MontoPago:6
					[ACT_Documentos_en_Cartera:182]Numero_Doc:6:=[ACT_Documentos_de_Pago:176]NoSerie:12
					[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-4
					[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
					[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
					[ACT_Documentos_en_Cartera:182]Ubicacion_Doc:8:="En Cartera"
					[ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12:=[ACT_Documentos_en_Cartera:182]Fecha_Doc:5
					[ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13:=[ACT_Documentos_en_Cartera:182]Fecha_Vencimiento:10-1
					$recNumCartera:=Record number:C243([ACT_Documentos_en_Cartera:182])
					SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
					ACTdc_EstadoCheque ($recNumCartera)
				: (vlACT_ReempPor=3)  //Otro cheque
					If (([ACT_Documentos_en_Cartera:182]id_estado:21=-2) | ([ACT_Documentos_en_Cartera:182]id_estado:21=-7))
						  //[ACT_Documentos_en_Cartera]id_estado:=-7
						[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestadoYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
						[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
						[ACT_Documentos_en_Cartera:182]Reemplazado:14:=True:C214
						SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
						READ ONLY:C145([ACT_Documentos_en_Cartera:182])
						READ WRITE:C146([ACT_Pagos:172])
						QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
						[ACT_Documentos_de_Pago:176]id_estado:53:=[ACT_Documentos_en_Cartera:182]id_estado:21
						[ACT_Documentos_de_Pago:176]Estado:14:=[ACT_Documentos_en_Cartera:182]Estado:9
						  //SAVE RECORD([ACT_Documentos_de_Pago])
						ACTdp_fSave 
						
						DUPLICATE RECORD:C225([ACT_Documentos_de_Pago:176])
						[ACT_Documentos_de_Pago:176]ID:1:=SQ_SeqNumber (->[ACT_Documentos_de_Pago:176]ID:1)
						[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=vACT_BancoCodigo
						[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=vACT_BancoNombre
						[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=vACT_Cuenta
						[ACT_Documentos_de_Pago:176]Fecha:13:=vACT_FechaDoc
						[ACT_Documentos_de_Pago:176]FechaProtesto:15:=!00-00-00!
						[ACT_Documentos_de_Pago:176]NoSerie:12:=vACT_Serie
						[ACT_Documentos_de_Pago:176]RUTTitular:10:=vACT_RUTTitular
						[ACT_Documentos_de_Pago:176]Titular:9:=vACT_Titular
						[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
						[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-4
						[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
						[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
						[ACT_Documentos_de_Pago:176]id_estado:53:=0
						[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
						[ACT_Documentos_de_Pago:176]Auto_UUID:74:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
						
						  //SAVE RECORD([ACT_Documentos_de_Pago])
						ACTdp_fSave 
						[ACT_Pagos:172]ID_DocumentodePago:6:=[ACT_Documentos_de_Pago:176]ID:1
						SAVE RECORD:C53([ACT_Pagos:172])
						ACTpgs_CreacionDocCartera (-4)
					Else 
						DELETE RECORD:C58([ACT_Documentos_en_Cartera:182])
						READ ONLY:C145([ACT_Documentos_en_Cartera:182])
						[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=vACT_BancoCodigo
						[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=vACT_BancoNombre
						[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=vACT_Cuenta
						[ACT_Documentos_de_Pago:176]Fecha:13:=vACT_FechaDoc
						[ACT_Documentos_de_Pago:176]FechaProtesto:15:=!00-00-00!
						[ACT_Documentos_de_Pago:176]NoSerie:12:=vACT_Serie
						[ACT_Documentos_de_Pago:176]RUTTitular:10:=vACT_RUTTitular
						[ACT_Documentos_de_Pago:176]Titular:9:=vACT_Titular
						[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
						[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-4
						[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
						[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
						
						[ACT_Documentos_de_Pago:176]id_estado:53:=0
						[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
						
						  //SAVE RECORD([ACT_Documentos_de_Pago])
						ACTdp_fSave 
						ACTpgs_CreacionDocCartera (-4)
					End if 
					UNLOAD RECORD:C212([ACT_Documentos_de_Pago:176])
					READ ONLY:C145([ACT_Documentos_de_Pago:176])
					UNLOAD RECORD:C212([ACT_Documentos_en_Cartera:182])
					READ ONLY:C145([ACT_Documentos_en_Cartera:182])
					UNLOAD RECORD:C212([ACT_Pagos:172])
					READ ONLY:C145([ACT_Pagos:172])
			End case 
			CANCEL:C270
		Else 
			Params:=String:C10([ACT_Documentos_en_Cartera:182]ID:1)+";"+ST_Concatenate (";";->vlACT_ReempPor;->vACT_BancoCodigo;->vACT_BancoNombre;->vACT_Cuenta;->vACT_FechaDoc;->vACT_Serie;->vACT_RUTTitular;->vACT_Titular)
			BM_CreateRequest ("ACT_ReemplazaCheques";Params)
			CANCEL:C270
		End if 
	End if 
Else 
	CANCEL:C270
End if 