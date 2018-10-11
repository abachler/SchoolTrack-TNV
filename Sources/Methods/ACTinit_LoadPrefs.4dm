//%attributes = {}
  //ACTinit_LoadPrefs

C_BLOB:C604($xBlob)

While (Semaphore:C143("ACTinit_LoadPrefs"))
	DELAY PROCESS:C323(Current process:C322;10)
End while 


ACTfdp_CargaFormasDePago 

ACTcfg_InitBolArrays 



ACTinit_LoadMatrixIntoArrays 
ACTtbl_CargaGlosasExtra 

SET BLOB SIZE:C606($xBlob;0)
$xBlob:=PREF_fGetBlob (0;"ACT_Frecuencias Facturación";$xBlob)
BLOB_Blob2Vars (->$xBlob;0;-><>atACT_FreqFacturacion;-><>arACT_FreqDescuento)
SET BLOB SIZE:C606($xBlob;0)

  //  `ejercicio        
  //$xBlob:=PREF_fGetBlob (0;"ACT_PreferenciasGenerales";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;-><>vdACT_InicioEjercicio;-><>vdACT_TerminoEjercicio)
  //SET BLOB SIZE($xBlob;0)

  //Descuentos familia (orden alumnos) 
  //$xBlob:=PREF_fGetBlob (0;"ACT_DescuentosFamilia";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas)
  //SET BLOB SIZE($xBlob;0)
$xBlob:=PREF_fGetBlob (0;"ACT_DescuentosFamilia";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas)
BLOB_Blob2Vars (->$xBlob;0;->gGroupByFamily;->gGroupByGardian;->oOrderbyBirthDate;->oOrderByClass;->nOrdenAscendiente;->nOrdenDescendiente;->cbUsarDescuentosFamilia;->cbUsarDescuentosIngresos;->cbUsarDescuentosIndividual;->cbIncluirAdmision;->cbUsarDescuentosCargas;->cbUsarDescuentosXSeparado;->cbConsiderarDctoMaximo;->vr_descuentoMaximo;->cbCrearDctosEnLineasSeparadas)
SET BLOB SIZE:C606($xBlob;0)

  //preferencias generación de deuda
  //$xBlob:=PREF_fGetBlob (0;"ACT_Deudas";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->cb_GenerarDeudaAuto;->dDeudaTodo;->dDeudaMes;->mMesComenzado;->mMesVencido;->viACT_DiaDeuda;->vs_labelDiaDeuda;->viACT_DiaVencimiento;->viACT_DiasRetardo;->viACT_DiaVencimiento2;->viACT_DiaVencimiento3;->viACT_DiaVencimiento4)
  //SET BLOB SIZE($xBlob;0)
ACTcfg_LeeBlob ("ACTcfg_GeneralesDeudas")

  //Preferencias Avisos
ACTcfg_LeeBlob ("ACTcfg_GeneralesEmAvisos")
  //$xBlob:=PREF_fGetBlob (0;"ACT_Avisos";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->cb_GenerarAvisoAuto;->bAvisoApoderado;->bAvisoAlumno;->cb_IncluirSaldosAnteriores;->cbAgrupar;->vlACT_PagosCta;->vlACT_PagosApdo;->mOrdenInterno;->mCtaGlosa;->cb_ImprimirCerosAviso;->cb_UsarCategorias;->cb_EliminarCargos;->cb_CalcularParaTodosLosAvisos;->cb_NoPrepagarAuto)
  //SET BLOB SIZE($xBlob;0)

  //Preferencias documentos tributarios 
