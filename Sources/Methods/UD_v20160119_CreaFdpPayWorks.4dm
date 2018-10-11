//%attributes = {}
  //para crear la forma de pago -20 payworks
C_LONGINT:C283($vl_IDFormaPago)
C_TEXT:C284($vt_glosa)
$vt_glosa:="Pago en línea - Payworks"
ACTfdp_VerificaNuevaFDP ($vt_glosa)
ACTfdp_CargaFormasDePago 
$vl_IDFormaPago:=Num:C11(ACTcfg_OpcionesFormasDePago ("NuevaFormaDePago";->$vt_glosa))
ACTfdp_EstadosXDefecto 

