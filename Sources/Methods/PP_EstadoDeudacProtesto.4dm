//%attributes = {}
  //PP_EstadoDeudacProtesto

C_LONGINT:C283($1)
LOAD RECORD:C52([Personas:7])

If (Count parameters:C259#0)
	Case of 
		: ($1=1)  //Para cheques protestados
			ARRAY TEXT:C222(atACT_DOCTitular;0)
			ARRAY TEXT:C222(atACT_DOCMotivo;0)
			ARRAY TEXT:C222(atACT_DOCNumero;0)
			ARRAY TEXT:C222(atACT_DOCBanco;0)
			ARRAY DATE:C224(adACT_DOCFecha;0)
			ARRAY DATE:C224(adACT_DOCFechaProtesto;0)
			ARRAY REAL:C219(arACT_DOCMonto;0)
			C_REAL:C285(vrTotalChProtestado)
			READ ONLY:C145([ACT_Documentos_en_Cartera:182])
			QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2;=;[Personas:7]No:1;*)
			  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado;=;"Protestado.";*)
			QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21=-2;*)
			QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;=;-4)
			KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
			SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]MotivoProtesto:16;atACT_DOCMotivo;[ACT_Documentos_en_Cartera:182]Numero_Doc:6;atACT_DOCNumero;[ACT_Documentos_en_Cartera:182]Ch_Protestadoel:11;adACT_DOCFechaProtesto;[ACT_Documentos_en_Cartera:182]Monto_Doc:7;arACT_DOCMonto;[ACT_Documentos_de_Pago:176]Fecha:13;adACT_DOCFecha;[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7;atACT_DOCBanco;[ACT_Documentos_de_Pago:176]Titular:9;atACT_DOCTitular)
			vrTotalChProtestado:=AT_GetSumArray (->arACT_DOCMonto)
		: ($1=2)  //Para Letras Protestadas
			ARRAY TEXT:C222(atACT_DOCTitular;0)
			ARRAY TEXT:C222(atACT_DOCMotivo;0)
			ARRAY TEXT:C222(atACT_DOCNumero;0)
			ARRAY DATE:C224(adACT_DOCFecha;0)
			ARRAY DATE:C224(adACT_DOCFechaProtesto;0)
			ARRAY REAL:C219(arACT_DOCMonto;0)
			C_REAL:C285(vrTotalChProtestado)
			READ ONLY:C145([ACT_Documentos_en_Cartera:182])
			QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID_Apoderado:2;=;[Personas:7]No:1;*)
			  //QUERY([ACT_Documentos_en_Cartera]; & ;[ACT_Documentos_en_Cartera]Estado;=;"Protestado.";*)
			QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_estado:21=-2;*)
			QUERY:C277([ACT_Documentos_en_Cartera:182]; & ;[ACT_Documentos_en_Cartera:182]id_forma_de_pago:19;=;-8)
			KRL_RelateSelection (->[ACT_Documentos_de_Pago:176]ID:1;->[ACT_Documentos_en_Cartera:182]ID_DocdePago:3;"")
			SELECTION TO ARRAY:C260([ACT_Documentos_en_Cartera:182]MotivoProtesto:16;atACT_DOCMotivo;[ACT_Documentos_en_Cartera:182]Numero_Doc:6;atACT_DOCNumero;[ACT_Documentos_en_Cartera:182]L_Protestadoel:15;adACT_DOCFechaProtesto;[ACT_Documentos_en_Cartera:182]Monto_Doc:7;arACT_DOCMonto;[ACT_Documentos_de_Pago:176]L_FechaEmision:26;adACT_DOCFecha;[ACT_Documentos_de_Pago:176]L_Indice:29;atACT_DOCTitular)
			vrTotalLProtestado:=AT_GetSumArray (->arACT_DOCMonto)
	End case 
	
End if 