$xBlob:=PREF_fGetBlob (0;"ACT_DocsTributarios";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada
  //BLOB_Blob2Vars (->$xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento)
  //BLOB_Blob2Vars (->$xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento;->cbEmitirXCategorias)
BLOB_Blob2Vars (->$xBlob;0;->cb_GenerarBoletaCaja;->cb_SeqBoletaPorUsuario;->cb_EmitirRecibo;->atACT_Categorias;->apACT_ReqDatos;->abACT_ReqDatos;->alACT_IDsCats;->atACT_Cats;->atACT_NombreDoc;->atACT_Tipo;->apACT_Afecta;->alACT_Proxima;->atACT_Impresora;->atACT_ModeloDoc;->alACT_IDDT;->alACT_IDCat;->abACT_Afecta;->vtACT_ModRecibo;->apACT_PorDefecto;->abACT_PorDefecto;->apACT_DocPorDefecto;->abACT_DocPorDefecto;->abACT_DocComplete;->vlACT_NextRecibo;->vtACT_PrinterRecibo;->aiACT_Tipo;->vtACT_CatVR;->vlACT_CatVR;->vlACT_ModRecibo;->cbAgruparBoletas;->cb_GenerarBoletaCero;->cb_ImprimirCeros;->cb_EliminarPagosAsociados;->cbUsarCategorias;->cb_BoletaSubvencionada;->atACT_idNumeracion;->cb_UtilizaMultiNum;->btnUsuario;->btnRBD;->cb_EmiteXApoderado;->cb_EmiteXCuenta;->atACT_RazonSocial;->alACT_RazonSocial;->cb_Sincroniza;->alACT_IdDTSinc;->atACT_DTSinc;->cbOrdenaRegXFam;->vlACTdt_numLineas;->apACT_EmiteAfectoExento;->abACT_EmiteAfectoExento;->cbEmitirXCategorias;->cbEmitirXMonedas;->lACTbol_DiaVencimiento)
SET BLOB SIZE:C606($xBlob;0)
ACTbol_LoadParamsSubvenciones 
ACTcfg_TranslateDocsTribData 


  //Preferencias Institución
READ ONLY:C145([Colegio:31])
ALL RECORDS:C47([Colegio:31])
FIRST RECORD:C50([Colegio:31])
<>vsACT_Direccion:=[Colegio:31]Administracion_Direccion:41
<>vsACT_Comuna:=[Colegio:31]Administracion_Comuna:42
<>vsACT_Ciudad:=[Colegio:31]Administracion_Ciudad:43
<>vsACT_CPostal:=[Colegio:31]Administracion_CPostal:44
<>vsACT_Telefono:=[Colegio:31]Administracion_Telefono:45
<>vsACT_Fax:=[Colegio:31]Administracion_Fax:46
<>vsACT_Email:=[Colegio:31]Administracion_EMail:47
<>vsACT_RepLegal:=[Colegio:31]RepresentanteLegal_Nombre:39
<>vsACT_RUTRepLegal:=[Colegio:31]RepresentanteLegal_RUN:40
<>vsACT_RazonSocial:=[Colegio:31]RazonSocial:38
<>vsACT_RUT:=[Colegio:31]RUT:2
<>vPict_Logo:=[Colegio:31]Logo:37
<>vsACT_Giro:=[Colegio:31]Giro:48

  //20121219 RCH En un colegio de MX habian 2 registros de colegio. Uno con la moneda peso mexicano y otro con moneda peso chileno
  //20130409 ASM se descomentan para que siempre se lea la moneda configurada por el colegio
  //20160510 RCH Se lee moneda preferentemente desde tabla monedas
  //<>vsACT_MonedaColegio:=ST_GetWord ([Colegio]Moneda;1;";")
  //<>vsACT_simbMonColegio:=ST_GetWord ([Colegio]Moneda;2;";")
  //20130409 ASM se comentan estas lineas porque siempre se debe leer la moneda del colegio.
  //<>vsACT_MonedaColegio:=ST_GetWord (ACT_DivisaPais ;1;";")
  //<>vsACT_simbMonColegio:=ST_GetWord (ACT_DivisaPais ;2;";")
ACT_LeeMoneda 

<>vsACT_NombreContacto:=[Colegio:31]ContactoACT_Nombre:50
<>vsACT_EMailContacto:=[Colegio:31]ContactoACT_EMail:51
<>vsACT_TelefonoContacto:=[Colegio:31]ContactoACT_Telefono:52
<>vlACT_NoDecimalesDespl:=[Colegio:31]Numero_Decimales:53
<>gCountryCode:=[Colegio:31]Codigo_Pais:31
UNLOAD RECORD:C212([Colegio:31])
READ ONLY:C145([Colegio:31])

  //Seleccion para ingreso de pagos
  //$xBlob:=PREF_fGetBlob (0;"SelIngPagos";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->cbDatosCta;->cbDatosApdo;->cb_PermitePorCta;->cb_soloCuotasVencidas)
  //SET BLOB SIZE($xBlob;0)
ACTcfg_LeeBlob ("ACTcfg_GeneralesIngresoPagos")

  //Tramos de ingreso
$xBlob:=PREF_fGetBlob (0;"ACT_TramosIngreso";$xBlob)
hl_TramosIngreso:=BLOB to list:C557($xBlob)

  //iVA, Tasa Interes, etc.
$xBlob:=PREF_fGetBlob (0;"ACT_IVA_tasas";$xBlob)
BLOB_Blob2Vars (->$xBlob;0;-><>vrACT_TasaIVA;-><>vrACT_FactorIVA;-><>vrACT_TasaInterés;-><>vrACT_MultaRetardo)
SET BLOB SIZE:C606($xBlob;0)


  //ARRAY TEXT(atACT_BankID;0)
  //ARRAY TEXT(atACT_BankName;0)
  //$xBlob:=PREF_fGetBlob (0;"ACT_Bancos";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->atACT_BankID;->atACT_BankName)
  //SET BLOB SIZE($xBlob;0)
  //SORT ARRAY(atACT_BankName;atACT_BankID;>)
  //ARRAY TEXT(◊atACT_BankName;0)
  //COPY ARRAY(atACT_BankName;◊atACT_BankName)

ACTcfg_LoadBancos 

ACTcfg_AddRemoveUF 

viACT_ACTDecideApoderado:=Num:C11(PREF_fGet (0;"ACT_DecideApoderado";"1"))
viACT_AsignarMatAdmision:=Num:C11(PREF_fGet (0;"ACT_AsignarMatAdmision";"1"))

ACTinit_CreateDefAfectasInteres ("LeeBlob")



  //meses
ARRAY TEXT:C222(atACT_Meses;0)
COPY ARRAY:C226(<>atXS_MonthNames;atACT_Meses)
COPY ARRAY:C226(atACT_Meses;aMeses)
COPY ARRAY:C226(aMeses;aMeses2)

  //tipos tarjeta credito
  //$xBlob:=PREF_fGetBlob (0;"ACT_Tarjetas";$xBlob)
  //BLOB_Blob2Vars (->$xBlob;0;->◊atACT_TipoTarjeta)
  //SET BLOB SIZE($xBlob;0)

  //Cargamos arreglos de opciones de busqueda rapida
ARRAY TEXT:C222(<>TiposBoleta;0)
ARRAY TEXT:C222(<>Bancos;0)
COPY ARRAY:C226(atACT_NombreDoc;<>TiposBoleta)
COPY ARRAY:C226(atACT_BankName;<>Bancos)
ARRAY TEXT:C222(<>EstadoDocumentosCartera;4)
<>EstadoDocumentosCartera{1}:="Al día"
<>EstadoDocumentosCartera{2}:="A Fecha"
<>EstadoDocumentosCartera{3}:="Vencido"
<>EstadoDocumentosCartera{4}:="Protestado"
ARRAY TEXT:C222(<>TipoDocumentoenCartera;2)
$vl_id:=-4
<>TipoDocumentoenCartera{1}:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->$vl_id)
$vl_id:=-8
<>TipoDocumentoenCartera{2}:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->$vl_id)
ARRAY TEXT:C222(<>EstadoBoletas;2)
<>EstadoBoletas{1}:="Cancelada"
<>EstadoBoletas{2}:="Nula"


  //ARRAY TEXT(<>atACT_MododePago;0)
  //COPY ARRAY(<>atACT_ModosdePago;<>atACT_MododePago)

