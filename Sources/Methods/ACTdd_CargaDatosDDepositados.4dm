//%attributes = {}
  //ACTdd_CargaDatosDDepositados

C_TEXT:C284(vt_tipoDocumento)
C_LONGINT:C283(vl_tipoDocumento)
READ WRITE:C146([ACT_Documentos_de_Pago:176])
GOTO RECORD:C242([ACT_Documentos_de_Pago:176];alACT_RecNumsDocs{i_Doc})

vdACT_FechaCheque:=[ACT_Documentos_de_Pago:176]Fecha:13
vsACT_Banco:=[ACT_Documentos_de_Pago:176]Ch_BancoNombre:7
vsACT_Titular:=[ACT_Documentos_de_Pago:176]Titular:9
vsACT_RUT:=[ACT_Documentos_de_Pago:176]RUTTitular:10
vsACT_Cuenta:=[ACT_Documentos_de_Pago:176]Ch_Cuenta:11
vsACT_NoSerie:=[ACT_Documentos_de_Pago:176]NoSerie:12
vrACT_Monto:=[ACT_Documentos_de_Pago:176]MontoPago:6

vdACT_FechaProtesto:=Current date:C33(*)
vtACT_FechaProtesto:=String:C10(vdACT_FechaProtesto;7)
vtACT_MotivoProtesto:=""
vdACT_FechaVencimiento:=[ACT_Documentos_de_Pago:176]FechaVencimiento:27
vt_tipoDocumento:=[ACT_Documentos_de_Pago:176]Tipodocumento:5
vl_tipoDocumento:=[ACT_Documentos_de_Pago:176]id_forma_de_pago:51

ACTcfg_OpcionesRecargos ("CargaDatosMulta")

cs_ImprimirComprobante:=0