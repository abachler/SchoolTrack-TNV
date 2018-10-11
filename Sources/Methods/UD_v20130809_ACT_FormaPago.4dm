//%attributes = {}
  //UD_v20130809_ACT_FormaPago

If (ACT_AccountTrackInicializado )
	
	  //cambio nombre posibles formas de pago
	UD_v20130821_FormaPagoWP 
	
	C_TEXT:C284($vt_glosa)
	C_LONGINT:C283($vl_IDFormaPago)
	
	ACTfdp_CargaFormasDePago 
	
	$vt_glosa:="Webpay"
	$vl_IDFormaPago:=Num:C11(ACTcfg_OpcionesFormasDePago ("NuevaFormaDePago";->$vt_glosa))
End if 