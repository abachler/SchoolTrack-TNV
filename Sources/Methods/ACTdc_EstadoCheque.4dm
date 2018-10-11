//%attributes = {}
  //ACTdc_EstadoCheque

If (Count parameters:C259=1)
	$recNum:=$1
	READ WRITE:C146([ACT_Documentos_en_Cartera:182])
	GOTO RECORD:C242([ACT_Documentos_en_Cartera:182];$recNum)
End if 
READ WRITE:C146([ACT_Documentos_de_Pago:176])
QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
Case of 
	: (([ACT_Documentos_de_Pago:176]id_forma_de_pago:51=-8) & (Not:C34([ACT_Documentos_de_Pago:176]Protestado:36)))
		[ACT_Documentos_en_Cartera:182]id_estado:21:=0
		[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
	: ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
		Case of 
			: (Not:C34([ACT_Documentos_de_Pago:176]Nulo:37))
				If ([ACT_Documentos_de_Pago:176]Protestado:36)
					  //[ACT_Documentos_en_Cartera]id_estado:=-7
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestadoYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
				Else 
					  //[ACT_Documentos_en_Cartera]id_estado:=-6
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoReemplazado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
				End if 
			Else 
				If ([ACT_Documentos_de_Pago:176]Protestado:36)
					  //[ACT_Documentos_en_Cartera]id_estado:=-10
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNuloProtYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
				Else 
					  //[ACT_Documentos_en_Cartera]id_estado:=-9
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNuloYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
				End if 
		End case 
	: ([ACT_Documentos_de_Pago:176]Protestado:36)
		Case of 
			: (Not:C34([ACT_Documentos_de_Pago:176]Nulo:37))
				If ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
					  //[ACT_Documentos_en_Cartera]id_estado:=-7
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestadoYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
				Else 
					  //[ACT_Documentos_en_Cartera]id_estado:=-2
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoProtestado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
				End if 
				[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
			Else 
				If ([ACT_Documentos_en_Cartera:182]Reemplazado:14)
					  //[ACT_Documentos_en_Cartera]id_estado:=-10
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNuloProtYReemp";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
				Else 
					  //[ACT_Documentos_en_Cartera]id_estado:=-8
					[ACT_Documentos_en_Cartera:182]id_estado:21:=Num:C11(ACTcfg_OpcionesEstadosPagos ("ObtieneEstadoNuloYProtestado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19))
				End if 
				[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
		End case 
		
		  //: ([ACT_Documentos_en_Cartera]Ch_Depositardesde>Current date(*))
	: ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12>[ACT_Documentos_de_Pago:176]FechaPago:4)
		If ([ACT_Documentos_en_Cartera:182]id_estado:21<=0)  //ASM 20151026 Ticket 151549 
			[ACT_Documentos_en_Cartera:182]id_estado:21:=-4
			[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)+". "+__ ("Depositar en ")+String:C10([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12-Current date:C33(*))+" "+__ ("día(s)")+"."
		End if 
		  //: ([ACT_Documentos_en_Cartera]Ch_Depositardesde<Current date(*))
	: ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12<[ACT_Documentos_de_Pago:176]FechaPago:4)
		If ([ACT_Documentos_en_Cartera:182]id_estado:21<=0)  //ASM 20151026 Ticket 151549 
			Case of 
					  //: ([ACT_Documentos_en_Cartera]Ch_Depositarhasta>Current date(*))
				: ([ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13>[ACT_Documentos_de_Pago:176]FechaPago:4)
					[ACT_Documentos_en_Cartera:182]id_estado:21:=0
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)+". "+__ ("Faltan ")+String:C10([ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13-Current date:C33(*))+__ (" para el vencimiento.")
					  //: ([ACT_Documentos_en_Cartera]Ch_Depositarhasta<Current date(*))
				: ([ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13<[ACT_Documentos_de_Pago:176]FechaPago:4)
					[ACT_Documentos_en_Cartera:182]id_estado:21:=-5
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
					[ACT_Documentos_en_Cartera:182]Estado:9:=[ACT_Documentos_en_Cartera:182]Estado:9+". "+__ ("Debió ser depositado hace ")+String:C10(Current date:C33(*)-[ACT_Documentos_en_Cartera:182]Ch_Depositarhasta:13)+" "+__ ("día(s)")+"."
				Else 
					[ACT_Documentos_en_Cartera:182]id_estado:21:=0
					[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)+". "+__ ("DEPOSITAR HOY")
			End case 
		End if 
		  //: ([ACT_Documentos_en_Cartera]Ch_Depositardesde=Current date(*))
	: ([ACT_Documentos_en_Cartera:182]Ch_Depositardesde:12=[ACT_Documentos_de_Pago:176]FechaPago:4)
		If ([ACT_Documentos_en_Cartera:182]id_estado:21<=0)  //ASM 20151026 Ticket 151549 
			[ACT_Documentos_en_Cartera:182]id_estado:21:=0
			[ACT_Documentos_en_Cartera:182]Estado:9:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;->[ACT_Documentos_en_Cartera:182]id_estado:21)
		End if 
End case 
SAVE RECORD:C53([ACT_Documentos_en_Cartera:182])
[ACT_Documentos_de_Pago:176]id_estado:53:=[ACT_Documentos_en_Cartera:182]id_estado:21
[ACT_Documentos_de_Pago:176]Estado:14:=[ACT_Documentos_en_Cartera:182]Estado:9
  //SAVE RECORD([ACT_Documentos_de_Pago])
ACTdp_fSave 
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])