//%attributes = {}
  //ACTter_PageInfoPagos

C_LONGINT:C283($0)
ACTpp_LabelPACPAT (->[ACT_Terceros:138]Fecha_de_Nacimiento:28;->vtACTTer_IdentPAC;->vtACTTer_IdentPAT)
ACTpp_CRYPTTC ("onLoad";->vtACT_NumTC;->[ACT_Terceros:138]PAT_NumTC:36)
ACTpp_CRYPTTC ("onLoad";->vtACT_NumTD;->[ACT_Terceros:138]RC_NumTD:66)  //20131128 ASM Ticket 127351
vt_ModoDePagoTer:=ACTcfg_OpcionesFormasDePago ("GetFormaDePagoXID";->[ACT_Terceros:138]Id_Modo_de_Pago:61)

  //20161115 RCH
C_BOOLEAN:C305($b_enterable)
$b_enterable:=(([ACT_Terceros:138]Id_Modo_de_Pago:61=-9) | ([ACT_Terceros:138]Id_Modo_de_Pago:61=-10))
IT_SetEnterable ($b_enterable;0;->[ACT_Terceros:138]Dia_de_Cargo:31)

$0:=1