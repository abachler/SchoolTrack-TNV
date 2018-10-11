//%attributes = {}
  //ACTdc_IngresaDocReemplazador

  //If (vlACT_ReempPor<=8) `20100518 RCH Ticket 86330. No se por que estaba esta restriccion
$r:=CD_Dlog (0;__ ("¿Desea imprimir un comprobante de este reemplazo?");__ ("");__ ("Si");__ ("No"))
If ($r=1)
	FORM SET OUTPUT:C54([ACT_Documentos_en_Cartera:182];"ComprobanteReemplazo")
	PRINT SETTINGS:C106
	If (ok=1)
		PRINT RECORD:C71([ACT_Documentos_en_Cartera:182];>)
	End if 
End if 
  //End if 
$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
$lockedDPagos:=Locked:C147([ACT_Documentos_de_Pago:176])
$lockedPagos:=Locked:C147([ACT_Pagos:172])
ACTpgs_OpcionesVR ("ACT_initArrays")
ACTfdp_OpcionesRecargos ("InicializaVars")
If (Not:C34(($lockedCartera) | ($lockedDPagos) | ($lockedPagos)))
	ACTcc_OpcionesCalculoCtaCte ("InitArraysAndAgregarElemento";->[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
	ACTdc_CargaDCCreados ("InitAll")
	Case of 
		: (vlACT_ReempPor=2)  //Varios cheques
			ACTreemp_VariosCheques 
		: (vlACT_ReempPor=(vl_indiceFormasDePago))  //Efectivo
			ACTreemp_Efectivo 
		: ((vlACT_ReempPor=1) | (vlACT_ReempPor=(vl_indiceFormasDePago+1)))  //Otro cheque o el mismo cheque
			ACTreemp_Cheques 
		: (vlACT_ReempPor=(vl_indiceFormasDePago+2))  //Tarjeta de credito
			ACTreemp_TarjetaCredito 
		: (vlACT_ReempPor=(vl_indiceFormasDePago+4))  //Letra
			ACTreemp_Letra 
		: (vlACT_ReempPor=(vl_indiceFormasDePago+3))  //Redcompra
			ACTreemp_RedCompra 
		Else 
			ACTreemp_Efectivo 
	End case 
	  //calcula protesto...
	ACTpp_OpcionesCalculoMontos ("CalculaDesdeArreglosRecalculoCtas")
	  //20110127 RCH Se manda a bash para que demore menos el proceso.
	  //ACTcc_OpcionesCalculoCtaCte ("RecalcularCtas")
	ACTcc_OpcionesCalculoCtaCte ("RecalcularCtasBash")
Else 
	C_BLOB:C604($xBlob)
	Params:=String:C10([ACT_Documentos_en_Cartera:182]ID:1)+";"+ST_Concatenate (";";->vlACT_ReempPor;->vACT_BancoCodigo;->vACT_BancoNombre;->vACT_Cuenta;->vACT_FechaDoc;->vACT_Serie;->vACT_RUTTitular;->vACT_Titular;->vtACT_TCAgnoVencimiento;->vtACT_TCBancoCodigo;->vtACT_TCBancoEmisor;->vtACT_TCMesVencimiento;->vtACT_TCDocumento;->vtACT_TCNumero;->vtACT_TCRUTTitular;->vtACT_TCTipo;->vtACT_TCTitular;->vtACT_TCCodigo;->vtACT_RDocumento)
	ACTpgs_InitArraysDocumentar ("ArmaBlob";->$xBlob)
	BM_CreateRequest ("ACT_ReemplazaCheques";"";"";$xBlob)
	SET BLOB SIZE:C606($xBlob;0)
End if 
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Pagos:172])
ACTpgs_InitArraysDocumentar ("InitVarsFormP7")