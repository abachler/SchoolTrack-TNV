//%attributes = {}
  //ACTreemp_Letra

  //20130805 RCH REEMPLAZO POR OPCION 1
  //$IDDocPago:=ACTpgs_ReempCarteraAnulaDocPago (->[ACT_Documentos_de_Pago]ID;->[ACT_Documentos_en_Cartera]ID)
$IDDocPago:=[ACT_Documentos_de_Pago:176]ID:1
$l_reemplazo:=ACTpgs_ReempCarteraAnulaDocPago (->$IDDocPago;->[ACT_Documentos_en_Cartera:182]ID:1)

READ WRITE:C146([ACT_Documentos_en_Cartera:182])
READ WRITE:C146([ACT_Documentos_de_Pago:176])
READ WRITE:C146([ACT_Pagos:172])

DUPLICATE RECORD:C225([ACT_Documentos_de_Pago:176])
[ACT_Documentos_de_Pago:176]ID:1:=$IDDocPago
[ACT_Documentos_de_Pago:176]id_forma_de_pago:51:=-8
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
[ACT_Documentos_de_Pago:176]FechaProtesto:15:=!00-00-00!
[ACT_Documentos_de_Pago:176]Estado:14:=""
  //[ACT_Documentos_de_Pago]Estado:="Aceptada"
[ACT_Documentos_de_Pago:176]Fecha:13:=vdACT_LFechaEmision
[ACT_Documentos_de_Pago:176]FechaProtesto:15:=!00-00-00!
[ACT_Documentos_de_Pago:176]FechaVencimiento:27:=vdACT_LFechaVencimiento
[ACT_Documentos_de_Pago:176]NoSerie:12:=vtACT_LDocumento
[ACT_Documentos_de_Pago:176]RUTTitular:10:=vtACT_LRUTTitular
[ACT_Documentos_de_Pago:176]Titular:9:=vtACT_LTitular
[ACT_Documentos_de_Pago:176]En_cartera:34:=True:C214
[ACT_Documentos_de_Pago:176]Depositado:35:=False:C215
[ACT_Documentos_de_Pago:176]Nulo:37:=False:C215
[ACT_Documentos_de_Pago:176]L_Impuesto:44:=vrACT_LImpuesto
[ACT_Documentos_de_Pago:176]L_Indice:29:=vtACT_LIndiceLetras
[ACT_Documentos_de_Pago:176]Tipodocumento:5:=ACTcfgfdp_OpcionesGenerales ("GetOLDFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
[ACT_Documentos_de_Pago:176]forma_de_pago_new:52:=ACTcfgfdp_OpcionesGenerales ("GetFormaDePagoFromID";->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51)
[ACT_Documentos_de_Pago:176]Auto_UUID:74:=Generate UUID:C1066  //20140107 ASM al duplicar los registros, tambien se duplicaban los UUID
[ACT_Documentos_de_Pago:176]id_estado:53:=0
[ACT_Documentos_de_Pago:176]Estado:14:=KRL_GetTextFieldData (->[ACT_Formas_de_Pago:287]id:1;->[ACT_Documentos_de_Pago:176]id_forma_de_pago:51;->[ACT_Formas_de_Pago:287]estado:13)
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

READ ONLY:C145([Personas:7])
QUERY:C277([Personas:7];[Personas:7]No:1=[ACT_Documentos_de_Pago:176]ID_Apoderado:2)
ACTpgs_CreacionDocCartera (-8)

KRL_UnloadReadOnly (->[ACT_Documentos_en_Cartera:182])
KRL_UnloadReadOnly (->[ACT_Documentos_de_Pago:176])
KRL_UnloadReadOnly (->[ACT_Pagos:172])