ACTinit_LoadFdPago 
  //COPY ARRAY(atACT_FormasdePago;<>atACT_FormasdePago)
ACTcfgfdp_OpcionesGenerales ("CargaArreglosFormaDePagoXDef")
COPY ARRAY:C226(atACT_Modo_de_Pago;<>atACT_FormasdePago)

  //20120720 ASM. Para cargar todas las formas de pago en las busquedas.
ARRAY TEXT:C222(<>atACT_MododePago;0)
ARRAY TEXT:C222(<>atACT_ModosdePago;0)
COPY ARRAY:C226(<>atACT_FormasdePago;<>atACT_MododePago)
COPY ARRAY:C226(<>atACT_FormasdePago;<>atACT_ModosdePago)

  //20140428 RCH
  //SET BLOB SIZE(xblob;0)
  //ARRAY STRING(80;<>asACT_GlosaCta;0)
  //ARRAY STRING(80;<>asACT_CuentaCta;0)
  //ARRAY STRING(80;<>asACT_CodAuxCta;0)
  //ARRAY STRING(80;<>asACT_Centro;0)
  //ARRAY TEXT(atACT_CtasEspecialesGlosa;0)
  //ARRAY STRING(80;asACT_CtasEspecialesCta;0)
  //ARRAY STRING(80;asACT_CtasEspecialesCentro;0)
  //xBlob:=PREF_fGetBlob (0;"Contabilidad";xBlob)
  //BLOB_Blob2Vars (->xBlob;0;-><>asACT_GlosaCta;-><>asACT_CuentaCta;-><>asACT_Centro;->atACT_CtasEspecialesGlosa;->asACT_CtasEspecialesCta;->asACT_CtasEspecialesCentro;-><>asACT_CodAuxCta)
  //SET BLOB SIZE(xBlob;0)
