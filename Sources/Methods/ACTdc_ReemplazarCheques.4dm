//%attributes = {}
  //ACTdc_ReemplazarCheques

C_BLOB:C604(xBlob;$1)
xBlob:=$1

$0:=True:C214

ARRAY TEXT:C222(aACT_DocsReemp;0)
COPY ARRAY:C226(atACT_FormasdePago;aACT_DocsReemp)
C_LONGINT:C283(vl_indiceFormasDePago)
vl_indiceFormasDePago:=4
AT_Insert (1;vl_indiceFormasDePago-1;->aACT_DocsReemp)
aACT_DocsReemp{1}:="Mismo cheque"
aACT_DocsReemp{2}:="Varios Cheques"
aACT_DocsReemp{3}:="(-"

IDDocC:=0
vACT_BancoCodigo:=""
vACT_BancoNombre:=""
vACT_Cuenta:=""
vACT_FechaDoc:=!00-00-00!
vACT_Serie:=""
vACT_RUTTitular:=""
vACT_Titular:=""

vtACT_TCAgnoVencimiento:=""
vtACT_TCBancoCodigo:=""
vtACT_TCBancoEmisor:=""
vtACT_TCMesVencimiento:=""
vtACT_TCDocumento:=""
vtACT_TCNumero:=""
vtACT_TCRUTTitular:=""
vtACT_TipoTarjeta:=""
vtACT_Titular:=""
vtACT_TCCodigo:=""

vtACT_RDocumento:=""

rCheques:=1
vrACT_MontoDescto:=0
Params:=""
ACTpgs_InitArraysDocumentar ("DeclaraArrays")
ACTpgs_InitArraysDocumentar ("DesarmaBlob";->xBlob)
ACTpgs_OpcionesVR ("ACT_initArrays")
ACTcfgmyt_OpcionesGenerales ("InicializaVars")
ACTdc_CargaDCCreados ("InitArray")
  //ASM 20140320 Para cargar las formas de pagos de los reemplazos de documentos (imprimir)
ACTdc_CargaArregloFDP ("CargaArreglos")

IDDocC:=Num:C11(Substring:C12(Params;1;Position:C15(";";Params)-1))
$RestParams:=Substring:C12(Params;Position:C15(";";Params)+1)
ST_Deconcatenate (";";$RestParams;->vlACT_ReempPor;->vACT_BancoCodigo;->vACT_BancoNombre;->vACT_Cuenta;->vACT_FechaDoc;->vACT_Serie;->vACT_RUTTitular;->vACT_Titular;->vtACT_TCAgnoVencimiento;->vtACT_TCBancoCodigo;->vtACT_TCBancoEmisor;->vtACT_TCMesVencimiento;->vtACT_TCDocumento;->vtACT_TCNumero;->vtACT_TCRUTTitular;->vtACT_TCTipo;->vtACT_TCTitular;->vtACT_TCCodigo;->vtACT_RDocumento)

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
READ WRITE:C146([ACT_Documentos_de_Pago:176])
READ WRITE:C146([ACT_Pagos:172])

QUERY:C277([ACT_Documentos_en_Cartera:182];[ACT_Documentos_en_Cartera:182]ID:1=IDDocC)
QUERY:C277([ACT_Documentos_de_Pago:176];[ACT_Documentos_de_Pago:176]ID:1=[ACT_Documentos_en_Cartera:182]ID_DocdePago:3)
QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)

$lockedCartera:=Locked:C147([ACT_Documentos_en_Cartera:182])
$lockedDPagos:=Locked:C147([ACT_Documentos_de_Pago:176])
$lockedPagos:=Locked:C147([ACT_Pagos:172])

If ((Records in selection:C76([ACT_Documentos_en_Cartera:182])>0) & (Records in selection:C76([ACT_Documentos_de_Pago:176])>0) & (Records in selection:C76([ACT_Pagos:172])>0))
	If (Not:C34(($lockedCartera) | ($lockedDPagos) | ($lockedPagos)))
		ACTcc_OpcionesCalculoCtaCte ("InitArraysAndAgregarElemento";->[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
		Case of 
			: (vlACT_ReempPor=2)  //Varios cheques
				ACTreemp_VariosCheques 
			: (vlACT_ReempPor=(vl_indiceFormasDePago+1))  //Efectivo
				ACTreemp_Efectivo 
			: ((vlACT_ReempPor=1) | (vlACT_ReempPor=(vl_indiceFormasDePago+2)))  //Otro cheque o el mismo cheque
				ACTreemp_Cheques 
			: (vlACT_ReempPor=(vl_indiceFormasDePago+3))  //Tarjeta de credito
				ACTreemp_TarjetaCredito 
			: (vlACT_ReempPor=(vl_indiceFormasDePago+5))  //Letra
				ACTreemp_Letra 
			: (vlACT_ReempPor=(vl_indiceFormasDePago+4))  //Redcompra
				ACTreemp_RedCompra 
			Else 
				ACTreemp_Efectivo 
		End case 
		ACTpp_OpcionesCalculoMontos ("CalculaDesdeArreglosRecalculoCtas")
		ACTcc_OpcionesCalculoCtaCte ("RecalcularCtasBash")
	Else 
		$0:=False:C215
	End if 
Else 
	$0:=True:C214
End if 

KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Pagos:172])