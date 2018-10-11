//%attributes = {}
  //ACTreemp_RedCompra

  //20130805 RCH REEMPLAZO POR OPCION 1
  //$IDDocPago:=ACTpgs_ReempCarteraAnulaDocPago (->[ACT_Documentos_de_Pago]ID;->[ACT_Documentos_en_Cartera]ID)
$IDDocPago:=[ACT_Documentos_de_Pago:176]ID:1
$l_reemplazo:=ACTpgs_ReempCarteraAnulaDocPago (->$IDDocPago;->[ACT_Documentos_en_Cartera:182]ID:1)

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
READ WRITE:C146([ACT_Documentos_de_Pago:176])
READ WRITE:C146([ACT_Pagos:172])

DUPLICATE RECORD:C225([ACT_Documentos_de_Pago:176])
[ACT_Documentos_de_Pago:176]ID:1:=$IDDocPago
[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-7
[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7:=""
[ACT_Documentos_de_Pago:176]Ch_BancoCodigo:8:=""
[ACT_Documentos_de_Pago:176]Ch_Cuenta:11:=""
[ACT_Documentos_de_Pago:176]Fecha:13:=!00-00-00!
[ACT_Documentos_de_Pago:176]NoSerie:12:=""
[ACT_Documentos_de_Pago:176]RUTTitular:10:=""
[ACT_Documentos_de_Pago:176]Titular:9:=""
[ACT_Documentos_de_Pago:176]En_cartera:34:=False:C215
[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
[ACT_Documentos_de_Pago:176]Protestado:36:=False:C215
[ACT_Documentos_de_Pago:176]Nulo:37:=False:C215
[ACT_Documentos_de_Pago:176]FechaProtesto:15:=!00-00-00!
  //[ACT_Documentos_de_Pago]Estado:=""
[ACT_Documentos_de_Pago:176]Auto_UUID:74:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
  //******Ticket 116401
[ACT_Documentos_de_Pago:176]R_NoDocumento:33:=vtACT_RDocumento
[ACT_Documentos_de_Pago:176]TD_Numero:69:=ACTpp_CRYPTTC ("xxACT_SetCryptTC";->vtACT_TDNumero;->[ACT_Documentos_de_Pago:176]xPass_TD:73)

[ACT_Documentos_de_Pago:176]TD_RUTTitular:70:=vtACT_TDRUTTitular
[ACT_Documentos_de_Pago:176]TD_Tipo:71:=vtACT_TDTipo
[ACT_Documentos_de_Pago:176]TD_Titular:72:=vtACT_TDTitular
[ACT_Documentos_de_Pago:176]TD_Codigo:67:=vtACT_TDCodigo
[ACT_Documentos_de_Pago:176]TD_MesVencimiento:68:=vtACT_TDMesVencimiento
[ACT_Documentos_de_Pago:176]TD_AgnoVencimiento:64:=vtACT_TDAgnoVencimiento
[ACT_Documentos_de_Pago:176]TD_BancoEmisor:66:=vtACT_TDBancoEmisor
[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)

  //**********************
[ACT_Documentos_de_Pago:176]id_estado:53:=0
[ACT_Documentos_de_Pago:176]Estado:14:=ACTcfg_OpcionesEstadosPagos ("ObtieneEstado";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Documentos_de_Pago:176]id_estado:53)
ACTdp_OpcionesHistorialReemplaz ("AsignaIDDeDctoReemplazado";->vl_idDctoCargoOld)
  //SAVE RECORD([ACT_Documentos_de_Pago])

  //20130805 RCH REEMPLAZO POR OPCION 1
[ACT_Documentos_de_Pago:176]id_reemplazado:62:=0  //20130827 RCH Se quedaba el campo con dato al duplicar...
[ACT_Documentos_de_Pago:176]id_reemplazador:63:=$l_reemplazo

ACTdp_fSave 

QUERY:C277([ACT_Pagos:172];[ACT_Pagos:172]ID_DocumentodePago:6=[ACT_Documentos_de_Pago:176]ID:1)
[ACT_Pagos:172]id_forma_de_pago:30:=[ACT_Documentos_de_Pago:176]id_forma_de_pago:51
[ACT_Pagos:172]FormaDePago:7:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
[ACT_Pagos:172]forma_de_pago_new:31:=[ACT_Documentos_de_Pago:176]forma_de_pago_new:52
SAVE RECORD:C53([ACT_Pagos:172])
ACTpgs_AsignaCuentasContables (->[ACT_Pagos:172]ID:1)

KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Pagos:172])