ACTcfg_LoadConfigData (10)

  //se utiliza para recalcular los dctos de cargo generados para los terceros
ARRAY LONGINT:C221(alACT_NewDctoCargo;0)
alACT_NewDctoCargo:=0
<>vlACT_decimalesDcto:=4

  //se necesita la variable <>vlACT_Decimales con valor...
ACTutl_GetDecimalFormat 

ACTcfg_OpcionesGenABancarios ("LeeBlob")

ACTcfg_OpcionesPagares ("CargaArregloEstadosPagares")

  //20111027 RCH Valida que siempre exista forma de pago por defecto
ACTcfgfdp_OpcionesGenerales ("GetIDFormaDePagoXDef")

  //20130807 RCH Valida que exista la RS
If (Records in table:C83([ACT_RazonesSociales:279])=0)
	ACTcfg_OpcionesRazonesSociales ("CreaPrincipal")
End if 

ACTcfg_LeeDecimalMonedaPais 

  //codigos de facturas para AR. NO estoy seguro que sean los mismos para todos...
C_TEXT:C284(<>tACT_FEAR_BOLETA_E;<>tACT_FEAR_FACTURA_E;<>tACT_FEAR_NC_E;<>tACT_FEAR_ND_E)
<>tACT_FEAR_BOLETA_E:="15"
<>tACT_FEAR_FACTURA_E:="11"
<>tACT_FEAR_NC_E:="13"
<>tACT_FEAR_ND_E:="12"
<>tACT_FEAR_BOLETA_E:=PREF_fGet (0;"ACT_FEAR_BOLETA_E";<>tACT_FEAR_BOLETA_E)
<>tACT_FEAR_FACTURA_E:=PREF_fGet (0;"ACT_FEAR_FACTURA_E";<>tACT_FEAR_FACTURA_E)
<>tACT_FEAR_NC_E:=PREF_fGet (0;"ACT_FEAR_NC_E";<>tACT_FEAR_NC_E)
<>tACT_FEAR_ND_E:=PREF_fGet (0;"ACT_FEAR_ND_E";<>tACT_FEAR_ND_E)

C_TEXT:C284(<>tACT_FEAR_BOLETA_A;<>tACT_FEAR_FACTURA_A;<>tACT_FEAR_NC_A;<>tACT_FEAR_ND_A)
<>tACT_FEAR_BOLETA_A:="9"
<>tACT_FEAR_FACTURA_A:="6"
<>tACT_FEAR_NC_A:="8"
<>tACT_FEAR_ND_A:="7"
<>tACT_FEAR_BOLETA_A:=PREF_fGet (0;"ACT_FEAR_BOLETA_A";<>tACT_FEAR_BOLETA_A)
<>tACT_FEAR_FACTURA_A:=PREF_fGet (0;"ACT_FEAR_FACTURA_A";<>tACT_FEAR_FACTURA_A)
<>tACT_FEAR_NC_A:=PREF_fGet (0;"ACT_FEAR_NC_A";<>tACT_FEAR_NC_A)
<>tACT_FEAR_ND_A:=PREF_fGet (0;"ACT_FEAR_ND_A";<>tACT_FEAR_ND_A)

ACTint_OpcionesGenerales   //20160908 RCH

  // Añadido por: Saúl Ponce (03-01-2017) - Ticket N° 172266, para generación de las tareas Batch
ACTcfg_ItemsMatricula ("InicializaYLee")

  //
ACTcc_DividirEmision ("LeeConf")

CLEAR SEMAPHORE:C144("ACTinit_LoadPrefs")