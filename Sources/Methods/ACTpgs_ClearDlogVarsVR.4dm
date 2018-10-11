//%attributes = {}
  //ACTpgs_ClearDlogVarsVR

vtACT_BancoNombre:=""
vtACT_BancoCodigo:=""
vtACT_BancoCuenta:=""
vtACT_BancoTitular:=""
vtACT_BancoRUTTitular:=""
vtACT_NoSerie:=""
vtACT_FechaDocumento:=""
vsACT_NomApellido:=""

vrACT_MontoAPagar:=0
vrACT_MontoDescto:=0
vrACT_MontoAfecto:=0
vrACT_MontoExento:=0
vrACT_MontoIVA:=0
vrACT_MontoPago:=0
vrACT_TotalAfecto:=0
vtACT_TCTipo:=""
vtACT_TCNumero:=""
vtACT_TCCodigo:=""
vtACT_TCTitular:=""
vtACT_TCRUTTitular:=""
vtACT_TCMesVencimiento:=""
vtACT_TCAgnoVencimiento:=""
vtACT_TCBanco:=""
vtACT_TCDocumento:=""
vtACT_RDocumento:=""
vtACT_LFechaEmision:=""
vtACT_LFechaVencimiento:=""
vtACT_LTitular:=""
vtACT_LRUTTitular:=""
vtACT_LDocumento:=""
AL_RemoveArrays (ALP_ItemsVentaRapida;1;7)
xALP_Set_ACT_ItemsVenta 
AL_UpdateArrays (ALP_ItemsRapidos;0)
ACTvr_LoadItems 
AL_UpdateArrays (ALP_ItemsRapidos;-2)