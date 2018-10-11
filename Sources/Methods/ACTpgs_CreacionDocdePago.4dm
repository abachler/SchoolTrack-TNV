//%attributes = {}
  //ACTpgs_CreacionDocdePago

  //**** IMPORTANTE 201300822 RCH*****
  //CUANDO SE AGREGUE UNA FORMA DE PAGO QUE NECESITE LLENAR CAMPOS,
  //SE DEBE AGREGAR EL ID EN ACTcfgfdp_OpcionesGenerales ("FormasDePagoNOReemplazantes")
  // de ahi se toman las formas de pago que pueden reemplazar a otra
  //**** IMPORTANTE 201300822 RCH*****

$FormadePago:=$1

  //Creacion del documento de pago

CREATE RECORD:C68([ACT_Documentos_de_Pago:176])
[ACT_Documentos_de_Pago:176]ID:1:=SQ_SeqNumber (->[ACT_Documentos_de_Pago:176]ID:1)
[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=$FormadePago
[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
[ACT_Documentos_de_Pago:176]ID_AvisodeCobranza:3:=[ACT_Avisos_de_Cobranza:124]ID_Aviso:1
[ACT_Documentos_de_Pago:176]FechaPago:4:=vdACT_FechaPago
[ACT_Documentos_de_Pago:176]MontoPago:6:=vrACT_MontoPago
[ACT_Documentos_de_Pago:176]id_estado:53:=0
[ACT_Documentos_de_Pago:176]Estado:14:=KRL_GetTextFieldData (->[ACT_Formas_de_Pago:287]id:1;->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Formas_de_Pago:287]estado:13)
If (vbACTpgs_PagoXTercero)
	[ACT_Documentos_de_Pago:176]ID_Tercero:48:=[ACT_Terceros:138]Id:1
Else 
	[ACT_Documentos_de_Pago:176]ID_Apoderado:2:=[Personas:7]No:1
End if 
Case of 
		
	: ($FormadePago=-3)  //Efectivo
		
	: ($FormadePago=-4)  //Cheque
		[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=vtACT_BancoNombre
		[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=vtACT_BancoCodigo
		[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=vtACT_BancoCuenta
		[ACT_Documentos_de_Pago:176]Fecha:13:=vdACT_FechaDocumento
		[ACT_Documentos_de_Pago:176]NoSerie:12:=vtACT_NoSerie
		[ACT_Documentos_de_Pago:176]RUTTitular:10:=vtACT_BancoRUTTitular
		[ACT_Documentos_de_Pago:176]Titular:9:=vtACT_BancoTitular
		[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
		[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
		  //[ACT_Documentos_de_Pago]FechaVencimiento:=[ACT_Documentos_de_Pago]Fecha+60
		Case of   //20140522 RCH Cambios según ticket 132961
			: (<>gCountryCode="ar")
				[ACT_Documentos_de_Pago:176]FechaVencimiento:27:=[ACT_Documentos_de_Pago:176]Fecha:13+30
			: (<>gCountryCode="co")
				[ACT_Documentos_de_Pago:176]FechaVencimiento:27:=[ACT_Documentos_de_Pago:176]Fecha:13+30
			Else 
				[ACT_Documentos_de_Pago:176]FechaVencimiento:27:=[ACT_Documentos_de_Pago:176]Fecha:13+60
		End case 
		If ([ACT_Documentos_de_Pago:176]FechaPago:4#[ACT_Documentos_de_Pago:176]Fecha:13)
			[ACT_Documentos_de_Pago:176]id_estado:53:=-4
		End if 
		
		
	: ($FormadePago=-6)  //Tarjeta de credito
		C_TEXT:C284(vtACT_TCRUTTitular;vtACT_TCCodigo)  // Cuando se guardan los datos directo desde la ventana de pagos, el rut y el codigo no son datos obligatorios. las variables venian indefinidas.
		[ACT_Documentos_de_Pago:176]TC_Tipo:16:=vtACT_TCTipo
		If (Position:C15("x";vtACT_TCNumero)=0)
			[ACT_Documentos_de_Pago:176]TC_Numero:17:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->vtACT_TCNumero;->[ACT_Documentos_de_Pago:176]xPass:49)
		Else 
			[ACT_Documentos_de_Pago:176]TC_Numero:17:=[Personas:7]ACT_Numero_TC:54
			[ACT_Documentos_de_Pago:176]xPass:49:=[Personas:7]ACT_xPass:91
		End if 
		[ACT_Documentos_de_Pago:176]TC_Codigo:20:=vtACT_TCCodigo
		[ACT_Documentos_de_Pago:176]TC_Titular:18:=vtACT_TCTitular
		[ACT_Documentos_de_Pago:176]TC_RUTTitular:19:=vtACT_TCRUTTitular
		[ACT_Documentos_de_Pago:176]TC_MesVencimiento:21:=vtACT_TCMesVencimiento
		[ACT_Documentos_de_Pago:176]AgnoVencimiento:22:=vtACT_TCAgnoVencimiento
		[ACT_Documentos_de_Pago:176]TC_BancoEmisor:23:=vtACT_TCBancoEmisor
		[ACT_Documentos_de_Pago:176]TC_BancoCodigo:24:=vtACT_TCBancoCodigo
		[ACT_Documentos_de_Pago:176]TC_NoDocumento:25:=vtACT_TCDocumento
	: ($FormadePago=-7)  //Redcompra
		C_TEXT:C284(vtACT_TCRUTTitular;vtACT_TCCodigo)  // Cuando se guardan los datos directo desde la ventana de pagos, el rut y el codigo no son datos obligatorios. las variables venian indefinidas.
		[ACT_Documentos_de_Pago:176]R_NoDocumento:33:=vtACT_RDocumento
		  //Ticket 116401
		C_TEXT:C284(vtACT_TDCodigo)
		If (Position:C15("x";vtACT_TDNumero)=0)
			[ACT_Documentos_de_Pago:176]TD_Numero:69:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->vtACT_TDNumero;->[ACT_Documentos_de_Pago:176]xPass_TD:73)
		Else 
			  //20131128 ASM Ticket 127351
			If (vbACTpgs_PagoXTercero)
				[ACT_Documentos_de_Pago:176]TD_Numero:69:=[ACT_Terceros:138]RC_NumTD:66
				[ACT_Documentos_de_Pago:176]xPass_TD:73:=[ACT_Terceros:138]RC_xPass:72
				[ACT_Documentos_de_Pago:176]TD_RUTTitular:70:=[ACT_Terceros:138]RC_IdentificadorTD:64
			Else 
				[ACT_Documentos_de_Pago:176]TD_Numero:69:=[Personas:7]ACT_Numero_TD:104
				[ACT_Documentos_de_Pago:176]xPass_TD:73:=[Personas:7]ACT_xPass_TD:109
				[ACT_Documentos_de_Pago:176]TD_RUTTitular:70:=[Personas:7]ACT_RUTTitular_TD:105
			End if 
		End if 
		[ACT_Documentos_de_Pago:176]TD_Codigo:67:=vtACT_TDCodigo
		[ACT_Documentos_de_Pago:176]TD_Titular:72:=vtACT_TDTitular
		[ACT_Documentos_de_Pago:176]TD_RUTTitular:70:=vtACT_TDRUTTitular
		[ACT_Documentos_de_Pago:176]TD_MesVencimiento:68:=vtACT_TDMesVencimiento
		[ACT_Documentos_de_Pago:176]TD_AgnoVencimiento:64:=vtACT_TDAgnoVencimiento
		[ACT_Documentos_de_Pago:176]TD_BancoEmisor:66:=vtACT_TDBancoEmisor
		[ACT_Documentos_de_Pago:176]TD_BancoCodigo:65:=vtACT_TDBancoCodigo
		[ACT_Documentos_de_Pago:176]TD_Tipo:71:=vtACT_TDTipo
		
	: ($FormadePago=-8)  //Letra
		
		[ACT_Documentos_de_Pago:176]Fecha:13:=vdACT_LFechaEmision
		[ACT_Documentos_de_Pago:176]FechaProtesto:15:=!00-00-00!
		[ACT_Documentos_de_Pago:176]FechaVencimiento:27:=vdACT_LFechaVencimiento
		[ACT_Documentos_de_Pago:176]NoSerie:12:=vtACT_LDocumento
		[ACT_Documentos_de_Pago:176]RUTTitular:10:=vtACT_LRUTTitular
		[ACT_Documentos_de_Pago:176]Titular:9:=vtACT_LTitular
		[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
		[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
		[ACT_Documentos_de_Pago:176]L_Impuesto:44:=vrACT_LImpuesto
		[ACT_Documentos_de_Pago:176]L_Indice:29:=vtACT_LIndiceLetras
End case 
$0:=[ACT_Documentos_de_Pago:176]ID:1
  //SAVE RECORD([ACT_Documentos_de_Pago])
ACTdp_fSave 